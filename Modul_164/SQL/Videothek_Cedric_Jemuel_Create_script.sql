CREATE DATABASE Videothek_Cedric_Jemuel;



CREATE TABLE ort (
    ort_id  SERIAL       PRIMARY KEY,
    plz     CHAR(4)      NOT NULL,
    stadt   VARCHAR(100) NOT NULL,
    UNIQUE (plz)
);

CREATE TABLE genre (
    genre_id    SERIAL      PRIMARY KEY,
    bezeichnung VARCHAR(50) NOT NULL,
    UNIQUE(bezeichnung)
);

CREATE TABLE kunde (
    kunde_id       SERIAL       PRIMARY KEY,
    vorname        VARCHAR(50)  NOT NULL,
    nachname       VARCHAR(50)  NOT NULL,
    email          VARCHAR(100) NOT NULL,
    telefon        VARCHAR(20),
    geburtsdatum   DATE         NOT NULL,
    registriert_am DATE         NOT NULL DEFAULT CURRENT_DATE,
    aktiv          BOOLEAN      NOT NULL DEFAULT TRUE,
    ort_id         INT,
    UNIQUE(email),
    FOREIGN KEY (ort_id) REFERENCES ort(ort_id) ON DELETE SET NULL
);

CREATE TABLE schauspieler (
    schauspieler_id SERIAL      PRIMARY KEY,
    vorname         VARCHAR(50) NOT NULL,
    nachname        VARCHAR(50) NOT NULL,
    geburtsdatum    DATE
);

CREATE TABLE film (
    film_id          SERIAL       PRIMARY KEY,
    titel            VARCHAR(150) NOT NULL,
    erscheinungsjahr INT          NOT NULL CHECK (erscheinungsjahr >= 1888),
    dauer_min        INT          NOT NULL CHECK (dauer_min > 0),
    beschreibung     TEXT,
    preis_pro_tag    DECIMAL(5,2) NOT NULL DEFAULT 3.50,
    verfuegbar       BOOLEAN      NOT NULL DEFAULT TRUE,
    genre_id         INT          NOT NULL,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id) ON DELETE NO ACTION
);

CREATE TABLE film_schauspieler (
    film_id         INT NOT NULL,
    schauspieler_id INT NOT NULL,
    PRIMARY KEY (film_id, schauspieler_id),
    FOREIGN KEY (film_id)         REFERENCES film(film_id)                 ON DELETE CASCADE,
    FOREIGN KEY (schauspieler_id) REFERENCES schauspieler(schauspieler_id) ON DELETE NO ACTION
);

CREATE TABLE ausleihe (
    ausleihe_id SERIAL       PRIMARY KEY,
    kunde_id    INT          NOT NULL,
    film_id     INT          NOT NULL,
    datum_von   DATE         NOT NULL,
    datum_bis   DATE,
    preis       DECIMAL(6,2) NOT NULL,
    status      VARCHAR(20)  NOT NULL DEFAULT 'ausgeliehen',
    CHECK (status IN ('ausgeliehen', 'zurueckgegeben', 'ueberfaellig')),
    FOREIGN KEY (kunde_id) REFERENCES kunde(kunde_id) ON DELETE NO ACTION,
    FOREIGN KEY (film_id)  REFERENCES film(film_id)   ON DELETE NO ACTION
);