START TRANSACTION;
-- =========================================
-- 1. TESTDATEN FÜR KUNDE
-- =========================================

INSERT INTO `Kunde`
(
    `Kundennummer`,
    `Vorname`,
    `Nachname`,
    `E-Mail-Adresse`,
    `Telefonnummer`,
    `Registrierungsdatum`
)
VALUES
(
    1,
    'Max',
    'Mustermann',
    'max.mustermann@test.at',
    '0664 1111111',
    '2026-07-01'
),
(
    2,
    'Anna',
    'Huber',
    'anna.huber@test.at',
    '0664 2222222',
    '2026-07-05'
),
(
    3,
    'Lukas',
    'Steiner',
    'lukas.steiner@test.at',
    '0664 3333333',
    '2026-07-10'
);


-- =========================================
-- 2. TESTDATEN FÜR LADESTATION
-- =========================================

INSERT INTO `Ladestation`
(
    `Stationsnummer`,
    `Bezeichnung`,
    `Straße`,
    `Hausnummer`,
    `Postleitzahl`,
    `Ort`,
    `Ladeleistung`,
    `Status`
)
VALUES
(
    1,
    'Ladestation Bahnhof',
    'Bahnhofstraße',
    10,
    '5020',
    'Salzburg',
    150.00,
    'frei'
),
(
    2,
    'Ladestation Stadtzentrum',
    'Hauptstraße',
    25,
    '5600',
    'St. Johann',
    75.00,
    'belegt'
),
(
    3,
    'Ladestation Einkaufszentrum',
    'Industriestraße',
    5,
    '5400',
    'Hallein',
    50.00,
    'frei'
);


-- =========================================
-- 3. TESTDATEN FÜR TARIF
-- =========================================

INSERT INTO `Tarif`
(
    `idTarif`,
    `PreisProStunde`,
    `Startgebühr`,
    `aktiv`
)
VALUES
(
    1,
    0.45,
    0.00,
    1
),
(
    2,
    0.59,
    1.50,
    1
),
(
    3,
    0.32,
    0.00,
    1
);


-- =========================================
-- 4. TESTDATEN FÜR LADEVORGANG
-- =========================================

INSERT INTO `Ladevorgang`
(
    `idLadevorgang`,
    `Startzeit`,
    `Endzeit`,
    `Kilowattstunden`,
    `fkKunde`,
    `fkLadestation`,
    `fkTarif`
)
VALUES
(
    1,
    '2026-07-15 08:00:00',
    '2026-07-15 09:00:00',
    22.50,
    1,
    1,
    1
),
(
    2,
    '2026-07-16 10:30:00',
    '2026-07-16 11:15:00',
    18.75,
    2,
    2,
    2
),
(
    3,
    '2026-07-20 11:00:00',
    NULL,
    0,
    3,
    3,
    3
);

COMMIT;

SELECT * FROM `Kunde`;
SELECT * FROM `Ladestation`;
SELECT * FROM `Tarif`;
SELECT * FROM `Ladevorgang`;

SELECT
    lv.`idLadevorgang`,
    k.`Vorname`,
    k.`Nachname`,
    ls.`Bezeichnung` AS Ladestation,
    lv.`Startzeit`,
    lv.`Endzeit`,
    lv.`Kilowattstunden`,
    t.`PreisProStunde`,
    t.`Startgebühr`
FROM `Ladevorgang` lv
JOIN `Kunde` k
    ON lv.`fkKunde` = k.`Kundennummer`
JOIN `Ladestation` ls
    ON lv.`fkLadestation` = ls.`Stationsnummer`
JOIN `Tarif` t
    ON lv.`fkTarif` = t.`idTarif`;
    
    
START transaction;
INSERT INTO kunde (Kundennummer, Vorname, Nachname, `E-Mail-Adresse`, Telefonnummer, Registrierungsdatum) VALUES ('4', 'leah', 'noidea', 'email@email.com', '0258258', '2026-3-03'), ('5', 'erik', 'whoknows', 'neue@email.at', '+49875', '2025-3-03');
commit;

INSERT INTO Ladestation
(
    Stationsnummer,
    Bezeichnung,
    `Straße`,
    Hausnummer,
    Postleitzahl,
    Ort,
    Ladeleistung,
    Status
)
VALUES
(
    4,
    'Ladestation Flughafen',
    'Flughafenstraße',
    15,
    '5020',
    'Salzburg',
    100.00,
    'frei'
);

SELECT *
FROM Ladestation
WHERE Stationsnummer = 4;