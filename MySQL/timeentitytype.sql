 
--
-- Table structure for table `timeentitytype`
--

DROP TABLE IF EXISTS `timeentitytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeentitytype` (
  `EntityTypeID` int NOT NULL AUTO_INCREMENT,
  `EntityName` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`EntityTypeID`),
  UNIQUE KEY `EntityName` (`EntityName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeentitytype`
--

LOCK TABLES `timeentitytype` WRITE;
/*!40000 ALTER TABLE `timeentitytype` DISABLE KEYS */;
INSERT INTO `timeentitytype` VALUES (1,'Museum'),(2,'Restaurant');
/*!40000 ALTER TABLE `timeentitytype` ENABLE KEYS */;
UNLOCK TABLES;
