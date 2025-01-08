-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sty 08, 2025 at 02:20 PM
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
-- Database: `shop`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `barcode` varchar(13) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`barcode`, `product_name`, `price`) VALUES
('5901234123457', 'Mleko', 3.50),
('5901234123458', 'Chleb pelnoziarnisty', 4.20),
('5901234123459', 'Masko ', 6.90),
('5901234123460', 'Ser zolty', 7.80),
('5901234123461', 'Jogurt naturalny', 2.99),
('5901234123462', 'Jajka ', 9.50),
('5901234123463', 'Woda mineralna', 1.20),
('5901234123464', 'Sok pomaranczowy', 4.50),
('5901234123465', 'Kawa mielona', 14.90),
('5901234123466', 'Herbata czarna', 5.50),
('5901234123467', 'Makaron spaghetti', 3.80),
('5901234123468', 'Ryz bialy', 6.20),
('5901234123469', 'Cukier bialy', 3.40),
('5901234123470', 'Maka pszenna', 2.50),
('5901234123471', 'Olej rzepakowy', 8.90),
('5901234123472', 'Szampon do wlosow', 12.50),
('5901234123473', 'Pasta do zebow', 7.20),
('5901234123474', 'Mydlo w plynie', 5.90),
('5901234123475', 'Plyn do naczyn', 6.80),
('5901234123476', 'Papier toaletowy', 14.50),
('5414635120807', 'Sprezone powietrze', 520.00),
('5449000234636', 'Sprite', 9.00),
('5449000011527', 'Fanta', 12.00),
('5449000000996', 'Coca-Cola', 10.00);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
