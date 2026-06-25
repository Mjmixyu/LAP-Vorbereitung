-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lap_patientenverwaltung
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lap_patientenverwaltung
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lap_patientenverwaltung` DEFAULT CHARACTER SET utf8 ;
USE `lap_patientenverwaltung` ;

-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Arztpraxis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Arztpraxis` (
  `idArztpraxis` INT NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(45) NULL,
  `Standort` VARCHAR(45) NULL,
  `Telefonnummer` VARCHAR(20) NULL,
  PRIMARY KEY (`idArztpraxis`),
  UNIQUE INDEX `Telefonnummer_UNIQUE` (`Telefonnummer` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Sozialversicherung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Sozialversicherung` (
  `idSozialversicherung` INT NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(45) NULL,
  PRIMARY KEY (`idSozialversicherung`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Patient` (
  `idPatient` INT NOT NULL AUTO_INCREMENT,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `Geburtsdatum` DATE NULL,
  `Telefonnummer` VARCHAR(20) NULL,
  `Wohnort` VARCHAR(45) NULL,
  `SVNummer` VARCHAR(20) NOT NULL,
  `FK_idArztpraxis` INT NULL,
  `FK_idSV` INT NULL,
  PRIMARY KEY (`idPatient`),
  UNIQUE INDEX `Telefonnummer_UNIQUE` (`Telefonnummer` ASC),
  UNIQUE INDEX `SVNummer_UNIQUE` (`SVNummer` ASC),
  INDEX `idArztpraxis_idx` (`FK_idArztpraxis` ASC),
  INDEX `idSV_idx` (`FK_idSV` ASC),
  CONSTRAINT `FK_idArztpraxis`
    FOREIGN KEY (`FK_idArztpraxis`)
    REFERENCES `lap_patientenverwaltung`.`Arztpraxis` (`idArztpraxis`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idSV`
    FOREIGN KEY (`FK_idSV`)
    REFERENCES `lap_patientenverwaltung`.`Sozialversicherung` (`idSozialversicherung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Terminverlauf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Terminverlauf` (
  `idTerminverlauf` INT NOT NULL AUTO_INCREMENT,
  `Beschreibung` TEXT NULL,
  `Status` VARCHAR(20) NULL,
  PRIMARY KEY (`idTerminverlauf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Termin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Termin` (
  `idTermin` INT NOT NULL AUTO_INCREMENT,
  `Datum` DATE NULL,
  `Uhrzeit` TIME NULL,
  `FK_idPatient` INT NULL,
  `FK_idTerminverlauf` INT NULL,
  PRIMARY KEY (`idTermin`),
  INDEX `idPAtient_idx` (`FK_idPatient` ASC),
  INDEX `idTerminverlauf_idx` (`FK_idTerminverlauf` ASC),
  CONSTRAINT `FK_idPatient`
    FOREIGN KEY (`FK_idPatient`)
    REFERENCES `lap_patientenverwaltung`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idTerminverlauf`
    FOREIGN KEY (`FK_idTerminverlauf`)
    REFERENCES `lap_patientenverwaltung`.`Terminverlauf` (`idTerminverlauf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Befund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Befund` (
  `idBefund` INT NOT NULL AUTO_INCREMENT,
  `Beschreibung` VARCHAR(45) NULL,
  `Datum` DATE NULL,
  `FK_idPAtient` INT NULL,
  `FK_idTermin` INT NULL,
  PRIMARY KEY (`idBefund`),
  INDEX `idPatient_idx` (`FK_idPAtient` ASC),
  INDEX `idTermin_idx` (`FK_idTermin` ASC),
  CONSTRAINT `FK_idPatient_Befund`
    FOREIGN KEY (`FK_idPAtient`)
    REFERENCES `lap_patientenverwaltung`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idTermin`
    FOREIGN KEY (`FK_idTermin`)
    REFERENCES `lap_patientenverwaltung`.`Termin` (`idTermin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Medikament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Medikament` (
  `idMedikament` INT NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(45) NULL,
  `Wirkstoff` VARCHAR(45) NULL,
  PRIMARY KEY (`idMedikament`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_patientenverwaltung`.`Befund_has_Medikament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_patientenverwaltung`.`Befund_has_Medikament` (
  `idBefundMedikament` INT NOT NULL AUTO_INCREMENT,
  `FK_idBefund` INT NULL,
  `FK_idMedikament` INT NULL,
  `Dosis` VARCHAR(45) NULL,
  `Einnahmehinweis` VARCHAR(45) NULL,
  PRIMARY KEY (`idBefundMedikament`),
  INDEX `idBefund_idx` (`FK_idBefund` ASC),
  INDEX `idMedikament_idx` (`FK_idMedikament` ASC),
  CONSTRAINT `FK_idBefund`
    FOREIGN KEY (`FK_idBefund`)
    REFERENCES `lap_patientenverwaltung`.`Befund` (`idBefund`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idMedikament`
    FOREIGN KEY (`FK_idMedikament`)
    REFERENCES `lap_patientenverwaltung`.`Medikament` (`idMedikament`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
