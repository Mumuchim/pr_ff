-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 17, 2024 at 06:33 AM
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
-- (55, '', 'dasdasd', '            asdasdasd', 'electrical-hazard', 'IMG-6738936faa82e8.18154084.jpg', '2024-11-28'),
-- (56, 'John Doe', 'Test Title', 'Test Details', 'caution', 'default-pp.png', '2024-11-16'),
-- (57, '', 'dasdasda', '                                            dadsadsads', 'request', 'IMG-6738c3c42cf3c1.82211065.jpg', '2024-11-17'),
-- (58, '', 'dadasd', '                                            dasdadasd', 'electrical-hazard', 'IMG-6738c66532d4f8.76706876.jpg', '2024-11-17'),
-- (59, '', 'dasdasd', 'asdasdasd', 'cleaning', 'IMG-6738cb0922da26.55293011.jpg', '2024-11-17'),
-- (60, '', 'asdasdasd', '                                            dasdasdas', 'electrical-hazard', 'IMG-6738cd9a5fd647.00252197.jpg', '2024-11-17'),
-- (61, '', 'testing ', 'asdasdasd', 'cleaning', 'IMG-67397703b932f8.20485228.jpg', '2024-11-17'),
-- (62, '', 'asdasd', 'asdasdd', 'cleaning', 'IMG-67397936676404.33885644.jpg', '2024-11-17'),
-- (63, 'diet pepsi', 'asdasd', '            dasdadsad', 'cleaning', 'IMG-67397a7fc2f2b1.74028559.jpg', '2024-11-17'),
-- (64, 'pau', 'walang sabon', 'wala po sabon sa cr            ', 'request', 'IMG-67397b3a06eb57.36368576.jpg', '2024-11-17'),
-- (65, 'newjeans', 'asdasdas', 'dsadasd', 'electrical-hazard', 'IMG-67397da756ac78.33468691.jpg', '2024-11-17'),
-- (66, 'test ', 'supernatural', 'shajdks', 'cleaning', 'IMG-67397deae9a281.17548100.jpg', '2024-11-17'),
-- (67, 'Pauline Carag', 'sis', 'dasdasd', 'it-maintenance', 'IMG-67397e32e15333.02049759.jpg', '2024-11-17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `lname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

-- INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `password`) VALUES
-- (1, 'hi', '', 'hello', '$2y$10$sHpcSZd5RPW3oud6euulMueObXCFBKmmFQ54c1n/womZg4kYfkyYe'),
-- (2, 'jhewen shene', '', 'wenji', '$2y$10$YtjMm6iCU7IT6CKxLLgdDOTlwnS3xROoVXFPzIpyVh3A4Tjh6ufcK'),
-- (3, 'test', '', 'test@gmail.com', '$2y$10$CzmnG/oegkuqR6jL8tSQ/O5Ynyct8ZV70DeE1uCTnPhMqffQMtZ9G'),
-- (5, 'Jhewen Doldol', '', 'js@gmail.com', '$2y$10$ROdLRSHNfXdoNzaWePLlTOHeyzN5v8lLkep566TWhknw9cJowAbVu'),
-- (6, 'Pauline', 'Carag', 'pc@gmail.com', '$2y$10$qWmF5t1xKj6QJ16KEFnTJ.fe.qMC3qHJQ8ztIKC3ubCmxK6HbtHUK');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `pins`
--
ALTER TABLE `pins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
