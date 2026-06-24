SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema `patientenverwaltung`
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `patientenverwaltung` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `patientenverwaltung`;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`soziale_versicherung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`soziale_versicherung` (
  `soz_id` INT NOT NULL AUTO_INCREMENT,
  `soz_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`soz_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`arztpraxis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`arztpraxis` (
  `arztpraxis_id` INT NOT NULL AUTO_INCREMENT,
  `bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`arztpraxis_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`patient` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `vorname` VARCHAR(45) NOT NULL,
  `nachname` VARCHAR(45) NOT NULL,
  `geburtstag` DATE NOT NULL,
  `soz_id` INT NOT NULL,
  `arztpraxis_id` INT NOT NULL,
  `svnr` VARCHAR(45) NOT NULL UNIQUE,  -- Sozialversicherungsnummer muss eindeutig sein
  PRIMARY KEY (`patient_id`),
  CONSTRAINT `fk_patient_soziale_versicherung`
    FOREIGN KEY (`soz_id`)
    REFERENCES `patientenverwaltung`.`soziale_versicherung` (`soz_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_patient_arztpraxis`
    FOREIGN KEY (`arztpraxis_id`)
    REFERENCES `patientenverwaltung`.`arztpraxis` (`arztpraxis_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`termin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`termin` (
  `termin_id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATETIME NOT NULL,
  `patient_id` INT NOT NULL,  -- Verknüpft Termin mit einem Patienten
  `status` ENUM('geplant', 'abgeschlossen', 'abgesagt') NOT NULL DEFAULT 'geplant',  -- Terminstatus hinzugefügt
  PRIMARY KEY (`termin_id`),
  CONSTRAINT `fk_termin_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patientenverwaltung`.`patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`befund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`befund` (
  `befund_id` INT NOT NULL AUTO_INCREMENT,
  `beschreibung` VARCHAR(145) NOT NULL,
  `termin_id` INT NOT NULL,  -- Verknüpft Befund mit einem Termin
  `patient_id` INT NOT NULL,  -- Verknüpft Befund auch mit einem Patienten (optional, da bereits durch Termin vorhanden)
  PRIMARY KEY (`befund_id`),
  CONSTRAINT `fk_befund_termin`
    FOREIGN KEY (`termin_id`)
    REFERENCES `patientenverwaltung`.`termin` (`termin_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_befund_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patientenverwaltung`.`patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`medikament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`medikament` (
  `medikament_id` INT NOT NULL AUTO_INCREMENT,
  `medikament_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`medikament_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patientenverwaltung`.`befund_has_medikament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patientenverwaltung`.`befund_has_medikament` (
  `befund_id` INT NOT NULL,
  `medikament_id` INT NOT NULL,
  `dosierung` VARCHAR(45) NULL,
  PRIMARY KEY (`befund_id`, `medikament_id`),
  CONSTRAINT `fk_befund_medikament`
    FOREIGN KEY (`befund_id`)
    REFERENCES `patientenverwaltung`.`befund` (`befund_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_medikament_befund`
    FOREIGN KEY (`medikament_id`)
    REFERENCES `patientenverwaltung`.`medikament` (`medikament_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Indexe hinzufügen
-- -----------------------------------------------------
CREATE INDEX idx_patient_svnr ON `patientenverwaltung`.`patient`(`svnr`);
CREATE INDEX idx_patient_arztpraxis ON `patientenverwaltung`.`patient`(`arztpraxis_id`);
CREATE INDEX idx_termin_patient ON `patientenverwaltung`.`termin`(`patient_id`);
CREATE INDEX idx_befund_termin ON `patientenverwaltung`.`befund`(`termin_id`);

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
