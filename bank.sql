-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 13, 2025 at 10:40 PM
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
  `client_id` int(11) DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  `credit` decimal(15,2) DEFAULT NULL,
  `validity` date DEFAULT NULL,
  `transaction_history` text DEFAULT NULL,
  PRIMARY KEY (`account_number`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`account_number`, `client_id`, `balance`, `credit`, `validity`, `transaction_history`) VALUES
(1, 1, 500.00, 200.00, '2026-12-31', 'Initial deposit, ATM withdrawal on 2025-01-14'),
(2, 2, 1500.00, 800.00, '2027-06-30', 'Deposit on 2025-01-15, Online payment on 2025-01-16'),
(3, 3, 3200.50, 1000.00, '2025-05-10', 'Deposit for rent on 2025-01-17'),
(4, 4, 1000.00, 500.00, '2025-12-01', 'Initial deposit, Grocery shopping on 2025-01-18'),
(5, 5, 2400.75, 1200.00, '2026-03-31', 'Savings deposit, Investment in stocks on 2025-01-19');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cards`
--

DROP TABLE IF EXISTS `cards`;
CREATE TABLE IF NOT EXISTS `cards` (
  `card_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_number` int(11) DEFAULT NULL,
  `cvc` varchar(3) DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `transaction_history` text DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`card_id`),
  KEY `account_number` (`account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`card_id`, `account_number`, `cvc`, `expiry_date`, `transaction_history`, `balance`) VALUES
(1, 1, '123', '2026-12-31', 'John Pork Farm on 2025-01-15, Skibidi Toilet Night Club on 2025-01-16, Online Shopping on 2025-01-17, Apple Music Subscription on 2025-01-18', 250.00),
(2, 2, '234', '2027-03-15', 'Spotify Subscription on 2025-01-19, Fortnite V-Bucks on 2025-01-20, Low Taper Fade haircut on 2025-01-21, Valorant Skin purchase on 2025-01-22', 300.00),
(3, 3, '345', '2025-08-25', 'League of Legends Skins on 2025-01-23, Locked In Subscription on 2025-01-24, Online Shopping on 2025-01-25, Spotify Premium Subscription on 2025-01-26', 200.00),
(4, 4, '456', '2025-10-05', 'Skibidi Toilet Night Club on 2025-01-19, Apple Music Subscription on 2025-01-20, Valorant Skin purchase on 2025-01-21, John Pork Farm on 2025-01-22', 150.00),
(5, 5, '567', '2027-07-20', 'Fortnite V-Bucks on 2025-01-23, Low Taper Fade on 2025-01-24, Locked In on 2025-01-25, League of Legends Skins on 2025-01-26', 1200.00);

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

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`);

--
-- Constraints for table `cards`
--
ALTER TABLE `cards`
  ADD CONSTRAINT `cards_ibfk_1` FOREIGN KEY (`account_number`) REFERENCES `accounts` (`account_number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
