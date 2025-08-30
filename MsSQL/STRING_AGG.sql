SELECT
    m.MuseumID,
    m.ToTown,
    t.TownName,
    m.AdultPrice,
    m.ChildPrice,
    m.PensionerPrice,
    m.VisitTime,
    m.Phone,
    m.Email,
    ts.ScheduleID,
    ts.ScheduleName,
    -- Monday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 1 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Monday,
    -- Tuesday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 2 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Tuesday,
    -- Wednesday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 3 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Wednesday,
    -- Thursday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 4 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Thursday,
    -- Friday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 5 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Friday,
    -- Saturday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 6 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Saturday,
    -- Sunday (multiple time slots)
    STRING_AGG(
        CASE WHEN tsl.DayOfWeek = 7 THEN
            CASE WHEN tsl.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tsl.OpenTime, 'HH:mm') + '-' + FORMAT(tsl.CloseTime, 'HH:mm')
            END
        END, ', '
    ) WITHIN GROUP (ORDER BY tsl.OpenTime) as Sunday,
    -- Special Schedules
    STRING_AGG(
        CASE WHEN tss.SpecialDate IS NOT NULL THEN
            FORMAT(tss.SpecialDate, 'yyyy-MM-dd') + ': ' +
            CASE WHEN tss.IsClosed = 1 THEN 'Closed'
                 ELSE FORMAT(tss.OpenTime, 'HH:mm') + '-' + FORMAT(tss.CloseTime, 'HH:mm')
            END
        END, '; '
    ) WITHIN GROUP (ORDER BY tss.SpecialDate) as SpecialDates,
    -- Special Descriptions
    STRING_AGG(
        CASE WHEN tss.Description IS NOT NULL THEN
            FORMAT(tss.SpecialDate, 'yyyy-MM-dd') + ': ' + tss.Description
        END, '; '
    ) WITHIN GROUP (ORDER BY tss.SpecialDate) as SpecialDescriptions
FROM Museums m
JOIN Towns t ON m.ToTown = t.TownID
LEFT JOIN [Time-entity] ts ON ts.EntityID = m.MuseumID
    AND ts.EntityTypeID = (SELECT EntityTypeID FROM TimeEntityType WHERE EntityName = 'Museum')
    AND ts.IsActive = 1
LEFT JOIN TimeSlot tsl ON tsl.ScheduleID = ts.ScheduleID AND tsl.IsActive = 1
LEFT JOIN TimeSpecialSchedule tss ON tss.ScheduleID = ts.ScheduleID AND tss.IsActive = 1
WHERE m.IsActive = 1
GROUP BY m.MuseumID, m.ToTown, t.TownName, m.AdultPrice, m.ChildPrice,
         m.PensionerPrice, m.VisitTime, m.Phone, m.Email, ts.ScheduleID, ts.ScheduleName;
