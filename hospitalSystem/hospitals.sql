-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospitals
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `admission`
--

DROP TABLE IF EXISTS `admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `attendDocID` int NOT NULL,
  `nurID` int NOT NULL,
  `patID` int NOT NULL,
  `dest` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `relocate_union` (`id`,`attendDocID`,`nurID`,`patID`,`dest`),
  KEY `admission_docID` (`attendDocID`),
  KEY `admission_nurID` (`nurID`),
  KEY `admission_patID` (`patID`),
  KEY `admission_dest` (`dest`),
  CONSTRAINT `admission_dest` FOREIGN KEY (`dest`) REFERENCES `hospitals` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admission_docID` FOREIGN KEY (`attendDocID`) REFERENCES `doctor` (`docID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admission_nurID` FOREIGN KEY (`nurID`) REFERENCES `nurse` (`nurID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `admission_patID` FOREIGN KEY (`patID`) REFERENCES `patient` (`patID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission`
--

LOCK TABLES `admission` WRITE;
/*!40000 ALTER TABLE `admission` DISABLE KEYS */;
INSERT INTO `admission` VALUES (1,1001,1001,1001,'Loyal Road');
/*!40000 ALTER TABLE `admission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `docID` int NOT NULL COMMENT 'the id of the doctor',
  `docName` varchar(20) NOT NULL COMMENT 'the name of the doctor',
  `docAge` int NOT NULL COMMENT 'the age of the doctor',
  `docLocation` varchar(20) NOT NULL COMMENT 'the doctor is in which location',
  `respPatID` int NOT NULL COMMENT 'the patient responded for',
  PRIMARY KEY (`id`),
  UNIQUE KEY `docID` (`docID`),
  KEY `doc_ID_Age_Loca_respPatID` (`id`,`docID`,`docName`,`docAge`,`docLocation`,`respPatID`),
  KEY `docLoca_fk_hosp` (`docLocation`),
  CONSTRAINT `docLoca_fk_hosp` FOREIGN KEY (`docLocation`) REFERENCES `hospitals` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `doctor_chk_1` CHECK ((`docAge` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='the information of the doctor';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,1001,'Krisu May',50,'Loyal Road',1001);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drugorder`
--

DROP TABLE IF EXISTS `drugorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drugorder` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `hospLocation` varchar(20) NOT NULL COMMENT 'which hospital pays the bill?',
  `pharLocation` varchar(20) NOT NULL COMMENT 'which pharmacy sends the drug?',
  `drugName` varchar(20) NOT NULL COMMENT 'the name of the drug',
  `billAmount` double NOT NULL COMMENT 'how much is the drug?',
  PRIMARY KEY (`id`),
  KEY `drugOrder_union_Info` (`id`,`hospLocation`,`pharLocation`,`drugName`,`billAmount`),
  KEY `drugOrder_fk_hospLocation` (`hospLocation`),
  KEY `drugOrder_fk_pharLocation` (`pharLocation`),
  CONSTRAINT `drugOrder_fk_hospLocation` FOREIGN KEY (`hospLocation`) REFERENCES `hospitals` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `drugOrder_fk_pharLocation` FOREIGN KEY (`pharLocation`) REFERENCES `pharmacies` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `drugorder_chk_1` CHECK ((`billAmount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the drug order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drugorder`
--

LOCK TABLES `drugorder` WRITE;
/*!40000 ALTER TABLE `drugorder` DISABLE KEYS */;
INSERT INTO `drugorder` VALUES (1,'Loyal Road','Rain Road','Rain Drug',123.45);
/*!40000 ALTER TABLE `drugorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital1`
--

DROP TABLE IF EXISTS `hospital1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital1` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `hospName` varchar(20) NOT NULL COMMENT 'the name of the hospital',
  `location1` varchar(20) NOT NULL COMMENT 'The first location of the hospital',
  `nurseNum` int NOT NULL COMMENT 'how many nurses in this hospital',
  `doctorNum` int NOT NULL COMMENT 'how many doctors',
  `patientNum` int NOT NULL COMMENT 'how many patients',
  PRIMARY KEY (`id`),
  KEY `hosp1_union_Info` (`id`,`hospName`,`location1`,`nurseNum`,`doctorNum`,`patientNum`),
  KEY `id_fk_h1` (`hospName`),
  CONSTRAINT `id_fk_h1` FOREIGN KEY (`hospName`) REFERENCES `hospitals` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hospital1_chk_1` CHECK (((`nurseNum` >= 0) and (`nurseNum` <= 5))),
  CONSTRAINT `hospital1_chk_2` CHECK (((`doctorNum` >= 0) and (`doctorNum` <= 3))),
  CONSTRAINT `hospital1_chk_3` CHECK (((`patientNum` >= 0) and (`patientNum` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the hospital at the first location';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital1`
--

LOCK TABLES `hospital1` WRITE;
/*!40000 ALTER TABLE `hospital1` DISABLE KEYS */;
INSERT INTO `hospital1` VALUES (1,'Loyal Hospital','Loyal Road',5,3,10);
/*!40000 ALTER TABLE `hospital1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital2`
--

DROP TABLE IF EXISTS `hospital2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital2` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `hospName` varchar(20) NOT NULL COMMENT 'the name of the hospital',
  `location2` varchar(20) NOT NULL COMMENT 'The second location of the hospital',
  `nurseNum` int NOT NULL COMMENT 'how many nurses in this hospital',
  `doctorNum` int NOT NULL COMMENT 'how many doctors',
  `patientNum` int NOT NULL COMMENT 'how many patients',
  PRIMARY KEY (`id`),
  KEY `hosp2_union_Info` (`id`,`hospName`,`location2`,`nurseNum`,`doctorNum`,`patientNum`),
  KEY `id_fk_h2` (`hospName`),
  CONSTRAINT `id_fk_h2` FOREIGN KEY (`hospName`) REFERENCES `hospitals` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hospital2_chk_1` CHECK (((`nurseNum` >= 0) and (`nurseNum` <= 5))),
  CONSTRAINT `hospital2_chk_2` CHECK (((`doctorNum` >= 0) and (`doctorNum` <= 3))),
  CONSTRAINT `hospital2_chk_3` CHECK (((`patientNum` >= 0) and (`patientNum` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the hospital at the second location';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital2`
--

LOCK TABLES `hospital2` WRITE;
/*!40000 ALTER TABLE `hospital2` DISABLE KEYS */;
INSERT INTO `hospital2` VALUES (1,'Center Hospital','Center Road',5,3,10);
/*!40000 ALTER TABLE `hospital2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital3`
--

DROP TABLE IF EXISTS `hospital3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital3` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `hospName` varchar(20) NOT NULL COMMENT 'the name of the hospital',
  `location3` varchar(20) NOT NULL COMMENT 'The third location of the hospital',
  `nurseNum` int NOT NULL COMMENT 'how many nurses in this hospital',
  `doctorNum` int NOT NULL COMMENT 'how many doctors',
  `patientNum` int NOT NULL COMMENT 'how many patients',
  PRIMARY KEY (`id`),
  KEY `hosp3_union_Info` (`id`,`hospName`,`location3`,`nurseNum`,`doctorNum`,`patientNum`),
  KEY `id_fk_h3` (`hospName`),
  CONSTRAINT `id_fk_h3` FOREIGN KEY (`hospName`) REFERENCES `hospitals` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hospital3_chk_1` CHECK (((`nurseNum` >= 0) and (`nurseNum` <= 5))),
  CONSTRAINT `hospital3_chk_2` CHECK (((`doctorNum` >= 0) and (`doctorNum` <= 3))),
  CONSTRAINT `hospital3_chk_3` CHECK (((`patientNum` >= 0) and (`patientNum` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the hospital at the third location';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital3`
--

LOCK TABLES `hospital3` WRITE;
/*!40000 ALTER TABLE `hospital3` DISABLE KEYS */;
INSERT INTO `hospital3` VALUES (1,'My Hospital','My Road',5,3,10);
/*!40000 ALTER TABLE `hospital3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospitals`
--

DROP TABLE IF EXISTS `hospitals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospitals` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `name` varchar(20) NOT NULL COMMENT 'The name of the hospital',
  `location` varchar(20) NOT NULL COMMENT 'The location of the hospital',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `location` (`location`),
  KEY `hospitals_id_name_loca` (`id`,`name`,`location`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='A hospital has three locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospitals`
--

LOCK TABLES `hospitals` WRITE;
/*!40000 ALTER TABLE `hospitals` DISABLE KEYS */;
INSERT INTO `hospitals` VALUES (1,'Loyal Hospital','Loyal Road'),(2,'Center Hospital','Center Road'),(3,'My Hospital','My Road');
/*!40000 ALTER TABLE `hospitals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nurID` int NOT NULL COMMENT 'the id of the nurse',
  `nurName` varchar(20) NOT NULL COMMENT 'the name of the nurse',
  `nurAge` int NOT NULL COMMENT 'the age of the nurse',
  `nurLocation` varchar(20) NOT NULL COMMENT 'the nurse is in which location',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nurID` (`nurID`),
  KEY `nur_ID_Age_dept_Loca` (`id`,`nurID`,`nurName`,`nurAge`,`nurLocation`),
  KEY `nurLoca_fk_hosp` (`nurLocation`),
  CONSTRAINT `nurLoca_fk_hosp` FOREIGN KEY (`nurLocation`) REFERENCES `hospitals` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nurse_chk_1` CHECK ((`nurAge` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='the information of the nurse';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES (1,1001,'Josephe Jostar',18,'Loyal Road');
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurtakecarepat`
--

DROP TABLE IF EXISTS `nurtakecarepat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurtakecarepat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nurID` int NOT NULL,
  `patID` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `patID` (`patID`),
  KEY `takeCare_nurID_patID` (`id`,`nurID`,`patID`),
  KEY `nurTakeCarePat_nurID` (`nurID`),
  CONSTRAINT `nurTakeCarePat_nurID` FOREIGN KEY (`nurID`) REFERENCES `nurse` (`nurID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nurTakeCarePat_patID` FOREIGN KEY (`patID`) REFERENCES `patient` (`patID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='the info of nurse taking care of patients';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurtakecarepat`
--

LOCK TABLES `nurtakecarepat` WRITE;
/*!40000 ALTER TABLE `nurtakecarepat` DISABLE KEYS */;
INSERT INTO `nurtakecarepat` VALUES (1,1001,1001);
/*!40000 ALTER TABLE `nurtakecarepat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `patID` int NOT NULL COMMENT 'The id of the patient',
  `patName` varchar(15) NOT NULL COMMENT 'The name of the patient',
  `patGender` varchar(10) DEFAULT NULL COMMENT 'The gender of the patient',
  `patAge` int NOT NULL COMMENT 'The age of the patient',
  `patPhoneNum` varchar(15) DEFAULT NULL COMMENT 'The phone number of the patient',
  `disease` varchar(20) NOT NULL COMMENT 'The disease of the patient',
  `treatment` varchar(20) NOT NULL COMMENT 'The treatment which is going on',
  `days` int NOT NULL COMMENT 'the number of days the patient are admitted',
  `primaryDocID` int NOT NULL COMMENT 'The id of the primary doctor of the patient',
  `patLocation` varchar(20) NOT NULL COMMENT 'The patient is at which location',
  `admitLocation` varchar(20) NOT NULL COMMENT 'The location where the patient is admitted',
  PRIMARY KEY (`id`),
  UNIQUE KEY `patID` (`patID`),
  UNIQUE KEY `patPhoneNum` (`patPhoneNum`),
  KEY `union_patientInfo` (`id`,`patID`,`patName`,`patGender`,`patAge`,`patPhoneNum`,`disease`,`treatment`,`days`,`primaryDocID`,`patLocation`,`admitLocation`),
  CONSTRAINT `patient_chk_1` CHECK ((`days` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the patient';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,1001,'Tom Cluse','male',20,'1234567890','heart disease','heart treatment',30,1001,'Tom Road','Loyal Road');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacies`
--

DROP TABLE IF EXISTS `pharmacies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacies` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key and the id of the pharmacies',
  `name` varchar(20) NOT NULL COMMENT 'The name of the pharmacies',
  `location` varchar(20) NOT NULL COMMENT 'The location of the pharmacies',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `location` (`location`),
  KEY `pharmacies_id_name` (`id`,`name`,`location`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Overview of three pharmacies';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacies`
--

LOCK TABLES `pharmacies` WRITE;
/*!40000 ALTER TABLE `pharmacies` DISABLE KEYS */;
INSERT INTO `pharmacies` VALUES (1,'Rain Pharmacy','Rain Road'),(2,'Sun Pharmacy','Sun Road'),(3,'Fog Pharmacy','Fog Road');
/*!40000 ALTER TABLE `pharmacies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy1`
--

DROP TABLE IF EXISTS `pharmacy1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy1` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pharID1` int NOT NULL COMMENT 'The id of this pharmacy',
  `pharName1` varchar(20) NOT NULL COMMENT 'The name of this pharmacy',
  `pharLocation1` varchar(20) NOT NULL COMMENT 'deliver to which location?',
  PRIMARY KEY (`id`),
  KEY `phar1` (`id`,`pharID1`,`pharName1`,`pharLocation1`),
  KEY `pharID1_fk_id` (`pharID1`),
  KEY `pharName1_fk_phar` (`pharName1`),
  KEY `deliLoca1_fk_location` (`pharLocation1`),
  CONSTRAINT `deliLoca1_fk_location` FOREIGN KEY (`pharLocation1`) REFERENCES `pharmacies` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharID1_fk_id` FOREIGN KEY (`pharID1`) REFERENCES `pharmacies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharName1_fk_phar` FOREIGN KEY (`pharName1`) REFERENCES `pharmacies` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the first pharmacy';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy1`
--

LOCK TABLES `pharmacy1` WRITE;
/*!40000 ALTER TABLE `pharmacy1` DISABLE KEYS */;
INSERT INTO `pharmacy1` VALUES (1,1,'Rain Pharmacy','Rain Road');
/*!40000 ALTER TABLE `pharmacy1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy2`
--

DROP TABLE IF EXISTS `pharmacy2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy2` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pharID2` int NOT NULL COMMENT 'The id of this pharmacy',
  `pharName2` varchar(20) NOT NULL COMMENT 'The name of this pharmacy',
  `pharLocation2` varchar(20) NOT NULL COMMENT 'deliver to which location?',
  PRIMARY KEY (`id`),
  KEY `phar2_union_Info` (`id`,`pharID2`,`pharName2`,`pharLocation2`),
  KEY `pharID2_fk_id` (`pharID2`),
  KEY `pharName2_fk_phar` (`pharName2`),
  KEY `deliLoca2_fk_location` (`pharLocation2`),
  CONSTRAINT `deliLoca2_fk_location` FOREIGN KEY (`pharLocation2`) REFERENCES `pharmacies` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharID2_fk_id` FOREIGN KEY (`pharID2`) REFERENCES `pharmacies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharName2_fk_phar` FOREIGN KEY (`pharName2`) REFERENCES `pharmacies` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the second pharmacy';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy2`
--

LOCK TABLES `pharmacy2` WRITE;
/*!40000 ALTER TABLE `pharmacy2` DISABLE KEYS */;
INSERT INTO `pharmacy2` VALUES (1,2,'Sun Pharmacy','Sun Road');
/*!40000 ALTER TABLE `pharmacy2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pharmacy3`
--

DROP TABLE IF EXISTS `pharmacy3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pharmacy3` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'primary key',
  `pharID3` int NOT NULL COMMENT 'The id of this pharmacy',
  `pharName3` varchar(20) NOT NULL COMMENT 'The name of this pharmacy',
  `pharLocation3` varchar(20) NOT NULL COMMENT 'deliver to which location?',
  PRIMARY KEY (`id`),
  KEY `phar3_union_Info` (`id`,`pharID3`,`pharName3`,`pharLocation3`),
  KEY `pharID3_fk_id` (`pharID3`),
  KEY `pharName3_fk_phar` (`pharName3`),
  KEY `deliLoca3_fk_location` (`pharLocation3`),
  CONSTRAINT `deliLoca3_fk_location` FOREIGN KEY (`pharLocation3`) REFERENCES `pharmacies` (`location`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharID3_fk_id` FOREIGN KEY (`pharID3`) REFERENCES `pharmacies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pharName3_fk_phar` FOREIGN KEY (`pharName3`) REFERENCES `pharmacies` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The information of the third pharmacy';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pharmacy3`
--

LOCK TABLES `pharmacy3` WRITE;
/*!40000 ALTER TABLE `pharmacy3` DISABLE KEYS */;
INSERT INTO `pharmacy3` VALUES (1,3,'Fog Pharmacy','Fog Road');
/*!40000 ALTER TABLE `pharmacy3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `doctorID` int NOT NULL,
  `disease` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `connPD_patID_docID` (`id`,`patientID`,`doctorID`,`disease`),
  KEY `patientID_fk` (`patientID`),
  KEY `doctorID_fk` (`doctorID`),
  CONSTRAINT `doctorID_fk` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`docID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `patientID_fk` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Connection of the table patient and doctor';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
INSERT INTO `treatment` VALUES (1,1001,1001,'heart disease');
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-08 17:43:28
