INSERT INTO kunde (Vorname, Nachname, Anschrift, Telefonnumer, Email) VALUES ("vani", "name", "wohnt", "01234889977", "email@validemail.com");
INSERT INTO kunde (Vorname, Nachname, Anschrift, Telefonnumer, Email) VALUES ("person", "ohnename", "lebt", "+12654987", "email@weirdemail.com");
INSERT INTO kunde (Vorname, Nachname, Anschrift, Telefonnumer, Email) VALUES ("who", "why", "where", "0321/457896", "test@nothing.com");

SELECT * FROM fahrt;

ALTER TABLE kunde
MODIFY idKunde INT NOT NULL AUTO_INCREMENT;

INSERT INTO tarif (Tarifbezeichnung, Tarifpreis) VALUES ("guteTarif", "3000.2€");
INSERT INTO tarif (Tarifbezeichnung, Tarifpreis) VALUES ("schlechteTarif", "3€");
INSERT INTO tarif (Tarifbezeichnung, Tarifpreis) VALUES ("eh", "15.49");

DELETE FROM tarif
WHERE idTarif IN (12);

ALTER TABLE tarif MODIFY Tarifpreis DECIMAL(10,2);

DELETE FROM fahrt
WHERE idFahrt > 0;
ALTER TABLE fahrt AUTO_INCREMENT = 1;

INSERT INTO haltestelle (Bezeichnung) VALUES ("mirfoidnixein");
INSERT INTO haltestelle (Bezeichnung) VALUES ("nedsoschönhier");
INSERT INTO haltestelle (Bezeichnung) VALUES ("wiesowillmadahin");

INSERT INTO fahrt (Fahrtantritt, Fahrtende, bezahlt, FK_idKunde, FK_idTarif, FK_idStarthaltestelle, FK_idEndhaltestelle) VALUES ("2026-06-12 06:30:00", "2026-06-12 08:30:00", "1", "1", "2", "1", "2");
INSERT INTO fahrt (Fahrtantritt, Fahrtende, bezahlt, FK_idKunde, FK_idTarif, FK_idStarthaltestelle, FK_idEndhaltestelle) VALUES ("2025-06-12 06:30:00", "2026-06-12 08:30:00", "0", "3", "3", "2", "2");
INSERT INTO fahrt (Fahrtantritt, Fahrtende, bezahlt, FK_idKunde, FK_idTarif, FK_idStarthaltestelle, FK_idEndhaltestelle) VALUES ("2026-04-03 06:20:00", "2026-04-03 014:30:00", "1", "2", "1", "1", "3");

