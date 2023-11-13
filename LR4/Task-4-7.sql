USE cd;
/* удаляем все данные из таблицы bookings, а потом возвращаем их обратно */
START TRANSACTION;
/* удаляем все данные из таблицы bookings */
DELETE FROM bookings;
SELECT * FROM bookings;
/* отменяем все предыдущие изменения */
ROLLBACK;
SELECT * FROM bookings;
/* Когда мы удалили все данные, таблица стала пустой, а когда отменили изменения, все вернулось в норму. */