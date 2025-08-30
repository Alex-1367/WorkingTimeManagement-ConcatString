 --
-- Table structure for table `timespecialschedule`
--

DROP TABLE IF EXISTS `timespecialschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timespecialschedule` (
  `TimeSpecialScheduleID` int NOT NULL AUTO_INCREMENT,
  `ScheduleID` int NOT NULL,
  `SpecialDate` date NOT NULL,
  `OpenTime` time DEFAULT NULL,
  `CloseTime` time DEFAULT NULL,
  `IsClosed` tinyint(1) DEFAULT '0',
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`TimeSpecialScheduleID`),
  KEY `ScheduleID` (`ScheduleID`),
  CONSTRAINT `timespecialschedule_ibfk_1` FOREIGN KEY (`ScheduleID`) REFERENCES `timeentity` (`ScheduleID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timespecialschedule`
--

LOCK TABLES `timespecialschedule` WRITE;
/*!40000 ALTER TABLE `timespecialschedule` DISABLE KEYS */;
INSERT INTO `timespecialschedule` VALUES (1,1,'2024-12-25',NULL,NULL,1,'Christmas Day - Closed','2025-08-27 00:21:01','2025-08-27 00:21:01',1),(2,1,'2024-12-31','10:00:00','15:00:00',0,'New Year\'s Eve - Special Hours','2025-08-27 00:21:01','2025-08-27 00:21:01',1);
/*!40000 ALTER TABLE `timespecialschedule` ENABLE KEYS */;
UNLOCK TABLES;
