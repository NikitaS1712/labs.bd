USE cd;
/* Выберите 10 фамилий членов клуба упорядочите их по алфавиту без повторов.*/
SELECT DISTINCT surname FROM members ORDER BY surname LIMIT 10;