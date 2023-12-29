/*Создайте таблицу payments со структурой (payid INT PK, FK on booking.bookid; payment  DECIMAL. 
Добавьте в таблицу bookings поле payed, смысл которого оплачена или не оплачена аренда. 
Создайте триггеры, которые 
- Запрещают удаление записей, если они уже оплачены;
- После отметки оплаты, заносят в таблицу  payments запись с соответствующим значением PK 
  и суммой оплаты,  для вычисления которой используется функция созданная в Task-7-1.
- При отмене оплаты удаляет соответствующую запись в таблице payments.    
Напишите скрипт, который отмечает, что все аренды июля 2012 года оплачены. 
Посчитайте (написав соответствующий скрипт) оплату на июль 2012 года двумя способами: 
- используя данные таблицы payments
- используя только функцию из Task-7-1 и данные таблицы bookings.
Сравните результаты расчета*/
USE cd;
DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
    payid INT PRIMARY KEY AUTO_INCREMENT,
    bookid int,
    payment  DECIMAL,
    FOREIGN KEY (bookid) REFERENCES bookings(bookid)
);
ALTER TABLE bookings ADD column payed INT DEFAULT 0;

DELIMITER //

DROP TRIGGER IF EXISTS no_pay_delete//
CREATE TRIGGER no_pay_delete BEFORE DELETE 
ON bookings
FOR EACH ROW
IF (OLD.payed = 1) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Эту запись нельзя удалить';
END IF//

DROP TRIGGER IF EXISTS pay_insert_delete//
CREATE TRIGGER pay_insert_delete AFTER UPDATE
ON bookings
FOR EACH ROW
BEGIN
   CASE
      WHEN NEW.payed = OLD.payed THEN BEGIN END;
      WHEN NEW.payed = 1 THEN 
         INSERT INTO payments (bookid, payment) 
         VALUES (NEW.bookid, slot_cost(NEW.memid, NEW.facid, NEW.slots));
      WHEN NEW.payed = 0 THEN
         DELETE FROM payments p WHERE p.bookid = NEW.bookid;
   END CASE;
END//

DROP TRIGGER IF EXISTS payed_already //
CREATE TRIGGER payed_already AFTER INSERT ON bookings FOR EACH ROW
BEGIN
    -- Если бронь уже оплачена при регистрации (payed = 1), добавляет оплату.
    IF NEW.payed = 1 THEN
        INSERT INTO payments(bookid, payment)
        VALUES(NEW.bookid, slot_cost(NEW.memid, NEW.facid, NEW.slots));
    END IF;
END //

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;
UPDATE bookings 
SET payed = 1
WHERE YEAR(starttime) = '2012' AND MONTH(starttime) = '7';
SET SQL_SAFE_UPDATES = 1;

SELECT SUM(payment) FROM payments;
SELECT SUM(slot_cost(memid, facid, slots))
    FROM bookings
    WHERE YEAR(starttime) = '2012' AND MONTH(starttime) = '7';