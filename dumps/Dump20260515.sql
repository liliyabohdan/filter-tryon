-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (arm64)
--
-- Host: mysql.studev.groept.be    Database: a25pt305
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientNumber` int NOT NULL,
  PRIMARY KEY (`clientNumber`),
  UNIQUE KEY `clientNumber_UNIQUE` (`clientNumber`),
  CONSTRAINT `useridFromUser` FOREIGN KEY (`clientNumber`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (5),(9),(10),(26),(27),(28),(29),(33),(34),(35),(36);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `ImageID` int NOT NULL AUTO_INCREMENT,
  `fileName` varchar(45) DEFAULT NULL,
  `makeoverID` int DEFAULT NULL,
  PRIMARY KEY (`ImageID`),
  KEY `makeoverIDForImages_idx` (`makeoverID`),
  CONSTRAINT `makeoverIDForImages` FOREIGN KEY (`makeoverID`) REFERENCES `makeover` (`makeoverID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'3RedLips2.png',1),(2,'1GrayBlueEyeshadow2.png',6),(3,'2PurpleEyeliner2.png',7),(4,'4ContourLipgloss2.png',8),(5,'5MPaleSymmetricalBlush2.png',9),(6,'3RedLips3.png',1),(7,'1GrayBlueEyeshadow3.png',6),(8,'2PurpleEyeliner3.png',7),(9,'4ContourLipgloss3.png',8),(10,'5MPaleSymmetricalBlush3.png',9),(11,'3RedLips4.png',1),(12,'1GrayBlueEyeshadow4.png',6),(13,'2PurpleEyeliner4.png',7),(14,'4ContourLipgloss4.png',8),(15,'5MPaleSymmetricalBlush4.png',9),(16,'3RedLips5.png',1),(17,'1GrayBlueEyeshadow5.png',6),(18,'2PurpleEyeliner5.png',7),(19,'4ContourLipgloss5.png',8),(20,'5MPaleSymmetricalBlush5.png',9),(21,'viking_helmet2.png',10),(22,'galaxy_background2.png',12),(23,'Stallone2.png',13),(24,'MakeupLook2.png',11),(25,'Fire_Effect2.png',14),(27,'viking_helmet3.png',10),(28,'galaxy_background3.png',12),(29,'Stallone3.png',13),(30,'MakeupLook3.png',11),(31,'Fire_Effect3.png',14),(34,'viking_helmet4.png',10),(35,'galaxy_background4.png',12),(36,'Stallone4.png',13),(37,'MakeupLook4.png',11),(38,'Fire_Effect4.png',14),(40,'viking_helmet5.png',10),(41,'galaxy_background5.png',12),(42,'Stallone5.png',13),(43,'MakeupLook5.png',11),(44,'Fire_Effect5.png',14),(46,NULL,NULL),(98,'img_6a009bd9e6448.png',27),(99,'img_6a009bdbcb3d1.png',27),(100,'img_6a06f4749bb41.png',27);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `makeover`
--

DROP TABLE IF EXISTS `makeover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `makeover` (
  `makeoverID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `deeparFile` varchar(45) NOT NULL,
  `imagePreview` varchar(45) DEFAULT NULL,
  `MUAid` int DEFAULT NULL COMMENT 'only for custom filters',
  `price` decimal(10,0) DEFAULT NULL,
  `isCustom` tinyint DEFAULT NULL,
  PRIMARY KEY (`makeoverID`),
  UNIQUE KEY `idmakeover_UNIQUE` (`makeoverID`),
  KEY `MUAidforMakeover_idx` (`MUAid`),
  CONSTRAINT `MUAidforMakeover` FOREIGN KEY (`MUAid`) REFERENCES `mua` (`MUAid`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `makeover`
--

LOCK TABLES `makeover` WRITE;
/*!40000 ALTER TABLE `makeover` DISABLE KEYS */;
INSERT INTO `makeover` VALUES (1,'RedLips','3RedLips.deepar','3RedLips2.png',NULL,10,0),(6,'GrayBlueEyeshadow','1GrayBlueEyeshadow.deepar','1GrayBlueEyeshadow2.png',NULL,0,0),(7,'PurpleEyeliner','2PurpleEyeliner.deepar','2PurpleEyeliner2.png',NULL,0,0),(8,'ContourLipgloss','4ContourLipgloss.deepar','4ContourLipgloss2.png',NULL,0,0),(9,'PaleSymmetricalBlush','5MPaleSymmetricalBlush.deepar','5MPaleSymmetricalBlush2.png',NULL,0,1),(10,'VikingHelmet','viking_helmet.deepar','viking_helmet2.png',NULL,0,1),(11,'MakeupLook','MakeupLook.deepar','MakeupLook2.png',NULL,0,0),(12,'Galaxy','galaxy_background.deepar','galaxy_background2.png',NULL,0,1),(13,'ExtremeMakeover','Stallone.deepar','Stallone2.png',NULL,0,1),(14,'Fire','burning_effect.deepar','Fire_Effect2.png',NULL,0,0),(27,'sunglassestestupdate','6a06ef4b0c329_Sunglasses.deepar','img_6a009bd7cace9.png',25,20,1),(35,'yestrhej','6a06f4e226129_Sunglasses.deepar','img_6a06f4ef1507e.png',25,2,1);
/*!40000 ALTER TABLE `makeover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `makeovertag`
--

DROP TABLE IF EXISTS `makeovertag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `makeovertag` (
  `makeoverID` int DEFAULT NULL,
  `tagName` varchar(45) DEFAULT NULL,
  `makeovertagID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`makeovertagID`),
  KEY `tagNameForMakeovertag_idx` (`tagName`),
  KEY `makeoverIDForMakeoverTag` (`makeoverID`),
  CONSTRAINT `makeoverIDForMakeoverTag` FOREIGN KEY (`makeoverID`) REFERENCES `makeover` (`makeoverID`),
  CONSTRAINT `tagNameForMakeovertag` FOREIGN KEY (`tagName`) REFERENCES `tag` (`tagName`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `makeovertag`
--

LOCK TABLES `makeovertag` WRITE;
/*!40000 ALTER TABLE `makeovertag` DISABLE KEYS */;
INSERT INTO `makeovertag` VALUES (1,'red',1),(6,'eyeshadow',2),(7,'eyeliner',3),(8,'lipgloss',4),(9,'natural',5),(10,'funny',6),(7,'evening',7),(6,'evening',8),(6,'eyeshadow',9),(6,'for filming',10),(7,'office',11),(7,'eyeliner',12),(10,'funny',13),(10,'scary',14),(11,'eyeshadow',15),(11,'for filming',16),(11,'eyeliner',17),(12,'office',18),(12,'cold',19),(13,'creative',20),(13,'for filming',21),(14,'warm',22),(12,'space',23),(14,'red',24),(9,'blush',34),(14,'funny',35),(6,'fashionable',36),(12,'cold',37),(1,'cold',40),(1,'bright',41),(12,'blush',42),(12,'for filming',43),(8,'warm',44),(9,'warm',45),(9,'soft',46),(9,'fashionable',47),(8,'contour',48),(9,'contour',49),(27,'accessories',52),(13,'accessories',53),(27,'for filming',54),(27,'cold',55),(35,'warm',56);
/*!40000 ALTER TABLE `makeovertag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mua`
--

DROP TABLE IF EXISTS `mua`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mua` (
  `MUAid` int NOT NULL,
  `artistName` varchar(45) DEFAULT NULL,
  ` biography` varchar(45) DEFAULT NULL,
  `avgReview` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`MUAid`),
  UNIQUE KEY `MUAid_UNIQUE` (`MUAid`),
  CONSTRAINT `useridForMUA` FOREIGN KEY (`MUAid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mua`
--

LOCK TABLES `mua` WRITE;
/*!40000 ALTER TABLE `mua` DISABLE KEYS */;
INSERT INTO `mua` VALUES (1,NULL,NULL,NULL),(4,NULL,NULL,NULL),(10,NULL,NULL,NULL),(11,NULL,NULL,NULL),(13,NULL,NULL,NULL),(21,NULL,NULL,NULL),(22,NULL,NULL,NULL),(25,NULL,NULL,NULL),(31,NULL,NULL,NULL),(32,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mua` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase`
--

DROP TABLE IF EXISTS `purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase` (
  `purchaseID` int NOT NULL AUTO_INCREMENT,
  `clientNumber` int DEFAULT NULL,
  `makeoverID` int DEFAULT NULL,
  `purchaseDate` date DEFAULT NULL,
  `paidPrice` decimal(10,0) DEFAULT NULL,
  `Removed` tinyint DEFAULT '0' COMMENT 'external reference, not needed',
  PRIMARY KEY (`purchaseID`),
  UNIQUE KEY `purchaseID_UNIQUE` (`purchaseID`),
  KEY `makeOverIDForPurchase_idx` (`makeoverID`),
  KEY `useridForPurchase_idx` (`clientNumber`),
  CONSTRAINT `makeOverIDForPurchase` FOREIGN KEY (`makeoverID`) REFERENCES `makeover` (`makeoverID`),
  CONSTRAINT `useridForPurchase` FOREIGN KEY (`clientNumber`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase`
--

LOCK TABLES `purchase` WRITE;
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` VALUES (1,5,10,NULL,NULL,1),(2,3,1,'2026-05-09',10,0),(3,3,1,'2026-05-09',0,0),(4,3,1,'2026-05-09',0,0),(5,3,1,'2026-05-09',0,0),(6,3,1,'2026-05-09',0,0),(7,3,1,'2026-05-09',0,0),(8,3,1,'2026-05-09',0,0),(9,3,1,'2026-05-09',0,0),(10,3,1,'2026-05-09',0,0),(11,3,1,'2026-05-09',0,0),(17,1,1,'2026-05-09',10,0),(18,27,1,'2026-05-09',10,0),(19,5,12,'2026-05-09',0,0),(22,5,9,'2026-05-10',0,0),(23,28,10,'2026-05-10',0,0),(24,28,12,'2026-05-10',0,0),(29,30,10,'2026-05-11',0,0),(30,5,27,'2026-05-11',NULL,1),(34,5,27,'2026-05-11',NULL,1),(36,5,27,'2026-05-12',NULL,1),(38,5,27,'2026-05-12',NULL,1),(41,5,27,'2026-05-12',NULL,1),(44,5,27,'2026-05-12',NULL,1),(46,5,27,'2026-05-12',NULL,1),(47,5,27,'2026-05-12',NULL,1),(48,5,27,'2026-05-12',NULL,1),(49,5,27,'2026-05-12',NULL,1),(50,5,27,'2026-05-12',NULL,1),(51,33,27,'2026-05-12',NULL,0),(52,5,10,'2026-05-12',NULL,0),(53,5,27,'2026-05-12',NULL,1),(54,5,27,'2026-05-14',NULL,0),(55,29,10,'2026-05-15',NULL,0),(56,29,27,'2026-05-15',NULL,1),(57,29,27,'2026-05-15',NULL,1),(58,29,13,'2026-05-15',NULL,0),(59,29,27,'2026-05-15',NULL,0),(60,36,27,'2026-05-15',NULL,0),(61,29,9,'2026-05-15',NULL,0);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `reviewID` int NOT NULL AUTO_INCREMENT,
  `clientNumber` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `reviewText` text,
  `reviewDate` date DEFAULT NULL,
  `makeoverID` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  UNIQUE KEY `reviewID_UNIQUE` (`reviewID`),
  KEY `makeoverIDForReview_idx` (`makeoverID`),
  KEY `useridForReview_idx` (`clientNumber`),
  CONSTRAINT `makeoverIDForReview` FOREIGN KEY (`makeoverID`) REFERENCES `makeover` (`makeoverID`),
  CONSTRAINT `useridForReview` FOREIGN KEY (`clientNumber`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,5,4,'perfect',NULL,10),(2,5,3,'okay',NULL,1),(3,1,5,'cool',NULL,10),(4,5,4,'good',NULL,9),(6,28,1,'Where\'s the picture of Milena???','2026-05-10',10),(7,28,2,'Changed my name','2026-05-10',10),(8,28,1,'Tried this filter and it\'s super laggy! Either fix it or remove it!!! >:(','2026-05-10',12),(9,28,5,'i like that tibe liked this one','2026-05-10',9),(10,28,5,'Liliya looks good with this one <3','2026-05-10',13),(11,28,1,'FILTER DOESN\'T LOOK LIKE IMAGE!!! ??','2026-05-10',13),(12,28,1,'Stop cat fishing!!?','2026-05-10',13),(13,28,3,'too small for big Shrek head ','2026-05-10',27),(14,5,4,'epic','2026-05-11',27),(15,5,5,'It\'s right there bro','2026-05-11',10),(16,5,5,'wow so much swag ?','2026-05-11',27),(17,33,1,'niet fijn','2026-05-12',27),(18,29,5,'goood','2026-05-15',27),(19,29,5,'really good','2026-05-15',27),(20,29,5,'cool','2026-05-15',13),(21,29,5,'great','2026-05-15',27),(22,36,4,'great','2026-05-15',27),(23,29,5,'fantastic!','2026-05-15',9);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tagName` varchar(45) NOT NULL,
  PRIMARY KEY (`tagName`),
  UNIQUE KEY `tagName_UNIQUE` (`tagName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES ('accessories'),('blue'),('blush'),('bold'),('bridal'),('bright'),('casual'),('clear'),('cold'),('contour'),('creative'),('daily'),('dramatic'),('evening'),('eyeliner'),('eyeshadow'),('fashionable'),('fire'),('for filming'),('funny'),('head'),('lipgloss'),('lipstick'),('movie'),('natural'),('office'),('professional'),('purple'),('red'),('scary'),('soft'),('space'),('warm'),('white'),('yellow');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `profilepicture` varchar(45) DEFAULT NULL,
  `fullName` varchar(45) DEFAULT NULL,
  `emailAddress` varchar(45) DEFAULT NULL,
  `dateOfBirth` date DEFAULT NULL,
  `passwordHash` varchar(100) DEFAULT NULL,
  `TermsArgeement` tinyint DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `emailAddress_UNIQUE` (`emailAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,NULL,'John P','john.p@test.com','2000-01-01','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL),(2,NULL,'milena','milena',NULL,'b27efa31a25a8ec090058f211f2ddfdeb485903104a2e18dd4976d77d5196060',NULL),(3,NULL,'BORYS','BORYS@gmail.com',NULL,'b09bc47c25d0ab8ce270e8951fb4bcf4b92ffb28cb4d5ec3c7a3f1d7403cbe4d',NULL),(4,NULL,'liliya','liliya',NULL,'a81898492f3d3b3c8ec617be43c7ee83ed49e335a1a1c51cb5e09f11e255196b',NULL),(5,NULL,'tibe','tibe',NULL,'f4c349d193a41eb91121c601360c0b9e3fe92efb5b26cc41419a64a2cdf1efed',NULL),(7,NULL,NULL,'new.user@test.com',NULL,'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL),(9,NULL,NULL,'test',NULL,'9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',NULL),(10,NULL,NULL,'testing@testing.test',NULL,'cf80cd8aed482d5d1527d7dc72fceff84e6326592848447d2dc0b0e87dfc9a90',NULL),(11,NULL,NULL,'creator',NULL,'7f9c40c9ac6a25c178d0c3fa6a26aa3fa0acc1335bb0fccfe61aa03e21872145',NULL),(13,NULL,NULL,'liliya@gmail.com',NULL,'a81898492f3d3b3c8ec617be43c7ee83ed49e335a1a1c51cb5e09f11e255196b',NULL),(21,NULL,NULL,'boryssydorchuk',NULL,'25e1bd9192f56f64027efb3065e5b472b58be0238360eedab246614050994628',NULL),(22,NULL,NULL,'Liliya1',NULL,'610ba0f3cb7e3bb2b7d9372bd422dac1c77739ac1d2b6a0b475708f9f052389b',NULL),(25,NULL,'Thebestcreator123','tibecreator',NULL,'f4c349d193a41eb91121c601360c0b9e3fe92efb5b26cc41419a64a2cdf1efed',NULL),(26,NULL,NULL,'testing customer',NULL,'1fef9eb2281d721795109fdae212c87944193856058a48b528101d493bf783b1',NULL),(27,NULL,NULL,'customer',NULL,'b6c45863875e34487ca3c155ed145efe12a74581e27befec5aa661b8ee8ca6dd',NULL),(28,NULL,'Gronkus','iulia.bilan@gmail.com',NULL,'3f9f33ca5fcfe8f018f2b7d20656a07bfb18932f0eb3a3e697a18108754e8d20',NULL),(29,NULL,'newuser','newuser',NULL,'9c9064c59f1ffa2e174ee754d2979be80dd30db552ec03e7e327e9b1a4bd594e',NULL),(30,NULL,NULL,'m',NULL,'62c66a7a5dd70c3146618063c344e531e6d4b59e379808443ce962b3abd63c5a',NULL),(31,NULL,NULL,'test123MUA',NULL,'9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',NULL),(32,NULL,NULL,'c',NULL,'2e7d2c03a9507ae265ecf5b5356885a53393a2029d241394997265a1a25aefc6',NULL),(33,NULL,NULL,'warre',NULL,'514f44570a0b955bd8589b2abc94cb6e53cd5604bb872f08d3175b0882329aa7',NULL),(34,NULL,NULL,'-5',NULL,'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL),(35,NULL,NULL,'-67',NULL,'454349e422f05297191ead13e21d3db520e5abef52055e4964b82fb213f593a1',NULL),(36,NULL,NULL,'a',NULL,'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-15 22:37:17
