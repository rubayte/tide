-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 14, 2015 at 11:25 AM
-- Server version: 5.6.21
-- PHP Version: 5.5.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tide`
--

-- --------------------------------------------------------

--
-- Table structure for table `anonymous_tickets`
--

CREATE TABLE IF NOT EXISTS `anonymous_tickets` (
  `email` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `ticket` text NOT NULL,
  `plan` int(10) NOT NULL,
  `status` enum('open','closed','','') NOT NULL,
  `createdAt` datetime NOT NULL,
  `lastEditAt` datetime NOT NULL,
  `lastEditBy` datetime NOT NULL,
`id` int(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `anonymous_tickets`
--

INSERT INTO `anonymous_tickets` (`email`, `name`, `ticket`, `plan`, `status`, `createdAt`, `lastEditAt`, `lastEditBy`, `id`) VALUES
('r.rahman@nki.nl', 'Rubayte Rahman', 'aasjdbjashbdiasudb]ads\r\nasda\r\nsd\r\nasd\r\nasd\r\nas\r\n', 0, 'open', '2015-09-22 17:16:27', '2015-09-22 17:16:27', '0000-00-00 00:00:00', 1),
('asdas', 'asdasd', 'asdasd', 2, 'open', '2015-09-22 17:19:38', '2015-09-22 17:19:38', '0000-00-00 00:00:00', 2),
('asd', 'asd', 'asd', 0, 'open', '2015-10-12 13:31:59', '2015-10-12 13:31:59', '0000-00-00 00:00:00', 3),
('asdas', 'asdasd', 'asdasda\r\nsd\r\nas\r\ndas\r\nd', 0, 'open', '2015-10-12 13:33:29', '2015-10-12 13:33:29', '0000-00-00 00:00:00', 4),
('asda', 'asd', 'asd', 0, 'open', '2015-10-12 14:06:45', '2015-10-12 14:06:45', '0000-00-00 00:00:00', 5),
('asdasd', 'asd', 'how about this?', 0, 'open', '2015-10-12 14:12:41', '2015-10-12 14:12:41', '0000-00-00 00:00:00', 6),
('asd', 'asd', 'asdasd  dasd as as ', 0, 'open', '2015-10-12 14:14:36', '2015-10-12 14:14:36', '0000-00-00 00:00:00', 7),
('asdasd', 'asd', 'askjdbjasd ashd asda asdlkjaskd adnas d ', 0, 'open', '2015-10-12 14:14:54', '2015-10-12 14:14:54', '0000-00-00 00:00:00', 8),
('asd', 'asdasd', 'asdasd', 0, 'open', '2015-10-12 14:44:15', '2015-10-12 14:44:15', '0000-00-00 00:00:00', 9),
('asdasd', 'asd', 'asdasd asdsa d asdnsadn asdjhsadkjhb', 0, 'open', '2015-10-12 14:44:37', '2015-10-12 14:44:37', '0000-00-00 00:00:00', 10);

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE IF NOT EXISTS `plans` (
  `planName` varchar(20) NOT NULL,
  `createdAt` datetime NOT NULL,
  `lastEditAt` datetime NOT NULL,
`id` int(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`planName`, `createdAt`, `lastEditAt`, `id`) VALUES
('Academic', '2015-08-13 00:00:00', '2015-08-13 00:00:00', 1),
('SME', '2015-08-13 00:00:00', '2015-08-13 00:00:00', 2),
('Corporate', '2015-08-13 00:00:00', '2015-08-13 00:00:00', 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `userEmail` varchar(255) NOT NULL,
  `userFullName` varchar(255) NOT NULL,
  `userOrganization` varchar(1024) NOT NULL,
  `userOrganizationAddress` text NOT NULL,
  `userContactNumber` varchar(20) NOT NULL,
  `userOrganizationUrl` varchar(255) NOT NULL,
  `userPass` varchar(255) NOT NULL,
  `userPassSalt` varchar(255) NOT NULL,
  `updatePass?` tinyint(1) NOT NULL,
  `isAdmin?` tinyint(1) NOT NULL,
  `isAuthorized?` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `lastEditAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userEmail`, `userFullName`, `userOrganization`, `userOrganizationAddress`, `userContactNumber`, `userOrganizationUrl`, `userPass`, `userPassSalt`, `updatePass?`, `isAdmin?`, `isAuthorized?`, `createdAt`, `lastEditAt`) VALUES
('asd', 'asd', 'asd', 'asd', '2345324', 'http://www.nki.nl', '$2a$10$qvfXq81o/tWwdh6d7mFfBe3R1wu4mn.WaLShhFFdXlQlZ/1HLAqya', '$2a$10$qvfXq81o/tWwdh6d7mFfBe', 1, 0, 0, '2015-10-13 16:22:19', '2015-10-13 16:22:19'),
('r.rahman@nki.nl', 'Rubayte Rahman', 'Netherlands Cancer Institute - NKI', 'Plesmanlaan Amsterdam', '213213421', 'www.nki.nl', '$2a$10$e9xBNft9MjCfuGnuKDgP3u6tTxt.t0j0bnCYDenV6vg8cBzU057Pe', '$2a$10$e9xBNft9MjCfuGnuKDgP3u', 1, 0, 1, '2015-09-16 16:06:20', '2015-09-16 16:06:20'),
('rubayte.iut@gmail.com', 'Rubayte Rahman', 'Netherlands Cancer Institute - NKI', 'Plesmanlaan 121 1066CX Amsterdam', '7889', 'www.nki.nl', '$2a$10$htHXxeKNYx.AAnKqMGIc7.G6v2V9Gtr24jwD0/cMNQUri.BKPynAa', '$2a$10$htHXxeKNYx.AAnKqMGIc7.', 0, 0, 1, '2015-08-13 14:32:35', '2015-08-17 13:59:22'),
('testuser@test.com', 'Test User', 'Netherlands Cancer Institute - NKI', 'Plesmanlaan 121 1066CX Amsterdam', '7889', 'www.nki.nl', '$2a$10$ScyKYWAThyamV0gsRFOcBOlrjb/UGDPTwQuJRKjby3kisHgHa3Hg.', '$2a$10$ScyKYWAThyamV0gsRFOcBO', 0, 0, 1, '2015-08-20 13:46:17', '2015-08-20 13:46:17');

-- --------------------------------------------------------

--
-- Table structure for table `user_created_tickets`
--

CREATE TABLE IF NOT EXISTS `user_created_tickets` (
  `user` varchar(255) NOT NULL,
  `ticket` text NOT NULL,
  `status` enum('open','closed','','') NOT NULL,
  `createdAt` datetime NOT NULL,
  `lastEditAt` datetime NOT NULL,
  `lastEditBy` varchar(255) NOT NULL,
`id` int(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_created_tickets`
--

INSERT INTO `user_created_tickets` (`user`, `ticket`, `status`, `createdAt`, `lastEditAt`, `lastEditBy`, `id`) VALUES
('rubayte.iut@gmail.com', 'test ticket', 'open', '2015-09-21 14:32:54', '2015-09-21 14:32:54', '-', 1),
('rubayte.iut@gmail.com', 'another ticket!!', 'open', '2015-09-21 14:37:08', '2015-09-21 14:37:08', '-', 2),
('rubayte.iut@gmail.com', 'asd', 'open', '2015-09-21 14:49:11', '2015-09-21 14:49:11', '-', 3),
('rubayte.iut@gmail.com', 'asdsa', 'open', '2015-09-21 15:15:14', '2015-09-21 15:15:14', '-', 4);

-- --------------------------------------------------------

--
-- Table structure for table `user_ordered_plans`
--

CREATE TABLE IF NOT EXISTS `user_ordered_plans` (
  `user` varchar(255) NOT NULL,
  `planId` int(20) NOT NULL,
  `isAuthorized?` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `lastEditAt` datetime NOT NULL,
`id` int(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_ordered_plans`
--

INSERT INTO `user_ordered_plans` (`user`, `planId`, `isAuthorized?`, `createdAt`, `lastEditAt`, `id`) VALUES
('rubayte.iut@gmail.com', 1, 0, '2015-08-13 14:32:35', '2015-08-13 14:32:35', 4),
('testuser@test.com', 1, 0, '2015-08-20 13:46:17', '2015-08-20 13:46:17', 8),
('r.rahman@nki.nl', 2, 1, '2015-09-16 16:06:20', '2015-09-16 16:06:20', 10),
('asd', 2, 0, '2015-10-13 16:22:19', '2015-10-13 16:22:19', 14);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anonymous_tickets`
--
ALTER TABLE `anonymous_tickets`
 ADD PRIMARY KEY (`id`), ADD KEY `email` (`email`,`plan`,`status`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`userEmail`);

--
-- Indexes for table `user_created_tickets`
--
ALTER TABLE `user_created_tickets`
 ADD PRIMARY KEY (`id`), ADD KEY `user` (`user`,`status`);

--
-- Indexes for table `user_ordered_plans`
--
ALTER TABLE `user_ordered_plans`
 ADD PRIMARY KEY (`id`), ADD KEY `planId` (`planId`), ADD KEY `user` (`user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anonymous_tickets`
--
ALTER TABLE `anonymous_tickets`
MODIFY `id` int(255) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_created_tickets`
--
ALTER TABLE `user_created_tickets`
MODIFY `id` int(255) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user_ordered_plans`
--
ALTER TABLE `user_ordered_plans`
MODIFY `id` int(255) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
