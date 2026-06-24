-- Schema: smartphone
CREATE SCHEMA IF NOT EXISTS `smartphone` DEFAULT CHARACTER SET utf8mb4;
USE `smartphone`;

-- -----------------------------------------------------
-- Tabelle `smartphone`.`hersteller`
-- -----------------------------------------------------
CREATE table IF NOT EXISTS `hersteller` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `hersteller` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Einfügen der Daten für `hersteller`
INSERT INTO `hersteller` (`hersteller`, `email`) VALUES
('Samsung', 'support@samsung.com'),
('Apple', 'support@apple.com'),
('Huawei', 'support@huawei.com'),
('Xiaomi', 'support@xiaomi.com'),
('OnePlus', 'support@oneplus.com');

-- -----------------------------------------------------
-- Tabelle `smartphone`.`modell`
-- -----------------------------------------------------
CREATE table IF NOT EXISTS `modell` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `display` VARCHAR(20) NOT NULL,
  `akku` VARCHAR(10) NOT NULL,
  `prozessor` VARCHAR(45) NOT NULL,
  `ram` VARCHAR(10) NOT NULL,
  `kamera` VARCHAR(45) NOT NULL,
  `hersteller_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`hersteller_id`) REFERENCES `hersteller`(`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Einfügen der Daten für `modell`
INSERT INTO `modell` (`name`, `display`, `akku`, `prozessor`, `ram`, `kamera`, `hersteller_id`) VALUES
('Galaxy S21', '6.2"', '4000mAh', 'Exynos 2100', '8GB', '64MP', 1),
('iPhone 13', '6.1"', '3240mAh', 'A15 Bionic', '4GB', '12MP', 2),
('P40 Pro', '6.58"', '4200mAh', 'Kirin 990', '8GB', '50MP', 3),
('Mi 11', '6.81"', '4600mAh', 'Snapdragon 888', '8GB', '108MP', 4),
('OnePlus 9', '6.55"', '4500mAh', 'Snapdragon 888', '8GB', '48MP', 5);

-- -----------------------------------------------------
-- Tabelle `smartphone`.`feature`
-- -----------------------------------------------------
CREATE table IF NOT EXISTS `feature` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `feature_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Einfügen der Daten für `feature`
INSERT INTO `feature` (`feature_name`) VALUES
('5G Support'),
('Wireless Charging'),
('Water Resistant'),
('Dual SIM'),
('Face Recognition');

-- -----------------------------------------------------
-- Tabelle `smartphone`.`modell_feature` (für Many-to-Many Beziehung)
-- -----------------------------------------------------
CREATE table IF NOT EXISTS `modell_feature` (
  `modell_id` INT UNSIGNED NOT NULL,
  `feature_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`modell_id`, `feature_id`),
  FOREIGN KEY (`modell_id`) REFERENCES `modell`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`feature_id`) REFERENCES `feature`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Einfügen der Daten für `modell_feature`
INSERT INTO `modell_feature` (`modell_id`, `feature_id`) VALUES
(1, 1), (1, 2), (2, 1), (2, 5),
(3, 1), (3, 3), (4, 1), (4, 4),
(5, 1), (5, 3);

-- -----------------------------------------------------
-- Tabelle `smartphone`.`kunde`
-- -----------------------------------------------------
CREATE table IF NOT EXISTS `kunde` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `vorname` VARCHAR(45) NOT NULL,
  `nachname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `telefon` VARCHAR(20),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

-- Einfügen der Daten für `kunde`
INSERT INTO `kunde` (`vorname`, `nachname`, `email`, `telefon`) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321'),
('Robert', 'Brown', 'robert.brown@example.com', '1122334455'),
('Emily', 'Johnson', 'emily.johnson@example.com', '2233445566'),
('Michael', 'Davis', 'michael.davis@example.com', '3344556677');

-- -----------------------------------------------------
-- Überprüfen
-- -----------------------------------------------------
-- Anzeigen der Daten für `hersteller`
SELECT * FROM `hersteller`;

-- Anzeigen der Daten für `modell`
SELECT * FROM `modell`;

-- Anzeigen der Daten für `feature`
SELECT * FROM `feature`;

-- Anzeigen der Daten für `modell_feature`
SELECT * FROM `modell_feature`;

-- Anzeigen der Daten für `kunde`
SELECT * FROM `kunde`;
