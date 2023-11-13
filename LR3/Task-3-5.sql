USE cd;
/* Выберите ФИО (== имя + фамилия) всех, кто покупал корты 1 и 2. */
SELECT DISTINCT surname, firstname FROM members
JOIN bookings ON members.memid = bookings.memid
JOIN facilities ON facilities.facid = bookings.facid
WHERE facilities.facility LIKE '%Tennis court%';