USE cd;
/* Выбрать имена объектов с их качественной стоимостью
 (качественной стоимостью == ‘дешевый’ если monthlymaintenance < 100 и 
 ‘дорогой’ в противном случае*/
SELECT facility, 'Дешевый' AS 'Качественная стоимость' FROM facilities WHERE monthlymaintenance < 100
UNION
SELECT facility, 'Дорогой' FROM facilities WHERE monthlymaintenance >= 100;