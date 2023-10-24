USE cd;
/* Выбрать информацию о наименовании и стоимости его
использования для членов клуба (membercost) для всех зарегистрированных 
в базе объектах (facilities) клуба. */
SELECT facility, membercost FROM facilities WHERE membercost != 0;