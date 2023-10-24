USE cd;
/* Найдите дату последней регистрации члена клуба.*/
SELECT MAX(joindate) AS 'Last registration' FROM members;