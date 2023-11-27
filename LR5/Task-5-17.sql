USE cd;
/*Классифицируйте объекты на группы одинакового размера (высокие, средние и низкие в зависимости от их доходов). 
Упорядочите по классификации и названию объекта. Примечание: используйте функцию деления на группы ntile.*/
SELECT facility, 
CASE 
  WHEN group1 = 1 THEN 'Высокий доход'
  WHEN group1 = 2 THEN 'Средний доход'
  WHEN group1 = 3 THEN 'Низкий доход'
END AS group1
FROM (
  SELECT f.facility, SUM(IF(b.memid = 0, f.guestcost * b.slots, f.membercost * b.slots)) AS revenue,
  NTILE(3) OVER (ORDER BY SUM(IF(b.memid = 0, f.guestcost * b.slots, f.membercost * b.slots))) AS group1
  FROM facilities f INNER JOIN bookings b ON f.facid = b.facid
  GROUP BY f.facility
) as temporary_table
ORDER BY group1, facility;