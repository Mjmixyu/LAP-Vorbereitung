-- Alle Ladevorgänge mit Kunde, Ladestation und Tarif anzeigen.
SELECT lv.idLadevorgang,
k.vorname,
k.nachname,
ls.bezeichnung,
t.idTarif
FROM ladevorgang lv
JOIN kunde k
ON lv.fkKunde = k.Kundennummer
JOIN ladestation ls
ON lv.fkLadestation = ls.Stationsnummer
JOIN tarif t
ON lv.fkTarif = t.idTarif;

-- Den Preis jedes abgeschlossenen Ladevorgangs berechnen.
SELECT (Kilowattstunden * PreisProStunde) + t.Startgebühr AS preis, lv.Startzeit, lv.Endzeit, t.aktiv FROM ladevorgang lv JOIN tarif t ON lv.fkTarif = t.idTarif WHERE lv.Endzeit IS NOT NULL;

-- Die Anzahl der Ladevorgänge pro Ladestation ermitteln.
SELECT ls.Bezeichnung, ls.Stationsnummer, COUNT(lv.idLadevorgang) AS ladevorgänge FROM ladevorgang lv LEFT JOIN ladestation ls ON lv.fkLadestation = ls.Stationsnummer GROUP BY ls.Bezeichnung;

-- Den gesamten Umsatz pro Ladestation berechnen.
	-- funktioniert nur da alle den gleichen tarif haben
	-- SELECT ls.Stationsnummer,  ((Kilowattstunden * PreisProStunde) + t.Startgebühr) * COUNT(lv.idLadevorgang) AS umsatz , (Kilowattstunden * PreisProStunde) + t.Startgebühr AS preis, COUNT(lv.idLadevorgang) AS ladevorgänge FROM ladevorgang lv JOIN tarif t ON lv.fkTarif = t.idTarif JOIN ladestation ls ON lv.fkLadestation = ls.Stationsnummer GROUP BY ls.Stationsnummer;
SELECT ls.Stationsnummer, ls.Bezeichnung, COUNT(lv.idLadevorgang) AS ladevorgänge, SUM(lv.Kilowattstunden * t.PreisProStunde + t.Startgebühr) AS umsatz FROM ladevorgang lv JOIN tarif t ON lv.fkTarif = t.idTarif JOIN ladestation ls ON lv.fkLadestation = ls.Stationsnummer WHERE lv.Endzeit IS NOT NULL GROUP BY ls.Bezeichnung;

-- Alle momentan laufenden Ladevorgänge anzeigen.
-- case now: abfrage als korrekt dokumentieren aber testdaten als falsch angeben! sollte belegt sein nicht frei, hat aber keine endzeit also ist die abfrage korrekt
SELECT lv.idLadevorgang, lv.Startzeit, ls.Bezeichnung, ls.Status FROM ladevorgang lv JOIN ladestation ls ON lv.fkLadestation = ls.Stationsnummer WHERE lv.Endzeit IS NULL GROUP BY ls.Bezeichnung;

-- Den Gesamtumsatz pro Kunde berechnen.
SELECT k.Kundennummer , k.Vorname, k.Nachname, k.`E-Mail-Adresse`, SUM(lv.Kilowattstunden * t.PreisProStunde + t.Startgebühr) AS umsatzProKunde FROM ladevorgang lv JOIN kunde k ON lv.fkKunde = k.Kundennummer JOIN tarif t ON lv.fkTarif = t.idTarif WHERE lv.fkKunde = k.Kundennummer GROUP BY k.Kundennummer;

-- Ladestationen auch dann anzeigen, wenn noch kein Ladevorgang vorhanden ist.
SELECT ls.Stationsnummer, ls.Bezeichnung, ls.Status, COUNT(lv.idLadevorgang) AS ladevorgänge FROM ladevorgang lv RIGHT JOIN ladestation ls ON lv.fkLadestation = ls.Stationsnummer GROUP BY ls.Stationsnummer;

-- Den Kunden mit dem höchsten Gesamtumsatz anzeigen.
-- alle umsätze anzeigen und absteigend sortieren so dass der höchste ganz oben ist und das anzeige LIMIT auf 1 setzen, so zeigt es nur den höchsten
SELECT k.Vorname, k.Nachname, SUM(lv.Kilowattstunden * t.PreisProStunde + t.Startgebühr) AS umsatz FROM kunde k JOIN ladevorgang lv ON lv.fkKunde = k.Kundennummer JOIN tarif t ON lv.fkTarif = t.idTarif WHERE lv.Endzeit IS NOT NULL GROUP BY k.Kundennummer ORDER BY umsatz DESC LIMIT 1;