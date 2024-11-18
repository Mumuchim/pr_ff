-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2024 at 01:45 PM
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
-- Database: `auth`
--

-- --------------------------------------------------------

--
-- Table structure for table `local_storage`
--

CREATE TABLE `local_storage` (
  `id` int(11) NOT NULL,
  `storage_key` varchar(255) NOT NULL,
  `storage_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `local_storage`
--

INSERT INTO `local_storage` (`id`, `storage_key`, `storage_value`) VALUES
(1, 'pinPositions', '[{\"pinId\":\"pin-1731904986149\",\"top\":\"264px\",\"left\":\"785px\",\"imgSrc\":null}]'),
(2, 'pinPositions', '[{\"pinId\":\"pin-1731904986149\",\"top\":\"264px\",\"left\":\"785px\",\"imgSrc\":\"http://localhost:3000/null\"},{\"pinId\":\"pin-1731931944278\",\"top\":\"168px\",\"left\":\"451px\",\"imgSrc\":\"http://localhost:3000/null\"},{\"pinId\":\"pin-1731932061102\",\"top\":\"224px\",\"left\":\"1087px\",\"imgSrc\":null}]');

-- --------------------------------------------------------

--
-- Table structure for table `pins`
--

CREATE TABLE `pins` (
  `id` int(11) NOT NULL,
  `pin_id` varchar(255) NOT NULL,
  `top` varchar(50) NOT NULL,
  `left` varchar(50) NOT NULL,
  `img_src` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `id` int(11) NOT NULL,
  `user` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `details` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'default-pp.png',
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report`
--

-- INSERT INTO `report` (`id`, `user`, `title`, `details`, `type`, `image`, `date`) VALUES
-- (80, 'Pauline Carag', 'dsaadsasd', '            dsadasdasd', 'cleaning', 'default-pp.png', '2024-11-18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

-- INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `password`, `role`) VALUES
-- (1, 'hi', '', 'hello', '$2y$10$sHpcSZd5RPW3oud6euulMueObXCFBKmmFQ54c1n/womZg4kYfkyYe', 'student'),
-- (2, 'jhewen shene', '', 'wenji', '$2y$10$YtjMm6iCU7IT6CKxLLgdDOTlwnS3xROoVXFPzIpyVh3A4Tjh6ufcK', 'student'),
-- (3, 'test', '', 'test@gmail.com', '$2y$10$CzmnG/oegkuqR6jL8tSQ/O5Ynyct8ZV70DeE1uCTnPhMqffQMtZ9G', 'student'),
-- (5, 'Jhewen Doldol', '', 'js@gmail.com', '$2y$10$ROdLRSHNfXdoNzaWePLlTOHeyzN5v8lLkep566TWhknw9cJowAbVu', 'student'),
-- (6, 'Pauline', 'Carag', 'pc@gmail.com', '$2y$10$qWmF5t1xKj6QJ16KEFnTJ.fe.qMC3qHJQ8ztIKC3ubCmxK6HbtHUK', 'student'),
-- (7, 'Joan', 'Trocio', 'jt@gmail.com', '$2y$10$m7e69JW.sITuYTzy4CvE8eecF26K0Haz4z7jZN5E.9BtJl0qU9Znq', 'student'),
-- (8, 'Jhewen', 'Doldol', 'jd@gmail.com', '$2y$10$qKMnE7eNL.8Fe0cpfExv6.QYnXDTJx29534OeH4i/WyHKvKRz9Tqq', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `local_storage`
--
ALTER TABLE `local_storage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pins`
--
ALTER TABLE `pins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `local_storage`
--
ALTER TABLE `local_storage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pins`
--
ALTER TABLE `pins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
