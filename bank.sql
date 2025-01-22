-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 22, 2025 at 02:22 PM
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

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `account_number` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `credit` decimal(15,2) DEFAULT NULL,
  `validity` date DEFAULT NULL,
  PRIMARY KEY (`account_number`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `cards` (
  `card_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_number` int(11) NOT NULL,
  `cvc` varchar(3) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`card_id`),
  KEY `account_number` (`account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`card_id`, `account_number`, `cvc`, `expiry_date`, `balance`) VALUES
(1, 1, '123', '2026-12-31', 250.00),
(2, 2, '234', '2027-03-15', 300.00),
(3, 3, '345', '2025-08-25', 200.00),
(4, 4, '456', '2025-10-05', 150.00),
(5, 5, '567', '2027-07-20', 1200.00);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `pesel` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `pesel` (`pesel`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
CREATE TABLE IF NOT EXISTS `transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `giver_account_number` int(11) DEFAULT NULL,
  `receiver_account_number` int(11) DEFAULT NULL,
  `transaction_type` enum('deposit','withdrawal','transfer') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `giver_account_number` (`giver_account_number`),
  KEY `receiver_account_number` (`receiver_account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
