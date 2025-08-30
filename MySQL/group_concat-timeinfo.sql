CREATE VIEW `timeinfo` AS
SELECT `te`.`ScheduleID` AS `ScheduleID`,
       `te`.`EntityTypeID` AS `EntityTypeID`,
       `tet`.`EntityName` AS `EntityTypeName`,
       `te`.`EntityID` AS `EntityID`,
       `te`.`ScheduleName` AS `ScheduleName`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 1) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Monday`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 2) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Tuesday`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 3) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Wednesday`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 4) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Thursday`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 5) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Friday`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 6) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Saturday`,
       group_concat((CASE
                         WHEN (`ts`.`DayOfWeek` = 7) THEN if(`ts`.`IsClosed`, 'Closed', concat(time_format(`ts`.`OpenTime`, '%H:%i'), '-', time_format(`ts`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `ts`.`OpenTime` ASC separator ', ') AS `Sunday`,
       group_concat(concat(date_format(`tss`.`SpecialDate`, '%Y-%m-%d'), ': ', if(`tss`.`IsClosed`, 'Closed', concat(time_format(`tss`.`OpenTime`, '%H:%i'), '-', time_format(`tss`.`CloseTime`, '%H:%i'))))
                    ORDER BY `tss`.`SpecialDate` ASC separator '; ') AS `SpecialDates`,
       group_concat(if((`tss`.`Description` IS NOT NULL),concat(date_format(`tss`.`SpecialDate`, '%Y-%m-%d'), ': ', `tss`.`Description`), NULL)
                    ORDER BY `tss`.`SpecialDate` ASC separator '; ') AS `SpecialDescriptions`,
       `te`.`CreatedAt` AS `CreatedAt`,
       `te`.`UpdatedAt` AS `UpdatedAt`,
       `te`.`IsActive` AS `IsActive`
FROM (((`timeentity` `te`
        JOIN `timeentitytype` `tet` on((`te`.`EntityTypeID` = `tet`.`EntityTypeID`)))
       LEFT JOIN `timeslot` `ts` on(((`ts`.`ScheduleID` = `te`.`ScheduleID`)
                                     AND (`ts`.`IsActive` = 1))))
      LEFT JOIN `timespecialschedule` `tss` on(((`tss`.`ScheduleID` = `te`.`ScheduleID`)
                                                AND (`tss`.`IsActive` = 1))))
WHERE (`te`.`IsActive` = 1)
GROUP BY `te`.`ScheduleID`,
         `te`.`EntityTypeID`,
         `tet`.`EntityName`,
         `te`.`EntityID`,
         `te`.`ScheduleName`,
         `te`.`CreatedAt`,
         `te`.`UpdatedAt`,
         `te`.`IsActive`
