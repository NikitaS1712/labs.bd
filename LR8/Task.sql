/* Создание таблицы */
CREATE DATABASE IF NOT EXISTS CINEMAS;
USE CINEMAS;
/*Кинотеатры: идентификтор, название, адрес, количество мест*/
CREATE TABLE IF NOT EXISTS Cinemas (
  idCIN INT PRIMARY KEY,
  titleCIN VARCHAR(25),
  address VARCHAR(25),
  number_of_places INT
);
/* Фильмы: идентификатор, название, год выпуска, киностудия, длительность, страна */
CREATE TABLE IF NOT EXISTS Films (
  idFIL INT PRIMARY KEY,
  titleFIL VARCHAR(25),
  release_year INT,
  film_studio VARCHAR(25),
  duration TIME,
  country VARCHAR(25)
);
/* Афиша: идентификатор, фильм, дата начала проката, дата окончания проката, кинотеатр, 
количество сеансов в день, стоимость просмотра (1 зритель) */
CREATE TABLE IF NOT EXISTS Poster (
  idPOS INT PRIMARY KEY,
  film INT,
  startDate DATE,
  endDate DATE,
  cinema INT,
  number_of_sessions INT,
  cost DECIMAL(10,2),
  FOREIGN KEY (film) REFERENCES Films(idFIL),
  FOREIGN KEY (cinema) REFERENCES Cinemas(idCIN)
);
/* Зрители (билеты): идентификатор, номер афиши, день посещения, количество билетов. */
CREATE TABLE IF NOT EXISTS Audience (
  idAUD INT PRIMARY KEY,
  poster_number INT,
  visiting_day DATE,
  number_of_tickets INT,
  FOREIGN KEY (poster_number) REFERENCES Poster(idPOS)
);

/*VIEW*/
/*VIEW_1: cамый кассовый фильм месяца. */
DROP TABLE IF EXISTS CINEMAS.Top_film;
USE CINEMAS;
CREATE  OR REPLACE VIEW Top_film AS
  SELECT f.titleFIL AS 'Название фильма', 
        MONTH(p.startDate) AS 'Месяц', SUM(a.number_of_tickets * p.cost) AS 'Выручка'
  FROM Films f 
  INNER JOIN Poster p ON f.idFIL = p.film 
  INNER JOIN Audience a ON p.idPOS = a.poster_number 
  GROUP BY f.titleFIL, p.startDate
  ORDER BY SUM(a.number_of_tickets * p.cost) DESC 
  LIMIT 1;
/*VIEW_2: кинотеатры по количеству свободных мест в день. */
DROP TABLE IF EXISTS CINEMAS.Available_seats;
USE CINEMAS;
CREATE  OR REPLACE VIEW Available_seats AS  
  SELECT C.titleCIN, C.address, C.number_of_places - SUM(A.number_of_tickets) AS freeseats, A.visiting_day
  FROM Cinemas C
  JOIN Poster P ON C.idCIN = P.cinema
  LEFT JOIN Audience A ON P.idPOS = A.poster_number
  GROUP BY C.idCIN, A.visiting_day
  HAVING freeseats > 0
  ORDER BY freeseats DESC;
/*VIEW_3: фильм с указанием максимального количества зрителей. */
DROP TABLE IF EXISTS CINEMAS.MAX_viewers;
USE CINEMAS;
CREATE  OR REPLACE VIEW MAX_viewers AS 
  SELECT F.titleFIL, MAX(A.total_tickets) AS max_daily_audience, DAY(a.visiting_day)
  FROM Films F
  JOIN Poster P ON F.idFIL = P.film
  JOIN (
      SELECT poster_number, visiting_day, SUM(number_of_tickets) AS total_tickets
      FROM Audience
      GROUP BY poster_number, visiting_day
  ) A ON P.idPOS = A.poster_number
  GROUP BY F.titleFIL, a.visiting_day
  ORDER BY max_daily_audience DESC;

/*Заполнение таблицы*/
/*Таблица Cinemas: Кинотеатры: идентификтор, название, адрес, количество мест*/
INSERT INTO Cinemas (idCIN, titleCIN, address, number_of_places) 
VALUES 
  (1, 'Кинотеатр А', 'Адрес 1', 100),
  (2, 'Кинотеатр Б', 'Адрес 2', 150),
  (3, 'Кинотеатр В', 'Адрес 3', 200),
  (4, 'Кинотеатр Г', 'Адрес 4', 120),
  (5, 'Кинотеатр Д', 'Адрес 5', 180),
  (6, 'Кинотеатр Е', 'Адрес 6', 90),
  (7, 'Кинотеатр Ж', 'Адрес 7', 130),
  (8, 'Кинотеатр З', 'Адрес 8', 110),
  (9, 'Кинотеатр И', 'Адрес 9', 160),
  (10, 'Кинотеатр К', 'Адрес 10', 140);
/*Таблица Films:  Фильмы: идентификатор, название, год выпуска, киностудия, длительность, страна*/
INSERT INTO Films (idFIL, titleFIL, release_year, film_studio, duration, country) 
VALUES 
  (1, 'Фильм 1', 2020, 'Киностудия А', '02:15:00', 'Страна 1'),
  (2, 'Фильм 2', 2019, 'Киностудия Б', '01:45:00', 'Страна 2'),
  (3, 'Фильм 3', 2021, 'Киностудия В', '02:30:00', 'Страна 3'),
  (4, 'Фильм 4', 2018, 'Киностудия Г', '01:50:00', 'Страна 4'),
  (5, 'Фильм 5', 2022, 'Киностудия Д', '02:10:00', 'Страна 5'),
  (6, 'Фильм 6', 2017, 'Киностудия Е', '01:55:00', 'Страна 6'),
  (7, 'Фильм 7', 2023, 'Киностудия Ж', '02:20:00', 'Страна 7'),
  (8, 'Фильм 8', 2016, 'Киностудия З', '01:40:00', 'Страна 8'),
  (9, 'Фильм 9', 2024, 'Киностудия И', '02:05:00', 'Страна 9'),
  (10, 'Фильм 10', 2015, 'Киностудия К', '01:50:00', 'Страна 10');
/*Таблица Poster: афиша: идентификатор, фильм, дата начала проката, дата окончания проката, кинотеатр, 
количество сеансов в день, стоимость просмотра (1 зритель)*/
INSERT INTO Poster (idPOS, film, startDate, endDate, cinema, number_of_sessions, cost) 
VALUES 
  (1, 1, '2022-01-01', '2022-01-10', 1, 3, 10.00),
  (2, 2, '2022-01-02', '2022-01-11', 2, 2, 8.50),
  (3, 3, '2022-01-03', '2022-01-12', 3, 4, 12.00),
  (4, 4, '2022-01-04', '2022-01-13', 4, 3, 9.50),
  (5, 5, '2022-01-05', '2022-01-14', 5, 4, 12.00),
  (6, 6, '2022-01-06', '2022-01-15', 6, 2, 8.50),
  (7, 7, '2022-01-07', '2022-01-16', 7, 3, 10.00),
  (8, 8, '2022-01-08', '2022-01-17', 8, 4, 12.50),
  (9, 9, '2022-01-09', '2022-01-18', 9, 3, 9.50),
  (10, 10, '2022-01-10', '2022-01-19', 10, 2, 8.00);
/*Таблица Audience:Зрители (билеты): идентификатор, номер афиши, день посещения, количество билетов.*/
  INSERT INTO Audience (idAUD, poster_number, visiting_day, number_of_tickets) 
VALUES 
  (1, 1, '2022-01-01', 2),
  (2, 2, '2022-01-02', 1),
  (3, 3, '2022-01-03', 3),
  (4, 4, '2022-01-04', 2),
  (5, 5, '2022-01-05', 4),
  (6, 6, '2022-01-06', 1),
  (7, 7, '2022-01-07', 2),
  (8, 8, '2022-01-08', 3),
  (9, 9, '2022-01-09', 2),
  (10, 10, '2022-01-10', 1);
  
  UPDATE 