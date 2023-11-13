USE cd;
/* Выберите 10 фамилий членов клуба упорядочите их по алфавиту без повторов.*/
SELECT DISTINCT surname FROM members WHERE surname != 'Guest' ORDER BY surname LIMIT 10;