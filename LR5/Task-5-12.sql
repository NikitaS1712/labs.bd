USE cd;
/* Составьте список имен и идентификаторов каждого участника, а также их первого 
бронирования после 1 сентября 2012 г. Упорядочите по идентификатору участника.*/
SELECT m.memid AS ID, CONCAT(m.firstname, ' ', m.surname) AS fiomember, MIN(b.starttime)
FROM members m 
LEFT JOIN bookings b ON m.memid = b.memid WHERE b.starttime >= '2012-09-01' AND m.firstname != 'Guest'
GROUP BY m.memid, m.firstname, m.surname ORDER BY m.memid;