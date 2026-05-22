-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2026 at 10:28 PM
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
-- Table structure for table `aircraft`
--

CREATE TABLE `aircraft` (
  `aircraft_id` int(11) NOT NULL,
  `model` varchar(60) NOT NULL,
  `airline_name` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `aircraft`
--

INSERT INTO `aircraft` (`aircraft_id`, `model`, `airline_name`, `capacity`) VALUES
(1, 'Boeing 737', 'SkyLine Air', 180),
(2, 'Airbus A320', 'SkyLine Air', 160),
(3, 'Boeing 777', 'Desert Wings', 350),
(4, 'Airbus A380', 'Desert Wings', 500),
(5, 'Boeing 737', 'AeroMed', 180),
(6, 'Airbus A321', 'AeroMed', 200),
(7, 'Boeing 787', 'PacificJet', 250),
(8, 'Airbus A350', 'PacificJet', 300),
(9, 'Boeing 737', 'NileAir', 180),
(10, 'Embraer E190', 'NileAir', 100);

-- --------------------------------------------------------

--
-- Table structure for table `airline`
--

CREATE TABLE `airline` (
  `airline_id` int(11) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `contact_person` varchar(50) NOT NULL,
  `airline_name` varchar(50) NOT NULL,
  `current_balance` int(11) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airline`
--

INSERT INTO `airline` (`airline_id`, `phone_number`, `contact_person`, `airline_name`, `current_balance`, `address`) VALUES
(1, '+1-202-555-0101', 'James Carter', 'SkyLine Air', 5000000, '123 Aviation Blvd, New York, NY'),
(2, '+971-4-555-0198', 'Layla Hassan', 'Desert Wings', 3200000, '45 Falcon Rd, Dubai, UAE'),
(3, '+39-02-555-0172', 'Marco Rossi', 'AeroMed', 4100000, '9 Via Roma, Milan, Italy'),
(4, '+86-21-555-0134', 'Chen Wei', 'PacificJet', 6700000, '88 Skyway Ave, Shanghai, China'),
(5, '+20-2-555-0167', 'Amira Nour', 'NileAir', 2800000, '22 Nile Corniche, Cairo, Egypt');

-- --------------------------------------------------------

--
-- Table structure for table `crew`
--

CREATE TABLE `crew` (
  `crew_id` int(11) NOT NULL,
  `assistant_pilot` varchar(50) NOT NULL,
  `major_pilot` varchar(50) NOT NULL,
  `hostess#1` varchar(50) NOT NULL,
  `hostess#2` varchar(50) NOT NULL,
  `aircraft_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crew`
--

INSERT INTO `crew` (`crew_id`, `assistant_pilot`, `major_pilot`, `hostess#1`, `hostess#2`, `aircraft_id`) VALUES
(1, 'Tom Harris', 'David King', 'Sara Lee', 'Mona Ali', 1),
(2, 'Jake Smith', 'Paul Brown', 'Emma Stone', 'Linda Ray', 2),
(3, 'Omar Khalid', 'Samir Nasser', 'Fatima Zahra', 'Hana Saleh', 3),
(4, 'Rami Yousef', 'Tariq Mansoor', 'Lina Aziz', 'Nadia Omar', 4),
(5, 'Luca Bianchi', 'Mario Conti', 'Giulia Ricci', 'Sofia Greco', 5),
(6, 'Pietro Esposito', 'Enrico Russo', 'Chiara Bruno', 'Elena Marino', 6),
(7, 'Li Wei', 'Zhang Fang', 'Mei Lin', 'Xiao Hong', 7),
(8, 'Wang Tao', 'Liu Yang', 'Jiang Hua', 'Chen Xiu', 8),
(9, 'Yusuf Ahmed', 'Karim Saad', 'Dina Farouk', 'Nour Salah', 9),
(10, 'Hassan Magdy', 'Tarek Samy', 'Rania Adel', 'Yasmin Wael', 10);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `position` varchar(30) NOT NULL,
  `airline_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `name`, `birth_date`, `gender`, `position`, `airline_name`) VALUES
(1, 'Alice Monroe', '1985-03-12', 'female', 'Manager', 'SkyLine Air'),
(2, 'Robert Dean', '1990-07-24', 'male', 'Ground Staff', 'SkyLine Air'),
(3, 'Nancy White', '1988-11-05', 'female', 'Ticketing Agent', 'SkyLine Air'),
(4, 'Brian Scott', '1992-01-30', 'male', 'Technician', 'SkyLine Air'),
(5, 'Fatima Al-Amin', '1987-06-18', 'female', 'Manager', 'Desert Wings'),
(6, 'Khalid Noor', '1993-09-22', 'male', 'Ground Staff', 'Desert Wings'),
(7, 'Sara Malik', '1991-04-14', 'female', 'Ticketing Agent', 'Desert Wings'),
(8, 'Adel Hamdan', '1989-12-03', 'male', 'Technician', 'Desert Wings'),
(9, 'Giovanna Ricci', '1986-08-27', 'female', 'Manager', 'AeroMed'),
(10, 'Antonio Marini', '1994-02-15', 'male', 'Ground Staff', 'AeroMed'),
(11, 'Carla Ferretti', '1990-10-09', 'female', 'Ticketing Agent', 'AeroMed'),
(12, 'Davide Leone', '1988-05-21', 'male', 'Technician', 'AeroMed'),
(13, 'Ying Zhang', '1985-07-31', 'female', 'Manager', 'PacificJet'),
(14, 'Bo Chen', '1992-03-17', 'male', 'Ground Staff', 'PacificJet'),
(15, 'Hui Wang', '1989-11-28', 'female', 'Ticketing Agent', 'PacificJet'),
(16, 'Jun Li', '1993-08-06', 'male', 'Technician', 'PacificJet'),
(17, 'Mariam Lotfy', '1987-01-19', 'female', 'Manager', 'NileAir'),
(18, 'Ahmed Zaki', '1991-06-25', 'male', 'Ground Staff', 'NileAir'),
(19, 'Heba Mostafa', '1990-09-13', 'female', 'Ticketing Agent', 'NileAir'),
(20, 'Omar Fathy', '1994-04-02', 'male', 'Technician', 'NileAir');

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

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL,
  `origin` varchar(50) NOT NULL,
  `classification` enum('domestic','international') NOT NULL,
  `distance` int(11) NOT NULL,
  `destination` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `route`
--

INSERT INTO `route` (`route_id`, `origin`, `classification`, `distance`, `destination`) VALUES
(1, 'New York', 'domestic', 2800, 'Los Angeles'),
(2, 'Dubai', 'international', 5500, 'London'),
(3, 'Milan', 'international', 1200, 'Paris'),
(4, 'Shanghai', 'international', 9200, 'San Francisco'),
(5, 'Cairo', 'international', 3500, 'Frankfurt'),
(6, 'Cairo', 'domestic', 450, 'Alexandria');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `description` varchar(250) NOT NULL,
  `airline_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `transaction_type` enum('buy','sell') NOT NULL,
  `transaction_category` enum('maintenance','operating costs') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `amount`, `description`, `airline_id`, `date`, `transaction_type`, `transaction_category`) VALUES
(1, 56000, 'Ticket sales - NY to LA flight', 1, '2026-05-01', 'sell', NULL),
(2, 12000, 'Engine maintenance - Boeing 737', 1, '2026-05-03', 'buy', 'maintenance'),
(3, 8500, 'Fuel and ground operations', 1, '2026-05-05', 'buy', 'operating costs'),
(4, 306000, 'Ticket sales - Dubai to London', 2, '2026-05-03', 'sell', NULL),
(5, 22000, 'Landing gear repair - Boeing 777', 2, '2026-05-04', 'buy', 'maintenance'),
(6, 15000, 'Airport handling fees', 2, '2026-05-06', 'buy', 'operating costs'),
(7, 64600, 'Ticket sales - Milan to Paris', 3, '2026-05-05', 'sell', NULL),
(8, 18000, 'Airframe inspection - Boeing 737', 3, '2026-05-06', 'buy', 'maintenance'),
(9, 11000, 'Staff overtime and catering costs', 3, '2026-05-07', 'buy', 'operating costs'),
(10, 240100, 'Ticket sales - Shanghai to SF', 4, '2026-05-07', 'sell', NULL),
(11, 35000, 'Avionics upgrade - Boeing 787', 4, '2026-05-08', 'buy', 'maintenance'),
(12, 19000, 'Fuel surcharge and navigation fees', 4, '2026-05-09', 'buy', 'operating costs'),
(13, 105000, 'Ticket sales - Cairo to Frankfurt', 5, '2026-05-09', 'sell', NULL),
(14, 9500, 'Brake system overhaul - Boeing 737', 5, '2026-05-10', 'buy', 'maintenance'),
(15, 6200, 'Ground crew wages and airport fees', 5, '2026-05-11', 'buy', 'operating costs');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aircraft`
--
ALTER TABLE `aircraft`
  ADD PRIMARY KEY (`aircraft_id`),
  ADD KEY `aircraft_ibfk_1` (`airline_name`);

--
-- Indexes for table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`airline_id`),
  ADD UNIQUE KEY `airline_name` (`airline_name`);

--
-- Indexes for table `crew`
--
ALTER TABLE `crew`
  ADD PRIMARY KEY (`crew_id`),
  ADD KEY `crew_ibfk_1` (`aircraft_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `employee_ibfk_1` (`airline_name`);

--
-- Indexes for table `operations`
--
ALTER TABLE `operations`
  ADD PRIMARY KEY (`route_id`,`aircraft_id`),
  ADD KEY `aircraft_id` (`aircraft_id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`route_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aircraft`
--
ALTER TABLE `aircraft`
  MODIFY `aircraft_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `airline`
--
ALTER TABLE `airline`
  MODIFY `airline_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `crew`
--
ALTER TABLE `crew`
  MODIFY `crew_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aircraft`
--
ALTER TABLE `aircraft`
  ADD CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`airline_name`) ON DELETE CASCADE;

--
-- Constraints for table `crew`
--
ALTER TABLE `crew`
  ADD CONSTRAINT `crew_ibfk_1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`) ON DELETE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`airline_name`) REFERENCES `airline` (`airline_name`) ON DELETE CASCADE;

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
