
--
-- Database: `inet_busbooking`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblbooking`
--

CREATE TABLE IF NOT EXISTS `tblbooking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `schedule_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `number_of_seats` int(2) NOT NULL,
  `fare_amount` float NOT NULL,
  `total_amount` float NOT NULL,
  `date_of_booking` datetime NOT NULL,
  `booking_status` int(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `schedule_id` (`schedule_id`,`customer_id`,`user_id`),
  KEY `user_id` (`user_id`),
  KEY `customer_id` (`customer_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tblbus`
--

CREATE TABLE IF NOT EXISTS `tblbus` (
  `bus_id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_number` varchar(15) NOT NULL,
  `bus_plate_number` varchar(15) NOT NULL,
  `bus_type` int(1) NOT NULL,
  `capacity` int(3) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`bus_id`),
  KEY `user_id` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tblcustomer`
--

CREATE TABLE IF NOT EXISTS `tblcustomer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `customer_contact` varchar(15) NOT NULL,
  `customer_email` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `account_status` int(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `user_id` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tbldriver`
--

CREATE TABLE IF NOT EXISTS `tbldriver` (
  `driver_id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_name` varchar(50) NOT NULL,
  `driver_contact` varchar(15) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`driver_id`),
  KEY `user_id` (`user_id`)
);

-- --------------------------------------------------------

--
-- Table structure for table `tblpayment`
--

CREATE TABLE IF NOT EXISTS `tblpayment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `booking_id` int(11) NOT NULL,
  `amount_paid` float NOT NULL,
  `payment_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `booking_id` (`booking_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ;
-- --------------------------------------------------------

--
-- Table structure for table `tbltravelschedule`
--

CREATE TABLE IF NOT EXISTS `tbltravelschedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `bus_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `starting_point` varchar(30) NOT NULL,
  `destination` varchar(30) NOT NULL,
  `schedule_date` date NOT NULL,
  `departure_time` time NOT NULL,
  `estimated_arrival_time` time NOT NULL,
  `fare_amount` float NOT NULL,
  `remarks` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `bus_id` (`bus_id`,`driver_id`,`user_id`),
  KEY `user_id` (`user_id`),
  KEY `driver_id` (`driver_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tbluser`
--

CREATE TABLE IF NOT EXISTS `tbluser` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL,
  `contact_no` varchar(15) NOT NULL,
  `email_address` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `userpassword` varchar(30) NOT NULL,
  `account_category` int(1) NOT NULL,
  `account_status` int(1) NOT NULL,
  PRIMARY KEY (`user_id`)
) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblbooking`
--
ALTER TABLE `tblbooking`
  ADD CONSTRAINT `tblbooking_ibfk_3` FOREIGN KEY (`schedule_id`) REFERENCES `tbltravelschedule` (`schedule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblbooking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblbooking_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `tblcustomer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblbus`
--
ALTER TABLE `tblbus`
  ADD CONSTRAINT `tblbus_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblcustomer`
--
ALTER TABLE `tblcustomer`
  ADD CONSTRAINT `tblcustomer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbldriver`
--
ALTER TABLE `tbldriver`
  ADD CONSTRAINT `tbldriver_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tblpayment`
--
ALTER TABLE `tblpayment`
  ADD CONSTRAINT `tblpayment_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `tblbooking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tblpayment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tbltravelschedule`
--
ALTER TABLE `tbltravelschedule`
  ADD CONSTRAINT `tbltravelschedule_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `tblbus` (`bus_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbltravelschedule_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbluser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tbltravelschedule_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `tbldriver` (`driver_id`) ON DELETE CASCADE ON UPDATE CASCADE;


