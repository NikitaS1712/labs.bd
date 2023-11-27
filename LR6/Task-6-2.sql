USE cd;
/*Выберите количество аренд объектов клуба в каждый месяц.*/
SELECT f.facility, MONTH(b.starttime) AS 'Месяц', COUNT(*) AS 'Количество бронирований' FROM facilities f
INNER JOIN bookings b ON f.facid = b.facid
GROUP BY f.facility, MONTH(b.starttime);