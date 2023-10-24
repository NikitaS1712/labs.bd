USE cd;
/*Выберите самый дорогой и самый дешевый объект.*/
SELECT facility, "Дорогой" AS 'Качественная стоимость' FROM facilities WHERE initialoutlay  = (SELECT MAX(initialoutlay ) FROM facilities)
UNION
SELECT facility, "Дешевый" FROM facilities WHERE initialoutlay  = (SELECT MIN(initialoutlay ) FROM facilities);