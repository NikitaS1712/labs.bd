USE cd;
/*Создайте монотонно увеличивающийся нумерованный список участников (включая гостей), упорядоченный по дате присоединения. 
Помните, что идентификаторы участников не обязательно будут последовательными. Используйте функцию нумерации row_number.*/
SELECT ROW_NUMBER() OVER (ORDER BY joindate) AS 'Номер', memid AS ID, 
CONCAT(firstname,' ', surname) AS fiomember, joindate 
FROM members ORDER BY joindate;