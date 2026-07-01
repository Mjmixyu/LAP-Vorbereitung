-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fahrplan_app
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fahrplan_app
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fahrplan_app` DEFAULT CHARACTER SET utf8 ;
USE `fahrplan_app` ;

-- -----------------------------------------------------
-- Table `fahrplan_app`.`Ort`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Ort` (
  `PLZ` INT NOT NULL,
  `ortsname` VARCHAR(45) NULL,
  PRIMARY KEY (`PLZ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fahrplan_app`.`Kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Kunde` (
  `idKunde` INT NOT NULL AUTO_INCREMENT,
  `vorname` VARCHAR(45) NULL,
  `nachname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idKunde`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fahrplan_app`.`Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Adresse` (
  `idAdresse` INT NOT NULL AUTO_INCREMENT,
  `strasse` VARCHAR(45) NULL,
  `hausnummer` INT NULL,
  `FK_PLZ` INT NOT NULL,
  `FK_idKunde` INT NULL,
  PRIMARY KEY (`idAdresse`),
  INDEX `FK_PLZ_idx` (`FK_PLZ` ASC),
  INDEX `FK_idKunde_idx` (`FK_idKunde` ASC),
  CONSTRAINT `FK_PLZ`
    FOREIGN KEY (`FK_PLZ`)
    REFERENCES `fahrplan_app`.`Ort` (`PLZ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idKunde`
    FOREIGN KEY (`FK_idKunde`)
    REFERENCES `fahrplan_app`.`Kunde` (`idKunde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fahrplan_app`.`Tarif`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Tarif` (
  `idTarif` INT NOT NULL AUTO_INCREMENT,
  `bezeichnung` VARCHAR(45) NULL,
  `preis` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idTarif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fahrplan_app`.`Haltestelle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Haltestelle` (
  `idHaltestelle` INT NOT NULL AUTO_INCREMENT,
  `bezeichnung` VARCHAR(45) NULL,
  `FK_idAdresse` INT NULL,
  PRIMARY KEY (`idHaltestelle`),
  INDEX `FK_idAdresse_idx` (`FK_idAdresse` ASC),
  CONSTRAINT `FK_idAdresse`
    FOREIGN KEY (`FK_idAdresse`)
    REFERENCES `fahrplan_app`.`Adresse` (`idAdresse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fahrplan_app`.`Fahrt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Fahrt` (
  `idFahrt` INT NOT NULL AUTO_INCREMENT,
  `fahrtbezahlt` TINYINT NULL,
  `startzeit` DATETIME NULL,
  `endzeit` DATETIME NULL,
  `FK_idKunde` INT NULL,
  `FK_idStarthaltestelle` INT NULL,
  `FK_idTarif` INT NULL,
  `FK_idEndhaltestelle` INT NULL,
  PRIMARY KEY (`idFahrt`),
  INDEX `FK_idKunde_idx` (`FK_idKunde` ASC),
  INDEX `FK_idTarif_idx` (`FK_idTarif` ASC),
  INDEX `FK_idStarthaltestelle_idx` (`FK_idStarthaltestelle` ASC),
  INDEX `FK_idEndhaltestelle_idx` (`FK_idEndhaltestelle` ASC),
  CONSTRAINT `FK_idKundeFahrt`
    FOREIGN KEY (`FK_idKunde`)
    REFERENCES `fahrplan_app`.`Kunde` (`idKunde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idTarif`
    FOREIGN KEY (`FK_idTarif`)
    REFERENCES `fahrplan_app`.`Tarif` (`idTarif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idStarthaltestelle`
    FOREIGN KEY (`FK_idStarthaltestelle`)
    REFERENCES `fahrplan_app`.`Haltestelle` (`idHaltestelle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idEndhaltestelle`
    FOREIGN KEY (`FK_idEndhaltestelle`)
    REFERENCES `fahrplan_app`.`Haltestelle` (`idHaltestelle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fahrplan_app`.`Kunde_Haltestelle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fahrplan_app`.`Kunde_Haltestelle` (
  `FK_idKunde` INT NOT NULL,
  `FK_idHaltestelle` INT NOT NULL,
  PRIMARY KEY (`FK_idKunde`, `FK_idHaltestelle`),
  INDEX `FK_idHaltestelle_idx` (`FK_idHaltestelle` ASC),
  CONSTRAINT `FK_idKundeFuerHaltestele`
    FOREIGN KEY (`FK_idKunde`)
    REFERENCES `fahrplan_app`.`Kunde` (`idKunde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idHaltestelle`
    FOREIGN KEY (`FK_idHaltestelle`)
    REFERENCES `fahrplan_app`.`Haltestelle` (`idHaltestelle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
