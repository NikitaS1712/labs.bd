USE cd; 
/* Выберите лист времке  (timestamp) покупки времени использования объектов членом клуба 'David Farrell'. */
SELECT starttime FROM bookings 
JOIN members ON bookings.memid = members.memid 
WHERE members.surname = "Farrell" AND members.firstname = "David";