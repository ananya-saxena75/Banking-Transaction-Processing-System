CREATE DATABASE  IF NOT EXISTS `bank` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bank`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bank
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `account_number` varchar(30) NOT NULL,
  `balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `account_type` varchar(20) NOT NULL,
  `account_status` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `idx_account_customer` (`customer_id`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `chk_account_balance` CHECK ((`balance` >= 0)),
  CONSTRAINT `chk_account_status` CHECK ((`account_status` in (_utf8mb4'ACTIVE',_utf8mb4'INACTIVE'))),
  CONSTRAINT `chk_account_type` CHECK ((`account_type` in (_utf8mb4'SAVINGS',_utf8mb4'CURRENT')))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,1,'ACC1001',10000.00,'SAVINGS','ACTIVE','2026-11-26 02:03:28.557435','2026-11-26 02:03:28.557435'),(2,2,'ACC1002',5000.00,'SAVINGS','ACTIVE','2026-11-26 02:03:28.557435','2026-11-26 02:03:28.557435'),(3,3,'ACC1003',15000.00,'CURRENT','ACTIVE','2026-11-26 02:03:28.557435','2026-11-26 02:03:28.557435'),(4,1,'ACC1004',2000.00,'SAVINGS','ACTIVE','2026-11-26 02:03:28.557435','2026-11-26 02:03:28.557435');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_transaction`
--

DROP TABLE IF EXISTS `bank_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_transaction` (
  `transaction_id` varchar(50) NOT NULL,
  `source_account_id` bigint DEFAULT NULL,
  `destination_account_id` bigint DEFAULT NULL,
  `amount` decimal(15,2) NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `transaction_status` varchar(20) NOT NULL DEFAULT 'PENDING',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `processed_at` datetime(6) DEFAULT NULL,
  `source_account_number` varchar(30) DEFAULT NULL,
  `destination_account_number` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `idx_transaction_source` (`source_account_id`),
  KEY `idx_transaction_destination` (`destination_account_id`),
  KEY `idx_transaction_created` (`created_at`),
  KEY `idx_transaction_type_status` (`transaction_type`,`transaction_status`),
  CONSTRAINT `fk_transaction_destination` FOREIGN KEY (`destination_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_transaction_source` FOREIGN KEY (`source_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `chk_transaction_accounts` CHECK ((((`transaction_type` = _utf8mb4'DEPOSIT') and (`source_account_id` is null) and (`destination_account_id` is not null)) or ((`transaction_type` = _utf8mb4'WITHDRAWAL') and (`source_account_id` is not null) and (`destination_account_id` is null)) or ((`transaction_type` = _utf8mb4'TRANSFER') and (`source_account_id` is not null) and (`destination_account_id` is not null) and (`source_account_id` <> `destination_account_id`)))),
  CONSTRAINT `chk_transaction_amount` CHECK (((`amount` > 0) or (`transaction_status` = _utf8mb4'REJECTED'))),
  CONSTRAINT `chk_transaction_status` CHECK ((`transaction_status` in (_utf8mb4'PENDING',_utf8mb4'SUCCESS',_utf8mb4'FAILED',_utf8mb4'REJECTED'))),
  CONSTRAINT `chk_transaction_type` CHECK ((`transaction_type` in (_utf8mb4'DEPOSIT',_utf8mb4'WITHDRAWAL',_utf8mb4'TRANSFER')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_transaction`
--

LOCK TABLES `bank_transaction` WRITE;
/*!40000 ALTER TABLE `bank_transaction` DISABLE KEYS */;
INSERT INTO `bank_transaction` VALUES ('TXN001',NULL,1,2000.00,'DEPOSIT','SUCCESS','2026-11-26 02:04:51.662790','2026-11-26 02:04:51.000000',NULL,'ACC1001'),('TXN002',2,NULL,1000.00,'WITHDRAWAL','SUCCESS','2026-11-26 02:04:51.662790','2026-11-26 02:04:51.000000','ACC1002',NULL),('TXN003',3,4,500.00,'TRANSFER','SUCCESS','2026-11-26 02:04:51.662790','2026-11-26 02:04:51.000000','ACC1003','ACC1004');
/*!40000 ALTER TABLE `bank_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Aarav','Sharma','aarav@example.com','9876543210','2026-11-26 02:02:14.097031'),(2,'Rahul','Verma','rahul@example.com','9876543211','2026-11-26 02:02:14.097031'),(3,'Priya','Singh','priya@example.com','9876543212','2026-11-26 02:02:14.097031');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_transaction`
--

DROP TABLE IF EXISTS `failed_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_transaction` (
  `failure_id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) NOT NULL,
  `failure_reason` text NOT NULL,
  `error_category` varchar(50) NOT NULL,
  `failed_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`failure_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `fk_failure_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `bank_transaction` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_transaction`
--

LOCK TABLES `failed_transaction` WRITE;
/*!40000 ALTER TABLE `failed_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_audit`
--

DROP TABLE IF EXISTS `transaction_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_audit` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(50) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `previous_status` varchar(20) DEFAULT NULL,
  `new_status` varchar(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `processed_by_thread` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `idx_audit_transaction` (`transaction_id`),
  CONSTRAINT `fk_audit_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `bank_transaction` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_audit`
--

LOCK TABLES `transaction_audit` WRITE;
/*!40000 ALTER TABLE `transaction_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_audit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-26  2:18:39
