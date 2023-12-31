USE cd;
/*Создайте функцию, которая рассчитывает стоимость каждой аренды 
(для каждой записи таблицы bookings).*/
DELIMITER $$
DROP FUNCTION IF EXISTS CalculateRentalCost;
CREATE FUNCTION CalculateRentalCost(memid INT, facid INT, slots INT)
RETURNS DECIMAL (5, 2)
DETERMINISTIC
BEGIN
DECLARE Стоимость_аренды INT;
SET Стоимость_аренды = (SELECT IF(memid = 0, guestcost * slots, membercost * slots)
FROM facilities f WHERE facid = f.facid);
RETURN Стоимость_аренды;
END$$
DELIMITER;
SELECT CalculateRentalCost(memid, facid, slots) AS Стоимость_аренды
FROM bookings;
