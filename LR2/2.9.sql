USE cd;
/* Выбрать всех членов клуба, зарегистрированных с сентября 2012 года.*/
SELECT memid, surname, firstname  FROM members WHERE joindate >= '2012-09-01'; 