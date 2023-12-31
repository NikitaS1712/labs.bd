/*Напишите функцию, которая будет рассчитывать увеличение/уменьшение стоимость аренды объекта на последующие месяцы  для изменения ( увеличения или уменьшения)
 срока окупаемость на заданную долю (в процентах) на основании расчета окупаемости за уже оплаченные периоды. 
 Сохраните расчет в виде csv или sql файла (например, используя временные таблицы). */
USE cd;

DELIMITER //

DROP FUNCTION IF EXISTS RentChange //
CREATE FUNCTION RentChange(facid INT, frac FLOAT, starttime TIMESTAMP, stoptime TIMESTAMP)
  RETURNS VARCHAR(50)
  READS SQL DATA
  NOT DETERMINISTIC
  BEGIN
    DECLARE income DECIMAL(10, 2);
    DECLARE maintenance DECIMAL(10, 2);
    DECLARE profit DECIMAL(10, 2);
    DECLARE initcost DECIMAL(10, 2);

    /*Расчет дохода(income) без учета обслуживания(maintenance)*/
    SELECT SUM(p.payment) INTO income
	FROM payments p
	INNER JOIN bookings b ON b.bookid = p.bookid
	INNER JOIN facilities f ON b.facid = f.facid
	WHERE facid = b.facid AND b.starttime BETWEEN starttime AND stoptime
	GROUP BY b.facid;

    IF income IS NULL THEN 
    RETURN 1;
    END IF;


	/*Расчет обслуживания (maintenance)*/
    SELECT f.monthlymaintenance * (MONTH(stoptime) - MONTH(starttime) + 1) INTO maintenance
	FROM facilities f
	INNER JOIN bookings b ON b.facid = f.facid 
    WHERE facid = b.facid
	GROUP BY b.facid;

    /*Начальная стоимость объекта*/
    SELECT f.initialoutlay INTO initcost FROM facilities AS f
	WHERE facid = f.facid;

    /*Прибыль*/ 
    SET profit = (income - maintenance);
    
    /*Проверка на окупаемость*/
    IF profit <= 0 OR initcost <= profit
    THEN 
    RETURN 1;
    END IF;
    
    /*Рассчитываем коэффициент стоимости аренды*/
    RETURN ((1 / frac) * (initcost - profit) / initcost * (1 - maintenance / income) + maintenance / income);
  END //

DELIMITER ;

/*Сохраняем данные в csv файл*/
SELECT RentChange(2, 5, '2012-07-01','2012-07-31 23:59:59')
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output2.csv' 
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';