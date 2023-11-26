USE cd;
/*Рассчитайте количество аренд каждого из объектов клуба за сентябрь 2012 года.*/
SELECT facility, SUM(book.slots) AS rent_count
FROM cd.facilities AS fac
LEFT JOIN cd.bookings AS book ON book.facid = fac.facid
WHERE DATE(book.starttime) = '2012.09.12'
GROUP BY fac.facid;