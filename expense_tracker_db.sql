-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2023 at 12:42 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expense_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `balance_table`
--

CREATE TABLE `balance_table` (
  `date` date NOT NULL,
  `expense_id` int(11) NOT NULL,
  `currency` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `income` int(11) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `balance_view`
-- (See below for the actual view)
--
CREATE TABLE `balance_view` (
`date` date
,`category_name` varchar(64)
,`expense_name` varchar(64)
,`currency` int(11)
,`amount` int(11)
,`income` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `category_master`
--

CREATE TABLE `category_master` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `expense_master`
--

CREATE TABLE `expense_master` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure for view `balance_view`
--
DROP TABLE IF EXISTS `balance_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `balance_view`  AS SELECT `bt`.`date` AS `date`, `cm`.`name` AS `category_name`, `em`.`name` AS `expense_name`, `bt`.`currency` AS `currency`, `bt`.`amount` AS `amount`, `bt`.`income` AS `income` FROM ((`balance_table` `bt` join `expense_master` `em` on(`bt`.`expense_id` = `em`.`id`)) join `category_master` `cm` on(`em`.`category_id` = `cm`.`id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `balance_table`
--
ALTER TABLE `balance_table`
  ADD PRIMARY KEY (`date`,`expense_id`),
  ADD KEY `fk_expense_id` (`expense_id`);

--
-- Indexes for table `category_master`
--
ALTER TABLE `category_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_master`
--
ALTER TABLE `expense_master`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category_master`
--
ALTER TABLE `category_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_master`
--
ALTER TABLE `expense_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `balance_table`
--
ALTER TABLE `balance_table`
  ADD CONSTRAINT `fk_expense_id` FOREIGN KEY (`expense_id`) REFERENCES `expense_master` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
