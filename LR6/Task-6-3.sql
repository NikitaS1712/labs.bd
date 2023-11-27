USE cd;
/*Выберите процент использования объектов по месяцам, упорядочив по возрастанию*/
SELECT 
    MONTH(b.starttime) AS Месяц, 
    f.facility,
    (SUM(b.slots) / (COUNT(DISTINCT b.facid) * 720 * COUNT(DISTINCT YEAR(b.starttime)))) * 100 AS Процент_использования 
FROM bookings b
INNER JOIN facilities f ON b.facid = f.facid 
GROUP BY Месяц, f.facility
ORDER BY Процент_использования ASC;