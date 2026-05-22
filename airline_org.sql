-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2026 at 09:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline_org`
--

-- --------------------------------------------------------

--
-- Table structure for table `operations`
--

CREATE TABLE `operations` (
  `route_id` int(11) NOT NULL,
  `aircraft_id` int(11) NOT NULL,
  `no_of_passengers` int(11) NOT NULL,
  `ticket_price` int(11) NOT NULL,
  `departure_date` date NOT NULL,
  `departure_time` varchar(5) NOT NULL,
  `arrival_date` date NOT NULL,
  `arrival_time` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `operations`
--

INSERT INTO `operations` (`route_id`, `aircraft_id`, `no_of_passengers`, `ticket_price`, `departure_date`, `departure_time`, `arrival_date`, `arrival_time`) VALUES
(1, 1, 175, 320, '2026-05-01', '08:00', '2026-05-01', '14:30'),
(2, 2, 155, 850, '2026-05-02', '10:15', '2026-05-02', '19:45'),
(2, 3, 340, 900, '2026-05-03', '07:30', '2026-05-03', '17:00'),
(3, 4, 480, 400, '2026-05-04', '12:00', '2026-05-04', '15:30'),
(3, 5, 170, 380, '2026-05-05', '09:00', '2026-05-05', '12:30'),
(4, 6, 195, 750, '2026-05-06', '06:45', '2026-05-06', '23:00'),
(4, 7, 245, 980, '2026-05-07', '11:00', '2026-05-08', '08:30'),
(5, 8, 290, 620, '2026-05-08', '13:30', '2026-05-08', '22:00'),
(5, 9, 175, 600, '2026-05-09', '08:00', '2026-05-09', '16:30'),
(6, 10, 95, 120, '2026-05-10', '15:00', '2026-05-10', '16:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `operations`
--
ALTER TABLE `operations`
  ADD PRIMARY KEY (`route_id`,`aircraft_id`),
  ADD KEY `aircraft_id` (`aircraft_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `operations`
--
ALTER TABLE `operations`
  ADD CONSTRAINT `operations_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`),
  ADD CONSTRAINT `operations_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
