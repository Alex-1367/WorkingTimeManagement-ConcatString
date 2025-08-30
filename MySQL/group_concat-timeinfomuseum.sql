CREATE VIEW `timeinfomuseum` AS
SELECT `m`.`MuseumID` AS `MuseumID`,
       `m`.`ToTown` AS `ToTown`,
       `t`.`TownName` AS `TownName`,
       `m`.`MuseumName` AS `MuseumName`,
       `ts`.`ScheduleID` AS `ScheduleID`,
       `ts`.`ScheduleName` AS `ScheduleName`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 1) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Monday`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 2) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Tuesday`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 3) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Wednesday`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 4) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Thursday`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 5) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Friday`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 6) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Saturday`,
       group_concat((CASE
                         WHEN (`tsl`.`DayOfWeek` = 7) THEN if(`tsl`.`IsClosed`, 'Closed', concat(time_format(`tsl`.`OpenTime`, '%H:%i'), '-', time_format(`tsl`.`CloseTime`, '%H:%i')))
                     END)
                    ORDER BY `tsl`.`OpenTime` ASC separator ', ') AS `Sunday`,
       group_concat(concat(date_format(`tss`.`SpecialDate`, '%Y-%m-%d'), ': ', if(`tss`.`IsClosed`, 'Closed', concat(time_format(`tss`.`OpenTime`, '%H:%i'), '-', time_format(`tss`.`CloseTime`, '%H:%i'))))
                    ORDER BY `tss`.`SpecialDate` ASC separator '; ') AS `SpecialDates`,
       group_concat(if((`tss`.`Description` IS NOT NULL),concat(date_format(`tss`.`SpecialDate`, '%Y-%m-%d'), ': ', `tss`.`Description`), NULL)
                    ORDER BY `tss`.`SpecialDate` ASC separator '; ') AS `SpecialDescriptions`
FROM ((((`museums` `m`
         JOIN `towns` `t` on((`m`.`ToTown` = `t`.`TownID`)))
        LEFT JOIN `timeentity` `ts` on(((`ts`.`EntityID` = `m`.`MuseumID`)
                                        AND (`ts`.`EntityTypeID` =
                                               (SELECT `timeentitytype`.`EntityTypeID`
                                                FROM `timeentitytype`
                                                WHERE (`timeentitytype`.`EntityName` = 'Museum')))
                                        AND (`ts`.`IsActive` = 1))))
       LEFT JOIN `timeslot` `tsl` on(((`tsl`.`ScheduleID` = `ts`.`ScheduleID`)
                                      AND (`tsl`.`IsActive` = 1))))
      LEFT JOIN `timespecialschedule` `tss` on(((`tss`.`ScheduleID` = `ts`.`ScheduleID`)
                                                AND (`tss`.`IsActive` = 1))))
WHERE (`m`.`IsActive` = 1)
GROUP BY `m`.`MuseumID`,
         `m`.`ToTown`,
         `t`.`TownName`,
         `m`.`AdultPrice`,
         `m`.`ChildPrice`,
         `m`.`PensionerPrice`,
         `m`.`VisitTime`,
         `m`.`Phone`,
         `m`.`Email`,
         `ts`.`ScheduleID`,
         `ts`.`ScheduleName`
