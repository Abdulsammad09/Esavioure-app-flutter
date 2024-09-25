-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2024 at 12:42 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `esaviour`
--

-- --------------------------------------------------------

--
-- Table structure for table `ambulances`
--

CREATE TABLE `ambulances` (
  `id` int(11) NOT NULL,
  `hospital_name` varchar(255) NOT NULL,
  `driver_name` varchar(255) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `ambulance_type` varchar(100) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `status` enum('available','not available') NOT NULL,
  `driver_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ambulances`
--

INSERT INTO `ambulances` (`id`, `hospital_name`, `driver_name`, `mobile`, `ambulance_type`, `zip_code`, `status`, `driver_id`) VALUES
(1, 'City Hospital', '', '123-456-7890', 'Basic Life Support', '12345', 'available', 2),
(2, 'aaa', '', 'ffdd ycy', 'Basic Life Support', '2580', 'available', 2),
(3, 'hthhh', '', 'hhgffg', 'Advanced Life Support', '888888', 'available', 2),
(4, 'bb', '', '98686867', 'Advanced Life Support', '636985', 'available', 2);

-- --------------------------------------------------------

--
-- Table structure for table `emergency`
--

CREATE TABLE `emergency` (
  `id` int(11) NOT NULL,
  `hospital_name` varchar(255) NOT NULL,
  `patient_name` varchar(255) NOT NULL,
  `basic_and_advance_type` varchar(100) NOT NULL,
  `number` varchar(15) DEFAULT NULL,
  `zip_code` varchar(10) NOT NULL,
  `status` enum('waiting_list','accept','complete') DEFAULT 'waiting_list'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `emergency`
--

INSERT INTO `emergency` (`id`, `hospital_name`, `patient_name`, `basic_and_advance_type`, `number`, `zip_code`, `status`) VALUES
(1, 'Hospital B', 'sammad', 'saas', '55455', '54444', 'waiting_list'),
(2, 'Hospital C', 'hammad', 'gff', '2588', '58085', 'waiting_list');

-- --------------------------------------------------------

--
-- Table structure for table `non_emergency`
--

CREATE TABLE `non_emergency` (
  `id` int(11) NOT NULL,
  `hospital_name` varchar(100) NOT NULL,
  `driver_name` varchar(100) NOT NULL,
  `patient_name` varchar(100) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `special_requirements` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) DEFAULT 'waiting_list'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `non_emergency`
--

INSERT INTO `non_emergency` (`id`, `hospital_name`, `driver_name`, `patient_name`, `contact_number`, `special_requirements`, `created_at`, `status`) VALUES
(1, 'Hospital C', 'ssss', 'ffdd', '03342979970', 'xzzsddd', '2024-09-20 20:01:26', 'Completed'),
(2, 'Hospital C', '30 minutes', 'subhan', '03085578887', 'ccvv', '2024-09-21 08:02:47', 'Completed'),
(3, 'Hospital D', '1 hour', 'fdhhg', '0882688585', 'rrhg', '2024-09-23 10:16:18', 'waiting_list'),
(4, 'Hospital B', '1 hour', 'hello', '36988632569', 'hell urgent need', '2024-09-23 10:33:38', 'waiting_list');

-- --------------------------------------------------------

--
-- Table structure for table `pre_planned_bookings`
--

CREATE TABLE `pre_planned_bookings` (
  `id` int(11) NOT NULL,
  `hospital_name` varchar(255) NOT NULL,
  `driver_name` varchar(255) NOT NULL,
  `patient_name` varchar(255) NOT NULL,
  `pickup_location` varchar(255) NOT NULL,
  `dropoff_location` varchar(255) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `appointment_date` datetime NOT NULL,
  `service_type` varchar(100) NOT NULL,
  `special_requirements` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pre_planned_bookings`
--

INSERT INTO `pre_planned_bookings` (`id`, `hospital_name`, `driver_name`, `patient_name`, `pickup_location`, `dropoff_location`, `contact_number`, `appointment_date`, `service_type`, `special_requirements`, `status`) VALUES
(2, 'City Hospital', 'John Doe', 'Jane Smith', '123 Main St, Cityville', '456 Elm St, Cityville', '1234567890', '2023-09-21 14:00:00', 'Routine Check-up', 'Wheelchair assistance', 'In Progress'),
(3, 'hh', 'he', 'dhfj', 'dhfh', 'djjff', '5859', '0000-00-00 00:00:00', 'xbfbfb', 'xbbf', 'In Progress'),
(4, 'hh', 'he', 'dhfj', 'dhfh', 'djjff', '5859', '0000-00-00 00:00:00', 'xbfbfb', 'xbbf', 'Completed'),
(5, 'fhjtj', 'fhhh', 'dhhdh', 'dhh', 'shdh', '5959', '0000-00-00 00:00:00', 'xbb', 'zxh', 'Pendingasdasda'),
(6, 'Hospital XYZ', 'John Doe', 'Jane Doe', '123 Main St', '456 Elm St', '1234567890', '2024-09-21 14:30:00', 'Ambulance', 'Wheelchair', 'Pending'),
(7, 'frft', 'ffg', 'gggggg', 'ggg', 'ggg', '5966', '2024-09-25 16:22:00', 'cccc', 'ffff', 'Pending'),
(8, 'gjhh', 'bbb', 'bbb', 'bnbbbnnb', 'bnbvb', '236589652369', '2024-09-25 17:34:00', 'basic', 'need it ', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `userss`
--

CREATE TABLE `userss` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `role` enum('admin','driver','user') NOT NULL,
  `status` enum('waiting_list','accept','complete') DEFAULT 'waiting_list'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userss`
--

INSERT INTO `userss` (`id`, `name`, `email`, `password`, `phone`, `role`, `status`) VALUES
(1, 'sam', 'kjansammad@gmail.com', '$2y$10$CkR30WkhzhynmhlFMcJE1uTOcimfY0lzaCpZGtCtkEAIB/vt17gly', '11111111111', 'admin', 'waiting_list'),
(2, 'hammad', 'hammad@gmail.com', '$2y$10$Kagwd8O2dvOgo4m0GIcpFelw7eAUjICo1tMar0jePoxCHocGwX1Qe', '03342979970', 'driver', 'waiting_list'),
(3, 'sammad ', 'kjansammad1@gmail.com', '$2y$10$AyahL4XP.y3HSBKzv8LRHOOhHpI5TJ2lKVWJrzsvU5NPj/g3nN3gO', '0852147', 'user', 'waiting_list'),
(4, 'sammad', 'sammad@gmail.com', '$2y$10$mfe.gcIkl770G2iMXFVGFOAfidZBBS4JPbLNM6jqO3C414QK4Emcu', '11555558', 'user', 'waiting_list'),
(7, 'sammad ', 'sammaad@gmail.com', '$2y$10$GFbNYQnAx2T/2p.biq3gLeX7hDMoD/R4sATAxR1PclNu9IAz8jQKq', '36985236985', 'driver', 'waiting_list');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ambulances`
--
ALTER TABLE `ambulances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`driver_id`);

--
-- Indexes for table `emergency`
--
ALTER TABLE `emergency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `non_emergency`
--
ALTER TABLE `non_emergency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pre_planned_bookings`
--
ALTER TABLE `pre_planned_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userss`
--
ALTER TABLE `userss`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ambulances`
--
ALTER TABLE `ambulances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `emergency`
--
ALTER TABLE `emergency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `non_emergency`
--
ALTER TABLE `non_emergency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pre_planned_bookings`
--
ALTER TABLE `pre_planned_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `userss`
--
ALTER TABLE `userss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ambulances`
--
ALTER TABLE `ambulances`
  ADD CONSTRAINT `ambulances_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `userss` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
