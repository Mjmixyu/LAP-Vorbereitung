SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- 1. Soziale Versicherung (Österreichische Beispiele)
INSERT INTO `patientenverwaltung`.`soziale_versicherung` (`soz_bezeichnung`) VALUES
('Österreichische Gesundheitskasse (ÖGK)'),
('BVAEB (Bundesverwaltungsagentur)'),
('SVS (Sozialversicherung der Selbständigen)'),
('Uniqa Krankenversicherung'),
('Wiener Städtische Krankenversicherung'),
('Allianz Private Krankenversicherung'),
('Generali Krankenversicherung'),
('Huk-Coburg Krankenversicherung'),
('Baxter Krankenversicherung'),
('Sparda Krankenversicherung');

-- 2. Arztpraxen
INSERT INTO `patientenverwaltung`.`arztpraxis` (`bezeichnung`) VALUES
('Praxis Dr. Müller'),
('Praxis Dr. Schmidt'),
('Zahnarztpraxis Dr. Maier'),
('Kardiologie Dr. Weber'),
('Orthopädie Dr. Fischer'),
('Allgemeinmedizin Dr. Schneider'),
('HNO Praxis Dr. Lang'),
('Dermatologie Dr. Schwarz'),
('Pädiatrie Dr. Berger'),
('Chirurgie Dr. Klein');

-- 3. Patienten (mit Referenzen auf Sozialversicherung und Arztpraxis)
INSERT INTO `patientenverwaltung`.`patient` (`vorname`, `nachname`, `geburtstag`, `soz_id`, `arztpraxis_id`, `svnr`) VALUES
('Max', 'Mustermann', '1990-05-10', 1, 1, 'SVNR123456789'),
('Anna', 'Schmidt', '1985-08-22', 2, 2, 'SVNR987654321'),
('Erika', 'Müller', '1978-12-01', 3, 3, 'SVNR112233445'),
('Peter', 'Weber', '1992-07-17', 4, 4, 'SVNR556677889'),
('Lena', 'Fischer', '1980-03-05', 5, 5, 'SVNR998877665'),
('Paul', 'Schneider', '1975-11-30', 6, 6, 'SVNR123123123'),
('Sophia', 'Lang', '1995-02-14', 7, 7, 'SVNR321321321'),
('David', 'Schwarz', '1982-01-26', 8, 8, 'SVNR654654654'),
('Julia', 'Meier', '1995-07-10', 9, 9, 'SVNR111222333'),
('Tom', 'Becker', '1987-04-20', 10, 10, 'SVNR444555666');

-- 4. Termine (mit Patientenreferenz)
INSERT INTO `patientenverwaltung`.`termin` (`datum`, `patient_id`, `status`) VALUES
('2024-11-15 10:00:00', 1, 'geplant'),
('2024-11-16 11:00:00', 2, 'abgeschlossen'),
('2024-11-17 14:30:00', 2, 'geplant'),
('2024-11-18 09:00:00', 3, 'abgeschlossen'),
('2024-11-19 16:00:00', 4, 'geplant'),
('2024-11-20 12:00:00', 4, 'abgeschlossen'),
('2024-11-21 15:00:00', 4, 'abgesagt'),
('2024-11-22 08:30:00', 5, 'geplant'),
('2024-11-23 09:30:00', 5, 'abgeschlossen'),
('2024-11-24 10:30:00', 5, 'geplant'),
('2024-11-25 11:00:00', 6, 'abgeschlossen'),
('2024-11-26 08:00:00', 7, 'geplant'),
('2024-11-27 10:00:00', 8, 'geplant'),
('2024-11-28 09:00:00', 9, 'geplant'),
('2024-11-29 14:00:00', 9, 'abgeschlossen'),
('2024-11-30 11:00:00', 10, 'geplant'),
('2024-12-01 13:00:00', 10, 'abgeschlossen');

-- 5. Befunde (mit Termin- und Patientenreferenz)
INSERT INTO `patientenverwaltung`.`befund` (`beschreibung`, `termin_id`, `patient_id`) VALUES
('Befund: Grippe', 1, 1),
('Befund: Rückenbeschwerden', 2, 2),
('Befund: Zahnentzündung', 3, 3),
('Befund: Herzuntersuchung normal', 4, 4),
('Befund: Allergische Reaktion', 5, 5),
('Befund: Bluthochdruck', 6, 6),
('Befund: HNO-Untersuchung normal', 7, 7),
('Befund: Hautuntersuchung unauffällig', 8, 8),
('Befund: Schwangerschaftstest positiv', 9, 9),
('Befund: Knieverletzung', 10, 10);

-- 6. Medikamente
INSERT INTO `patientenverwaltung`.`medikament` (`medikament_bezeichnung`) VALUES
('Ibuprofen'),
('Paracetamol'),
('Amoxicillin'),
('Ciprofloxacin'),
('Loratadin'),
('Amlodipin'),
('Metformin'),
('Pantoprazol'),
('Omeprazol'),
('Lorazepam'),
('Insulin'),
('Simvastatin');

-- 7. Befund-Medikament-Verordnungen (mit Dosierung)
INSERT INTO `patientenverwaltung`.`befund_has_medikament` (`befund_id`, `medikament_id`, `dosierung`) VALUES
(1, 1, '200mg zweimal täglich'),
(2, 2, '500mg alle 6 Stunden'),
(3, 3, 'Amoxicillin 250mg 3x täglich'),
(4, 4, '500mg Ciprofloxacin zweimal täglich'),
(5, 5, 'Loratadin 10mg täglich'),
(6, 6, 'Amlodipin 5mg täglich'),
(7, 7, 'Metformin 500mg zweimal täglich'),
(8, 8, 'Pantoprazol 20mg täglich'),
(9, 9, 'Omeprazol 20mg täglich'),
(10, 10, 'Lorazepam 1mg bei Bedarf'),
(11, 11, 'Insulin 10 Einheiten täglich'),
(12, 12, 'Simvastatin 20mg täglich');

-- SQL MODE zurücksetzen
SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
