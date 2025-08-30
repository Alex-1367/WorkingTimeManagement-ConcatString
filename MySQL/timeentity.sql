--
-- Table structure for table `timeentity`
--

DROP TABLE IF EXISTS `timeentity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeentity` (
  `ScheduleID` int NOT NULL AUTO_INCREMENT,
  `EntityTypeID` int NOT NULL,
  `EntityID` int NOT NULL,
  `ScheduleName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`ScheduleID`),
  KEY `EntityTypeID` (`EntityTypeID`),
  CONSTRAINT `timeentity_ibfk_1` FOREIGN KEY (`EntityTypeID`) REFERENCES `timeentitytype` (`EntityTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeentity`
--

LOCK TABLES `timeentity` WRITE;
/*!40000 ALTER TABLE `timeentity` DISABLE KEYS */;
INSERT INTO `timeentity` VALUES (1,1,1,'Main Working Hours','2025-08-27 00:03:11','2025-08-27 00:04:53',1);
/*!40000 ALTER TABLE `timeentity` ENABLE KEYS */;
UNLOCK TABLES;
