-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2024 at 05:30 AM
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
-- Database: `social`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth`
--

CREATE TABLE `auth` (
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `pfp` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth`
--

INSERT INTO `auth` (`name`, `email`, `password`, `pfp`) VALUES
('', '', '', 'static/media/pfp/'),
('\' ` \" -', '\'!@gmail.com', '\'`\"', 'static/media/pfp/'),
('Dabi', 'dabi@gmail.com', '1234', 'static/media/pfp/937823.jpg'),
('Frog', 'frog@gmail.com', '1234', 'static/media/pfp/940133092402823198.webp'),
('hello man', 'hello@gmail.com', '123', NULL),
('Himanshu', 'himanshu@gmail.com', '1234', 'static/media/pfp/618290.png'),
('Himanshu 1', 'himanshu@gmail.com', '12345', NULL),
('Ken', 'ken@gmail.com', '1234', 'static/media/pfp/545905.jpg'),
('Luffy', 'luffy@gmail.com', '1234', 'static/media/pfp/319176.jpg'),
('Pain', 'pain@gmail.com', '12', 'static/media/pfp/57496.png'),
('Person', 'person@gmail.com', '1234', 'static/media/pfp/'),
('Phone man', 'phone@gmail.com', '1234', 'static/media/pfp/1731336719767.jpeg'),
('Roshni Chandnani', 'roshni.chandnani01@gmail.com', '12345', 'static/media/pfp/'),
('Zoro', 'fakezoro@gmail.com', '1', 'static/media/pfp/164942.png');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(100) NOT NULL,
  `post_id` int(100) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `post_id`, `name`, `time`, `comment`) VALUES
(1, 4, 'Zoro', '2024-11-17 03:48', 'this is my first comment'),
(8, 6, 'Luffy', '2024-11-17 22:41', 'wau theres nothing in the post'),
(9, 6, 'Luffy', '2024-11-17 22:41', '\''),
(10, 7, 'Luffy', '2024-11-17 22:57', 'hello'),
(11, 9, 'Dabi', '2024-11-18 14:22', 'Yo hello whats up'),
(12, 9, 'Dabi', '2024-11-18 14:24', 'hello'),
(13, 9, 'Dabi', '2024-11-18 14:24', 'yo yo'),
(14, 9, 'Dabi', '2024-11-18 14:24', 'hehe'),
(15, 9, 'Phone man', '2024-11-18 19:55', 'Yoo'),
(16, 9, 'Himanshu', '2024-11-19 09:54', 'hello'),
(17, 10, 'Himanshu', '2024-11-19 09:58', 'ghello'),
(18, 10, 'Zoro', '2024-11-20 22:04', 'ho'),
(29, 10, 'Roshni Cha', '2024-11-21 23:28', 'Hi'),
(30, 32, 'Zoro', '2024-11-22 02:47', 'ist his working lets see \'/ \\ \'\" \' ; : `'),
(31, 34, '\' ` \" -', '2024-11-22 21:56', 'hey testing \' ` \"');

-- --------------------------------------------------------

--
-- Table structure for table `content`
--

CREATE TABLE `content` (
  `msg_id` int(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  `caption` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `content`
--

INSERT INTO `content` (`msg_id`, `name`, `time`, `path`, `caption`) VALUES
(1, 'hello man', '2024-11-1617:11', 'static/media/2499.jpg', 'bleach'),
(2, 'hello man', '2024-11-16 17:14', 'static/media/14808.jpg', 'Death note'),
(3, 'hello man', '2024-11-16 17:41', 'static/media/39868.png', 'light'),
(4, 'Pain', '2024-11-16 17:51', 'static/media/57496.png', 'pain'),
(6, 'Person', '2024-11-17 20:52', 'static/media/', ''),
(7, 'Person', '2024-11-17 20:53', 'static/media/106774.jpg', ''),
(8, 'Dabi', '2024-11-18 09:39', 'static/media/553934.jpg', 'Nine tails'),
(9, 'Dabi', '2024-11-18 14:22', 'static/media/589730.jpg', 'hello'),
(10, 'Himanshu', '2024-11-19 09:55', 'static/media/526888.jpg', 'how are you'),
(23, 'Zoro', '2024-11-21 09:41', 'static/media/589781.jpg', 'pirate'),
(24, 'Zoro', '2024-11-21 09:41', 'static/media/149386.jpg', 'gost'),
(26, 'Zoro', '2024-11-21 19:56', 'static/media/408565.png', 'cool'),
(28, 'Himanshu', '2024-11-21 21:48', 'static/media/654247.jpg', 'opm'),
(32, 'Roshni Chandnani', '2024-11-21 23:37', 'static/media/1000969398.jpg', 'Read guysss guysss'),
(33, 'Himanshu', '2024-11-22 19:21:48', 'static/media/89384.jpg', 'yes \' \" ] { `\r\n\''),
(34, '\' ` \" -', '2024-11-22 21:55:41', 'static/media/699287.jpg', 'bug fix test \' ` \"\r\nedit: a;osfj \' `');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `post_id` int(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`post_id`, `name`) VALUES
(3, 'Zoro'),
(4, 'Zoro'),
(4, 'Luffy'),
(7, 'Luffy'),
(7, 'Dabi'),
(8, 'Dabi'),
(9, 'Dabi'),
(9, 'Phone man'),
(9, 'Himanshu'),
(10, 'Himanshu'),
(10, 'Zoro'),
(9, 'Zoro'),
(24, 'Roshni Chandnani'),
(26, 'Roshni Chandnani'),
(23, 'Roshni Chandnani'),
(10, 'Roshni Chandnani'),
(9, 'Roshni Chandnani'),
(8, 'Roshni Chandnani'),
(7, 'Roshni Chandnani'),
(6, 'Roshni Chandnani'),
(4, 'Roshni Chandnani'),
(3, 'Roshni Chandnani'),
(2, 'Roshni Chandnani'),
(1, 'Roshni Chandnani'),
(26, 'Zoro'),
(32, 'Himanshu'),
(34, '\' ` \" -');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(100) NOT NULL,
  `sender` varchar(100) DEFAULT NULL,
  `receiver` varchar(100) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  `text` varchar(10000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender`, `receiver`, `time`, `text`) VALUES
(1, 'Himanshu', 'global', '2024-11-18 22:20:43', 'hello guys how are you all!!'),
(2, 'Zoro', 'global', '2024-11-19 10:27:17', 'hello'),
(3, 'Zoro', 'global', '2024-11-19 10:30:43', 'i have been wanting to talk to you guys for so long, i am doing really good what about you guys'),
(4, 'Zoro', 'global', '2024-11-19 11:09:33', 'yo'),
(5, 'Zoro', 'global', '2024-11-19 20:30:39', 'hoho'),
(6, 'Zoro', 'global', '2024-11-19 20:31:40', 'aha'),
(7, 'Zoro', 'global', '2024-11-19 20:32:51', 'hmmmm'),
(8, 'Zoro', 'global', '2024-11-19 20:40:09', 'haha'),
(9, 'Zoro', 'global', '2024-11-19 20:42:06', 'yo'),
(10, 'Zoro', 'global', '2024-11-19 20:42:58', 'hey'),
(11, 'Zoro', 'global', '2024-11-19 20:52:09', 'how is it going'),
(12, 'Zoro', 'global', '2024-11-19 20:53:31', 'man this is taking so long'),
(13, 'Zoro', 'global', '2024-11-19 20:54:46', 'ok this must be the final test'),
(14, 'Zoro', 'global', '2024-11-19 20:55:56', 'what about now huh'),
(15, 'Zoro', 'global', '2024-11-19 21:04:17', 'lets see if this is working'),
(16, 'Zoro', 'global', '2024-11-19 21:04:42', 'aite'),
(17, 'Zoro', 'global', '2024-11-19 21:06:50', 'i am here'),
(18, 'Zoro', 'global', '2024-11-19 21:08:08', 'now this should work'),
(19, 'Zoro', 'global', '2024-11-19 21:09:46', 'hey guys'),
(20, 'Phone man', 'global', '2024-11-19 21:09:56', 'oo this seems to be working'),
(21, 'Zoro', 'global', '2024-11-19 21:10:56', 'ye'),
(22, 'Zoro', 'global', '2024-11-19 21:12:30', 'hmm'),
(23, 'Zoro', 'global', '2024-11-19 21:12:41', 'wait this is cool'),
(24, 'Zoro', 'global', '2024-11-19 21:14:05', 'ok without animations now'),
(25, 'Zoro', 'global', '2024-11-19 21:14:11', 'ya '),
(26, 'Zoro', 'global', '2024-11-19 21:14:16', 'that totally worked'),
(27, 'Zoro', 'global', '2024-11-19 21:33:22', 'now this is cool'),
(28, 'Zoro', 'global', '2024-11-19 22:26:01', ''),
(29, 'Zoro', 'global', '2024-11-19 22:26:39', ''),
(30, 'Zoro', 'global', '2024-11-19 22:26:40', ''),
(31, 'Zoro', 'global', '2024-11-19 22:26:40', ''),
(32, 'Zoro', 'global', '2024-11-19 22:26:41', ''),
(33, 'Zoro', 'global', '2024-11-19 22:26:48', ''),
(34, 'Zoro', 'global', '2024-11-19 22:27:01', ''),
(35, 'Zoro', 'global', '2024-11-19 22:27:21', 'wth'),
(36, 'Zoro', 'global', '2024-11-20 20:32:28', 'try'),
(37, 'Zoro', 'Himanshu', '2024-11-20 20:32:57', 'hello himanshu'),
(38, 'Himanshu', 'Zoro', '2024-11-20 22:05:49', 'hey'),
(39, 'Zoro', 'Himanshu', '2024-11-20 22:06:24', 'hows it goin'),
(40, 'Zoro', 'Himanshu', '2024-11-21 10:13:53', 'hello'),
(41, 'Himanshu', 'Zoro', '2024-11-21 10:14:46', 'yo'),
(42, 'Himanshu', 'global', '2024-11-21 21:52:23', 'helllo'),
(43, 'Himanshu', 'Zoro', '2024-11-21 21:52:29', 'hey'),
(44, 'Zoro', 'Himanshu', '2024-11-21 21:52:45', 'yo whatsup'),
(45, 'Himanshu', 'Zoro', '2024-11-21 21:53:09', 'nothing really'),
(46, 'Zoro', 'Himanshu', '2024-11-21 21:53:13', 'crazzy'),
(47, 'Himanshu', 'Dabi', '2024-11-21 21:59:24', 'hey'),
(48, 'Zoro', 'Himanshu', '2024-11-21 22:01:10', 'hello'),
(49, 'Roshni Chandnani', 'global', '2024-11-21 23:29:30', 'Hi'),
(50, 'Frog', 'global', '2024-11-21 23:29:45', 'Hello'),
(51, 'Roshni Chandnani', 'global', '2024-11-21 23:29:58', 'Ho'),
(52, 'Roshni Chandnani', 'Frog', '2024-11-21 23:31:12', 'Hi'),
(53, 'Frog', 'Roshni Chandnani', '2024-11-21 23:31:27', 'Henlo'),
(54, 'Roshni Chandnani', 'Frog', '2024-11-21 23:31:39', 'Ok'),
(55, 'Frog', 'Roshni Chandnani', '2024-11-21 23:31:42', 'No ok'),
(56, 'Roshni Chandnani', 'Frog', '2024-11-21 23:31:45', 'Gotchya'),
(57, 'Frog', 'Roshni Chandnani', '2024-11-21 23:31:54', 'What did you get'),
(58, 'Roshni Chandnani', 'Frog', '2024-11-21 23:32:12', 'Working'),
(59, 'Frog', 'Roshni Chandnani', '2024-11-21 23:32:29', 'Nu'),
(60, 'Roshni Chandnani', 'Frog', '2024-11-21 23:32:48', '\"'),
(61, 'Roshni Chandnani', 'Frog', '2024-11-21 23:33:15', '\'\''),
(62, 'Zoro', 'global', '2024-11-22 02:46:02', 'helo'),
(63, 'Zoro', 'global', '2024-11-22 02:46:07', 'holy \''),
(64, 'Zoro', 'global', '2024-11-22 02:46:18', '\' . / \\ is this working'),
(65, 'Zoro', 'global', '2024-11-22 02:46:20', 'crazy'),
(66, 'Zoro', 'global', '2024-11-22 03:09:40', 'ho'),
(67, '\' ` \" -', 'global', '2024-11-22 22:01:29', 'hey'),
(68, '\' ` \" -', 'global', '2024-11-22 22:01:46', 'a'),
(69, '\' ` \" -', 'global', '2024-11-22 22:01:53', 'huh'),
(70, '\' ` \" -', 'Himanshu', '2024-11-22 22:02:07', 'oka'),
(71, '\' ` \" -', 'global', '2024-11-22 22:11:02', 'hmm'),
(72, '\' ` \" -', 'global', '2024-11-22 22:17:00', 'hey'),
(73, 'Zoro', 'global', '2024-11-22 22:20:06', 'helo'),
(74, 'Zoro', 'global', '2024-11-22 22:28:00', 'hey'),
(75, 'Zoro', 'global', '2024-11-22 23:45:01', 'hey'),
(76, 'Zoro', 'global', '2024-11-22 23:45:05', 'woah'),
(77, 'Zoro', 'global', '2024-11-22 23:45:52', ' \' asd \" '),
(78, 'Zoro', 'global', '2024-11-22 23:45:55', '\" asjfk \''),
(79, '\' ` \" -', 'global', '2024-11-22 23:46:31', '\' hoho'),
(80, '\' ` \" -', 'global', '2024-11-22 23:46:41', 'ho ho'),
(81, '\' ` \" -', 'global', '2024-11-22 23:47:03', 'ey'),
(82, 'Zoro', 'global', '2024-11-22 23:47:18', 'huh'),
(83, '\' ` \" -', 'global', '2024-11-22 23:48:02', 'hmm'),
(84, '\' ` \" -', 'global', '2024-11-22 23:48:10', 'oh it works'),
(85, '\' ` \" -', 'global', '2024-11-22 23:48:22', 'now idea how eval works but okaa'),
(86, 'Zoro', 'global', '2024-11-22 23:48:31', 'great'),
(87, 'Zoro', 'Himanshu', '2024-11-22 23:49:54', 'uhh \' hey'),
(88, 'Zoro', 'Himanshu', '2024-11-22 23:51:03', 'is this working fine'),
(89, 'Zoro', 'Himanshu', '2024-11-22 23:51:08', 'ya seems \'like it'),
(90, 'Zoro', 'Himanshu', '2024-11-22 23:51:11', 'aps \\');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`msg_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `content`
--
ALTER TABLE `content`
  MODIFY `msg_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
