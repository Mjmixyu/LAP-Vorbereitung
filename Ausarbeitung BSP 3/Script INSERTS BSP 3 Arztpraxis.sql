INSERT INTO arztpraxis (Bezeichnung, Standort, Telefonnummer) VALUES ("praxisName", "irgendwo", "0123456789");
INSERT INTO arztpraxis (Bezeichnung, Standort, Telefonnummer) VALUES ("neuePraxis", "ort", "987654321");
INSERT INTO arztpraxis (Bezeichnung, Standort, Telefonnummer) VALUES ("altePraxis", "stadt", "+142536987");

SELECT * FROM arztpraxis;

INSERT INTO sozialversicherung (Bezeichnung) VALUES ("ikennkanesv");
INSERT INTO sozialversicherung (Bezeichnung) VALUES ("woasined");
INSERT INTO sozialversicherung (Bezeichnung) VALUES ("weadnedkronkka");

SELECT * FROM sozialversicherung;

INSERT INTO medikament (Bezeichnung, Wirkstoff) VALUES ("meds", "duadwos");
INSERT INTO medikament (Bezeichnung, Wirkstoff) VALUES ("crazyStuff", "uuuuhh");
INSERT INTO medikament (Bezeichnung, Wirkstoff) VALUES ("lsd", "ka");

SELECT * FROM medikament;

INSERT INTO terminverlauf (Beschreibung, Status) VALUES ("checkup", "done");
INSERT INTO terminverlauf (Beschreibung, Status) VALUES ("new meds", "waiting");
INSERT INTO terminverlauf (Beschreibung, Status) VALUES ("op mocht ma ned in anan arztpraxis", "postponed");

SELECT * FROM terminverlauf;

INSERT INTO patient (Vorname, Nachname, Geburtsdatum, Telefonnummer, Wohnort, SVNummer, FK_idArztpraxis, FK_idSV) VALUES ("name", "nochaname", "2000-05-04", "+128596347", "irgendaort", "123", "1", "1");
INSERT INTO patient (Vorname, Nachname, Geburtsdatum, Telefonnummer, Wohnort, SVNummer, FK_idArztpraxis, FK_idSV) VALUES ("lisa", "stein", "1999-01-01", "+4366478956123", "berg", "170101", "3", "2");
INSERT INTO patient (Vorname, Nachname, Geburtsdatum, Telefonnummer, Wohnort, SVNummer, FK_idArztpraxis, FK_idSV) VALUES ("alex", "berg", "2003-05-05", "+987653214", "stadtLandFluss", "160505", "2", "2");
SELECT * FROM patient;

INSERT INTO termin (Datum, Uhrzeit, FK_idPatient, FK_idTerminverlauf) VALUES ("2026-06-06", "07:30", 1, 1);
INSERT INTO termin (Datum, Uhrzeit, FK_idPatient, FK_idTerminverlauf) VALUES ("2026-06-22", "13:30", 3, 2);
INSERT INTO termin (Datum, Uhrzeit, FK_idPatient, FK_idTerminverlauf) VALUES ("2026-06-17", "18:00", 2, 2);
SELECT * FROM termin;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM Befund_has_Medikament;
DELETE FROM Befund;

ALTER TABLE Befund_has_Medikament AUTO_INCREMENT = 1;
ALTER TABLE Befund AUTO_INCREMENT = 1;

SHOW CREATE TABLE befund;
ALTER TABLE befund DROP FOREIGN KEY FK_idPatient_Befund, DROP COLUMN Datum;
ALTER TABLE befund
DROP COLUMN FK_idPAtient;

INSERT INTO befund (Beschreibung, FK_idTermin) VALUES ("beschreibung", "2");
INSERT INTO befund (Beschreibung, FK_idTermin) VALUES ("hmm", "3");
INSERT INTO befund (Beschreibung, FK_idTermin) VALUES ("beschreibungNeu", "4");

SELECT * FROM befund;

INSERT INTO befund_has_medikament (FK_idBefund, FK_idMedikament, Dosis, Einnahmehinweis) VALUES ("1", "1", "einmal", "aufpassen");
INSERT INTO befund_has_medikament (FK_idBefund, FK_idMedikament, Dosis, Einnahmehinweis) VALUES ("3", "2", "mehrmals täglich", "passt scho");
INSERT INTO befund_has_medikament (FK_idBefund, FK_idMedikament, Dosis, Einnahmehinweis) VALUES ("2", "3", "nie", "nein");

SELECT * FROM befund_has_medikament;