-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2021 at 05:51 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mvp`
--

-- --------------------------------------------------------

--
-- Table structure for table `points`
--

CREATE TABLE `points` (
  `id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  `point_system_id` int(11) NOT NULL,
  `postion_id` int(11) NOT NULL,
  `point` int(11) NOT NULL,
  `sys_id_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `points`
--

INSERT INTO `points` (`id`, `sport_id`, `point_system_id`, `postion_id`, `point`, `sys_id_order`) VALUES
(1, 1, 1, 1, 2, 5),
(2, 1, 1, 2, 2, 5),
(3, 1, 1, 3, 2, 5),
(4, 1, 3, 1, 3, 6),
(5, 1, 3, 2, 2, 6),
(6, 1, 3, 3, 1, 6),
(7, 1, 2, 1, 1, 7),
(8, 1, 2, 2, 2, 7),
(9, 1, 2, 3, 3, 7),
(10, 2, 4, 5, 50, -1),
(11, 2, 4, 4, 20, -1),
(12, 2, 6, 5, -2, 6),
(13, 2, 6, 4, -1, 6),
(27, 2, 5, 5, 5, 5),
(28, 2, 5, 4, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `points_system`
--

CREATE TABLE `points_system` (
  `points_system_id` int(11) NOT NULL,
  `points_system_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `points_system`
--

INSERT INTO `points_system` (`points_system_id`, `points_system_name`) VALUES
(1, 'Scored point'),
(2, 'Assist'),
(3, 'Rebound'),
(4, 'Initial rating points'),
(5, 'Goal made'),
(6, 'Goal recieved');

-- --------------------------------------------------------

--
-- Table structure for table `postion`
--

CREATE TABLE `postion` (
  `position_id` int(11) NOT NULL,
  `postion_name` varchar(50) NOT NULL,
  `short_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `postion`
--

INSERT INTO `postion` (`position_id`, `postion_name`, `short_name`) VALUES
(1, 'Guard', 'G'),
(2, 'Forward', 'F'),
(3, 'Center', 'C'),
(4, 'Field player', 'F'),
(5, 'Goalkeeper', 'G');

-- --------------------------------------------------------

--
-- Table structure for table `sport`
--

CREATE TABLE `sport` (
  `sport_id` int(11) NOT NULL,
  `sport_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sport`
--

INSERT INTO `sport` (`sport_id`, `sport_name`) VALUES
(1, 'Basketball'),
(2, 'Handball');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `points`
--
ALTER TABLE `points`
  ADD PRIMARY KEY (`id`),
  ADD KEY `f001` (`point_system_id`),
  ADD KEY `f002` (`postion_id`),
  ADD KEY `f003` (`sport_id`);

--
-- Indexes for table `points_system`
--
ALTER TABLE `points_system`
  ADD PRIMARY KEY (`points_system_id`);

--
-- Indexes for table `postion`
--
ALTER TABLE `postion`
  ADD PRIMARY KEY (`position_id`);

--
-- Indexes for table `sport`
--
ALTER TABLE `sport`
  ADD PRIMARY KEY (`sport_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `points`
--
ALTER TABLE `points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `points_system`
--
ALTER TABLE `points_system`
  MODIFY `points_system_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `postion`
--
ALTER TABLE `postion`
  MODIFY `position_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sport`
--
ALTER TABLE `sport`
  MODIFY `sport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `points`
--
ALTER TABLE `points`
  ADD CONSTRAINT `f001` FOREIGN KEY (`point_system_id`) REFERENCES `points_system` (`points_system_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `f002` FOREIGN KEY (`postion_id`) REFERENCES `postion` (`position_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `f003` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
