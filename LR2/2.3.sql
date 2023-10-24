USE cd;
/* Выбрать объекты, пользование которых бесплатно для членов клуба. */
SELECT facility FROM facilities  WHERE membercost = 0;