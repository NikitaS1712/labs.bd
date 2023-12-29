/*Произведите изменения в стоимости аренды объектов согласно расчету задания Task-7-4, написав update-скрипт. 
Напишите скрипт отмечающий оплату всех аренд за , используя функцию Task-7-3 . 
Сравните, совпадают ли расчетные данные с теми, что были Вами получены в задании Task-7-4.  */

USE cd;

START TRANSACTION;
    CALL payback(1, MONTH('2012-07-03'), YEAR('2012-07-03'));

    UPDATE facilities
    SET
        guestcost = guestcost * (SELECT RentChange(facid, 2, '2012-07-01-00:00:00', '2012-07-31-23:59:59')),
        membercost = membercost * (SELECT RentChange(facid, 2, '2012-07-01-00:00:00', '2012-07-31-23:59:59'));

    UPDATE bookings
    SET payed = 1
    WHERE DATE(starttime) < '2012-09-01' AND DATE(starttime) >= '2012-08-01';

    CALL payback(1, MONTH('2012-08-03'), YEAR('2012-08-03'));
ROLLBACK;
/*Вывод: В данном случае окупаемость возрасла.*/