USE cd;
/*Составьте список общего количества бронирований на каждый объект в месяц в 2012 году.*/
SELECT f.facility, MONTH(b.starttime) AS 'Месяц', SUM(b.slots) AS 'Количество бронирований' FROM facilities f
INNER JOIN bookings b ON f.facid = b.facid WHERE YEAR(b.starttime) = 2012
GROUP BY f.facility, MONTH(b.starttime);