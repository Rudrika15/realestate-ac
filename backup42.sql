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
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingCustomers`
--

LOCK TABLES `BookingCustomers` WRITE;
/*!40000 ALTER TABLE `BookingCustomers` DISABLE KEYS */;
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
  `brokerName` varchar(255) DEFAULT NULL,
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
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingMasters`
--

LOCK TABLES `BookingMasters` WRITE;
/*!40000 ALTER TABLE `BookingMasters` DISABLE KEYS */;
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
  `selectPlan` enum('Full','Installment','Loan','Mixed') NOT NULL DEFAULT 'Installment',
  `frequency` varchar(255) NOT NULL,
  `defaultDate` datetime NOT NULL,
  `loanStatus` enum('In Progress','Completed') NOT NULL DEFAULT 'In Progress',
  `loanBankName` varchar(255) NOT NULL,
  `loanAgentName` varchar(255) NOT NULL,
  `builderBankName` varchar(255) NOT NULL,
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
-- Dumping data for table `BookingPaymentTerms`
--

LOCK TABLES `BookingPaymentTerms` WRITE;
/*!40000 ALTER TABLE `BookingPaymentTerms` DISABLE KEYS */;
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
-- Dumping data for table `BookingPaymentTermsDetails`
--

LOCK TABLES `BookingPaymentTermsDetails` WRITE;
/*!40000 ALTER TABLE `BookingPaymentTermsDetails` DISABLE KEYS */;
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
INSERT INTO `Brokers` VALUES (5,'Raviraj','Surendranagar','7896541237',0,0,3,3,'2025-01-10 09:12:54','2025-01-17 08:50:21'),(18,'devanshi ','baroda','8956235689',0,0,3,3,'2025-01-17 05:12:18','2025-01-23 04:54:26');
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
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `mobileNumber` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerMasters`
--

LOCK TABLES `CustomerMasters` WRITE;
/*!40000 ALTER TABLE `CustomerMasters` DISABLE KEYS */;
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
  `ExpenseMasterId` int NOT NULL,
  `projectId` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ExpenseHeadId` int NOT NULL,
  `naration` varchar(255) NOT NULL,
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
-- Dumping data for table `ExpenseDetails`
--

LOCK TABLES `ExpenseDetails` WRITE;
/*!40000 ALTER TABLE `ExpenseDetails` DISABLE KEYS */;
INSERT INTO `ExpenseDetails` VALUES (2,3,2,'',2,'Other expense',5500,0,0,43,1,'2025-01-28 05:27:22','2025-01-29 13:07:45'),(3,4,2,'',1,'Other expense',5500,0,0,5,5,'2025-01-28 05:29:33','2025-01-29 11:12:10'),(5,5,40,'',1,'Office supplies',5000,0,0,5,5,'2025-01-28 10:10:41','2025-01-28 10:10:41'),(8,6,45,'',2,'Travel expenses',10000,0,0,5,5,'2025-01-28 14:33:30','2025-01-28 14:33:30'),(10,7,45,'',2,'Travel expenses',10000,0,0,5,5,'2025-01-29 06:49:56','2025-01-29 06:49:56'),(12,8,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-01-30 12:44:07','2025-01-30 12:44:07'),(13,9,40,' ',1,'Office supplies',5000,0,0,5,5,'2025-01-30 15:34:26','2025-01-30 15:34:26'),(16,10,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-01-31 05:04:05','2025-01-31 05:04:05'),(18,11,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-02-01 09:53:55','2025-02-01 09:53:55'),(19,12,40,' ',1,'Office supplies',5000,0,0,5,5,'2025-02-01 10:48:08','2025-02-01 10:48:08'),(20,12,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-02-01 10:48:08','2025-02-01 10:48:08'),(22,13,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-02-03 06:23:57','2025-02-03 06:23:57'),(24,14,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-02-03 07:15:06','2025-02-03 07:15:06'),(25,15,40,' ',1,'Office supplies',5000,0,0,5,5,'2025-02-03 09:43:44','2025-02-03 09:43:44'),(26,15,45,' ',2,'Travel expenses',10000,0,0,5,5,'2025-02-03 09:43:44','2025-02-03 09:43:44'),(27,16,45,' ',3,'demo',1998,0,0,85,85,'2025-02-03 09:46:53','2025-02-03 09:46:53'),(28,17,45,' ',3,'test',45546,0,0,85,85,'2025-02-04 04:47:25','2025-02-04 04:47:25'),(29,18,59,' ',4,'devanshi',456456449,0,0,85,85,'2025-02-04 04:48:07','2025-02-04 04:48:07');
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
INSERT INTO `ExpenseHeads` VALUES (1,'Other',0,0,43,43,'2025-01-28 05:22:16','2025-01-28 05:22:16'),(2,'Labour',0,0,43,43,'2025-01-28 05:22:24','2025-01-28 05:22:24'),(3,'Labour',0,0,5,5,'2025-01-28 06:13:57','2025-01-28 06:13:57'),(4,'Labour',0,0,5,5,'2025-01-28 07:35:10','2025-01-28 07:35:10'),(5,'Labour',0,0,5,5,'2025-01-28 14:34:35','2025-01-28 14:34:35'),(6,'Labour',0,0,5,5,'2025-01-29 06:29:48','2025-01-29 06:29:48');
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
INSERT INTO `ExpenseMasters` VALUES (1,123,'2025-01-25 00:00:00',15000,0,0,43,43,'2025-01-28 05:25:12','2025-01-28 05:25:12'),(2,123,'2025-01-25 00:00:00',15000,0,0,43,43,'2025-01-28 05:26:09','2025-01-28 05:26:09'),(12,123,'2025-01-25 00:00:00',15000,0,0,5,5,'2025-02-01 10:48:08','2025-02-01 10:48:08'),(15,123,'2025-01-25 00:00:00',15000,0,0,5,5,'2025-02-03 09:43:44','2025-02-03 09:43:44'),(16,555,'2025-02-15 00:00:00',1998,0,0,85,85,'2025-02-03 09:46:53','2025-02-03 09:46:53'),(17,4646,'2025-03-02 00:00:00',45546,0,0,85,85,'2025-02-04 04:47:25','2025-02-04 04:47:25'),(18,787,'2025-02-12 00:00:00',456456449,0,0,85,85,'2025-02-04 04:48:07','2025-02-04 04:48:07');
/*!40000 ALTER TABLE `ExpenseMasters` ENABLE KEYS */;
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
  `naration` varchar(255) NOT NULL,
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
  `dateReceived` datetime NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId` (`projectId`),
  CONSTRAINT `Incomes_ibfk_1` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Incomes`
--

LOCK TABLES `Incomes` WRITE;
/*!40000 ALTER TABLE `Incomes` DISABLE KEYS */;
INSERT INTO `Incomes` VALUES (4,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,5,5,'2025-02-03 04:59:37','2025-02-03 04:59:37'),(5,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,5,5,'2025-02-03 04:59:51','2025-02-03 04:59:51'),(6,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,5,5,'2025-02-03 05:05:12','2025-02-03 05:05:12'),(8,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,5,5,'2025-02-03 05:09:17','2025-02-03 05:09:17'),(9,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,5,5,'2025-02-04 04:15:23','2025-02-04 04:15:23'),(11,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,85,85,'2025-02-04 04:31:20','2025-02-04 04:31:20'),(12,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,85,85,'2025-02-04 04:31:26','2025-02-04 04:31:26'),(13,45,'partner',200.00,'cash','2025-02-06 00:00:00',0,0,85,85,'2025-02-04 04:33:16','2025-02-04 04:33:16'),(14,45,'partner',5000000.00,'cash','2025-01-31 00:00:00',0,0,85,85,'2025-02-04 04:33:40','2025-02-04 04:33:40'),(15,45,'partner',2000.00,'cash','2025-02-17 00:00:00',0,0,85,85,'2025-02-04 04:40:57','2025-02-04 04:40:57'),(16,45,'partner',2000.00,'cheque','2025-02-18 00:00:00',0,0,85,85,'2025-02-04 04:41:56','2025-02-04 04:41:56'),(18,45,'scrap',5000000.00,'cash','2025-01-31 00:00:00',0,0,85,85,'2025-02-04 04:42:35','2025-02-04 04:42:35'),(19,45,'partner',200.00,'cash','2025-02-10 00:00:00',0,0,85,85,'2025-02-04 05:17:27','2025-02-04 05:17:27'),(20,45,'partner',2000000.00,'cash','2025-02-18 00:00:00',0,0,85,85,'2025-02-04 05:18:16','2025-02-04 05:18:16'),(21,45,'partner',3000.00,'cash','2027-06-04 00:00:00',0,0,85,85,'2025-02-04 05:21:31','2025-02-04 05:21:31'),(22,45,'partner',2000.00,'cheque','2028-12-04 00:00:00',0,0,85,85,'2025-02-04 05:22:57','2025-02-04 05:22:57');
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
  `bankName` varchar(255) NOT NULL,
  `chequeNumber` varchar(255) DEFAULT NULL,
  `chequeDate` datetime DEFAULT NULL,
  `receivedFrom` varchar(255) NOT NULL,
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
INSERT INTO `PartnerIncomes` VALUES (2,5,65,NULL,NULL,NULL,0,0,5,5,'2025-02-03 04:59:51','2025-02-03 04:59:51'),(3,6,65,'State Bank of India','123456789','2025-02-21 00:00:00',0,0,5,5,'2025-02-03 05:05:12','2025-02-03 05:05:12'),(4,8,65,'State Bank of India','123456789','2025-02-21 00:00:00',0,0,5,5,'2025-02-03 05:09:17','2025-02-03 05:09:17'),(5,9,65,'State Bank of India','123456','2025-02-21 00:00:00',0,0,5,5,'2025-02-04 04:15:23','2025-02-04 04:15:23'),(8,14,65,NULL,NULL,NULL,0,0,85,85,'2025-02-04 04:33:40','2025-02-04 04:33:40'),(9,15,65,'','',NULL,0,0,85,85,'2025-02-04 04:40:57','2025-02-04 04:40:57'),(10,16,65,'dhsgh','56465464','2025-02-09 00:00:00',0,0,85,85,'2025-02-04 04:41:56','2025-02-04 04:41:56'),(11,19,65,'','',NULL,0,0,85,85,'2025-02-04 05:17:27','2025-02-04 05:17:27'),(12,20,65,'','',NULL,0,0,85,85,'2025-02-04 05:18:16','2025-02-04 05:18:16'),(13,21,65,'','',NULL,0,0,85,85,'2025-02-04 05:21:31','2025-02-04 05:21:31'),(14,22,65,'csjakhdsa','466','2025-02-01 00:00:00',0,0,85,85,'2025-02-04 05:22:57','2025-02-04 05:22:57');
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
  `projectId` int DEFAULT NULL,
  `partnerId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  KEY `projectId` (`projectId`),
  KEY `partnerId` (`partnerId`),
  CONSTRAINT `Partners_ibfk_280` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_281` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_282` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_283` FOREIGN KEY (`partnerId`) REFERENCES `ProjectPartners` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Partners`
--

LOCK TABLES `Partners` WRITE;
/*!40000 ALTER TABLE `Partners` DISABLE KEYS */;
INSERT INTO `Partners` VALUES (65,'Shiv',0,0,43,43,'2025-01-28 06:35:09','2025-01-28 06:35:09',NULL,NULL),(67,'Dipak',0,0,43,43,'2025-01-28 11:45:35','2025-01-28 11:45:35',NULL,NULL);
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
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permissions`
--

LOCK TABLES `Permissions` WRITE;
/*!40000 ALTER TABLE `Permissions` DISABLE KEYS */;
INSERT INTO `Permissions` VALUES (76,'Users-add',0,0,1,1,'2025-01-30 09:35:01','2025-01-30 09:35:01','Users-add'),(77,'add-partner',0,0,79,79,'2025-01-30 11:04:43','2025-01-30 11:07:31','add-partner'),(78,'view-partner',0,0,79,79,'2025-01-30 11:11:17','2025-01-30 11:11:17','view-partner'),(79,'edit-partner',0,0,79,79,'2025-01-30 11:11:38','2025-01-30 11:11:38','edit-partner'),(80,'delete-partner',0,0,79,79,'2025-01-30 11:11:51','2025-01-30 11:11:51','delete-partner'),(81,'add-user',0,0,79,79,'2025-01-30 11:13:37','2025-01-30 11:13:37','add-user'),(82,'view-user',0,0,79,79,'2025-01-30 11:13:47','2025-01-30 11:13:47','view-user'),(83,'edit-user',0,0,79,79,'2025-01-30 11:13:59','2025-01-30 11:13:59','edit-user'),(84,'delete-user',0,0,79,79,'2025-01-30 11:14:10','2025-01-30 11:14:10','delete-user'),(85,'view-project',0,0,79,79,'2025-01-30 11:15:24','2025-01-30 11:15:24','view-project'),(86,'new-project',0,0,79,79,'2025-01-30 11:15:36','2025-01-30 11:15:36','new-project'),(87,'unit-project',0,0,79,79,'2025-01-30 11:15:59','2025-01-30 11:15:59','unit-project'),(88,'edit-project',0,0,79,79,'2025-01-30 11:16:12','2025-01-30 11:16:12','edit-project'),(89,'delete-project',0,0,79,79,'2025-01-30 11:16:35','2025-01-30 11:16:35','delete-project'),(90,'project-stage',0,0,79,79,'2025-01-30 11:16:52','2025-01-30 11:16:52','project-stage'),(91,'edit-projectstage',0,0,79,79,'2025-01-30 11:20:09','2025-01-30 11:20:09','edit-projectstage'),(92,'edit-unit',0,0,79,79,'2025-01-30 11:20:26','2025-01-30 11:20:26','edit-unit'),(93,'add-project-stage',0,0,79,79,'2025-01-30 11:20:42','2025-01-30 11:20:42','add-project-stage'),(94,'view-booking',0,0,79,79,'2025-01-30 11:23:25','2025-01-30 11:23:25','view-booking'),(95,'new-booking',0,0,79,79,'2025-01-30 11:23:46','2025-01-30 11:23:46','new-booking'),(96,'action-booking',0,0,79,79,'2025-01-30 11:24:04','2025-01-30 11:24:04','action-booking'),(97,'cancelled-booking',0,0,79,79,'2025-01-30 11:24:15','2025-01-30 11:24:15','cancelled-booking'),(98,'view-booking-page',0,0,79,79,'2025-01-30 11:24:38','2025-01-30 11:24:38','view-booking-page'),(99,'booking',0,0,79,79,'2025-01-30 11:27:41','2025-01-30 11:27:41','booking'),(100,'view-broker',0,0,79,79,'2025-01-30 11:28:44','2025-01-30 11:28:44','view-broker'),(101,'new-broker',0,0,79,79,'2025-01-30 11:28:57','2025-01-30 11:28:57','new-broker'),(102,'edit-broker',0,0,79,79,'2025-01-30 11:29:12','2025-01-30 11:29:12','edit-broker'),(103,'delete-broker',0,0,79,79,'2025-01-30 11:29:22','2025-01-30 11:29:22','delete-broker'),(104,'view-expenses',0,0,79,79,'2025-01-30 11:32:25','2025-01-30 11:32:25','view-expenses'),(105,'new-expenses',0,0,79,79,'2025-01-30 11:32:39','2025-01-30 11:32:39','new-expenses'),(106,'edit-expenses',0,0,79,79,'2025-01-30 11:32:49','2025-01-30 11:32:49','edit-expenses'),(107,'delete-expenses',0,0,79,79,'2025-01-30 11:33:00','2025-01-30 11:33:00','delete-expenses'),(108,'view-role',0,0,79,79,'2025-01-30 11:40:22','2025-01-30 11:40:22','view-role'),(109,'new-role',0,0,79,79,'2025-01-30 11:40:34','2025-01-30 11:40:34','new-role'),(110,'edit-role',0,0,79,79,'2025-01-30 11:40:43','2025-01-30 11:40:43','edit-role'),(111,'delete-role',0,0,79,79,'2025-01-30 11:41:02','2025-01-30 11:41:02','delete-role'),(112,'view-permissions',0,0,79,79,'2025-01-30 11:41:19','2025-01-30 11:41:19','view-permissions'),(113,'new-permissions',0,0,79,79,'2025-01-30 11:41:36','2025-01-30 11:41:36','new-permissions'),(114,'edit-permissions',0,0,79,79,'2025-01-30 11:42:48','2025-01-30 11:42:48','edit-permissions'),(115,'delete-permissions',0,0,79,79,'2025-01-30 11:45:50','2025-01-30 11:45:50','delete-permissions'),(116,'view-income',0,0,79,79,'2025-01-31 04:47:16','2025-01-31 04:47:16','view-income'),(117,'new-income',0,0,79,79,'2025-01-31 04:47:29','2025-01-31 04:47:29','new-income'),(118,'edit-income',0,0,79,79,'2025-01-31 04:47:39','2025-01-31 04:47:39','edit-income'),(119,'delete-income',0,0,79,79,'2025-01-31 04:47:47','2025-01-31 04:47:47','delete-income'),(120,'view-ledger-partner',0,0,79,79,'2025-01-31 05:18:46','2025-01-31 05:18:46','view-ledger-partner'),(121,'ledger',0,0,79,79,'2025-01-31 05:18:58','2025-01-31 05:18:58','ledger'),(122,'view-customer-partner',0,0,79,79,'2025-01-31 05:19:15','2025-01-31 05:19:15','view-customer-partner'),(123,'add-partner-income',0,0,79,79,'2025-01-31 05:19:50','2025-01-31 05:19:50','add-partner-income'),(124,'view-reimbursement',0,0,79,79,'2025-01-31 05:20:38','2025-01-31 05:20:38','view-reimbursement'),(125,'edit-partner-incom',0,0,79,79,'2025-01-31 05:20:53','2025-01-31 05:20:53','edit-partner-incom'),(126,'delete-partner-income',0,0,79,79,'2025-01-31 05:21:04','2025-01-31 05:21:04','delete-partner-income'),(127,'add-customer-income',0,0,79,79,'2025-01-31 05:21:19','2025-01-31 05:21:19','add-customer-income'),(128,'add-partner-reimbursment',0,0,79,79,'2025-01-31 06:10:04','2025-01-31 06:10:04','add-partner-reimbursment'),(130,'delete-partner-reimbursment',0,0,79,79,'2025-01-31 06:18:49','2025-01-31 06:18:49','delete-partner-reimbursment'),(131,'edit-partner-reimbursment',0,0,79,79,'2025-01-31 06:22:24','2025-01-31 06:22:24','edit-partner-reimbursment'),(132,'approval',0,0,79,79,'2025-01-31 07:11:49','2025-01-31 07:11:49','approval'),(133,'view-cash-deposit',0,0,79,79,'2025-01-31 07:12:44','2025-01-31 07:12:44','view-cash-deposit'),(134,'all-delete-cash-deposit',0,0,79,79,'2025-01-31 07:13:06','2025-01-31 07:13:06','all-delete-cash-deposit'),(135,'one-delete-cash-deposit',0,0,79,79,'2025-01-31 07:13:18','2025-01-31 07:13:18','one-delete-cash-deposit'),(136,'check-cash-deposit',0,0,79,79,'2025-01-31 07:14:23','2025-01-31 07:14:23','check-cash-deposit'),(137,'eye-cash-deposit',0,0,79,79,'2025-01-31 07:14:43','2025-01-31 07:14:43','eye-cash-deposit'),(138,'view-cheque-deposit',0,0,79,79,'2025-01-31 07:15:39','2025-01-31 07:15:39','view-cheque-deposit'),(140,'one-delete-cheque-deposit',0,0,79,79,'2025-01-31 07:16:21','2025-01-31 07:16:21','one-delete-cheque-deposit'),(141,'check-cheque-deposit',0,0,79,79,'2025-01-31 07:16:49','2025-01-31 07:16:49','check-cheque-deposit'),(142,'eye-cheque-deposit',0,0,79,79,'2025-01-31 07:16:55','2025-01-31 07:16:55','eye-cheque-deposit'),(143,'view-booking-authorization',0,0,79,79,'2025-01-31 07:17:59','2025-01-31 07:17:59','view-booking-authorization'),(144,'all-delete-booking-authorization',0,0,79,79,'2025-01-31 07:18:17','2025-01-31 07:18:17','all-delete-booking-authorization'),(145,'one-delete-booking-authorization',0,0,79,79,'2025-01-31 07:18:27','2025-01-31 07:18:27','one-delete-booking-authorization'),(146,'check-booking-authorization',0,0,79,79,'2025-01-31 07:18:58','2025-01-31 07:18:58','check-booking-authorization'),(147,'eye-booking-authorization',0,0,79,79,'2025-01-31 07:19:06','2025-01-31 07:19:06','eye-booking-authorization'),(148,'all-delete-cheque-deposit',0,0,79,79,'2025-01-31 07:32:01','2025-01-31 07:32:01','all-delete-cheque-deposit'),(149,'view-report',0,0,79,79,'2025-01-31 07:46:44','2025-01-31 07:46:44','view-report');
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
  KEY `projectId` (`projectId`),
  KEY `partnerId` (`partnerId`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `ProjectPartners_ibfk_280` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectPartners_ibfk_281` FOREIGN KEY (`partnerId`) REFERENCES `Partners` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ProjectPartners_ibfk_282` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectPartners_ibfk_283` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectPartners`
--

LOCK TABLES `ProjectPartners` WRITE;
/*!40000 ALTER TABLE `ProjectPartners` DISABLE KEYS */;
INSERT INTO `ProjectPartners` VALUES (157,49,65,100,0,0,43,43);
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
  `status` varchar(255) NOT NULL,
  `projectcompletionDate` datetime DEFAULT NULL,
  `actualCompletionDate` datetime DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `projectWingId` varchar(255) DEFAULT NULL,
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
INSERT INTO `ProjectStageTransactions` VALUES (30,36,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-17 10:33:36','2025-01-17 10:33:36','A'),(31,36,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-17 10:33:36','2025-01-17 10:33:36','B'),(51,49,'In Progress','2025-01-07 00:00:00',NULL,0,0,3,3,'2025-01-18 05:37:18','2025-01-18 05:37:18','A'),(74,65,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-18 11:04:08','2025-01-18 11:04:08','A'),(75,65,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-18 11:04:08','2025-01-18 11:04:08','B'),(76,66,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-18 11:04:28','2025-01-18 11:04:28','A'),(77,66,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-18 11:04:28','2025-01-18 11:04:28','B'),(78,67,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-18 11:04:38','2025-01-18 11:04:38','A'),(79,67,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-18 11:04:38','2025-01-18 11:04:38','B'),(80,68,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-18 14:14:03','2025-01-18 14:14:03','A'),(81,68,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-18 14:14:03','2025-01-18 14:14:03','B');
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
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `projectStagePer` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId` (`projectId`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `ProjectStages_ibfk_229` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectStages_ibfk_230` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectStages_ibfk_231` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectStages`
--

LOCK TABLES `ProjectStages` WRITE;
/*!40000 ALTER TABLE `ProjectStages` DISABLE KEYS */;
INSERT INTO `ProjectStages` VALUES (36,49,'rcc1',0,0,5,5,'2025-01-17 10:33:36','2025-01-22 11:20:04',29),(49,49,'rcc',0,0,3,3,'2025-01-18 05:37:18','2025-01-22 11:05:41',20),(65,49,'Foundation',0,0,5,5,'2025-01-18 11:04:08','2025-01-18 11:04:08',25),(66,49,'rcc',0,0,5,5,'2025-01-18 11:04:28','2025-01-22 07:04:01',25),(67,49,'Foundation',0,0,5,5,'2025-01-18 11:04:38','2025-01-18 11:04:38',25),(68,49,'Foundation',0,0,5,5,'2025-01-18 14:14:03','2025-01-18 14:14:03',25);
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
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `terraceStatus` varchar(255) DEFAULT NULL,
  `terraceSize` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectUnits`
--

LOCK TABLES `ProjectUnits` WRITE;
/*!40000 ALTER TABLE `ProjectUnits` DISABLE KEYS */;
INSERT INTO `ProjectUnits` VALUES (133,49,'2-bhk','A-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(134,49,'2-bhk','A-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(135,49,'2-bhk','A-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(136,49,'2-bhk','A-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(137,49,'3-bhk','B-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(138,49,'3-bhk','B-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(139,49,'3-bhk','B-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(140,49,'3-bhk','B-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(141,49,'3-bhk','C-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(142,49,'3-bhk','C-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(143,49,'3-bhk','C-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(144,49,'3-bhk','C-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(145,49,'2-bhk','A-117',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(146,49,'3-bhk','A-118',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(147,49,'2-bhk','A-119',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(148,49,'3-bhk','A-120',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(149,49,'2-bhk','A-121',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(150,49,'3-bhk','A-122',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(151,49,'2-bhk','A-123',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(152,49,'3-bhk','A-124',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(153,49,'2-bhk','A-125',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(154,49,'3-bhk','A-126',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(155,49,'2-bhk','A-127',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(156,49,'3-bhk','A-128',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(157,49,'2-bhk','A-129',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(158,49,'3-bhk','A-130',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(159,49,'2-bhk','A-131',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(160,49,'3-bhk','A-132',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(161,49,'2-bhk','A-133',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(162,49,'3-bhk','A-134',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(163,49,'2-bhk','A-135',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(164,49,'3-bhk','A-136',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(165,49,'2-bhk','A-137',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(166,49,'3-bhk','A-138',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(167,49,'2-bhk','A-139',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(168,49,'3-bhk','A-140',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(169,49,'2-bhk','A-141',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(170,49,'3-bhk','A-142',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(171,49,'2-bhk','A-143',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(172,49,'3-bhk','A-144',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(173,49,'2-bhk','A-145',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(174,49,'3-bhk','A-146',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(175,49,'2-bhk','A-147',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(176,49,'3-bhk','A-148',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(177,49,'2-bhk','A-149',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(178,49,'3-bhk','A-150',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(179,49,'2-bhk','A-151',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(180,49,'3-bhk','A-152',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(181,49,'2-bhk','A-153',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(182,49,'3-bhk','A-154',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(183,49,'2-bhk','A-155',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(184,49,'3-bhk','A-156',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(185,49,'2-bhk','A-157',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(186,49,'3-bhk','A-158',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(187,49,'2-bhk','A-159',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(188,49,'3-bhk','A-160',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(189,49,'2-bhk','A-161',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(190,49,'3-bhk','A-162',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(191,49,'2-bhk','A-163',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(192,49,'3-bhk','A-164',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(193,49,'2-bhk','A-165',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(194,49,'3-bhk','A-166',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(195,49,'2-bhk','A-167',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(196,49,'3-bhk','A-168',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(197,49,'2-bhk','A-169',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(198,49,'3-bhk','A-170',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(199,49,'2-bhk','A-171',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(200,49,'3-bhk','A-172',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(201,49,'2-bhk','A-173',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(202,49,'3-bhk','A-174',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(203,49,'2-bhk','A-175',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(204,49,'3-bhk','A-176',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(205,49,'2-bhk','A-177',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(206,49,'3-bhk','A-178',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(207,49,'2-bhk','A-179',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(208,49,'3-bhk','A-180',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(209,49,'2-bhk','A-181',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(210,49,'3-bhk','A-182',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(211,49,'2-bhk','A-183',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(212,49,'3-bhk','A-184',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(213,49,'2-bhk','A-185',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(214,49,'3-bhk','A-186',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(215,49,'2-bhk','A-187',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(216,49,'3-bhk','A-188',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(217,49,'2-bhk','A-189',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(218,49,'3-bhk','A-190',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(219,49,'2-bhk','A-191',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(220,49,'3-bhk','A-192',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(221,49,'2-bhk','A-193',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(222,49,'3-bhk','A-194',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(223,49,'2-bhk','A-195',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(224,49,'3-bhk','A-196',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(225,49,'2-bhk','A-197',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(226,49,'3-bhk','A-198',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(227,49,'2-bhk','A-199',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(228,49,'3-bhk','A-200',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(229,49,'2-bhk','A-201',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(230,49,'3-bhk','A-202',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(231,49,'2-bhk','A-203',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(232,49,'3-bhk','A-204',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(233,49,'2-bhk','B-105',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(234,49,'3-bhk','B-106',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(235,49,'2-bhk','B-107',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(236,49,'3-bhk','B-108',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(237,49,'2-bhk','B-109',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(238,49,'3-bhk','B-110',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(239,49,'2-bhk','B-111',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(240,49,'3-bhk','B-112',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(241,49,'2-bhk','B-113',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(242,49,'3-bhk','B-114',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(243,49,'2-bhk','B-115',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(244,49,'3-bhk','B-116',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(245,49,'2-bhk','B-117',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(246,49,'3-bhk','B-118',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(247,49,'2-bhk','B-119',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(248,49,'3-bhk','B-120',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(249,49,'2-bhk','B-121',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(250,49,'3-bhk','B-122',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(251,49,'2-bhk','B-123',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(252,49,'3-bhk','B-124',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(253,49,'2-bhk','B-125',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(254,49,'3-bhk','B-126',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(255,49,'2-bhk','B-127',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(256,49,'3-bhk','B-128',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(257,49,'2-bhk','B-129',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(258,49,'3-bhk','B-130',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(259,49,'2-bhk','B-131',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(260,49,'3-bhk','B-132',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(261,49,'2-bhk','B-133',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(262,49,'3-bhk','B-134',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(263,49,'2-bhk','B-135',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(264,49,'3-bhk','B-136',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(265,49,'2-bhk','B-137',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(266,49,'3-bhk','B-138',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(267,49,'2-bhk','B-139',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(268,49,'3-bhk','B-140',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(269,49,'2-bhk','B-141',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(270,49,'3-bhk','B-142',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(271,49,'2-bhk','B-143',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(272,49,'3-bhk','B-144',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(273,49,'2-bhk','B-145',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(274,49,'3-bhk','B-146',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(275,49,'2-bhk','B-147',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(276,49,'3-bhk','B-148',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(277,49,'2-bhk','B-149',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(278,49,'3-bhk','B-150',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(279,49,'2-bhk','B-151',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(280,49,'3-bhk','B-152',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(281,49,'2-bhk','B-153',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(282,49,'3-bhk','B-154',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(283,49,'2-bhk','B-155',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(284,49,'3-bhk','B-156',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(285,49,'2-bhk','B-157',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(286,49,'3-bhk','B-158',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(287,49,'2-bhk','B-159',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(288,49,'3-bhk','B-160',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(289,49,'2-bhk','B-161',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(290,49,'3-bhk','B-162',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(291,49,'2-bhk','B-163',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(292,49,'3-bhk','B-164',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(293,49,'2-bhk','B-165',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(294,49,'3-bhk','B-166',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(295,49,'2-bhk','B-167',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(296,49,'3-bhk','B-168',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(297,49,'2-bhk','B-169',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(298,49,'3-bhk','B-170',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(299,49,'2-bhk','B-171',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(300,49,'3-bhk','B-172',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(301,49,'2-bhk','B-173',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(302,49,'3-bhk','B-174',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(303,49,'2-bhk','B-175',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(304,49,'3-bhk','B-176',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(305,49,'2-bhk','B-177',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(306,49,'3-bhk','B-178',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(307,49,'2-bhk','B-179',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(308,49,'3-bhk','B-180',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(309,49,'2-bhk','B-181',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(310,49,'3-bhk','B-182',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(311,49,'2-bhk','B-183',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(312,49,'3-bhk','B-184',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(313,49,'2-bhk','B-185',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(314,49,'3-bhk','B-186',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(315,49,'2-bhk','B-187',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(316,49,'3-bhk','B-188',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(317,49,'2-bhk','B-189',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(318,49,'3-bhk','B-190',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(319,49,'2-bhk','B-191',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(320,49,'3-bhk','B-192',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(321,49,'2-bhk','B-193',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(322,49,'3-bhk','B-194',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(323,49,'2-bhk','B-195',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(324,49,'3-bhk','B-196',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(325,49,'2-bhk','B-197',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(326,49,'3-bhk','B-198',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(327,49,'2-bhk','B-199',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(328,49,'3-bhk','B-200',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(329,49,'2-bhk','B-201',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(330,49,'3-bhk','B-202',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(331,49,'2-bhk','B-203',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(332,49,'3-bhk','B-204',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(333,49,'2-bhk','C-105',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(334,49,'3-bhk','C-106',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(335,49,'2-bhk','C-107',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(336,49,'3-bhk','C-108',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(337,49,'2-bhk','C-109',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(338,49,'3-bhk','C-110',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(339,49,'2-bhk','C-111',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(340,49,'3-bhk','C-112',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(341,49,'2-bhk','C-113',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(342,49,'3-bhk','C-114',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(343,49,'2-bhk','C-115',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(344,49,'3-bhk','C-116',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(345,49,'2-bhk','C-117',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(346,49,'3-bhk','C-118',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(347,49,'2-bhk','C-119',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(348,49,'3-bhk','C-120',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(349,49,'2-bhk','C-121',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(350,49,'3-bhk','C-122',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(351,49,'2-bhk','C-123',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(352,49,'3-bhk','C-124',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(353,49,'2-bhk','C-125',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(354,49,'3-bhk','C-126',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(355,49,'2-bhk','C-127',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(356,49,'3-bhk','C-128',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(357,49,'2-bhk','C-129',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(358,49,'3-bhk','C-130',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(359,49,'2-bhk','C-131',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(360,49,'3-bhk','C-132',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(361,49,'2-bhk','C-133',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(362,49,'3-bhk','C-134',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(363,49,'2-bhk','C-135',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(364,49,'3-bhk','C-136',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(365,49,'2-bhk','C-137',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(366,49,'3-bhk','C-138',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(367,49,'2-bhk','C-139',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(368,49,'3-bhk','C-140',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(369,49,'2-bhk','C-141',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(370,49,'3-bhk','C-142',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(371,49,'2-bhk','C-143',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(372,49,'3-bhk','C-144',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(373,49,'2-bhk','C-145',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(374,49,'3-bhk','C-146',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(375,49,'2-bhk','C-147',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(376,49,'3-bhk','C-148',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(377,49,'2-bhk','C-149',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(378,49,'3-bhk','C-150',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(379,49,'2-bhk','C-151',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(380,49,'3-bhk','C-152',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(381,49,'2-bhk','C-153',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(382,49,'3-bhk','C-154',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59',NULL,NULL),(471,59,'2 bhk','A 101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-28 11:12:53','2025-01-28 11:12:53','Yes','200'),(472,59,'2 bhk','A 102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-28 11:12:53','2025-01-28 11:12:53','No',NULL);
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
INSERT INTO `Projects` VALUES (45,'Ajay',0,0,5,5,'2025-01-16 12:09:28','2025-01-16 12:09:28'),(49,'Raam Residency',0,0,3,3,'2025-01-17 10:14:59','2025-01-17 10:14:59'),(59,'Gandhinagar heights',0,0,3,3,'2025-01-28 11:12:53','2025-01-28 11:12:53');
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
  CONSTRAINT `RolePermissions_ibfk_181` FOREIGN KEY (`role`) REFERENCES `Roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RolePermissions_ibfk_182` FOREIGN KEY (`permission`) REFERENCES `Permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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
INSERT INTO `ScrapIncomes` VALUES (1,18,NULL,NULL,NULL,NULL,0,0,85,85,'2025-02-04 04:42:35','2025-02-04 04:42:35');
/*!40000 ALTER TABLE `ScrapIncomes` ENABLE KEYS */;
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
  CONSTRAINT `UserRoles_ibfk_181` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_182` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_183` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_184` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRoles`
--

LOCK TABLES `UserRoles` WRITE;
/*!40000 ALTER TABLE `UserRoles` DISABLE KEYS */;
INSERT INTO `UserRoles` VALUES (28,43,57,0,0,NULL,NULL,'2025-01-23 05:23:29','2025-01-23 05:23:29'),(29,44,1,0,0,NULL,NULL,'2025-01-23 09:28:48','2025-01-23 09:28:48'),(34,66,1,0,0,NULL,NULL,'2025-01-25 09:43:26','2025-01-25 09:43:26'),(35,67,1,0,0,NULL,NULL,'2025-01-25 09:45:23','2025-01-25 09:45:23'),(39,71,59,0,0,NULL,NULL,'2025-01-29 06:51:09','2025-01-29 06:51:09'),(41,73,60,0,0,NULL,NULL,'2025-01-29 07:23:45','2025-01-29 07:23:45'),(47,74,63,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(48,74,65,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(49,74,66,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(50,75,61,0,0,NULL,NULL,'2025-01-29 08:55:30','2025-01-29 08:55:30'),(51,76,62,0,0,NULL,NULL,'2025-01-29 11:27:36','2025-01-29 11:27:36'),(52,77,68,0,0,NULL,NULL,'2025-01-29 11:59:41','2025-01-29 11:59:41'),(53,78,69,0,0,NULL,NULL,'2025-01-29 12:16:06','2025-01-29 12:16:06'),(54,79,57,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(55,79,59,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(56,79,60,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(57,79,61,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(58,79,62,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(59,79,68,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(60,79,69,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(61,80,63,0,0,NULL,NULL,'2025-01-30 09:06:05','2025-01-30 09:06:05'),(62,81,70,0,0,NULL,NULL,'2025-01-31 04:50:56','2025-01-31 04:50:56'),(63,82,71,0,0,NULL,NULL,'2025-01-31 05:22:57','2025-01-31 05:22:57'),(64,83,72,0,0,NULL,NULL,'2025-01-31 07:21:29','2025-01-31 07:21:29'),(65,84,73,0,0,NULL,NULL,'2025-01-31 07:47:42','2025-01-31 07:47:42'),(66,85,57,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(67,85,59,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(68,85,60,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(69,85,61,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(70,85,62,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(71,85,63,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(72,85,68,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(73,85,69,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(74,85,70,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(75,85,71,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(76,85,72,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30'),(77,85,73,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30');
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
INSERT INTO `Users` VALUES (3,'Raviraj123','Active','$2b$10$uITJ39ao6C59cpUTfqmGduh/VJL84gA1nTmWUZyIUNAGJbosHJCY.','$2b$10$CMUaQa6P4LYvhqqA/Wqr4uyRB1Ouf6.Zn6WCz4Hj3p.ES.H0qc2Mu',0,0,NULL,NULL,'2025-01-07 05:42:10','2025-01-07 05:42:10'),(5,'Raviraj','Active','$2b$10$kTtQQx.wKgvDsdYZmmYpnOfBVBBQ6Vro8CyOCSW/T1RiY1SwXjsQK','$2b$10$dFUK.osFSEmnntJN5LL1ue1t1GzxwO7ruQgRQMQ6jD1euCjycW.Pm',0,0,NULL,NULL,'2025-01-07 11:09:06','2025-01-07 11:09:06'),(17,'khilen','Active','$2b$10$hzTqexG3TAWNpfHDdAdI4e1iXUSM9L6ygrAn6ZTqGPIQP6wQiAGgG','$2b$10$/OORPrYjO1vqJU/BSNtvI.jww8P4..EFM2Qo6Nzirk6F6z8aIsPy6',0,0,NULL,NULL,'2025-01-17 10:47:23','2025-01-17 10:47:23'),(43,'partner','Active','$2b$10$jSNoRjQ1o/jFKmllgAAJ0eD07QXdh/npUjumOHRfTOFFZ8aRHwXka','$2b$10$AmUEzCO6pXtuwItE9Yp0AeMAI.rHlODtc0.dmYhxBm5raAW4LAoyi',0,0,NULL,NULL,'2025-01-23 05:23:29','2025-01-23 05:23:29'),(44,'Raj','Active','$2b$10$DolJsQ2Qc5.1R4TCAhFn3uVP36sCDL3j9/CrwbL3JASjXytHXiFqS','$2b$10$W4xJCH4j/sn6s/vf1eo56O.mrnj/Z0uOtud3iFl6a2MQ4Gf7xPKO2',0,0,NULL,NULL,'2025-01-23 09:28:48','2025-01-23 09:28:48'),(56,'khilen89','Active','$2b$10$pwRrWp5XPbDCxdX6ROP.s.9h4gzYPPuA4Ls2ZBwneXuZ1LMWGv7Ie','$2b$10$mTTOZiPPMbbvaqHVmwNnIO9T.tc1Ajh9pevcDbhJD5f1CymdS3k.2',0,0,NULL,NULL,'2025-01-23 18:45:54','2025-01-23 18:45:54'),(66,'Raviraj1','Active','$2b$10$T0FcRVFGZEy4JRrxFIyciOesdZxNC53VhVHd9jDvzNGwwFYV/JbS2',NULL,0,0,NULL,NULL,'2025-01-25 09:43:26','2025-01-25 09:43:26'),(67,'devanshi','Active','$2b$10$yDDo1qEq.BLRU9zxBrLQveQ2nhI8Hkl2mPNDmYWF3D83WoOkAmy1q',NULL,0,0,NULL,NULL,'2025-01-25 09:45:23','2025-01-25 09:45:23'),(71,'User','Active','$2b$10$m0crjwaHgeH9pps4L6hf6OEWIALmPt8zm3GLGZuR61LQhjoBeV89q',NULL,0,0,NULL,NULL,'2025-01-29 06:51:09','2025-01-29 06:51:09'),(73,'Project','Active','$2b$10$sBg7Lhw0B13Hn28p39Y59ujkR0cfXhy6gUfiVfbcIiZNX0eEM.MlG',NULL,0,0,NULL,NULL,'2025-01-29 07:23:45','2025-01-29 07:23:45'),(74,'realestate','Active','$2b$10$cHBZkMYq.viwp.FHof5DwOyyFGFwBUe3LcNCASEjrJI6GcUKV1vrC',NULL,0,0,NULL,NULL,'2025-01-29 08:47:53','2025-01-29 08:47:53'),(75,'Booking','Active','$2b$10$OcqklKu/05upTbzWX.RJzeoW.ZF9z/bBnScy9mZIiI17P.T8dNLCu',NULL,0,0,NULL,NULL,'2025-01-29 08:55:30','2025-01-29 08:55:30'),(76,'Broker','Active','$2b$10$Kn0VRdjsAcpHYxphSCDXBu/vBLoEN5tHqQbd3IqqLECR0ZhFSmhFm',NULL,0,0,NULL,NULL,'2025-01-29 11:27:36','2025-01-29 11:27:36'),(77,'Role','Active','$2b$10$hPIvc6ir2mtDPb6be.nTTOabM/FioQ84O5be7/bxeXBwE3TPW0Chm',NULL,0,0,NULL,NULL,'2025-01-29 11:59:41','2025-01-29 11:59:41'),(78,'Permissions','Active','$2b$10$QbheuEHeJitAgrFuKViXIef.4NqfOoS/dYn98tU0Z3fTDCErEfpIW',NULL,0,0,NULL,NULL,'2025-01-29 12:16:06','2025-01-29 12:16:06'),(79,'state','Active','$2b$10$gR2JvqG8u5OxjKQIkJDByez97ligBZ4XXrGaLYYX5Jkj5wnv6NH2u',NULL,0,0,NULL,NULL,'2025-01-30 06:55:08','2025-01-30 06:55:08'),(80,'Expenses','Active','$2b$10$TDABwSoBVj3zpeYCiE0b2eBY8JHDvuIk7LirzezZVHFhBIfPMcRTO',NULL,0,0,NULL,NULL,'2025-01-30 09:06:05','2025-01-30 09:06:05'),(81,'Income','Active','$2b$10$Ag6aRQZQYCmR7b4CTQQt8OAcBEP03DiM/1MaIKYxIeMCmkV7sZnQ2',NULL,0,0,NULL,NULL,'2025-01-31 04:50:56','2025-01-31 04:50:56'),(82,'Ledger','Active','$2b$10$UQ3P/TmfRIwwhyvRjXzG5uQIYdrHahTQ4fLdLj4fS72As.h.OV7ua',NULL,0,0,NULL,NULL,'2025-01-31 05:22:57','2025-01-31 05:22:57'),(83,'Approval','Active','$2b$10$F6dEMTE/TJd2ihvOuR6Xre.dhq3xHSGriJd7VD1SFZZCIDwximPPa',NULL,0,0,NULL,NULL,'2025-01-31 07:21:29','2025-01-31 07:21:29'),(84,'Report','Active','$2b$10$.8G3fYRv6UtHTX04jnytrOcIVQqmNv38IL/RX.2/pPnnDWVXqNizu',NULL,0,0,NULL,NULL,'2025-01-31 07:47:42','2025-01-31 07:47:42'),(85,'flipcode','Active','$2b$10$WWdlH4zKiOAULnVRjjonYO4WTienfacEY9ev7XR/xUYstKsQxJYE6',NULL,0,0,NULL,NULL,'2025-01-31 11:57:30','2025-01-31 11:57:30');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-04  6:35:13
