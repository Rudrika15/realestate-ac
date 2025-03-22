-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: realestateDb
-- ------------------------------------------------------
-- Server version	8.0.41-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BookingCustomers`
--

DROP TABLE IF EXISTS `BookingCustomers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookingCustomers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookingId` int NOT NULL,
  `customerId` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookingId` (`bookingId`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `BookingCustomers_ibfk_1` FOREIGN KEY (`bookingId`) REFERENCES `BookingMasters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BookingCustomers_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `CustomerMasters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingCustomers`
--

LOCK TABLES `BookingCustomers` WRITE;
/*!40000 ALTER TABLE `BookingCustomers` DISABLE KEYS */;
INSERT INTO `BookingCustomers` VALUES (1,1,1,0,0,85,85,'2025-03-22 11:15:12','2025-03-22 11:15:12'),(2,2,2,0,0,85,85,'2025-03-22 11:15:40','2025-03-22 11:15:40'),(3,3,3,0,0,85,85,'2025-03-22 11:16:54','2025-03-22 11:16:54'),(4,4,4,0,0,85,85,'2025-03-22 11:17:28','2025-03-22 11:17:28'),(5,5,5,0,0,85,85,'2025-03-22 11:17:56','2025-03-22 11:17:56'),(6,6,6,0,0,85,85,'2025-03-22 11:23:04','2025-03-22 11:23:04'),(7,7,7,0,0,85,85,'2025-03-22 11:27:02','2025-03-22 11:27:02'),(8,8,8,0,0,85,85,'2025-03-22 11:30:40','2025-03-22 11:30:40'),(9,9,9,0,0,85,85,'2025-03-22 11:54:47','2025-03-22 11:54:47'),(10,10,10,0,0,85,85,'2025-03-22 11:54:55','2025-03-22 11:54:55'),(11,11,11,0,0,85,85,'2025-03-22 11:59:34','2025-03-22 11:59:34'),(12,12,12,0,0,85,85,'2025-03-22 12:08:43','2025-03-22 12:08:43'),(13,13,13,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13');
/*!40000 ALTER TABLE `BookingCustomers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookingMasters`
--

DROP TABLE IF EXISTS `BookingMasters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookingMasters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int NOT NULL,
  `projectUnitId` int NOT NULL,
  `brokerId` varchar(255) DEFAULT NULL,
  `bookingDate` datetime NOT NULL,
  `saleDeedAmount` int NOT NULL,
  `extraWorkAmount` int NOT NULL,
  `otherWorkAmount` int NOT NULL,
  `approvalStatus` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `approvalDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectUnitId` (`projectUnitId`),
  CONSTRAINT `BookingMasters_ibfk_1` FOREIGN KEY (`projectUnitId`) REFERENCES `ProjectUnits` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingMasters`
--

LOCK TABLES `BookingMasters` WRITE;
/*!40000 ALTER TABLE `BookingMasters` DISABLE KEYS */;
INSERT INTO `BookingMasters` VALUES (1,1,2,'1','2025-02-24 18:30:00',2000000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:15:12','2025-03-22 11:15:12'),(2,1,2,'1','2025-02-24 18:30:00',2000000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:15:40','2025-03-22 11:15:40'),(3,1,2,'1','2025-03-03 18:30:00',2000000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:16:54','2025-03-22 11:16:54'),(4,1,2,'1','2025-03-03 18:30:00',2000000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:17:28','2025-03-22 11:17:28'),(5,1,2,'1','2025-03-03 18:30:00',2000000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:17:56','2025-03-22 11:17:56'),(6,1,4,'1','2025-03-06 18:30:00',2500000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:23:04','2025-03-22 11:23:04'),(7,1,1,'2','2025-02-28 18:30:00',1500000,50000,30000,'Pending',NULL,0,0,85,85,'2025-03-22 11:27:01','2025-03-22 11:27:01'),(8,1,2,'2','2025-03-22 00:00:00',2000000,50000,0,'Pending',NULL,0,0,85,85,'2025-03-22 11:30:40','2025-03-22 11:30:40'),(9,1,1,'1','2025-03-05 18:30:00',5000000,2500,5200,'Pending',NULL,0,0,85,85,'2025-03-22 11:54:47','2025-03-22 11:54:47'),(10,1,1,'1','2025-03-05 18:30:00',5000000,2500,5200,'Pending',NULL,0,0,85,85,'2025-03-22 11:54:55','2025-03-22 11:54:55'),(11,1,1,'2','2025-03-31 18:30:00',2000000,50000,15000,'Pending',NULL,0,0,85,85,'2025-03-22 11:59:34','2025-03-22 11:59:34'),(12,1,1,'1','2025-03-31 18:30:00',1500000,50000,15000,'Pending',NULL,0,0,85,85,'2025-03-22 12:08:43','2025-03-22 12:08:43'),(13,1,4,'1','2025-03-06 18:30:00',2000000,50000,0,'Pending',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13');
/*!40000 ALTER TABLE `BookingMasters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookingPaymentTerms`
--

DROP TABLE IF EXISTS `BookingPaymentTerms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookingPaymentTerms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookingId` int NOT NULL,
  `selectPlan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `frequency` varchar(255) NOT NULL,
  `defaultDate` datetime DEFAULT NULL,
  `loanStatus` varchar(255) DEFAULT NULL,
  `loanBankName` varchar(255) DEFAULT NULL,
  `loanAgentName` varchar(255) DEFAULT NULL,
  `isByBuilder` tinyint(1) DEFAULT '0',
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bookingId` (`bookingId`),
  CONSTRAINT `BookingPaymentTerms_ibfk_1` FOREIGN KEY (`bookingId`) REFERENCES `BookingMasters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingPaymentTerms`
--

LOCK TABLES `BookingPaymentTerms` WRITE;
/*!40000 ALTER TABLE `BookingPaymentTerms` DISABLE KEYS */;
INSERT INTO `BookingPaymentTerms` VALUES (1,13,'DownPayment','one-time',NULL,'N/A','N/A','N/A',1,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13');
/*!40000 ALTER TABLE `BookingPaymentTerms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookingPaymentTermsDetails`
--

DROP TABLE IF EXISTS `BookingPaymentTermsDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookingPaymentTermsDetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `BookingPaymentTermsId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `installmentAmount` int NOT NULL,
  `installmentDueDate` datetime NOT NULL,
  `stagId` int DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `BookingPaymentTermsId` (`BookingPaymentTermsId`),
  CONSTRAINT `BookingPaymentTermsDetails_ibfk_1` FOREIGN KEY (`BookingPaymentTermsId`) REFERENCES `BookingPaymentTerms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingPaymentTermsDetails`
--

LOCK TABLES `BookingPaymentTermsDetails` WRITE;
/*!40000 ALTER TABLE `BookingPaymentTermsDetails` DISABLE KEYS */;
INSERT INTO `BookingPaymentTermsDetails` VALUES (1,1,'tokan',10,'2025-03-12 18:30:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(2,1,'downpayment',20,'2025-03-19 18:30:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(3,1,'Installment',14,'2025-03-25 00:00:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(4,1,'Installment',14,'2025-06-25 00:00:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(5,1,'Installment',14,'2025-09-25 00:00:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(6,1,'Installment',14,'2025-12-25 00:00:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(7,1,'Installment',14,'2026-03-25 00:00:00',NULL,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13'),(8,1,'Stage',0,'2025-03-29 00:00:00',1,0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13');
/*!40000 ALTER TABLE `BookingPaymentTermsDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Brokers`
--

DROP TABLE IF EXISTS `Brokers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Brokers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brokerName` varchar(255) NOT NULL,
  `brokerAddress` varchar(255) NOT NULL,
  `brokerMobileNumber` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `Brokers_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Brokers_ibfk_2` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Brokers`
--

LOCK TABLES `Brokers` WRITE;
/*!40000 ALTER TABLE `Brokers` DISABLE KEYS */;
INSERT INTO `Brokers` VALUES (1,'test','test','99999999999',0,0,85,85,'2025-03-22 11:11:59','2025-03-22 11:11:59'),(2,'leo','surendranager','7897897897',0,0,85,85,'2025-03-22 11:24:49','2025-03-22 11:24:49');
/*!40000 ALTER TABLE `Brokers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerMasters`
--

DROP TABLE IF EXISTS `CustomerMasters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerMasters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerName` varchar(255) NOT NULL,
  `type` enum('Primary','Others') NOT NULL DEFAULT 'Primary',
  `address` varchar(255) NOT NULL,
  `mobileNumber` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerMasters`
--

LOCK TABLES `CustomerMasters` WRITE;
/*!40000 ALTER TABLE `CustomerMasters` DISABLE KEYS */;
INSERT INTO `CustomerMasters` VALUES (1,'vijay','Primary','test','1234567890',0,0,85,85,'2025-03-22 11:15:12','2025-03-22 11:15:12'),(2,'vijay','Primary','test','1234567890',0,0,85,85,'2025-03-22 11:15:40','2025-03-22 11:15:40'),(3,'sapath','Primary','surendranagar','1234567890',0,0,85,85,'2025-03-22 11:16:54','2025-03-22 11:16:54'),(4,'sapath','Primary','surendranagar','1234567890',0,0,85,85,'2025-03-22 11:17:28','2025-03-22 11:17:28'),(5,'sapath','Primary','surendranagar','1234567890',0,0,85,85,'2025-03-22 11:17:56','2025-03-22 11:17:56'),(6,'Shiv','Primary','test','1234567890',0,0,85,85,'2025-03-22 11:23:04','2025-03-22 11:23:04'),(7,'vivek','Primary','ssss','1234560000',0,0,85,85,'2025-03-22 11:27:01','2025-03-22 11:27:01'),(8,'sapath','Primary','aaaa','1234567890',0,0,85,85,'2025-03-22 11:30:40','2025-03-22 11:30:40'),(9,'Rudrika','Primary','abcd','9874563210',0,0,85,85,'2025-03-22 11:54:47','2025-03-22 11:54:47'),(10,'Rudrika','Primary','abcd','9874563210',0,0,85,85,'2025-03-22 11:54:55','2025-03-22 11:54:55'),(11,'hiren','Primary','ssss','1231231231',0,0,85,85,'2025-03-22 11:59:34','2025-03-22 11:59:34'),(12,'hiren','Primary','aaa','1234560000',0,0,85,85,'2025-03-22 12:08:43','2025-03-22 12:08:43'),(13,'vijay','Primary','aaaaa','1234560000',0,0,85,85,'2025-03-22 12:44:13','2025-03-22 12:44:13');
/*!40000 ALTER TABLE `CustomerMasters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExpenseDetails`
--

DROP TABLE IF EXISTS `ExpenseDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExpenseDetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `expenseMasterId` int NOT NULL,
  `projectId` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expenseHeadId` int NOT NULL,
  `naration` varchar(255) NOT NULL,
  `amount` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenseMasterId` (`expenseMasterId`),
  KEY `expenseHeadId` (`expenseHeadId`),
  CONSTRAINT `ExpenseDetails_ibfk_1` FOREIGN KEY (`expenseMasterId`) REFERENCES `ExpenseMasters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ExpenseDetails_ibfk_2` FOREIGN KEY (`expenseHeadId`) REFERENCES `ExpenseHeads` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExpenseDetails`
--

LOCK TABLES `ExpenseDetails` WRITE;
/*!40000 ALTER TABLE `ExpenseDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExpenseDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExpenseHeads`
--

DROP TABLE IF EXISTS `ExpenseHeads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExpenseHeads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ExpenseHeadName` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExpenseHeads`
--

LOCK TABLES `ExpenseHeads` WRITE;
/*!40000 ALTER TABLE `ExpenseHeads` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExpenseHeads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ExpenseMasters`
--

DROP TABLE IF EXISTS `ExpenseMasters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExpenseMasters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucherNo` int NOT NULL,
  `expenceDate` datetime NOT NULL,
  `totalAmount` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExpenseMasters`
--

LOCK TABLES `ExpenseMasters` WRITE;
/*!40000 ALTER TABLE `ExpenseMasters` DISABLE KEYS */;
/*!40000 ALTER TABLE `ExpenseMasters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncomeBookingDetails`
--

DROP TABLE IF EXISTS `IncomeBookingDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IncomeBookingDetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeBookingId` int NOT NULL,
  `term_id` int NOT NULL,
  `percentage` int NOT NULL,
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `incomeBookingId` (`incomeBookingId`),
  CONSTRAINT `IncomeBookingDetails_ibfk_1` FOREIGN KEY (`incomeBookingId`) REFERENCES `IncomeBookings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IncomeBookingDetails`
--

LOCK TABLES `IncomeBookingDetails` WRITE;
/*!40000 ALTER TABLE `IncomeBookingDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncomeBookingDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncomeBookings`
--

DROP TABLE IF EXISTS `IncomeBookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IncomeBookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookingId` int NOT NULL,
  `incomeType` enum('sale_deed','extra','other') NOT NULL,
  `incomeDate` datetime NOT NULL,
  `depositDate` datetime NOT NULL,
  `amount` int NOT NULL,
  `receiptNo` varchar(255) DEFAULT NULL,
  `receiptName` varchar(255) DEFAULT NULL,
  `bankName` varchar(255) DEFAULT NULL,
  `chequeNo` varchar(255) DEFAULT NULL,
  `chequeDate` datetime DEFAULT NULL,
  `receiptUrl` varchar(255) DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IncomeBookings`
--

LOCK TABLES `IncomeBookings` WRITE;
/*!40000 ALTER TABLE `IncomeBookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncomeBookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncomeDetails`
--

DROP TABLE IF EXISTS `IncomeDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IncomeDetails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeMasterId` int NOT NULL,
  `projectId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `incomeHeadId` int NOT NULL,
  `amount` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IncomeDetails`
--

LOCK TABLES `IncomeDetails` WRITE;
/*!40000 ALTER TABLE `IncomeDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncomeDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncomeHeads`
--

DROP TABLE IF EXISTS `IncomeHeads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IncomeHeads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeHeadName` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IncomeHeads`
--

LOCK TABLES `IncomeHeads` WRITE;
/*!40000 ALTER TABLE `IncomeHeads` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncomeHeads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IncomeMasters`
--

DROP TABLE IF EXISTS `IncomeMasters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IncomeMasters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeDate` datetime NOT NULL,
  `totalAmount` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IncomeMasters`
--

LOCK TABLES `IncomeMasters` WRITE;
/*!40000 ALTER TABLE `IncomeMasters` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncomeMasters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Incomes`
--

DROP TABLE IF EXISTS `Incomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Incomes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int DEFAULT NULL,
  `incomeType` enum('installment','partner','scrap') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paymentMode` enum('cash','cheque') NOT NULL,
  `paymentType` varchar(255) DEFAULT NULL,
  `amountType` varchar(255) DEFAULT NULL,
  `bookingId` int DEFAULT NULL,
  `incomeHeadId` int DEFAULT NULL,
  `dateReceived` datetime NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId` (`projectId`),
  KEY `incomeHeadId` (`incomeHeadId`),
  CONSTRAINT `Incomes_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Incomes_ibfk_2` FOREIGN KEY (`incomeHeadId`) REFERENCES `IncomeHeads` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Incomes`
--

LOCK TABLES `Incomes` WRITE;
/*!40000 ALTER TABLE `Incomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `Incomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `InstallmentIncomes`
--

DROP TABLE IF EXISTS `InstallmentIncomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `InstallmentIncomes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeId` int DEFAULT NULL,
  `bookingId` int DEFAULT NULL,
  `installmentId` int DEFAULT NULL,
  `loanId` int DEFAULT NULL,
  `receiptNo` varchar(255) DEFAULT NULL,
  `receiptName` varchar(255) DEFAULT NULL,
  `bankName` varchar(255) NOT NULL,
  `chequeNumber` varchar(255) DEFAULT NULL,
  `chequeDate` datetime DEFAULT NULL,
  `receivedFrom` varchar(255) DEFAULT NULL,
  `verificationStatus` varchar(255) DEFAULT 'Pending',
  `verificationDate` datetime DEFAULT NULL,
  `verificationBy` int DEFAULT NULL,
  `receiptURL` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `incomeId` (`incomeId`),
  KEY `bookingId` (`bookingId`),
  CONSTRAINT `InstallmentIncomes_ibfk_1` FOREIGN KEY (`incomeId`) REFERENCES `Incomes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `InstallmentIncomes_ibfk_2` FOREIGN KEY (`bookingId`) REFERENCES `BookingMasters` (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `InstallmentIncomes`
--

LOCK TABLES `InstallmentIncomes` WRITE;
/*!40000 ALTER TABLE `InstallmentIncomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `InstallmentIncomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PartnerIncomes`
--

DROP TABLE IF EXISTS `PartnerIncomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PartnerIncomes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeId` int DEFAULT NULL,
  `partnerId` int DEFAULT NULL,
  `bankName` varchar(255) DEFAULT NULL,
  `chequeNumber` varchar(255) DEFAULT NULL,
  `chequeDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `incomeId` (`incomeId`),
  KEY `partnerId` (`partnerId`),
  CONSTRAINT `PartnerIncomes_ibfk_1` FOREIGN KEY (`incomeId`) REFERENCES `Incomes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PartnerIncomes_ibfk_2` FOREIGN KEY (`partnerId`) REFERENCES `Partners` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PartnerIncomes`
--

LOCK TABLES `PartnerIncomes` WRITE;
/*!40000 ALTER TABLE `PartnerIncomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `PartnerIncomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Partners`
--

DROP TABLE IF EXISTS `Partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Partners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `partnerName` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `partnerId` int DEFAULT NULL,
  `projectId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  KEY `partnerId` (`partnerId`),
  KEY `projectId` (`projectId`),
  CONSTRAINT `Partners_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_2` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_3` FOREIGN KEY (`partnerId`) REFERENCES `ProjectPartners` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_4` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Partners`
--

LOCK TABLES `Partners` WRITE;
/*!40000 ALTER TABLE `Partners` DISABLE KEYS */;
INSERT INTO `Partners` VALUES (1,'shiv',0,0,85,85,'2025-03-22 11:13:59','2025-03-22 11:13:59',NULL,NULL);
/*!40000 ALTER TABLE `Partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permissions`
--

DROP TABLE IF EXISTS `Permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionName` varchar(255) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permissions`
--

LOCK TABLES `Permissions` WRITE;
/*!40000 ALTER TABLE `Permissions` DISABLE KEYS */;
INSERT INTO `Permissions` VALUES (76,'Users-add','Users-add',0,0,1,1,'2025-01-30 09:35:01','2025-01-30 09:35:01'),(77,'add-partner','add-partner',0,0,79,79,'2025-01-30 11:04:43','2025-01-30 11:07:31'),(78,'view-partner','view-partner',0,0,79,79,'2025-01-30 11:11:17','2025-01-30 11:11:17'),(79,'edit-partner','edit-partner',0,0,79,79,'2025-01-30 11:11:38','2025-01-30 11:11:38'),(80,'delete-partner','delete-partner',0,0,79,79,'2025-01-30 11:11:51','2025-01-30 11:11:51'),(81,'add-user','add-user',0,0,79,79,'2025-01-30 11:13:37','2025-01-30 11:13:37'),(82,'view-user','view-user',0,0,79,79,'2025-01-30 11:13:47','2025-01-30 11:13:47'),(83,'edit-user','edit-user',0,0,79,79,'2025-01-30 11:13:59','2025-01-30 11:13:59'),(84,'delete-user','delete-user',0,0,79,79,'2025-01-30 11:14:10','2025-01-30 11:14:10'),(85,'view-project','view-project',0,0,79,79,'2025-01-30 11:15:24','2025-01-30 11:15:24'),(86,'new-project','new-project',0,0,79,79,'2025-01-30 11:15:36','2025-01-30 11:15:36'),(87,'unit-project','unit-project',0,0,79,79,'2025-01-30 11:15:59','2025-01-30 11:15:59'),(88,'edit-project','edit-project',0,0,79,79,'2025-01-30 11:16:12','2025-01-30 11:16:12'),(89,'delete-project','delete-project',0,0,79,79,'2025-01-30 11:16:35','2025-01-30 11:16:35'),(90,'project-stage','project-stage',0,0,79,79,'2025-01-30 11:16:52','2025-01-30 11:16:52'),(91,'edit-projectstage','edit-projectstage',0,0,79,79,'2025-01-30 11:20:09','2025-01-30 11:20:09'),(92,'edit-unit','edit-unit',0,0,79,79,'2025-01-30 11:20:26','2025-01-30 11:20:26'),(93,'add-project-stage','add-project-stage',0,0,79,79,'2025-01-30 11:20:42','2025-01-30 11:20:42'),(94,'view-booking','view-booking',0,0,79,79,'2025-01-30 11:23:25','2025-01-30 11:23:25'),(95,'new-booking','new-booking',0,0,79,79,'2025-01-30 11:23:46','2025-01-30 11:23:46'),(96,'action-booking','action-booking',0,0,79,79,'2025-01-30 11:24:04','2025-01-30 11:24:04'),(97,'cancelled-booking','cancelled-booking',0,0,79,79,'2025-01-30 11:24:15','2025-01-30 11:24:15'),(98,'view-booking-page','view-booking-page',0,0,79,79,'2025-01-30 11:24:38','2025-01-30 11:24:38'),(99,'booking','booking',0,0,79,79,'2025-01-30 11:27:41','2025-01-30 11:27:41'),(100,'view-broker','view-broker',0,0,79,79,'2025-01-30 11:28:44','2025-01-30 11:28:44'),(101,'new-broker','new-broker',0,0,79,79,'2025-01-30 11:28:57','2025-01-30 11:28:57'),(102,'edit-broker','edit-broker',0,0,79,79,'2025-01-30 11:29:12','2025-01-30 11:29:12'),(103,'delete-broker','delete-broker',0,0,79,79,'2025-01-30 11:29:22','2025-01-30 11:29:22'),(104,'view-expenses','view-expenses',0,0,79,79,'2025-01-30 11:32:25','2025-01-30 11:32:25'),(105,'new-expenses','new-expenses',0,0,79,79,'2025-01-30 11:32:39','2025-01-30 11:32:39'),(106,'edit-expenses','edit-expenses',0,0,79,79,'2025-01-30 11:32:49','2025-01-30 11:32:49'),(107,'delete-expenses','delete-expenses',0,0,79,79,'2025-01-30 11:33:00','2025-01-30 11:33:00'),(108,'view-role','view-role',0,0,79,79,'2025-01-30 11:40:22','2025-01-30 11:40:22'),(109,'new-role','new-role',0,0,79,79,'2025-01-30 11:40:34','2025-01-30 11:40:34'),(110,'edit-role','edit-role',0,0,79,79,'2025-01-30 11:40:43','2025-01-30 11:40:43'),(111,'delete-role','delete-role',0,0,79,79,'2025-01-30 11:41:02','2025-01-30 11:41:02'),(112,'view-permissions','view-permissions',0,0,79,79,'2025-01-30 11:41:19','2025-01-30 11:41:19'),(113,'new-permissions','new-permissions',0,0,79,79,'2025-01-30 11:41:36','2025-01-30 11:41:36'),(114,'edit-permissions','edit-permissions',0,0,79,79,'2025-01-30 11:42:48','2025-01-30 11:42:48'),(115,'delete-permissions','delete-permissions',0,0,79,79,'2025-01-30 11:45:50','2025-01-30 11:45:50'),(116,'view-income','view-income',0,0,79,79,'2025-01-31 04:47:16','2025-01-31 04:47:16'),(117,'new-income','new-income',0,0,79,79,'2025-01-31 04:47:29','2025-01-31 04:47:29'),(118,'edit-income','edit-income',0,0,79,79,'2025-01-31 04:47:39','2025-01-31 04:47:39'),(119,'delete-income','delete-income',0,0,79,79,'2025-01-31 04:47:47','2025-01-31 04:47:47'),(120,'view-ledger-partner','view-ledger-partner',0,0,79,79,'2025-01-31 05:18:46','2025-01-31 05:18:46'),(121,'ledger','ledger',0,0,79,79,'2025-01-31 05:18:58','2025-01-31 05:18:58'),(122,'view-customer-partner','view-customer-partner',0,0,79,79,'2025-01-31 05:19:15','2025-01-31 05:19:15'),(123,'add-partner-income','add-partner-income',0,0,79,79,'2025-01-31 05:19:50','2025-01-31 05:19:50'),(124,'view-reimbursement','view-reimbursement',0,0,79,79,'2025-01-31 05:20:38','2025-01-31 05:20:38'),(125,'edit-partner-incom','edit-partner-incom',0,0,79,79,'2025-01-31 05:20:53','2025-01-31 05:20:53'),(126,'delete-partner-income','delete-partner-income',0,0,79,79,'2025-01-31 05:21:04','2025-01-31 05:21:04'),(127,'add-customer-income','add-customer-income',0,0,79,79,'2025-01-31 05:21:19','2025-01-31 05:21:19'),(128,'add-partner-reimbursment','add-partner-reimbursment',0,0,79,79,'2025-01-31 06:10:04','2025-01-31 06:10:04'),(130,'delete-partner-reimbursment','delete-partner-reimbursment',0,0,79,79,'2025-01-31 06:18:49','2025-01-31 06:18:49'),(131,'edit-partner-reimbursment','edit-partner-reimbursment',0,0,79,79,'2025-01-31 06:22:24','2025-01-31 06:22:24'),(132,'approval','approval',0,0,79,79,'2025-01-31 07:11:49','2025-01-31 07:11:49'),(133,'view-cash-deposit','view-cash-deposit',0,0,79,79,'2025-01-31 07:12:44','2025-01-31 07:12:44'),(134,'all-delete-cash-deposit','all-delete-cash-deposit',0,0,79,79,'2025-01-31 07:13:06','2025-01-31 07:13:06'),(135,'one-delete-cash-deposit','one-delete-cash-deposit',0,0,79,79,'2025-01-31 07:13:18','2025-01-31 07:13:18'),(136,'check-cash-deposit','check-cash-deposit',0,0,79,79,'2025-01-31 07:14:23','2025-01-31 07:14:23'),(137,'eye-cash-deposit','eye-cash-deposit',0,0,79,79,'2025-01-31 07:14:43','2025-01-31 07:14:43'),(138,'view-cheque-deposit','view-cheque-deposit',0,0,79,79,'2025-01-31 07:15:39','2025-01-31 07:15:39'),(140,'one-delete-cheque-deposit','one-delete-cheque-deposit',0,0,79,79,'2025-01-31 07:16:21','2025-01-31 07:16:21'),(141,'check-cheque-deposit','check-cheque-deposit',0,0,79,79,'2025-01-31 07:16:49','2025-01-31 07:16:49'),(142,'eye-cheque-deposit','eye-cheque-deposit',0,0,79,79,'2025-01-31 07:16:55','2025-01-31 07:16:55'),(143,'view-booking-authorization','view-booking-authorization',0,0,79,79,'2025-01-31 07:17:59','2025-01-31 07:17:59'),(144,'all-delete-booking-authorization','all-delete-booking-authorization',0,0,79,79,'2025-01-31 07:18:17','2025-01-31 07:18:17'),(145,'one-delete-booking-authorization','one-delete-booking-authorization',0,0,79,79,'2025-01-31 07:18:27','2025-01-31 07:18:27'),(146,'check-booking-authorization','check-booking-authorization',0,0,79,79,'2025-01-31 07:18:58','2025-01-31 07:18:58'),(147,'eye-booking-authorization','eye-booking-authorization',0,0,79,79,'2025-01-31 07:19:06','2025-01-31 07:19:06'),(148,'all-delete-cheque-deposit','all-delete-cheque-deposit',0,0,79,79,'2025-01-31 07:32:01','2025-01-31 07:32:01'),(149,'view-report','view-report',0,0,79,79,'2025-01-31 07:46:44','2025-01-31 07:46:44');
/*!40000 ALTER TABLE `Permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectPartners`
--

DROP TABLE IF EXISTS `ProjectPartners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProjectPartners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int NOT NULL,
  `partnerId` int NOT NULL,
  `percentage` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ProjectPartners_partnerId_projectId_unique` (`projectId`,`partnerId`),
  KEY `partnerId` (`partnerId`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `ProjectPartners_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectPartners_ibfk_2` FOREIGN KEY (`partnerId`) REFERENCES `Partners` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ProjectPartners_ibfk_3` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectPartners_ibfk_4` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectPartners`
--

LOCK TABLES `ProjectPartners` WRITE;
/*!40000 ALTER TABLE `ProjectPartners` DISABLE KEYS */;
INSERT INTO `ProjectPartners` VALUES (1,1,1,10,0,0,85,85);
/*!40000 ALTER TABLE `ProjectPartners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectStageTransactions`
--

DROP TABLE IF EXISTS `ProjectStageTransactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProjectStageTransactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectStageId` int NOT NULL,
  `wings` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `projectcompletionDate` datetime DEFAULT NULL,
  `actualCompletionDate` datetime DEFAULT NULL,
  `projectWingId` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectStageId` (`projectStageId`),
  CONSTRAINT `ProjectStageTransactions_ibfk_1` FOREIGN KEY (`projectStageId`) REFERENCES `ProjectStages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectStageTransactions`
--

LOCK TABLES `ProjectStageTransactions` WRITE;
/*!40000 ALTER TABLE `ProjectStageTransactions` DISABLE KEYS */;
INSERT INTO `ProjectStageTransactions` VALUES (1,1,'A','In Progress','2025-03-29 00:00:00',NULL,'A',0,0,85,85,'2025-03-22 11:29:19','2025-03-22 11:29:19');
/*!40000 ALTER TABLE `ProjectStageTransactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectStages`
--

DROP TABLE IF EXISTS `ProjectStages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProjectStages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int NOT NULL,
  `projectStageName` varchar(255) NOT NULL,
  `projectStagePer` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId` (`projectId`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `ProjectStages_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectStages_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectStages_ibfk_3` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectStages`
--

LOCK TABLES `ProjectStages` WRITE;
/*!40000 ALTER TABLE `ProjectStages` DISABLE KEYS */;
INSERT INTO `ProjectStages` VALUES (1,1,'rcc',10,0,0,85,85,'2025-03-22 11:29:19','2025-03-22 11:29:19');
/*!40000 ALTER TABLE `ProjectStages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProjectUnits`
--

DROP TABLE IF EXISTS `ProjectUnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProjectUnits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectId` int NOT NULL,
  `unitType` varchar(255) NOT NULL,
  `unitNo` varchar(255) NOT NULL,
  `wing` varchar(255) DEFAULT NULL,
  `size` varchar(255) NOT NULL,
  `currerntStatus` varchar(255) NOT NULL,
  `saleDeedAmount` varchar(255) NOT NULL,
  `extraWorkAmount` varchar(255) NOT NULL,
  `terraceStatus` varchar(255) DEFAULT NULL,
  `terraceSize` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectUnits`
--

LOCK TABLES `ProjectUnits` WRITE;
/*!40000 ALTER TABLE `ProjectUnits` DISABLE KEYS */;
INSERT INTO `ProjectUnits` VALUES (1,1,'2 bhk','A-101',NULL,'100','Unsold','2500000','500000','Yes','200',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(2,1,'2 bhk','A-102',NULL,'100','Unsold','2500000','500000','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(3,1,'1 bhk','A-464',NULL,'150','Unsold','2113615','410584','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(4,1,'1 bhk','A-444',NULL,'150','Sold','4949446','177844','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 12:44:13'),(5,1,'2 bhk','A-451',NULL,'100','Unsold','3925011','370367','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(6,1,'2 bhk','A-299',NULL,'100','Unsold','3639606','438718','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(7,1,'3 bhk','A-323',NULL,'100','Unsold','3904853','283122','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(8,1,'3 bhk','A-328',NULL,'120','Unsold','2756786','314113','Yes','200',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(9,1,'2 bhk','A-356',NULL,'100','Unsold','3100175','356695','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(10,1,'2 bhk','A-481',NULL,'100','Unsold','4832676','142398','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(11,1,'3 bhk','A-403',NULL,'100','Unsold','2226894','332076','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(12,1,'3 bhk','A-378',NULL,'150','Unsold','2817414','444901','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(13,1,'1 bhk','A-309',NULL,'100','Unsold','2748569','235346','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(14,1,'3 bhk','A-386',NULL,'80','Unsold','2416024','131865','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(15,1,'3 bhk','A-275',NULL,'150','Unsold','4930174','320090','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(16,1,'2 bhk','A-220',NULL,'120','Unsold','2814672','210661','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(17,1,'3 bhk','A-263',NULL,'100','Unsold','3527322','291076','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(18,1,'2 bhk','A-386',NULL,'120','Unsold','3699113','172171','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(19,1,'3 bhk','A-425',NULL,'100','Unsold','4799631','426815','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(20,1,'1 bhk','A-391',NULL,'80','Unsold','4031867','126528','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(21,1,'3 bhk','A-226',NULL,'80','Unsold','3023067','350331','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(22,1,'2 bhk','A-402',NULL,'150','Unsold','4969281','441390','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(23,1,'3 bhk','A-389',NULL,'150','Unsold','2231818','161533','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(24,1,'1 bhk','A-387',NULL,'150','Unsold','4803793','264969','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(25,1,'3 bhk','A-215',NULL,'80','Unsold','4081216','431905','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(26,1,'2 bhk','A-402',NULL,'80','Unsold','3038876','175584','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(27,1,'2 bhk','A-299',NULL,'80','Unsold','4986730','190025','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(28,1,'2 bhk','A-258',NULL,'80','Unsold','3498332','386955','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(29,1,'3 bhk','A-424',NULL,'100','Unsold','4828718','305683','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(30,1,'1 bhk','A-241',NULL,'150','Unsold','3090677','462590','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(31,1,'3 bhk','A-213',NULL,'150','Unsold','4760458','263883','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(32,1,'1 bhk','A-442',NULL,'120','Unsold','2796392','385142','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(33,1,'2 bhk','A-487',NULL,'120','Unsold','3475548','462135','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(34,1,'1 bhk','A-408',NULL,'120','Unsold','4196922','193501','Yes','200',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(35,1,'2 bhk','A-301',NULL,'120','Unsold','2943215','498848','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(36,1,'1 bhk','A-360',NULL,'150','Unsold','3733654','488635','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(37,1,'3 bhk','A-291',NULL,'150','Unsold','4972895','105746','Yes','200',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(38,1,'3 bhk','A-277',NULL,'100','Unsold','4134793','183224','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(39,1,'2 bhk','A-325',NULL,'100','Unsold','3262182','321872','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(40,1,'3 bhk','A-332',NULL,'100','Unsold','3775967','324825','Yes','200',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(41,1,'3 bhk','A-400',NULL,'150','Unsold','4596145','402911','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(42,1,'2 bhk','A-300',NULL,'80','Unsold','4536093','204178','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(43,1,'3 bhk','A-224',NULL,'80','Unsold','4995489','291439','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(44,1,'2 bhk','A-385',NULL,'120','Unsold','3033626','229590','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(45,1,'3 bhk','A-439',NULL,'80','Unsold','2374409','329895','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(46,1,'2 bhk','A-444',NULL,'120','Unsold','4168917','402644','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(47,1,'1 bhk','A-437',NULL,'80','Unsold','2743728','171830','Yes','150',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(48,1,'2 bhk','A-386',NULL,'120','Unsold','3929185','178396','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(49,1,'2 bhk','A-338',NULL,'80','Unsold','2220698','280245','Yes','100',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(50,1,'1 bhk','A-247',NULL,'150','Unsold','4693950','412980','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(51,1,'2 bhk','A-223',NULL,'80','Unsold','3148890','173132','Yes','200',0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34'),(52,1,'3 bhk','A-304',NULL,'80','Unsold','2157516','424413','No',NULL,0,0,85,85,'2025-03-22 11:13:34','2025-03-22 11:13:34');
/*!40000 ALTER TABLE `ProjectUnits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Projects`
--

DROP TABLE IF EXISTS `Projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projectName` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `Projects_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Projects_ibfk_2` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Projects`
--

LOCK TABLES `Projects` WRITE;
/*!40000 ALTER TABLE `Projects` DISABLE KEYS */;
INSERT INTO `Projects` VALUES (1,'sapath',0,0,85,85,'2025-03-22 11:13:33','2025-03-22 11:13:33');
/*!40000 ALTER TABLE `Projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RolePermissions`
--

DROP TABLE IF EXISTS `RolePermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RolePermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` int DEFAULT NULL,
  `permission` int DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `RolePermissions_permission_role_unique` (`role`,`permission`),
  KEY `permission` (`permission`),
  CONSTRAINT `RolePermissions_ibfk_1` FOREIGN KEY (`role`) REFERENCES `Roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RolePermissions_ibfk_2` FOREIGN KEY (`permission`) REFERENCES `Permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RolePermissions`
--

LOCK TABLES `RolePermissions` WRITE;
/*!40000 ALTER TABLE `RolePermissions` DISABLE KEYS */;
INSERT INTO `RolePermissions` VALUES (326,57,77,0,0,79,79,'2025-01-30 11:12:11','2025-01-30 11:12:11'),(327,57,78,0,0,79,79,'2025-01-30 11:12:11','2025-01-30 11:12:11'),(328,57,79,0,0,79,79,'2025-01-30 11:12:11','2025-01-30 11:12:11'),(329,57,80,0,0,79,79,'2025-01-30 11:12:11','2025-01-30 11:12:11'),(330,59,81,0,0,79,79,'2025-01-30 11:14:39','2025-01-30 11:14:39'),(331,59,82,0,0,79,79,'2025-01-30 11:14:39','2025-01-30 11:14:39'),(332,59,83,0,0,79,79,'2025-01-30 11:14:39','2025-01-30 11:14:39'),(333,59,84,0,0,79,79,'2025-01-30 11:14:39','2025-01-30 11:14:39'),(334,60,85,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(335,60,86,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(336,60,87,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(337,60,88,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(338,60,89,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(339,60,93,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(340,60,90,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(341,60,91,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(342,60,92,0,0,79,79,'2025-01-30 11:22:07','2025-01-30 11:22:07'),(349,62,100,0,0,79,79,'2025-01-30 11:30:03','2025-01-30 11:30:03'),(350,62,101,0,0,79,79,'2025-01-30 11:30:03','2025-01-30 11:30:03'),(351,62,102,0,0,79,79,'2025-01-30 11:30:03','2025-01-30 11:30:03'),(352,62,103,0,0,79,79,'2025-01-30 11:30:03','2025-01-30 11:30:03'),(353,63,104,0,0,79,79,'2025-01-30 11:34:59','2025-01-30 11:34:59'),(354,63,105,0,0,79,79,'2025-01-30 11:34:59','2025-01-30 11:34:59'),(355,63,106,0,0,79,79,'2025-01-30 11:34:59','2025-01-30 11:34:59'),(356,63,107,0,0,79,79,'2025-01-30 11:34:59','2025-01-30 11:34:59'),(361,69,112,0,0,79,79,'2025-01-30 11:46:24','2025-01-30 11:46:24'),(362,69,113,0,0,79,79,'2025-01-30 11:46:24','2025-01-30 11:46:24'),(363,69,114,0,0,79,79,'2025-01-30 11:46:24','2025-01-30 11:46:24'),(364,69,115,0,0,79,79,'2025-01-30 11:46:24','2025-01-30 11:46:24'),(368,68,108,0,0,79,79,'2025-01-30 11:49:10','2025-01-30 11:49:10'),(369,68,109,0,0,79,79,'2025-01-30 11:49:10','2025-01-30 11:49:10'),(370,68,110,0,0,79,79,'2025-01-30 11:49:10','2025-01-30 11:49:10'),(371,68,111,0,0,79,79,'2025-01-30 11:49:10','2025-01-30 11:49:10'),(377,61,94,0,0,79,79,'2025-01-30 12:00:41','2025-01-30 12:00:41'),(378,61,95,0,0,79,79,'2025-01-30 12:00:41','2025-01-30 12:00:41'),(379,61,96,0,0,79,79,'2025-01-30 12:00:41','2025-01-30 12:00:41'),(380,61,97,0,0,79,79,'2025-01-30 12:00:41','2025-01-30 12:00:41'),(381,61,98,0,0,79,79,'2025-01-30 12:00:41','2025-01-30 12:00:41'),(382,61,99,0,0,79,79,'2025-01-30 12:00:41','2025-01-30 12:00:41'),(390,70,116,0,0,79,79,'2025-01-31 05:00:41','2025-01-31 05:00:41'),(391,70,117,0,0,79,79,'2025-01-31 05:00:41','2025-01-31 05:00:41'),(392,70,118,0,0,79,79,'2025-01-31 05:00:41','2025-01-31 05:00:41'),(393,70,119,0,0,79,79,'2025-01-31 05:00:41','2025-01-31 05:00:41'),(439,71,120,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(440,71,121,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(441,71,122,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(442,71,123,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(443,71,124,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(444,71,125,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(445,71,126,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(446,71,127,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(447,71,128,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(448,71,130,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(449,71,131,0,0,79,79,'2025-01-31 06:22:38','2025-01-31 06:22:38'),(559,72,132,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(560,72,133,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(561,72,134,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(562,72,135,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(563,72,138,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(564,72,136,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(565,72,137,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(566,72,141,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(567,72,142,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(568,72,140,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(569,72,143,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(570,72,144,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(571,72,145,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(572,72,146,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(573,72,147,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(574,72,148,0,0,79,79,'2025-01-31 07:41:49','2025-01-31 07:41:49'),(575,73,149,0,0,79,79,'2025-01-31 07:47:13','2025-01-31 07:47:13');
/*!40000 ALTER TABLE `RolePermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'Super Admin',0,0,NULL,NULL,'2025-01-06 12:43:21','2025-01-25 09:41:48'),(57,'Parnter Admin',0,0,3,3,'2025-01-23 05:13:18','2025-01-28 09:38:42'),(59,'User Admin',0,0,3,3,'2025-01-28 09:39:44','2025-01-29 06:50:32'),(60,'Project Admin',0,0,3,3,'2025-01-28 10:35:38','2025-01-29 07:20:30'),(61,'Booking Admin',0,0,3,3,'2025-01-28 10:42:37','2025-01-29 08:55:08'),(62,'Broker Admin',0,0,3,3,'2025-01-28 10:44:41','2025-01-29 11:00:24'),(63,'Expenses Admin',0,0,3,3,'2025-01-28 10:47:23','2025-01-30 09:04:19'),(65,'Role',0,0,3,3,'2025-01-28 11:01:25','2025-01-28 11:01:25'),(66,'Permissions',0,0,3,3,'2025-01-28 11:02:19','2025-01-28 11:02:19'),(68,'Role Admin',0,0,3,3,'2025-01-29 11:56:34','2025-01-29 11:56:34'),(69,'Permissions Admin',0,0,77,77,'2025-01-29 12:14:55','2025-01-29 12:14:55'),(70,'Income Admin',0,0,79,79,'2025-01-31 04:49:27','2025-01-31 05:00:27'),(71,'Ledger Admin',0,0,79,79,'2025-01-31 05:22:16','2025-01-31 05:22:16'),(72,'Approval Admin',0,0,79,79,'2025-01-31 07:20:12','2025-01-31 07:21:02'),(73,'Report Admin',0,0,79,79,'2025-01-31 07:47:13','2025-01-31 07:47:13');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScrapIncomes`
--

DROP TABLE IF EXISTS `ScrapIncomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ScrapIncomes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `incomeId` int DEFAULT NULL,
  `narration` varchar(255) DEFAULT NULL,
  `buyerName` varchar(255) DEFAULT NULL,
  `bankName` varchar(255) DEFAULT NULL,
  `chequeNumber` varchar(255) DEFAULT NULL,
  `chequeDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `incomeId` (`incomeId`),
  CONSTRAINT `ScrapIncomes_ibfk_1` FOREIGN KEY (`incomeId`) REFERENCES `Incomes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScrapIncomes`
--

LOCK TABLES `ScrapIncomes` WRITE;
/*!40000 ALTER TABLE `ScrapIncomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ScrapIncomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserProjects`
--

DROP TABLE IF EXISTS `UserProjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserProjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `projectId` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserProjects_projectId_userId_unique` (`userId`,`projectId`),
  KEY `projectId` (`projectId`),
  CONSTRAINT `UserProjects_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UserProjects_ibfk_2` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserProjects`
--

LOCK TABLES `UserProjects` WRITE;
/*!40000 ALTER TABLE `UserProjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserProjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRoles`
--

DROP TABLE IF EXISTS `UserRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserRoles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `roleId` int NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UserRoles_roleId_userId_unique` (`userId`,`roleId`),
  KEY `roleId` (`roleId`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `UserRoles_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_3` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_4` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRoles`
--

LOCK TABLES `UserRoles` WRITE;
/*!40000 ALTER TABLE `UserRoles` DISABLE KEYS */;
INSERT INTO `UserRoles` VALUES (28,43,57,0,0,NULL,NULL,'2025-01-23 05:23:29','2025-01-23 05:23:29'),(29,44,1,0,0,NULL,NULL,'2025-01-23 09:28:48','2025-01-23 09:28:48'),(34,66,1,0,0,NULL,NULL,'2025-01-25 09:43:26','2025-01-25 09:43:26'),(35,67,1,0,0,NULL,NULL,'2025-01-25 09:45:23','2025-01-25 09:45:23'),(39,71,59,0,0,NULL,NULL,'2025-01-29 06:51:09','2025-01-29 06:51:09'),(41,73,60,0,0,NULL,NULL,'2025-01-29 07:23:45','2025-01-29 07:23:45'),(47,74,63,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(48,74,65,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(49,74,66,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(50,75,61,0,0,NULL,NULL,'2025-01-29 08:55:30','2025-01-29 08:55:30'),(51,76,62,0,0,NULL,NULL,'2025-01-29 11:27:36','2025-01-29 11:27:36'),(52,77,68,0,0,NULL,NULL,'2025-01-29 11:59:41','2025-01-29 11:59:41'),(53,78,69,0,0,NULL,NULL,'2025-01-29 12:16:06','2025-01-29 12:16:06'),(54,79,57,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(55,79,59,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(56,79,60,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(57,79,61,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(58,79,62,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(59,79,68,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(60,79,69,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(61,80,63,0,0,NULL,NULL,'2025-01-30 09:06:05','2025-01-30 09:06:05'),(62,81,70,0,0,NULL,NULL,'2025-01-31 04:50:56','2025-01-31 04:50:56'),(63,82,71,0,0,NULL,NULL,'2025-01-31 05:22:57','2025-01-31 05:22:57'),(64,83,72,0,0,NULL,NULL,'2025-01-31 07:21:29','2025-01-31 07:21:29'),(65,84,73,0,0,NULL,NULL,'2025-01-31 07:47:42','2025-01-31 07:47:42'),(66,85,57,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(67,85,59,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(68,85,60,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(69,85,61,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(70,85,62,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(71,85,63,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(72,85,68,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(73,85,69,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(74,85,70,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(75,85,71,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(76,85,72,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(77,85,73,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(78,87,59,0,0,NULL,NULL,'2025-02-12 05:07:14','2025-02-12 05:07:14'),(79,87,60,0,0,NULL,NULL,'2025-02-12 05:07:14','2025-02-12 05:07:14');
/*!40000 ALTER TABLE `UserRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `passcode` varchar(255) NOT NULL,
  `authPasscode` varchar(255) DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `Users_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Users_ibfk_2` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (3,'Raviraj123','Active','$2b$10$uITJ39ao6C59cpUTfqmGduh/VJL84gA1nTmWUZyIUNAGJbosHJCY.','$2b$10$CMUaQa6P4LYvhqqA/Wqr4uyRB1Ouf6.Zn6WCz4Hj3p.ES.H0qc2Mu',0,0,NULL,NULL,'2025-01-07 05:42:10','2025-01-07 05:42:10'),(5,'Raviraj','Active','$2b$10$kTtQQx.wKgvDsdYZmmYpnOfBVBBQ6Vro8CyOCSW/T1RiY1SwXjsQK','$2b$10$dFUK.osFSEmnntJN5LL1ue1t1GzxwO7ruQgRQMQ6jD1euCjycW.Pm',0,0,NULL,NULL,'2025-01-07 11:09:06','2025-01-07 11:09:06'),(17,'khilen','Active','$2b$10$hzTqexG3TAWNpfHDdAdI4e1iXUSM9L6ygrAn6ZTqGPIQP6wQiAGgG','$2b$10$/OORPrYjO1vqJU/BSNtvI.jww8P4..EFM2Qo6Nzirk6F6z8aIsPy6',0,0,NULL,NULL,'2025-01-17 10:47:23','2025-01-17 10:47:23'),(43,'partner','Active','$2b$10$jSNoRjQ1o/jFKmllgAAJ0eD07QXdh/npUjumOHRfTOFFZ8aRHwXka','$2b$10$AmUEzCO6pXtuwItE9Yp0AeMAI.rHlODtc0.dmYhxBm5raAW4LAoyi',0,0,NULL,NULL,'2025-01-23 05:23:29','2025-02-19 11:54:31'),(44,'Raj','Active','$2b$10$DolJsQ2Qc5.1R4TCAhFn3uVP36sCDL3j9/CrwbL3JASjXytHXiFqS','$2b$10$W4xJCH4j/sn6s/vf1eo56O.mrnj/Z0uOtud3iFl6a2MQ4Gf7xPKO2',0,0,NULL,NULL,'2025-01-23 09:28:48','2025-01-23 09:28:48'),(56,'khilen89','Active','$2b$10$pwRrWp5XPbDCxdX6ROP.s.9h4gzYPPuA4Ls2ZBwneXuZ1LMWGv7Ie','$2b$10$mTTOZiPPMbbvaqHVmwNnIO9T.tc1Ajh9pevcDbhJD5f1CymdS3k.2',0,0,NULL,NULL,'2025-01-23 18:45:54','2025-01-23 18:45:54'),(66,'Raviraj1','Active','$2b$10$T0FcRVFGZEy4JRrxFIyciOesdZxNC53VhVHd9jDvzNGwwFYV/JbS2',NULL,0,0,NULL,NULL,'2025-01-25 09:43:26','2025-01-25 09:43:26'),(67,'devanshi','Active','$2b$10$yDDo1qEq.BLRU9zxBrLQveQ2nhI8Hkl2mPNDmYWF3D83WoOkAmy1q',NULL,0,0,NULL,NULL,'2025-01-25 09:45:23','2025-01-25 09:45:23'),(71,'User','Active','$2b$10$m0crjwaHgeH9pps4L6hf6OEWIALmPt8zm3GLGZuR61LQhjoBeV89q',NULL,0,0,NULL,NULL,'2025-01-29 06:51:09','2025-01-29 06:51:09'),(73,'Project','Active','$2b$10$sBg7Lhw0B13Hn28p39Y59ujkR0cfXhy6gUfiVfbcIiZNX0eEM.MlG',NULL,0,0,NULL,NULL,'2025-01-29 07:23:45','2025-01-29 07:23:45'),(74,'realestate','Active','$2b$10$cHBZkMYq.viwp.FHof5DwOyyFGFwBUe3LcNCASEjrJI6GcUKV1vrC',NULL,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(75,'Booking','Active','$2b$10$OcqklKu/05upTbzWX.RJzeoW.ZF9z/bBnScy9mZIiI17P.T8dNLCu',NULL,0,0,NULL,NULL,'2025-01-29 08:55:30','2025-01-29 08:55:30'),(76,'Broker','Active','$2b$10$Kn0VRdjsAcpHYxphSCDXBu/vBLoEN5tHqQbd3IqqLECR0ZhFSmhFm',NULL,0,0,NULL,NULL,'2025-01-29 11:27:36','2025-01-29 11:27:36'),(77,'Role','Active','$2b$10$hPIvc6ir2mtDPb6be.nTTOabM/FioQ84O5be7/bxeXBwE3TPW0Chm',NULL,0,0,NULL,NULL,'2025-01-29 11:59:41','2025-01-29 11:59:41'),(78,'Permissions','Active','$2b$10$QbheuEHeJitAgrFuKViXIef.4NqfOoS/dYn98tU0Z3fTDCErEfpIW',NULL,0,0,NULL,NULL,'2025-01-29 12:16:06','2025-01-29 12:16:06'),(79,'state','Active','$2b$10$gR2JvqG8u5OxjKQIkJDByez97ligBZ4XXrGaLYYX5Jkj5wnv6NH2u',NULL,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(80,'Expenses','Active','$2b$10$TDABwSoBVj3zpeYCiE0b2eBY8JHDvuIk7LirzezZVHFhBIfPMcRTO',NULL,0,0,NULL,NULL,'2025-01-30 09:06:05','2025-01-30 09:06:05'),(81,'Income','Active','$2b$10$Ag6aRQZQYCmR7b4CTQQt8OAcBEP03DiM/1MaIKYxIeMCmkV7sZnQ2',NULL,0,0,NULL,NULL,'2025-01-31 04:50:56','2025-01-31 04:50:56'),(82,'Ledger','Active','$2b$10$UQ3P/TmfRIwwhyvRjXzG5uQIYdrHahTQ4fLdLj4fS72As.h.OV7ua',NULL,0,0,NULL,NULL,'2025-01-31 05:22:57','2025-01-31 05:22:57'),(83,'Approval','Active','$2b$10$F6dEMTE/TJd2ihvOuR6Xre.dhq3xHSGriJd7VD1SFZZCIDwximPPa',NULL,0,0,NULL,NULL,'2025-01-31 07:21:29','2025-01-31 07:21:29'),(84,'Report','Active','$2b$10$.8G3fYRv6UtHTX04jnytrOcIVQqmNv38IL/RX.2/pPnnDWVXqNizu',NULL,0,0,NULL,NULL,'2025-01-31 07:47:42','2025-01-31 07:47:42'),(85,'flipcode','Active','$2b$10$WWdlH4zKiOAULnVRjjonYO4WTienfacEY9ev7XR/xUYstKsQxJYE6',NULL,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(87,'john_doe3','Active','$2b$10$/XPOJWwIQrXotmGVZ0cAfOLfRDKZ6tUxoZki1xclgzFjVS2eusBpq','$2b$10$h0UyLXWTGp1xxlsfPacx1.UeX4qh7QVRPvNZVFfJZBBZocOujx7Ey',0,0,NULL,NULL,'2025-02-12 05:07:14','2025-02-12 05:07:14');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logincounts`
--

DROP TABLE IF EXISTS `logincounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logincounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `loginCount` int NOT NULL,
  `date` date DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logincounts`
--

LOCK TABLES `logincounts` WRITE;
/*!40000 ALTER TABLE `logincounts` DISABLE KEYS */;
INSERT INTO `logincounts` VALUES (5,85,1,'2025-03-19','2025-03-19 07:01:22','2025-03-19 07:01:22'),(6,87,2,'2025-03-19','2025-03-19 07:01:28','2025-03-19 07:04:49');
/*!40000 ALTER TABLE `logincounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-22 13:05:50
