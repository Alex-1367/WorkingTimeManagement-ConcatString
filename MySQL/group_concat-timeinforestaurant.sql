 CREATE VIEW `timeinforestaurant` AS
SELECT `r`.`RestaurantID` AS `RestaurantID`,
       `r`.`TownID` AS `ToTown`,
       `t`.`TownName` AS `TownName`,
       `r`.`RestaurantName` AS `RestaurantName`,
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
FROM ((((`restaurants` `r`
         JOIN `towns` `t` on((`r`.`TownID` = `t`.`TownID`)))
        LEFT JOIN `timeentity` `ts` on(((`ts`.`EntityID` = `r`.`RestaurantID`)
                                        AND (`ts`.`EntityTypeID` =
                                               (SELECT `timeentitytype`.`EntityTypeID`
                                                FROM `timeentitytype`
                                                WHERE (`timeentitytype`.`EntityName` = 'Restaurant')))
                                        AND (`ts`.`IsActive` = 1))))
       LEFT JOIN `timeslot` `tsl` on(((`tsl`.`ScheduleID` = `ts`.`ScheduleID`)
                                      AND (`tsl`.`IsActive` = 1))))
      LEFT JOIN `timespecialschedule` `tss` on(((`tss`.`ScheduleID` = `ts`.`ScheduleID`)
                                                AND (`tss`.`IsActive` = 1))))
WHERE (`r`.`IsActive` = 1)
GROUP BY `r`.`RestaurantID`,
         `r`.`TownID`,
         `t`.`TownName`,
         `r`.`Phone`,
         `r`.`Email`,
         `ts`.`ScheduleID`,
         `ts`.`ScheduleName`
