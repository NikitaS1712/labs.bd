USE cd;
/* Выводим всех членов клуба, которые не арендовали объекты клуба  */
SELECT * FROM members
WHERE memid NOT  IN (SELECT memid FROM bookings);
/* Удаляем всех членов клуба, которые не арендовали объекты клуба  */
DELETE FROM members
WHERE memid NOT IN (SELECT memid FROM bookings);
/* Проверяем есть ли член клуба с memid = 37 */
SELECT * FROM members WHERE memid = 37;
/* Возвращение члена клуба с memid = 37 (для проверки работы скрипта) */
INSERT INTO members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) VALUES
(37, 'Smith', 'Darren', '3 Funktown, Denzington, Boston', 66796, '(822) 577-3541', NULL, '2012-09-26 18:08:45');