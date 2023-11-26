USE cd;
/*  Рассчитайте количество аренд каждого из объектов клуба.*/
SELECT facility, sum(b.slots) AS 'Количество аренд' FROM facilities f 
INNER JOIN bookings AS b ON b.facid = f.facid GROUP BY f.facid;