-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 24, 2024 at 01:58 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sh_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE  DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_no` varchar(255) CHARACTER SET utf8mb4 COLLATE  DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `image` varchar(255) DEFAULT NULL
) 

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `first_name`, `last_name`, `email`, `phone_no`, `gender`, `status`, `password`, `created_at`, `updated_at`, `image`) VALUES
(1, 'Admin1', 'Hospital', 'admin@hospital.com', '986532012', NULL, 1, '$2y$10$cq/jpbvUphHSp/b5JdlsseBQqCwAyQE0wY9a2Psla3nyiyu8LJ0U6', '2024-01-18 04:56:07', '2024-01-18 04:56:07', '');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int NOT NULL,
  `patient_id` int DEFAULT NULL,
  `patient_name` varchar(255) DEFAULT NULL,
  `diagnosis` varchar(255) CHARACTER SET utf8mb4 COLLATE  DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `opd_date` datetime DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(255) DEFAULT NULL,
  `canceled_by` varchar(255) DEFAULT NULL
) 

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `patient_name`, `diagnosis`, `doctor_id`, `opd_date`, `description`, `created_at`, `status`, `canceled_by`) VALUES
(58, 18, '', '1', 19, '2024-01-25 00:00:00', 'esRest', '2024-01-24 12:08:28', 'Pending', NULL),
(59, 18, '', '1', 19, '2024-01-24 00:00:00', 'Tetestestes', '2024-01-24 12:09:51', 'Confirm', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `diagnosis`
--

CREATE TABLE `diagnosis` (
  `id` int NOT NULL,
  `diagnosis_name` varchar(255) CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) 

--
-- Dumping data for table `diagnosis`
--

INSERT INTO `diagnosis` (`id`, `diagnosis_name`, `created_at`, `updated_at`) VALUES
(1, 'Test', '2024-01-18 10:26:19', '2024-01-18 10:26:19'),
(4, 'Another Test', '2024-01-18 11:15:44', '2024-01-18 11:15:44'),
(5, 'Dfddg', '2024-01-24 11:29:06', '2024-01-24 11:29:06');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `diagnosis_id` int DEFAULT NULL,
  `designation` varchar(255) NOT NULL,
  `qualification` varchar(255) NOT NULL,
  `gender` int NOT NULL,
  `status` int NOT NULL,
  `specialist` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phone_no` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) 

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `first_name`, `last_name`, `email`, `diagnosis_id`, `designation`, `qualification`, `gender`, `status`, `specialist`, `password`, `created_at`, `updated_at`, `phone_no`, `image`) VALUES
(19, 'Doctor', 'Hospital', 'doctor@hospital.com', 1, 'MBBS', 'MS', 0, 1, 'Surgeon', '$2y$10$/.CrJ1Ie1Y5GTnd/1MjmcOAlC4yPBK20WVSUXf8K.24AzQU1Zr.oa', '2024-01-23 05:09:26', '2024-01-24 13:58:07', '8956230174', '');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE  DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_no` varchar(255) CHARACTER SET utf8mb4 COLLATE  DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `image` varchar(255) DEFAULT NULL
) 

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `first_name`, `last_name`, `email`, `phone_no`, `gender`, `status`, `password`, `created_at`, `updated_at`, `image`) VALUES
(18, 'Patient', 'Hospital', 'patient@hospital.com', '9856230147', 0, 0, '$2y$10$VVFZ/4EdTsVOEC2fkunJbO.FOpwH7ZK9xr9x2I05RPcIr2C6pGE2a', '2024-01-23 05:08:42', '2024-01-23 05:08:42', '');

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` int NOT NULL,
  `appointment_id` int DEFAULT NULL,
  `prescription_details` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) 

--
-- Dumping data for table `prescriptions`
--

INSERT INTO `prescriptions` (`id`, `appointment_id`, `prescription_details`, `created_at`) VALUES
(5, 59, 'Test', '2024-01-24 12:13:50');

-- --------------------------------------------------------

--
-- Table structure for table `receptionists`
--

CREATE TABLE `receptionists` (
  `id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `gender` int NOT NULL,
  `status` int NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phone_no` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) 

--
-- Dumping data for table `receptionists`
--

INSERT INTO `receptionists` (`id`, `first_name`, `last_name`, `email`, `gender`, `status`, `password`, `created_at`, `updated_at`, `phone_no`, `image`) VALUES
(4, 'Receptionist', 'Hopsital', 'receptionist@hospital.com', 0, 1, '$2y$10$CW44bwvlbmiC1t0aun3vPeehoVx5ejbWrkIW2rI09X1QS5EHZOfma', '2024-01-24 13:03:50', '2024-01-24 13:36:59', '8956231047', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE  NOT NULL,
  `roles` varchar(2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) 

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `created_at`, `updated_at`) VALUES
(18, 'admin@hospital.com', 'a', '2024-01-18 10:26:07', '2024-01-18 10:26:07'),
(41, 'patient@hospital.com', 'p', '2024-01-23 05:08:42', '2024-01-23 05:08:42'),
(42, 'doctor@hospital.com', 'd', '2024-01-23 05:09:26', '2024-01-23 05:09:26'),
(43, 'receptionist@hospital.com', 'r', '2024-01-24 13:03:50', '2024-01-24 13:03:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_appointments_doctors` (`doctor_id`),
  ADD KEY `fk_appointments_patients` (`patient_id`);

--
-- Indexes for table `diagnosis`
--
ALTER TABLE `diagnosis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `diagnosis_id` (`diagnosis_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prescriptions` (`appointment_id`);

--
-- Indexes for table `receptionists`
--
ALTER TABLE `receptionists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `diagnosis`
--
ALTER TABLE `diagnosis`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `receptionists`
--
ALTER TABLE `receptionists`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `fk_appointments_doctors` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_appointments_patients` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnosis` (`id`);

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `prescriptions` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
