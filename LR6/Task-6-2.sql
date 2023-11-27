USE cd;
/*Выберите количество аренд объектов клуба в каждый месяц.*/
SELECT YEAR(b.starttime) AS "Год", MONTH(b.starttime) AS 'Месяц', COUNT(*) AS 'Количество бронирований' 
FROM bookings b
INNER JOIN facilities f ON b.facid = f.facid
GROUP BY YEAR(starttime), MONTH(b.starttime);