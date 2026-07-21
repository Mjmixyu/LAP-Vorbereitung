-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ladestationenUWU
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ladestationenUWU
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ladestationenUWU` DEFAULT CHARACTER SET utf8 ;
USE `ladestationenUWU` ;

-- -----------------------------------------------------
-- Table `ladestationenUWU`.`Kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ladestationenUWU`.`Kunde` (
  `Kundennummer` INT NOT NULL AUTO_INCREMENT,
  `Vorname` VARCHAR(45) NOT NULL,
  `Nachname` VARCHAR(45) NOT NULL,
  `E-Mail-Adresse` VARCHAR(45) NOT NULL,
  `Telefonnummer` VARCHAR(45) NULL,
  `Registrierungsdatum` DATE NOT NULL,
  PRIMARY KEY (`Kundennummer`),
  UNIQUE INDEX `E-Mail-Adresse_UNIQUE` (`E-Mail-Adresse` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ladestationenUWU`.`Ladestation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ladestationenUWU`.`Ladestation` (
  `Stationsnummer` INT NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(45) NOT NULL,
  `Straße` VARCHAR(45) NOT NULL,
  `Hausnummer` INT NOT NULL,
  `Postleitzahl` VARCHAR(45) NOT NULL,
  `Ort` VARCHAR(45) NOT NULL,
  `Ladeleistung` DOUBLE NOT NULL,
  `Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Stationsnummer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ladestationenUWU`.`Tarif`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ladestationenUWU`.`Tarif` (
  `idTarif` INT NOT NULL AUTO_INCREMENT,
  `PreisProStunde` DOUBLE NOT NULL,
  `Startgebühr` DOUBLE NOT NULL,
  `aktiv` TINYINT NOT NULL,
  PRIMARY KEY (`idTarif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ladestationenUWU`.`Ladevorgang`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ladestationenUWU`.`Ladevorgang` (
  `idLadevorgang` INT NOT NULL AUTO_INCREMENT,
  `Startzeit` DATETIME NOT NULL,
  `Endzeit` DATETIME NULL,
  `Kilowattstunden` DECIMAL(8,2) NOT NULL DEFAULT 0,
  `fkKunde` INT NOT NULL,
  `fkLadestation` INT NOT NULL,
  `fkTarif` INT NOT NULL,
  PRIMARY KEY (`idLadevorgang`),
  INDEX `fk_ladevorgang_kunde_idx` (`fkKunde` ASC),
  INDEX `fk_ladevorgang_ladestation_idx` (`fkLadestation` ASC),
  INDEX `fk_ladevorgang_tarif_idx` (`fkTarif` ASC),
  CONSTRAINT `fk_ladevorgang_kunde`
    FOREIGN KEY (`fkKunde`)
    REFERENCES `ladestationenUWU`.`Kunde` (`Kundennummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ladevorgang_ladestation`
    FOREIGN KEY (`fkLadestation`)
    REFERENCES `ladestationenUWU`.`Ladestation` (`Stationsnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ladevorgang_tarif`
    FOREIGN KEY (`fkTarif`)
    REFERENCES `ladestationenUWU`.`Tarif` (`idTarif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
