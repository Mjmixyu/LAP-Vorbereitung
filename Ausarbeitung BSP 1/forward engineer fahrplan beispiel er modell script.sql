-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lap_fahrtplan
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lap_fahrtplan
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lap_fahrtplan` DEFAULT CHARACTER SET utf8 ;
USE `lap_fahrtplan` ;

-- -----------------------------------------------------
-- Table `lap_fahrtplan`.`Kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_fahrtplan`.`Kunde` (
  `idKunde` INT NOT NULL,
  `Vorname` VARCHAR(45) NULL,
  `Nachname` VARCHAR(45) NULL,
  `Anschrift` VARCHAR(45) NULL,
  `Telefonnumer` VARCHAR(20) NULL,
  `Email` VARCHAR(100) NULL,
  PRIMARY KEY (`idKunde`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_fahrtplan`.`Tarif`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_fahrtplan`.`Tarif` (
  `idTarif` INT NOT NULL,
  `Tarifbezeichnung` VARCHAR(45) NULL,
  `Tarifpreis` DECIMAL NULL,
  PRIMARY KEY (`idTarif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_fahrtplan`.`Haltestelle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_fahrtplan`.`Haltestelle` (
  `idHaltestelle` INT NOT NULL,
  `Bezeichnung` VARCHAR(45) NULL,
  PRIMARY KEY (`idHaltestelle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lap_fahrtplan`.`Fahrt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lap_fahrtplan`.`Fahrt` (
  `idFahrt` INT NOT NULL,
  `Fahrtantritt` DATETIME NULL,
  `Fahrtende` DATETIME NULL,
  `bezahlt` TINYINT NULL,
  `FK_idKunde` INT NULL,
  `FK_idTarif` INT NULL,
  `FK_idStarthaltestelle` INT NULL,
  `FK_idEndhaltestelle` INT NULL,
  PRIMARY KEY (`idFahrt`),
  INDEX `FK_idKunde_idx` (`FK_idKunde` ASC) VISIBLE,
  INDEX `FK_idTarif_idx` (`FK_idTarif` ASC) VISIBLE,
  INDEX `FK_idStarthaltestelle_idx` (`FK_idStarthaltestelle` ASC) VISIBLE,
  INDEX `FK_idEndhaltestelle_idx` (`FK_idEndhaltestelle` ASC) VISIBLE,
  CONSTRAINT `FK_idKunde`
    FOREIGN KEY (`FK_idKunde`)
    REFERENCES `lap_fahrtplan`.`Kunde` (`idKunde`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idTarif`
    FOREIGN KEY (`FK_idTarif`)
    REFERENCES `lap_fahrtplan`.`Tarif` (`idTarif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idStarthaltestelle`
    FOREIGN KEY (`FK_idStarthaltestelle`)
    REFERENCES `lap_fahrtplan`.`Haltestelle` (`idHaltestelle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_idEndhaltestelle`
    FOREIGN KEY (`FK_idEndhaltestelle`)
    REFERENCES `lap_fahrtplan`.`Haltestelle` (`idHaltestelle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
