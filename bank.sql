-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 29, 2025 at 02:55 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank`
--
CREATE DATABASE IF NOT EXISTS `bank` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bank`;

DELIMITER $$
--
-- Procedury
--
DROP PROCEDURE IF EXISTS `TransferBalance`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TransferBalance` (IN `giver_account` INT, IN `receiver_account` INT, IN `transfer_amount` DECIMAL(15,2), OUT `result_message` VARCHAR(255))   BEGIN
    DECLARE
        giver_balance DECIMAL(15, 2) ;
        -- Sprawdzenie salda darczyńcy
    SELECT
        balance
    INTO giver_balance
FROM
    accounts
WHERE
    account_number = giver_account ;
    -- Sprawdzenie, czy darczyńca ma wystarczające środki
    IF giver_balance < transfer_amount THEN
SET
    result_message = 'Insufficient funds' ; 
END IF ;
-- Zmniejszenie salda darczyńcy
UPDATE
    accounts
SET
    balance = balance - transfer_amount
WHERE
    account_number = giver_account ;
    -- Zwiększenie salda odbiorcy
UPDATE
    accounts
SET
    balance = balance + transfer_amount
WHERE
    account_number = receiver_account ;
    -- Zalogowanie transakcji
INSERT INTO transactions(
    giver_account_number,
    receiver_account_number,
    transaction_type,
    amount,
    description
)
VALUES(
    giver_account,
    receiver_account,
    'transfer',
    transfer_amount,
    'Balance transfer'
) ;
-- Ustawienie komunikatu o pomyślnym transferze
SET
    result_message = 'Transfer successful' ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `account_number` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `credit` decimal(15,2) DEFAULT NULL,
  `validity` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`account_number`, `client_id`, `credit`, `validity`) VALUES
(1, 1, 200.00, '2026-12-31'),
(2, 2, 800.00, '2027-06-30'),
(3, 3, 1000.00, '2025-05-10'),
(4, 4, 500.00, '2025-12-01'),
(5, 5, 1200.00, '2026-03-31');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cards`
--

DROP TABLE IF EXISTS `cards`;
CREATE TABLE `cards` (
  `card_id` int(11) NOT NULL,
  `account_number` int(11) NOT NULL,
  `cvc` varchar(3) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  `card_number` varchar(16) NOT NULL,
  `pin` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`card_id`, `account_number`, `cvc`, `expiry_date`, `balance`, `card_number`, `pin`) VALUES
(1, 1, '123', '2026-12-31', 250.00, '1234567890123456', 4567),
(2, 2, '234', '2027-03-15', 300.00, '6668754477950999', 7898),
(3, 3, '345', '2025-08-25', 200.00, '8718679866989676', 2233),
(4, 4, '456', '2025-10-05', 150.00, '3368393939345794', 1234),
(5, 5, '567', '2027-07-20', 1200.00, '7357892547898554', 2351);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `pesel` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `birth_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `first_name`, `last_name`, `pesel`, `email`, `phone_number`, `birth_date`) VALUES
(1, 'Skibidi', 'Toilet', '11122334455', 'skibidi.toilet@skibidi.com', '567-890-123', '1995-03-10'),
(2, 'Adolf', 'Hitler', '22334455667', 'adolf.hitler@trzeciarzesza.com', '678-901-234', '1990-06-20'),
(3, 'Hubert', 'Kowalski', '33445566778', 'kupilemposiadloscwegipcie@dupa.gg', '789-012-345', '1987-09-15'),
(4, 'Patryk', 'Kowalczyk', '44556677889', 'nerdfacenigger@skibiod.valorant', '890-123-456', '1982-01-22'),
(5, 'Jan', 'Baran', '55667788990', 'geometrydashnigga@timeless.ohio', '901-234-567', '1992-11-11');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `giver_account_number` int(11) DEFAULT NULL,
  `receiver_account_number` int(11) DEFAULT NULL,
  `transaction_type` enum('deposit','withdrawal','transfer') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `giver_account_number`, `receiver_account_number`, `transaction_type`, `amount`, `timestamp`, `description`) VALUES
(1, 1, 2, 'transfer', 100.00, '2025-01-22 13:17:19', 'SkibidiToilet_NightClub'),
(2, 2, 3, 'transfer', 200.00, '2025-01-22 13:17:19', 'ZA ZySDA'),
(3, 3, NULL, 'withdrawal', 150.00, '2025-01-22 13:17:19', 'ATM -KOKS >:0- withdrawal'),
(4, NULL, 4, 'deposit', 300.00, '2025-01-22 13:17:19', 'totally not money laundering deposit'),
(5, 4, 5, 'transfer', 50.00, '2025-01-22 13:17:19', 'zazaaaauuu');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_number`),
  ADD KEY `client_id` (`client_id`);

--
-- Indeksy dla tabeli `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`card_id`),
  ADD UNIQUE KEY `card_number` (`card_number`),
  ADD KEY `account_number` (`account_number`);

--
-- Indeksy dla tabeli `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`),
  ADD UNIQUE KEY `pesel` (`pesel`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indeksy dla tabeli `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `giver_account_number` (`giver_account_number`),
  ADD KEY `receiver_account_number` (`receiver_account_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE;

--
-- Constraints for table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_ibfk_1` FOREIGN KEY (`account_number`) REFERENCES `accounts` (`account_number`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`giver_account_number`) REFERENCES `accounts` (`account_number`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`receiver_account_number`) REFERENCES `accounts` (`account_number`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
