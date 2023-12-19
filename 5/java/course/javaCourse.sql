-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 18, 2023 at 04:37 AM
-- Server version: 11.2.2-MariaDB
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `javaCourse`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `count_in_stok` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `barcode`, `count_in_stok`, `price`) VALUES
(1, 'Пятерка за курсовик по java', '123', 92, 5),
(2, 'Четверка за курсовик по java', '111', 81, 4),
(3, 'Тройка за курсовик по java', '222', 97, 3),
(4, 'Учебник по литературе часть 1', '9785090772723', 100, 500),
(5, 'Учебник по литературе часть 2', '9785090772716', 100, 500),
(6, 'Веб-камера logitech hd 720p', '5012345678900', 98, 3998),
(7, 'Алгебра и начала математического анализа Ш.А. Алимов, Ю.М.Колягин', '9785090779258', 90, 700),
(8, 'Геометрия 10-11 классы Л.С. Атанасян, В.Ф. Бутузов', '9785090738835', 86, 700),
(9, 'Обществознание 11 класс Л.Н. Боголюбова', '9785090875417', 97, 900),
(10, 'Русский язык 10-11 классы Л.М. Рыбченкова, О.М. Александрова', '9785090880237', 96, 400),
(11, 'История россии 1945 год - начало XXI века 11 класс В.Р. Мединский, А.В. Торкунов', '9785091094770', 97, 1000),
(12, 'Биология 11 класс В.В. Пасечник', '9785090774420', 98, 600),
(23, 'test name', '0712221819179', 123, 123);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `buyer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `purchase_id` int(11) NOT NULL,
  `total_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`buyer_id`, `date`, `purchase_id`, `total_price`) VALUES
(50, '2023-12-16', 13, 5),
(0, '2023-12-16', 14, 63),
(0, '2023-12-16', 15, 5),
(56, '2023-12-16', 16, 37),
(50, '2023-12-17', 17, 5),
(0, '2023-12-17', 18, 6800),
(50, '2023-12-17', 19, 18796),
(56, '2023-12-17', 20, 700),
(0, '2023-12-17', 21, 5600),
(0, '2023-12-17', 22, 700),
(0, '2023-12-17', 23, 700),
(0, '2023-12-17', 24, 123),
(56, '2023-12-17', 25, 5),
(59, '2023-12-18', 26, 5);

-- --------------------------------------------------------

--
-- Table structure for table `purchases_items`
--

CREATE TABLE `purchases_items` (
  `product_count` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases_items`
--

INSERT INTO `purchases_items` (`product_count`, `purchase_id`, `product_id`) VALUES
(1, 13, 1),
(2, 14, 1),
(3, 14, 3),
(11, 14, 2),
(1, 15, 1),
(1, 16, 1),
(8, 16, 2),
(1, 17, 1),
(4, 18, 7),
(1, 18, 8),
(1, 18, 9),
(2, 18, 10),
(1, 18, 11),
(1, 18, 12),
(5, 19, 7),
(3, 19, 8),
(2, 19, 9),
(2, 19, 10),
(2, 19, 11),
(1, 19, 12),
(2, 19, 6),
(1, 20, 7),
(8, 21, 8),
(1, 22, 8),
(1, 23, 8),
(1, 25, 1),
(1, 26, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `login`, `password`, `email`, `name`, `surname`, `phone`, `role`) VALUES
(0, '', '���EؠW�Vj3��t�.\\jf�6P�so��', '', 'БезАккаунта', '', '+7(000)000-00-00', 'admin'),
(50, 'admin', '���EؠW�Vj3��t�.\\jf�6P�so��', 'qwer@qwer.qwer', 'ivan', 'qwer', '+7(800)555-35-35', 'admin'),
(51, 'salesman', '���EؠW�Vj3��t�.\\jf�6P�so��', 'rab@mail.ru', 'работяга', 'xxx', '+7(800)555-35-34', 'salesman'),
(56, 'user', '���EؠW�Vj3��t�.\\jf�6P�so��', 'qwer@qwer.qwer', 'Димон', 'хех', '+7(800)555-35-32', 'user'),
(59, 'admin1', '���EؠW�Vj3��t�.\\jf�6P�so��', 'qwer@qwer.qwer', 'вася', 'пупкин', '+7(111)111-11-11', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `purchases_Users_id_fk` (`buyer_id`);

--
-- Indexes for table `purchases_items`
--
ALTER TABLE `purchases_items`
  ADD KEY `purchases_items_purchases_purchase_id_fk` (`purchase_id`),
  ADD KEY `purchases_items_products_id_fk` (`product_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_Users_id_fk` FOREIGN KEY (`buyer_id`) REFERENCES `Users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchases_items`
--
ALTER TABLE `purchases_items`
  ADD CONSTRAINT `purchases_items_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_items_purchases_purchase_id_fk` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`purchase_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
