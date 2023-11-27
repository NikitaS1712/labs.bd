USE cd;
/*Выведите наименования всех объектов клуба заглавными буквами, если они содержат в названии слово ‘Tennis’*/
SELECT facility FROM facilities 
WHERE BINARY facility LIKE '%Tennis%';