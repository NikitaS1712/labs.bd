USE cd;
/* Выбрать объекты, пользование которых платно для членов клуба */
SELECT facility  FROM facilities  WHERE membercost != 0;