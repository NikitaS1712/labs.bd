/* Самый кассовый фильм месяца */
SELECT f.titleFIL AS 'Название фильма', 
       SUM(a.number_of_tickets * p.cost) AS 'Выручка' 
FROM Films f 
INNER JOIN Poster p ON f.idFIL = p.film 
INNER JOIN Audience a ON p.idPOS = a.poster_number 
GROUP BY f.titleFIL 
ORDER BY SUM(a.number_of_tickets * p.cost) DESC 
LIMIT 1;

/* Кинотеатры по количеству свободных мест в день. */
SELECT C.titleCIN, C.address, C.number_of_places - SUM(A.number_of_tickets) AS freeseats, A.visiting_day
FROM Cinemas C
JOIN Poster P ON C.idCIN = P.cinema
LEFT JOIN Audience A ON P.idPOS = A.poster_number
WHERE P.startDate <= '2022-01-19' AND P.endDate >= '2022-01-01'
GROUP BY C.idCIN, A.visiting_day
HAVING freeseats > 0
ORDER BY freeseats DESC;

/* Фильм с указанием максимального количества зрителей. */
SELECT F.titleFIL, MAX(A.total_tickets) AS max_daily_audience
FROM Films F
JOIN Poster P ON F.idFIL = P.film
JOIN (
    SELECT poster_number, SUM(number_of_tickets) AS total_tickets
    FROM Audience
    GROUP BY poster_number
) A ON P.idPOS = A.poster_number
GROUP BY F.idFIL
ORDER BY max_daily_audience DESC;