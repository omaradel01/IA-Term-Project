-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: hotel_reservation_system
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `CityID` int NOT NULL AUTO_INCREMENT,
  `CityName` varchar(30) NOT NULL,
  PRIMARY KEY (`CityID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Cairo'),(2,'Alexandria'),(3,'Luxor'),(4,'Aswan'),(5,'Giza'),(6,'Huragada'),(7,'Sharm-El-sheikh');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city_hotel`
--

DROP TABLE IF EXISTS `city_hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_hotel` (
  `CityHotelID` int NOT NULL AUTO_INCREMENT,
  `CityID` int NOT NULL,
  `HotelID` int NOT NULL,
  `PriceOfOneNight` int DEFAULT NULL,
  `Distance` float DEFAULT NULL,
  `AvailableRooms` int DEFAULT NULL,
  `MapLocation` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`CityHotelID`),
  KEY `HotelID` (`HotelID`),
  KEY `CityID` (`CityID`),
  CONSTRAINT `city_hotel_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `city_hotel_ibfk_2` FOREIGN KEY (`CityID`) REFERENCES `city` (`CityID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_hotel`
--

LOCK TABLES `city_hotel` WRITE;
/*!40000 ALTER TABLE `city_hotel` DISABLE KEYS */;
INSERT INTO `city_hotel` VALUES (1,1,1,4131,1.2,10,'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d6908.043351181974!2d31.2250784!3d30.036236!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xd7f50b4221f71eb0!2sFour%20Seasons%20Hotel%20Cairo%20at%20Nile%20Plaza!5e0!3m2!1sen!2seg!4v1610649811145!5m2!1sen!2seg'),(2,2,1,4147,8.6,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3411.114485803373!2d29.964688914851962!3d31.245253881461384!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14f5c52e30aaf1df%3A0xc9d2d428ea2ba3d2!2sFour%20Seasons%20Hotel%20Alexandria%20at%20San%20Stefano%2C%20Egypt!5e0!3m2!1sen!2seg!4v1610649925994!5m2!1sen!2seg'),(3,5,1,2639,3.8,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6908.8761237181025!2d31.212409634887695!3d30.0242879!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145841aed9f9d687%3A0x37dd6f74867cf818!2sFour%20Seasons%20Hotel%20Cairo%20at%20The%20First%20Residence!5e0!3m2!1sen!2seg!4v1610650080740!5m2!1sen!2seg'),(4,7,1,3960,4.8,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1373.5587695421384!2d34.388745833648606!3d27.9573177427949!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145349bc1be43c57%3A0xa090387be33c0e8f!2sFour%20Seasons%20Resort%20Sharm%20El%20Sheikh!5e0!3m2!1sen!2seg!4v1610650170225!5m2!1sen!2seg'),(5,1,2,1135,4,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3452.7829670997276!2d31.22575131482022!3d30.071754981872395!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145840fa057818c7%3A0x3f7e03a153cbeafc!2sFairmont%20Nile%20City%20Hotel%2C%20Cairo!5e0!3m2!1sen!2seg!4v1610650231450!5m2!1sen!2seg'),(6,1,4,613,0.9,2,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d221007.4081804343!2d31.045259006317533!3d30.058632772562202!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145840d0447d5a79%3A0xbb55286e18afc4d8!2sNovotel%20Cairo%20El%20Borg!5e0!3m2!1sen!2seg!4v1610650323695!5m2!1sen!2seg'),(7,5,4,1445,34.5,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d221007.73963847914!2d31.045258379468933!3d30.058484288374988!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145856f50b216a4b%3A0xbde555c0a9ab88d6!2sNovotel%20Cairo%206th%20of%20October!5e0!3m2!1sen!2seg!4v1610650369838!5m2!1sen!2seg'),(8,7,4,814,8.1,3,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3525.55655750981!2d34.32904041476493!3d27.915578382706148!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14533787f83288e7%3A0x12499f16f664fbae!2sNovotel%20Sharm%20El%20Sheikh!5e0!3m2!1sen!2seg!4v1610650429060!5m2!1sen!2seg'),(9,1,5,1372,4.9,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3453.918763178149!2d31.2180973148194!3d30.03918838188424!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145840d4e3acf7d9%3A0x3687d919cd672753!2sSheraton%20Cairo%20Hotel%20%26%20Casino!5e0!3m2!1sen!2seg!4v1610650551781!5m2!1sen!2seg'),(10,7,5,646,10.2,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3525.362186120335!2d34.36532021476511!3d27.921539882703687!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145337c898dafabb%3A0x150d9fa2541db067!2sSheraton%20Sharm%20Hotel%2C%20Resort%2C%20Villas%20%26%20Spa!5e0!3m2!1sen!2seg!4v1610650655397!5m2!1sen!2seg'),(11,2,5,1292,15,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3409.816902720808!2d30.009294714852906!3d31.281159481449368!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14f5c4e865c9604d%3A0xf92035fc06e0dcf3!2sSheraton%20Montazah%20Hotel!5e0!3m2!1sen!2seg!4v1610650714404!5m2!1sen!2seg'),(12,1,6,738,3.7,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3452.9293523924152!2d31.22047211482009!3d30.06755948187384!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14584065145d2269%3A0xa5a0aab784cfb4e1!2sHilton%20Cairo%20Zamalek%20Residences!5e0!3m2!1sen!2seg!4v1610650807609!5m2!1sen!2seg'),(13,5,6,1227,24.4,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3456.543004368651!2d31.043026914817418!3d29.96382098191175!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x145dc811b1314563%3A0xa99f95462bd1a126!2sHilton%20Pyramids%20Golf!5e0!3m2!1sen!2seg!4v1610650873652!5m2!1sen!2seg'),(14,2,6,1613,11.2,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3410.5255831416166!2d29.981610614852336!3d31.261554081456037!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14f5dab03d82fc05%3A0x397ed68805937f51!2sHilton%20Alexandria%20Corniche!5e0!3m2!1sen!2seg!4v1610650966975!5m2!1sen!2seg'),(15,7,6,723,7,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3525.573314406496!2d34.32729931476481!3d27.915064382706333!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14533828fb56886b%3A0x5947d859d95a4d0b!2sFayrouz%20Resort!5e0!3m2!1sen!2seg!4v1610651025748!5m2!1sen!2seg'),(16,6,6,826,3.1,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3546.8006690337056!2d33.8282108147488!3d27.25678028298062!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14528193a74a2a35%3A0x10ac3fd65217e28!2sHilton%20Hurghada%20Plaza!5e0!3m2!1sen!2seg!4v1610651176100!5m2!1sen!2seg'),(18,3,6,1064,6.5,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3594.2146642159755!2d32.65443281471262!3d25.730413783650896!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x144915844975c5c7%3A0x2874674d2b198e52!2sHilton%20Luxor%20Resort%20%26%20Spa!5e0!3m2!1sen!2seg!4v1610651240206!5m2!1sen!2seg'),(19,5,10,767,15.8,10,'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d55283.87674829641!2d31.132277403227587!3d30.00119836570895!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xc17e2ece7a759c2b!2sMercure%20Cairo%20Le%20Sphinx%20Hotel!5e0!3m2!1sen!2seg!4v1610742418979!5m2!1sen!2seg');
/*!40000 ALTER TABLE `city_hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `HotelID` int NOT NULL AUTO_INCREMENT,
  `HotelName` varchar(100) NOT NULL,
  `UserRating` float DEFAULT NULL,
  `HotelStars` int NOT NULL,
  `PriceOfOneNight` int DEFAULT NULL,
  `HotelImages` varchar(100) NOT NULL,
  `SingleImage` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`HotelID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'4 Season',0,5,4440,'Hotels Images\\4 Season','Hotels Images\\4 Season\\1200px-Cairo_-_Garden_City_-_Four_Seasons_Hotel_from_the_Nile.jpg'),(2,'Fairmont',0,5,1135,'Hotels Images\\Fairmont','Hotels Images\\Fairmont\\Fairmont-Hotels-and-Resorts-career-work.jpg'),(3,'Kempinski',0,5,1365,'Hotels Images\\Kempinski','Hotels Images\\Kempinski\\xxl_153075251.jpg'),(4,'Novotel',0,4,988,'Hotels Images\\Novotel','Hotels Images\\Novotel\\3786cbd3b9b7bec64d106830ea9c2c27.jpg'),(5,'Sheraton',0,5,1453,'Hotels Images\\Sheraton','Hotels Images\\Sheraton\\177368841.jpg'),(6,'Hilton',0,5,754,'Hotels Images\\Hilton','Hotels Images\\Hilton\\2112-usa-hilton-hotel-boston-001.jpg'),(10,'Mercure',NULL,4,NULL,'null','Hotels Images\\Mercure\\stunning-view-from-the.jpg');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `HotelID` int NOT NULL,
  `CityID` int NOT NULL,
  `ReservationType` varchar(100) NOT NULL,
  `CheckInDate` date NOT NULL,
  `CheckOutDate` date NOT NULL,
  `TotalPrice` float NOT NULL,
  `NumberOfRooms` int NOT NULL,
  `NumberOfAdults` int NOT NULL,
  `NumberOfChildren` int NOT NULL,
  `Confirmed` bit(1) DEFAULT NULL,
  `Running` bit(1) DEFAULT NULL,
  `Canceled` bit(1) DEFAULT NULL,
  PRIMARY KEY (`ReservationID`),
  KEY `UserID` (`UserID`),
  KEY `HotelID` (`HotelID`),
  KEY `CityID` (`CityID`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`HotelID`) REFERENCES `hotel` (`HotelID`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`CityID`) REFERENCES `city` (`CityID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (14,9,4,1,'Half Board - Triple Room','2021-01-16','2021-01-17',1072.75,1,1,1,_binary '',_binary '',_binary '\0'),(15,9,4,7,'Full Board - Double Room','2021-01-15','2021-01-28',7122.5,1,1,1,_binary '',_binary '',_binary ''),(16,10,1,2,'Full Board - Single Room','2021-01-23','2021-01-29',37323,1,1,0,_binary '',_binary '\0',_binary '');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(30) NOT NULL,
  `UserEmail` varchar(30) NOT NULL,
  `UserPassword` varchar(30) NOT NULL,
  `UserDisplayName` varchar(30) NOT NULL,
  `UserFirstName` varchar(30) NOT NULL,
  `UserLastName` varchar(30) NOT NULL,
  `is_admin` bit(1) DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserName` (`UserName`),
  UNIQUE KEY `UserEmail` (`UserEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Omar_Ezz','omaradelezz54@gmail.com','12345','Omar Ezz','Omar','Adel',_binary ''),(2,'Omar_Samii','omarrr.samiii98@gmail.com','11111','Omar Samii','Omar','Samii',_binary ''),(3,'Amr_Osama','amrosama075@gmail.com','00000','Amr Osama','Amr','Osama',_binary ''),(4,'omaradel','oezz6939@gmail.com','omar123','Omar Adel','Omar','Adel',_binary '\0'),(5,'ziadadel','zeiadadel94@gmail.com','1TTLVG09','Ziad Adel','Ziad','Adel',_binary '\0'),(9,'mark_ehab','markihab98@gmail.com','0WOLG55M','Mark Ehab','Mark','Ehab',_binary '\0'),(10,'sami','omarrr.samiii98@hotmail.com','M54NJB1K','Omar Sami','Omar','Sami',_binary '\0'),(12,'kassas','mkassas1998@gmail.com','VLUH377Q','Mohamed Kassas','Mohamed','Kassas',_binary '\0');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 22:39:56
