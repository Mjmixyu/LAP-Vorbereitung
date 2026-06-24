-- Neue Tabelle `verkauf` hinzufügen, um Kundenkäufe zu dokumentieren
CREATE TABLE IF NOT EXISTS `verkauf` (
  `verkauf_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `kunde_id` INT UNSIGNED NOT NULL,
  `modell_id` INT UNSIGNED NOT NULL,
  `kaufdatum` DATE NOT NULL,
  PRIMARY KEY (`verkauf_id`),
  FOREIGN KEY (`kunde_id`) REFERENCES `kunde`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`modell_id`) REFERENCES `modell`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Beispiel-Daten für die `verkauf`-Tabelle
INSERT INTO `verkauf` (`kunde_id`, `modell_id`, `kaufdatum`) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-02-10'),
(3, 3, '2024-03-05'),
(4, 4, '2024-04-20'),
(5, 5, '2024-05-25');


-- Abfrage, die zeigt, welcher Kunde welches Handy gekauft hat
SELECT 
    k.vorname AS Kunde_Vorname,
    k.nachname AS Kunde_Nachname,
    k.email AS Kunde_Email,
    m.name AS Handy_Modell,
    h.hersteller AS Hersteller,
    v.kaufdatum AS Kaufdatum
FROM 
    verkauf v
JOIN 
    kunde k ON v.kunde_id = k.id
JOIN 
    modell m ON v.modell_id = m.id
JOIN 
    hersteller h ON m.hersteller_id = h.id;
