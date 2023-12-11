USE cd;
/*Выберите процент использования объектов по месяцам, упорядочив по возрастанию*/
WITH slots AS (SELECT facility, SUM(b.slots) AS bookcost,   
DATE_FORMAT(b.starttime, '%y.%m') AS YearMonth
FROM facilities f
JOIN bookings b ON b.facid = f.facid
GROUP BY f.facid, YearMonth)
SELECT slot1.facility AS facility, ROUND(slot1.bookcost / SUM(slot2.bookcost) * 100, 1) AS usage_percent, slot1.YearMonth
FROM slots AS slot1
JOIN slots AS slot2 ON slot1.YearMonth = slot2.YearMonth
GROUP BY slot1.facility, slot1.bookcost, slot1.YearMonth
ORDER BY usage_percent ASC;