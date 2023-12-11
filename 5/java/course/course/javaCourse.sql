-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Дек 11 2023 г., 04:42
-- Версия сервера: 11.2.2-MariaDB
-- Версия PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `javaCourse`
--

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `barcode` varchar(255) DEFAULT NULL,
  `count_in_stok` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `name`, `barcode`, `count_in_stok`, `price`) VALUES
(1, 'Пятерка за курсовик по java', '123', 88, 5),
(2, 'Четверка за курсовик по java', '111', 83, 4),
(3, 'Тройка за курсовик по java', '222', 0, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `purchases`
--

CREATE TABLE `purchases` (
  `buyer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `purchase_id` int(11) NOT NULL,
  `total_price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `purchases`
--

INSERT INTO `purchases` (`buyer_id`, `date`, `purchase_id`, `total_price`) VALUES
(49, '2023-12-11', 1, 12),
(50, '2023-12-11', 2, 5),
(51, '2023-12-11', 3, 9),
(49, '2023-12-11', 4, 9),
(50, '2023-12-11', 5, 12),
(50, '2023-12-11', 6, 12),
(50, '2023-12-11', 7, 12),
(50, '2023-12-11', 8, 12),
(50, '2023-12-11', 9, 12);

-- --------------------------------------------------------

--
-- Структура таблицы `purchases_items`
--

CREATE TABLE `purchases_items` (
  `product_count` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `purchases_items`
--

INSERT INTO `purchases_items` (`product_count`, `purchase_id`, `product_id`) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(100, 2, 1),
(10, 3, 1),
(10, 3, 2),
(8, 4, 1),
(4, 4, 2),
(2, 5, 1),
(3, 5, 2),
(4, 5, 3),
(1, 6, 1),
(5, 6, 3),
(10, 6, 2),
(1, 7, 1),
(5, 7, 2),
(10, 7, 3),
(1, 8, 1),
(6, 8, 2),
(10, 8, 3),
(1, 9, 1),
(1, 9, 2),
(80, 9, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `Users`
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
-- Дамп данных таблицы `Users`
--

INSERT INTO `Users` (`id`, `login`, `password`, `email`, `name`, `surname`, `phone`, `role`) VALUES
(49, '', '��B�����șo�$\'�A�d��L���xR�U', '', '', 'qwer', '', 'user'),
(50, 'admin', '�iv�A���M�߱g��s�K��o*�H�', 'qwer@qwer.qwer', 'ivan', 'ivanov', '88005553535', 'admin'),
(51, 'salesman', '���EؠW�Vj3��t�.\\jf�6P�so��', 'rab@mail.ru', 'работяга', 'zavodchanin', '8 800 555 35 35', 'salesman'),
(55, '', '���EؠW�Vj3��t�.\\jf�6P�so��', '', '', 'qwer', '88005553535', 'user');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `purchases_Users_id_fk` (`buyer_id`);

--
-- Индексы таблицы `purchases_items`
--
ALTER TABLE `purchases_items`
  ADD KEY `purchases_items_purchases_purchase_id_fk` (`purchase_id`),
  ADD KEY `purchases_items_products_id_fk` (`product_id`);

--
-- Индексы таблицы `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `purchases`
--
ALTER TABLE `purchases`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_Users_id_fk` FOREIGN KEY (`buyer_id`) REFERENCES `Users` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `purchases_items`
--
ALTER TABLE `purchases_items`
  ADD CONSTRAINT `purchases_items_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `purchases_items_purchases_purchase_id_fk` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`purchase_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
