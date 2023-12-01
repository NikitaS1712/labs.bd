USE cd;
/*Выведите все объектов клуба, если они содержат в названии слово  ‘Tennis’ в произвольном регистре.*/
SELECT f.facility
  FROM facilities f
  WHERE F.facility LIKE '%Tennis%'