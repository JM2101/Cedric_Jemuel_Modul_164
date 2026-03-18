-- SELECT-Abfragen


-- 1. Alle Filme eines bestimmten Genres anzeigen
SELECT f.titel, f.erscheinungsjahr, f.dauer_min, f.preis_pro_tag
FROM film f
JOIN genre g ON f.genre_id = g.genre_id
WHERE g.bezeichnung = 'Science-Fiction';



-- 2. Alle aktuell ausgeliehenen Filme anzeigen (mit Kundennamen)
SELECT k.vorname, k.nachname, f.titel, a.datum_von, a.status
FROM ausleihe a
JOIN kunde k ON a.kunde_id = k.kunde_id
JOIN film f ON a.film_id = f.film_id
WHERE a.status = 'ausgeliehen';



-- 3. Alle Ausleihen eines bestimmten Kunden anzeigen
SELECT f.titel, a.datum_von, a.datum_bis, a.preis, a.status
FROM ausleihe a
JOIN film f ON a.film_id = f.film_id
JOIN kunde k ON a.kunde_id = k.kunde_id
WHERE k.nachname = 'Müller';



-- 4. Alle Schauspieler eines bestimmten Films anzeigen
SELECT s.vorname, s.nachname, s.geburtsdatum
FROM film_schauspieler fs
JOIN schauspieler s ON fs.schauspieler_id = s.schauspieler_id
JOIN film f ON fs.film_id = f.film_id
WHERE f.titel = 'Interstellar';



-- 5. Alle Kunden aus einer bestimmten Stadt anzeigen
SELECT k.vorname, k.nachname, k.email
FROM kunde k
JOIN ort o ON k.ort_id = o.ort_id
WHERE o.stadt = 'Bern';



-- 6. Alle verfügbaren Filme sortiert nach Preis aufsteigend
SELECT f.titel, g.bezeichnung AS genre, f.preis_pro_tag
FROM film f
JOIN genre g ON f.genre_id = g.genre_id
WHERE f.verfuegbar = TRUE
ORDER BY f.preis_pro_tag ASC;



-- 7. Alle Kunden die einen bestimmten Film ausgeliehen haben
SELECT DISTINCT k.vorname, k.nachname, k.email
FROM ausleihe a
JOIN kunde k ON a.kunde_id = k.kunde_id
JOIN film f  ON a.film_id  = f.film_id
WHERE f.titel = 'Inception';



-- 8. Anzahl Ausleihen pro Film anzeigen (beliebteste Filme)
SELECT f.titel, COUNT(a.ausleihe_id) AS anzahl_ausleihen
FROM film f
LEFT JOIN ausleihe a ON f.film_id = a.film_id
GROUP BY f.titel
ORDER BY anzahl_ausleihen DESC;



-- 9. Umsatz pro Genre anzeigen
SELECT g.bezeichnung AS genre, SUM(a.preis) AS gesamtumsatz
FROM ausleihe a
JOIN film  f ON a.film_id = f.film_id
JOIN genre g ON f.genre_id = g.genre_id
GROUP BY g.bezeichnung
ORDER BY gesamtumsatz DESC;



-- 10. Kunden die mehr als 1 Ausleihe gemacht haben
SELECT k.vorname, k.nachname, COUNT(a.ausleihe_id) AS anzahl_ausleihen
FROM kunde k
JOIN ausleihe a ON k.kunde_id = a.kunde_id
GROUP BY k.vorname, k.nachname
HAVING COUNT(a.ausleihe_id) > 1
ORDER BY anzahl_ausleihen DESC;