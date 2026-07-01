-- testing of DB entries

-- Aufgabe: alle kunden mit vorname, nachname, start-/endhaltestelle mit datum/uhrzeit, tarif mit preis
-- DATE_FORMAT formatiert fahrt.startzeit/endzeit nach tag.monat.jahr stunde.minute, schöner zu lesen
-- JOINS um alle gewollten Daten aus den verschiedenen Tabellen zu bekommen
-- 2 Haltestellen (start/ende) also 2 mal JOIN auf haltestelle - abkürzung muss unterschiedlich benannt sein (hs/hse)
-- vergleiche bei den JOINS ob die FKs der id vom gewollten wert in der Haupttabelle(fahrt) übereinstimmen (also ein eintrag exestiert) in JOIN tabelle
-- Fahrt ist die "haupttabelle" da sie den großteil an Informationen enthält (kunde, start-/end HS, tarif, start-endzeit)
SELECT 
	k.vorname,
	k.nachname,
    hs.bezeichnung AS starthaltestelle,
	DATE_FORMAT(f.startzeit, '%d.%m.%Y %H:%i') AS start_datum_uhrzeit,
    hse.bezeichnung AS endhaltestelle,
    DATE_FORMAT(f.endzeit, '%d.%m.%Y %H:%i') AS ende_datum_zeit,
    t.bezeichnung AS tarif,
    t.preis AS preis
FROM Fahrt f
JOIN kunde k
	ON f.FK_idKunde = k.idKunde
JOIN haltestelle hs
	ON f.FK_idStarthaltestelle = hs.idHaltestelle
JOIN haltestelle hse
	ON f.FK_idEndHaltestelle = hse.idHaltestelle
JOIN tarif t
	ON f.FK_idTarif = t.idTarif;
    
-- Aufgabe: alle Kunden die mehr als 1 Fahrt gebucht haben
-- Fahrt als "hauttabelle" da sie kunde beinhaltet
-- join holt man die daten von kunde wo der FK_idKunde von Fahrt zu idKunde von Kunde passen muss
-- COUNT zählt die idFahrt aus fahrt (also wie viele fahrten ein kunde hat)
-- HAVING zeig nur ergebnisse an, wenn diese den count-wert > 1 haben
-- GROUP BY fasst alle fahrten pro Kunde (id, vorname, nachname, email) zusammen
SELECT 
	k.vorname,
    k.nachname,
    k.email,
    COUNT(f.idFahrt) AS fahrten
FROM fahrt f
JOIN kunde k
	ON f.FK_idKunde = k.idKunde
GROUP BY
	k.idKunde,
    k.vorname,
    k.nachname,
    k.email
HAVING COUNT(f.idFahrt) > 1;

-- Aufgabe: anzahl der fahrten pro kunde mit vorname, nachname, email, adresse - mind 1 fahrt
-- SELECT alle daten aus 3 tabellen
-- Fahrt wieder Haupttabelle da sie alles enthält mit FK
-- GROUP BY user und HAVING mindestens 1 fahrt
SELECT
	k.vorname,
    k.nachname, 
    k.email,
    a.strasse AS straße,
    a.hausnummer AS hausnummer,
    COUNT(f.idFahrt) AS fahrten
FROM fahrt f
JOIN kunde k
	ON f.FK_idKunde = k.idKunde
JOIN adresse a
	ON f.FK_idKunde = a.FK_idKunde
GROUP BY
	k.vorname,
    k.nachname,
    k.email
HAVING COUNT(f.idFahrt) >= 1;

-- Aufagabe: alle kunden mit bestimmten tarif 'senior'
-- distinct um einen kunden mit passendem ergebnis nur 1x anzeigen zu lassen
-- WHERE um zu checken, alle ergebnisse wo der gefragte wert (t.bezeichnung) = senior ist
SELECT DISTINCT
	k.vorname,
    k.nachname,
    k.email, 
    t.bezeichnung,
    t.preis
FROM fahrt f
JOIN kunde k
	on f.FK_idKunde = k.idKunde
JOIN tarif t
	ON f.FK_idTarif = t.idTarif
WHERE t.bezeichnung = 'senior';

-- Aufgabe: alle kunden mit unbezahlten fahrten
-- distinct, wenn ein kunde mehrere unbezahlte fahrten hat, wird er trotzdem nur 1x angezeigt
-- case when - (wie switch case) wenn der boolean fahrtbezahlt = 1/0 (wie in der tabelle gespeichert) zeigt es stattdessen ja/nein an
-- where checkt trotzdem tabellenwert also 0 od 1
SELECT DISTINCT
	k.vorname,
    k.nachname,
    k.email,
    CASE
		WHEN f.fahrtbezahlt = 1 then 'ja'
		WHEN f.fahrtbezahlt = 0 then 'nein'
		ELSE null
	end as fahrtbezahlt
FROM kunde k
JOIN fahrt f
	ON k.idKunde = f.FK_idKunde
WHERE f.fahrtbezahlt = "0";

-- Aufagb: alle fahrten die an einem bestimmten datum waren
-- sucht alle fahrten mit passendem kunden die an eine genauen Datum stattfanden
-- bei DATETIME fledern kann man trotzdem mit DATE() nur das datum ohne  uhrzeit durchsuchen/suchen
SELECT DISTINCT
    k.email AS kunde,
    f.startzeit,
    f.endzeit,
    f.fahrtbezahlt
FROM fahrt f
JOIN kunde k
	ON f.FK_idKunde = k.idKunde
WHERE DATE(f.startzeit) = '2026-06-12';
-- sucht alle fahrten mit passendem kunden die genau zu einer Zeit gestartet/geendet haben mit WHERE AND 
-- (um sicherzustellen, dass start und ende passen falls 2 od mehrer fahrten zugleich beginnen aber nicht gleich enden)
-- WHERE f.startzeit = '2026-05-04 14:15:00' AND f.endzeit = '2026-05-04 14:35:00';
