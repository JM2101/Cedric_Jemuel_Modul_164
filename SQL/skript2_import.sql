set search_path TO data;

TRUNCATE TABLE ausleihe CASCADE;
TRUNCATE TABLE film_schauspieler CASCADE;
TRUNCATE TABLE film CASCADE;
TRUNCATE TABLE kunde CASCADE;
TRUNCATE TABLE schauspieler CASCADE;
TRUNCATE TABLE genre CASCADE;
TRUNCATE TABLE ort CASCADE;

ALTER SEQUENCE ort_ort_id_seq RESTART WITH 1;
ALTER SEQUENCE genre_genre_id_seq RESTART WITH 1;
ALTER SEQUENCE kunde_kunde_id_seq RESTART WITH 1;
ALTER SEQUENCE schauspieler_schauspieler_id_seq RESTART WITH 1;
ALTER SEQUENCE film_film_id_seq RESTART WITH 1;
ALTER SEQUENCE ausleihe_ausleihe_id_seq RESTART WITH 1;

COPY ort(plz, stadt)
FROM 'C:/Daten/CSV/ort.csv'
DELIMITER ';' CSV HEADER;

COPY genre(bezeichnung)
FROM 'C:/Daten/CSV/genre.csv'
DELIMITER ';' CSV HEADER;

COPY schauspieler(vorname, nachname, geburtsdatum)
FROM 'C:/Daten/CSV/schauspieler.csv'
DELIMITER ';' CSV HEADER;

COPY kunde(vorname, nachname, email, telefon, geburtsdatum, registriert_am, aktiv, ort_id)
FROM 'C:/Daten/CSV/kunde.csv'
DELIMITER ';' CSV HEADER;

COPY film(titel, erscheinungsjahr, dauer_min, beschreibung, preis_pro_tag, verfuegbar, genre_id)
FROM 'C:/Daten/CSV/film.csv'
DELIMITER ';' CSV HEADER;

COPY film_schauspieler(film_id, schauspieler_id)
FROM 'C:/Daten/CSV/film_schauspieler.csv'
DELIMITER ';' CSV HEADER;

COPY ausleihe(kunde_id, film_id, datum_von, datum_bis, preis, status)
FROM 'C:/Daten/CSV/ausleihe.csv'
DELIMITER ';' CSV HEADER;