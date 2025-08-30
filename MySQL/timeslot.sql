DROP TABLE IF EXISTS `timeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeslot` (
  `TimeSlotID` int NOT NULL AUTO_INCREMENT,
  `ScheduleID` int NOT NULL,
  `DayOfWeek` tinyint NOT NULL,
  `OpenTime` time DEFAULT NULL,
  `CloseTime` time DEFAULT NULL,
  `IsClosed` tinyint(1) DEFAULT '0',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `IsActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`TimeSlotID`),
  KEY `ScheduleID` (`ScheduleID`),
  CONSTRAINT `timeslot_ibfk_1` FOREIGN KEY (`ScheduleID`) REFERENCES `timeentity` (`ScheduleID`) ON DELETE CASCADE,
  CONSTRAINT `timeslot_chk_1` CHECK ((`DayOfWeek` between 1 and 7))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslot`
--

LOCK TABLES `timeslot` WRITE;
/*!40000 ALTER TABLE `timeslot` DISABLE KEYS */;
INSERT INTO `timeslot` VALUES (13,1,1,'09:00:00','12:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(14,1,1,'14:00:00','17:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(15,1,2,'09:00:00','12:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(16,1,2,'14:00:00','17:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(17,1,3,'09:00:00','12:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(18,1,3,'14:00:00','17:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(19,1,4,'09:00:00','12:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(20,1,4,'14:00:00','17:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(21,1,5,'09:00:00','12:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(22,1,5,'14:00:00','17:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(23,1,6,'09:00:00','14:00:00',0,'2025-08-27 00:07:33','2025-08-27 00:07:33',1),(24,1,7,NULL,NULL,1,'2025-08-27 00:07:33','2025-08-27 00:07:33',1);
/*!40000 ALTER TABLE `timeslot` ENABLE KEYS */;
UNLOCK TABLES;
