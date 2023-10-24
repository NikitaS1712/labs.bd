USE cd; 
/* Выберите теннисные корты, забронированные пользователями на 19 сентября 2012 года.*/
SELECT DISTINCT facility FROM facilities
JOIN bookings ON facilities.facid = bookings.facid
WHERE facilities.facid IN (0, 1) AND bookings.starttime LIKE "2012-09-19%"
