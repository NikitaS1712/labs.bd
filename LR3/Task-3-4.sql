USE cd;
/* Выберите всех членов клуба и членов, которые их рекомендовали,  отсортировав их по имени и фамилии. */
SELECT m1.surname, m1.firstname, m2.surname AS "Recommender surname", m2.firstname AS "Recommender firstname"
FROM members m1
LEFT JOIN members m2 ON m1.recommendedby = m2.memid
ORDER BY m1.firstname;  