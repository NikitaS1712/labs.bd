USE cd;
/*Выберите имя, фамилию и дату вступления в клуб последних из всех вступивших.*/
SELECT surname, firstname, joindate FROM members  WHERE joindate = (SELECT MAX(joindate) FROM members);