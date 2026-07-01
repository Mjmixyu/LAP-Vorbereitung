-- insert statemenmt of all attributes besides PK_id since it is auto increment
INSERT INTO kunde (vorname, nachname, email) VALUES ("lisa", "steiner", "lsteiner@test.com");
INSERT INTO kunde (vorname, nachname, email) VALUES ("alex", "berger", "aberger@test.com");
INSERT INTO kunde (vorname, nachname, email) VALUES ("marie", "nachname", "mnachname@test.com");

-- simple select statement to check if data has been correctly added with insert statement
SELECT * FROM kunde;

INSERT INTO tarif (bezeichnung, preis) VALUES ("senior", "12.2");
INSERT INTO tarif (bezeichnung, preis) VALUES ("schüler", "13.5");
INSERT INTO tarif (bezeichnung, preis) VALUES ("regulär", "15");

SELECT * FROM tarif;

INSERT INTO ort (PLZ, ortsname) VALUES ("5500", "Bischofshofen");
INSERT INTO ort (PLZ, ortsname) VALUES ("5020", "Salzburg");
INSERT INTO ort (PLZ, ortsname) VALUES ("5600", "St Johann");

SELECT * FROM ort;

INSERT INTO adresse (strasse, hausnummer, FK_PLZ, FK_idKunde) VALUES ("steggasse", "12", "5500", "1");
INSERT INTO adresse (strasse, hausnummer, FK_PLZ, FK_idKunde) VALUES ("salzburgerstraße", "3", "5020", "2");
INSERT INTO adresse (strasse, hausnummer, FK_PLZ, FK_idKunde) VALUES ("eurofunkstraße", "1", "5600", "3");

SELECT * FROM adresse;

INSERT INTO haltestelle (bezeichnung, FK_idAdresse) VALUES ("post", "1");
INSERT INTO haltestelle (bezeichnung, FK_idAdresse) VALUES ("amt", "2");
INSERT INTO haltestelle (bezeichnung, FK_idAdresse) VALUES ("arbeit", "3");

SELECT * FROM haltestelle;

INSERT INTO fahrt (fahrtbezahlt, startzeit, endzeit, FK_idKunde, FK_idStarthaltestelle, FK_idTarif, FK_idEndhaltestelle) VALUES ("1", "2026-06-12 06:30:00", "2026-06-12 06:50:00", "1", "1", "1", "2");
INSERT INTO fahrt (fahrtbezahlt, startzeit, endzeit, FK_idKunde, FK_idStarthaltestelle, FK_idTarif, FK_idEndhaltestelle) VALUES ("1", "2026-06-12 06:30:00", "2026-06-12 06:50:00", "2", "2", "2", "3");
INSERT INTO fahrt (fahrtbezahlt, startzeit, endzeit, FK_idKunde, FK_idStarthaltestelle, FK_idTarif, FK_idEndhaltestelle) VALUES ("1", "2026-06-12 06:30:00", "2026-06-12 06:50:00", "3", "1", "3", "3");

SELECT * FROM fahrt;