-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: realestateDb
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `brokerName` varchar(255) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Brokers`
--

LOCK TABLES `Brokers` WRITE;
/*!40000 ALTER TABLE `Brokers` DISABLE KEYS */;
INSERT INTO `Brokers` VALUES (2,'Jigar bhai','surendranagar','9874563210',0,0,5,5,'2025-01-10 04:26:29','2025-01-10 04:26:29'),(3,'Jigar bhai','surendranagar','9874563210',0,0,5,5,'2025-01-10 09:07:36','2025-01-10 09:07:36'),(5,'raviraj','jjhjghjgj','1664564',0,0,3,3,'2025-01-10 09:12:54','2025-01-10 09:12:54'),(9,'jamnagar','46464646','4646',0,0,3,3,'2025-01-10 10:56:05','2025-01-10 10:56:05'),(10,'Surendranagar ','bjhhjjh','46464',0,0,3,3,'2025-01-10 11:03:58','2025-01-10 11:03:58'),(11,'Surendranagar ','dsadsajhdsajhdas','546464',0,0,3,3,'2025-01-10 11:05:55','2025-01-10 11:05:55'),(12,'Cricket','dfdfd','64646',0,0,3,3,'2025-01-10 11:06:18','2025-01-10 11:06:18'),(13,'devanshi','surendranagar','9925943808',0,0,3,3,'2025-01-13 06:32:59','2025-01-13 06:32:59'),(14,'Jamnagar','nnn','654646446',0,0,3,3,'2025-01-13 06:34:06','2025-01-13 06:34:06');
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
  `city` varchar(255) NOT NULL,
  `moblieNumber` varchar(255) NOT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `isLocked` tinyint(1) DEFAULT '0',
  `createdBy` int NOT NULL,
  `updatedBy` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `name` varchar(255) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ExpenseMasters`
--

LOCK TABLES `ExpenseMasters` WRITE;
/*!40000 ALTER TABLE `ExpenseMasters` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IncomeMasters`
--

LOCK TABLES `IncomeMasters` WRITE;
/*!40000 ALTER TABLE `IncomeMasters` DISABLE KEYS */;
/*!40000 ALTER TABLE `IncomeMasters` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  KEY `updatedBy` (`updatedBy`),
  CONSTRAINT `Partners_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `Partners_ibfk_2` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Partners`
--

LOCK TABLES `Partners` WRITE;
/*!40000 ALTER TABLE `Partners` DISABLE KEYS */;
INSERT INTO `Partners` VALUES (1,'Rudrika',0,0,5,5,'2025-01-10 09:11:50','2025-01-10 09:11:50'),(2,'Rudrika',0,0,5,5,'2025-01-10 10:15:35','2025-01-10 10:15:35'),(3,'Rudrika',0,0,5,5,'2025-01-10 10:50:04','2025-01-10 10:50:04'),(4,'Rudrika',0,0,5,5,'2025-01-10 11:39:52','2025-01-10 11:39:52'),(5,'Rudrika',0,0,5,5,'2025-01-10 15:14:16','2025-01-10 15:14:16'),(6,'Rudrika',0,0,5,5,'2025-01-11 09:42:25','2025-01-11 09:42:25'),(7,'dADA',0,0,3,3,'2025-01-11 09:53:51','2025-01-11 09:53:51'),(8,'Rudrika',0,0,5,5,'2025-01-11 09:54:03','2025-01-11 09:54:03'),(9,'Dipak',0,0,3,3,'2025-01-11 10:00:52','2025-01-11 10:00:52'),(10,'Rudrika',0,0,5,5,'2025-01-11 10:02:20','2025-01-11 10:02:20'),(11,'Dipak',0,0,3,3,'2025-01-11 10:06:33','2025-01-11 10:06:33'),(12,'Shivq',0,0,3,3,'2025-01-11 10:22:25','2025-01-11 10:22:25'),(13,'sita',0,0,5,5,'2025-01-11 11:28:22','2025-01-11 11:28:22'),(14,'Demo',0,0,3,3,'2025-01-16 04:36:39','2025-01-16 04:36:39');
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permissions`
--

LOCK TABLES `Permissions` WRITE;
/*!40000 ALTER TABLE `Permissions` DISABLE KEYS */;
INSERT INTO `Permissions` VALUES (1,'User-add',0,0,3,3,'2025-01-07 13:29:35','2025-01-07 13:29:35'),(2,'User-view',0,0,5,5,'2025-01-09 12:14:39','2025-01-09 12:14:39'),(3,'User-EDIT',0,0,5,5,'2025-01-10 08:45:40','2025-01-13 11:05:51'),(4,'User-view',0,0,5,5,'2025-01-10 09:44:49','2025-01-10 09:44:49'),(5,'sgcskjfhdsuifdsuivksdj',0,0,3,3,'2025-01-10 10:11:58','2025-01-10 10:11:58'),(6,'user-delete',0,0,3,3,'2025-01-10 10:54:26','2025-01-10 10:54:26');
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
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectPartners`
--

LOCK TABLES `ProjectPartners` WRITE;
/*!40000 ALTER TABLE `ProjectPartners` DISABLE KEYS */;
INSERT INTO `ProjectPartners` VALUES (1,3,1,10,0,0,5,5,'2025-01-10 09:11:50','2025-01-10 09:11:50'),(2,3,2,10,0,0,5,5,'2025-01-10 10:15:35','2025-01-10 10:15:35'),(3,3,3,10,0,0,5,5,'2025-01-10 10:50:04','2025-01-10 10:50:04'),(4,3,4,10,0,0,5,5,'2025-01-10 11:39:52','2025-01-10 11:39:52'),(5,3,5,10,0,0,5,5,'2025-01-10 15:14:16','2025-01-10 15:14:16'),(6,3,6,10,0,0,5,5,'2025-01-11 09:42:25','2025-01-11 09:42:25'),(7,37,7,12,0,0,3,3,'2025-01-11 09:53:51','2025-01-11 09:53:51'),(8,3,8,10,0,0,5,5,'2025-01-11 09:54:03','2025-01-11 09:54:03'),(9,38,9,34,0,0,3,3,'2025-01-11 10:00:52','2025-01-11 10:00:52'),(10,3,10,10,0,0,5,5,'2025-01-11 10:02:20','2025-01-11 10:02:20'),(11,38,11,100,0,0,3,3,'2025-01-11 10:06:34','2025-01-11 10:06:34'),(12,16,12,99,0,0,3,3,'2025-01-11 10:22:25','2025-01-11 10:22:25'),(13,16,13,10,0,0,5,5,'2025-01-11 11:28:22','2025-01-11 11:28:22'),(14,40,14,1,0,0,3,3,'2025-01-16 04:36:39','2025-01-16 04:36:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectStageTransactions`
--

LOCK TABLES `ProjectStageTransactions` WRITE;
/*!40000 ALTER TABLE `ProjectStageTransactions` DISABLE KEYS */;
INSERT INTO `ProjectStageTransactions` VALUES (1,19,'In Progress','2025-03-31 00:00:00',NULL,0,0,3,3,'2025-01-11 09:35:27','2025-01-11 09:35:27','A'),(2,19,'Completed','2025-03-15 00:00:00',NULL,0,0,3,3,'2025-01-11 09:35:27','2025-01-11 09:35:27','B'),(3,20,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-11 09:48:22','2025-01-11 09:48:22','A'),(4,20,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-11 09:48:22','2025-01-11 09:48:22','B'),(5,21,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-11 09:52:31','2025-01-11 09:52:31','A'),(6,21,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-11 09:52:31','2025-01-11 09:52:31','B'),(7,22,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-11 10:04:46','2025-01-11 10:04:46','A'),(8,22,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-11 10:04:46','2025-01-11 10:04:46','B'),(9,23,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-13 05:13:47','2025-01-13 05:13:47','A'),(10,23,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-13 05:13:47','2025-01-13 05:13:47','B'),(11,24,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-13 07:08:21','2025-01-13 07:08:21','A'),(12,24,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-13 07:08:21','2025-01-13 07:08:21','B'),(13,25,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-13 07:09:23','2025-01-13 07:09:23','A'),(14,25,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-13 07:09:23','2025-01-13 07:09:23','B'),(15,26,'In Progress','2025-03-31 00:00:00',NULL,0,0,5,5,'2025-01-16 06:51:49','2025-01-16 06:51:49','A'),(16,26,'Completed','2025-03-15 00:00:00',NULL,0,0,5,5,'2025-01-16 06:51:49','2025-01-16 06:51:49','B');
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
  CONSTRAINT `ProjectStages_ibfk_10` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectStages_ibfk_11` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ProjectStages_ibfk_12` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectStages`
--

LOCK TABLES `ProjectStages` WRITE;
/*!40000 ALTER TABLE `ProjectStages` DISABLE KEYS */;
INSERT INTO `ProjectStages` VALUES (1,16,'Foundation',0,0,3,3,'2025-01-11 09:31:25','2025-01-11 09:31:25',25),(2,16,'Foundation',0,0,3,3,'2025-01-11 09:33:10','2025-01-11 09:33:10',25),(3,16,'Foundation',0,0,3,3,'2025-01-11 09:33:11','2025-01-11 09:33:11',25),(4,16,'Foundation',0,0,3,3,'2025-01-11 09:33:12','2025-01-11 09:33:12',25),(5,16,'Foundation',0,0,3,3,'2025-01-11 09:33:13','2025-01-11 09:33:13',25),(6,16,'Foundation',0,0,3,3,'2025-01-11 09:33:15','2025-01-11 09:33:15',25),(7,16,'Foundation',0,0,3,3,'2025-01-11 09:33:57','2025-01-11 09:33:57',25),(8,16,'Foundation',0,0,3,3,'2025-01-11 09:34:18','2025-01-11 09:34:18',25),(9,16,'Foundation',0,0,3,3,'2025-01-11 09:34:20','2025-01-11 09:34:20',25),(10,16,'Foundation',0,0,3,3,'2025-01-11 09:34:21','2025-01-11 09:34:21',25),(11,16,'Foundation',0,0,3,3,'2025-01-11 09:35:06','2025-01-11 09:35:06',25),(12,16,'Foundation',0,0,3,3,'2025-01-11 09:35:08','2025-01-11 09:35:08',25),(13,16,'Foundation',0,0,3,3,'2025-01-11 09:35:09','2025-01-11 09:35:09',25),(14,16,'Foundation',0,0,3,3,'2025-01-11 09:35:10','2025-01-11 09:35:10',25),(15,16,'Foundation',0,0,3,3,'2025-01-11 09:35:11','2025-01-11 09:35:11',25),(16,16,'Foundation',0,0,3,3,'2025-01-11 09:35:11','2025-01-11 09:35:11',25),(17,16,'Foundation',0,0,3,3,'2025-01-11 09:35:12','2025-01-11 09:35:12',25),(18,16,'Foundation',0,0,3,3,'2025-01-11 09:35:13','2025-01-11 09:35:13',25),(19,16,'Foundation',0,0,3,3,'2025-01-11 09:35:27','2025-01-11 09:35:27',25),(20,16,'Foundation',0,0,5,5,'2025-01-11 09:48:22','2025-01-11 09:48:22',25),(21,16,'Foundation',0,0,5,5,'2025-01-11 09:52:31','2025-01-11 09:52:31',25),(22,16,'Foundation',0,0,5,5,'2025-01-11 10:04:46','2025-01-11 10:04:46',25),(23,16,'Foundation',0,0,5,5,'2025-01-13 05:13:47','2025-01-13 05:13:47',25),(24,16,'Foundation',0,0,5,5,'2025-01-13 07:08:21','2025-01-13 07:08:21',25),(25,16,'Foundation',0,0,5,5,'2025-01-13 07:09:23','2025-01-13 07:09:23',25),(26,16,'Foundation',0,0,5,5,'2025-01-16 06:51:49','2025-01-16 06:51:49',25);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProjectUnits`
--

LOCK TABLES `ProjectUnits` WRITE;
/*!40000 ALTER TABLE `ProjectUnits` DISABLE KEYS */;
INSERT INTO `ProjectUnits` VALUES (1,16,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:28:48','2025-01-08 05:28:48'),(2,17,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:43:59','2025-01-08 05:43:59'),(3,18,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:45:59','2025-01-08 05:45:59'),(4,19,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:50:40','2025-01-08 05:50:40'),(5,20,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:52:54','2025-01-08 05:52:54'),(6,21,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:54:05','2025-01-08 05:54:05'),(7,22,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 05:55:41','2025-01-08 05:55:41'),(8,23,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:00:51','2025-01-08 06:00:51'),(9,24,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:03:44','2025-01-08 06:03:44'),(10,25,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:04:00','2025-01-08 06:04:00'),(11,26,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:07:04','2025-01-08 06:07:04'),(12,27,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:09:07','2025-01-08 06:09:07'),(13,28,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:11:34','2025-01-08 06:11:34'),(14,29,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:22:25','2025-01-08 06:22:25'),(15,30,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:25:18','2025-01-08 06:25:18'),(16,31,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 06:55:41','2025-01-08 06:55:41'),(17,32,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 08:15:56','2025-01-08 08:15:56'),(18,33,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 11:30:31','2025-01-08 11:30:31'),(19,34,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 12:17:35','2025-01-08 12:17:35'),(20,35,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 12:19:09','2025-01-08 12:19:09'),(21,36,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-08 12:22:00','2025-01-08 12:22:00'),(22,37,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-10 04:23:33','2025-01-10 04:23:33'),(23,38,'type 1','10','10','100','Unsold','2500000','500000',0,0,3,3,'2025-01-10 07:28:32','2025-01-10 07:28:32'),(24,39,'2-bhk','A-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(25,39,'2-bhk','A-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(26,39,'2-bhk','A-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(27,39,'2-bhk','A-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(28,39,'3-bhk','B-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(29,39,'3-bhk','B-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(30,39,'3-bhk','B-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(31,39,'3-bhk','B-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(32,39,'3-bhk','C-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(33,39,'3-bhk','C-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(34,39,'3-bhk','C-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(35,39,'3-bhk','C-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(36,40,'2-bhk','A-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(37,40,'2-bhk','A-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(38,40,'2-bhk','A-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(39,40,'2-bhk','A-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(40,40,'3-bhk','B-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(41,40,'3-bhk','B-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(42,40,'3-bhk','B-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(43,40,'3-bhk','B-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(44,40,'3-bhk','C-101',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(45,40,'3-bhk','C-102',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(46,40,'3-bhk','C-103',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21'),(47,40,'3-bhk','C-104',NULL,'100','Unsold','2500000','500000',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21');
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Projects`
--

LOCK TABLES `Projects` WRITE;
/*!40000 ALTER TABLE `Projects` DISABLE KEYS */;
INSERT INTO `Projects` VALUES (16,'Ajay',0,0,3,3,'2025-01-08 05:28:48','2025-01-08 05:28:48'),(17,'Ajay',0,0,3,3,'2025-01-08 05:43:59','2025-01-08 05:43:59'),(18,'Ajay',0,0,3,3,'2025-01-08 05:45:59','2025-01-08 05:45:59'),(19,'Ajay',0,0,3,3,'2025-01-08 05:50:40','2025-01-08 05:50:40'),(20,'Ajay',0,0,3,3,'2025-01-08 05:52:54','2025-01-08 05:52:54'),(21,'Ajay',0,0,3,3,'2025-01-08 05:54:05','2025-01-08 05:54:05'),(22,'Ajay',0,0,3,3,'2025-01-08 05:55:41','2025-01-08 05:55:41'),(23,'Ajay',0,0,3,3,'2025-01-08 06:00:51','2025-01-08 06:00:51'),(24,'Ajay',0,0,3,3,'2025-01-08 06:03:44','2025-01-08 06:03:44'),(25,'Ajay',0,0,3,3,'2025-01-08 06:04:00','2025-01-08 06:04:00'),(26,'Ajay',0,0,3,3,'2025-01-08 06:07:04','2025-01-08 06:07:04'),(27,'Ajay',0,0,3,3,'2025-01-08 06:09:07','2025-01-08 06:09:07'),(28,'Ajay',0,0,3,3,'2025-01-08 06:11:34','2025-01-08 06:11:34'),(29,'Ajay',0,0,3,3,'2025-01-08 06:22:25','2025-01-08 06:22:25'),(30,'Ajay',0,0,3,3,'2025-01-08 06:25:18','2025-01-08 06:25:18'),(31,'Ajay',0,0,3,3,'2025-01-08 06:55:41','2025-01-08 06:55:41'),(32,'Ajay',0,0,3,3,'2025-01-08 08:15:56','2025-01-08 08:15:56'),(33,'Ajay',0,0,3,3,'2025-01-08 11:30:31','2025-01-08 11:30:31'),(34,'Ajay',0,0,3,3,'2025-01-08 12:17:35','2025-01-08 12:17:35'),(35,'test',0,0,3,3,'2025-01-08 12:19:09','2025-01-08 12:19:09'),(36,'DabhiDipak ',0,0,3,3,'2025-01-08 12:22:00','2025-01-08 12:22:00'),(37,'DabhiDipak ',0,0,3,3,'2025-01-10 04:23:33','2025-01-10 04:23:33'),(38,'Dipak',0,0,3,3,'2025-01-10 07:28:32','2025-01-10 07:28:32'),(39,'Cricket',0,0,3,3,'2025-01-13 10:29:03','2025-01-13 10:29:03'),(40,'ram',0,0,3,3,'2025-01-13 11:06:21','2025-01-13 11:06:21');
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
  CONSTRAINT `RolePermissions_ibfk_35` FOREIGN KEY (`role`) REFERENCES `Roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RolePermissions_ibfk_36` FOREIGN KEY (`permission`) REFERENCES `Permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RolePermissions`
--

LOCK TABLES `RolePermissions` WRITE;
/*!40000 ALTER TABLE `RolePermissions` DISABLE KEYS */;
INSERT INTO `RolePermissions` VALUES (53,45,2,0,0,3,3,'2025-01-13 11:29:37','2025-01-13 11:29:37'),(54,45,1,0,0,3,3,'2025-01-13 11:29:37','2025-01-13 11:29:37'),(55,45,3,0,0,3,3,'2025-01-13 11:29:37','2025-01-13 11:29:37'),(56,45,6,0,0,3,3,'2025-01-13 11:29:37','2025-01-13 11:29:37'),(57,46,1,0,0,3,3,'2025-01-13 11:33:00','2025-01-13 11:33:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'Super Admin',0,0,NULL,NULL,'2025-01-06 12:43:21','2025-01-07 08:22:25'),(8,'admin',0,0,NULL,NULL,'2025-01-08 08:16:07','2025-01-08 08:16:07'),(45,'peon',0,0,3,3,'2025-01-13 11:29:37','2025-01-13 11:29:37'),(46,'admin',0,0,3,3,'2025-01-13 11:33:00','2025-01-13 11:33:00');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
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
  CONSTRAINT `UserRoles_ibfk_35` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_36` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_37` FOREIGN KEY (`createdBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `UserRoles_ibfk_38` FOREIGN KEY (`updatedBy`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRoles`
--

LOCK TABLES `UserRoles` WRITE;
/*!40000 ALTER TABLE `UserRoles` DISABLE KEYS */;
INSERT INTO `UserRoles` VALUES (4,5,1,0,0,NULL,NULL,'2025-01-07 11:09:06','2025-01-07 11:09:06'),(6,7,1,0,0,NULL,NULL,'2025-01-08 04:39:45','2025-01-08 04:39:45'),(10,11,8,0,0,NULL,NULL,'2025-01-08 11:22:55','2025-01-08 11:22:55'),(11,12,8,0,0,NULL,NULL,'2025-01-09 05:34:11','2025-01-09 05:34:11'),(12,13,1,0,0,NULL,NULL,'2025-01-09 12:40:39','2025-01-09 12:40:39');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (3,'Raviraj123','Active','$2b$10$uITJ39ao6C59cpUTfqmGduh/VJL84gA1nTmWUZyIUNAGJbosHJCY.','$2b$10$CMUaQa6P4LYvhqqA/Wqr4uyRB1Ouf6.Zn6WCz4Hj3p.ES.H0qc2Mu',0,0,NULL,NULL,'2025-01-07 05:42:10','2025-01-07 05:42:10'),(5,'Raviraj','Active','$2b$10$kTtQQx.wKgvDsdYZmmYpnOfBVBBQ6Vro8CyOCSW/T1RiY1SwXjsQK','$2b$10$dFUK.osFSEmnntJN5LL1ue1t1GzxwO7ruQgRQMQ6jD1euCjycW.Pm',0,0,NULL,NULL,'2025-01-07 11:09:06','2025-01-07 11:09:06'),(7,'demo','Active','$2b$10$.opuseU0e0eJLpQvnQGG4.OMWU7fS8Ab4R7J6YcG6BIwU7Plc5fci','$2b$10$YMJt/tneNWxsbnXSqJuAue2NV1NoNj7kkrFSaIeMSOAQyUBhil.d6',0,0,NULL,NULL,'2025-01-08 04:39:45','2025-01-08 04:39:45'),(11,'kiran','Active','$2b$10$qIcINOXrLXbFaagx4ks2YOaCJ3lnSZGhwhsavFJg27DfuMvS.WR0q','$2b$10$oq8TWtCGs/eC4DxJb4wL5eBD5tlVfHkVFAfAOqZ0/Beaah6hqSrQ2',0,0,NULL,NULL,'2025-01-08 11:22:55','2025-01-08 11:22:55'),(12,'dnbsjf','Active','$2b$10$DvDWEkzWqeVemY7Ou313b.zOEuPFA61pPlVwZdy/tXRlo71Czo22a','$2b$10$aA0Fo1xzYOvSPPrb9EmIL.Y40Sn4hDIvRVVcCe7x/razh/W6xw7ja',0,0,NULL,NULL,'2025-01-09 05:34:11','2025-01-09 05:34:11'),(13,'Kiran1','Active','$2b$10$O.KmslpMD5AgDkRcxTUPFugXU2ymisn/kdLaS3fuFIbW88iEX1TGK','$2b$10$8HivIC5ePKYRa6z.N.q8aODYmTOAi6Ajg7Jgbipb8dm7E3RdYaKOW',0,0,NULL,NULL,'2025-01-09 12:40:39','2025-01-09 12:40:39');
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

-- Dump completed on 2025-01-16  7:13:13
