USE cd;
/*Выберите начальное и конечное время последних 10 аренд  объектов, 
упорядочив их по времени их окончания.*/
SELECT starttime AS 'Начальное время', ADDTIME(starttime, SEC_TO_TIME(slots * 1800)) AS конечное_время
FROM bookings
ORDER BY конечное_время DESC
LIMIT 10;