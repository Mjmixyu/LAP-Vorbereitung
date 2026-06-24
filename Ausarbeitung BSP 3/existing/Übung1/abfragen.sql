-- finden sie Patienten die mehr als 2 Termine haben
SELECT 
    p.vorname, 
    p.nachname, 
    COUNT(t.termin_id) AS Anzahl_Termine
FROM 
    patientenverwaltung.patient p
JOIN 
    patientenverwaltung.termin t ON p.patient_id = t.patient_id
GROUP BY 
    p.patient_id
HAVING 
    COUNT(t.termin_id) > 2;
	
-- Anzahl der Befunde pro Patienten mit Beschreibung, midestens 1 Befund
SELECT 
    p.vorname, 
    p.nachname, 
    b.beschreibung AS befund_beschreibung,
    COUNT(b.befund_id) AS anzahl_befunde
FROM 
    patientenverwaltung.patient p
JOIN 
    patientenverwaltung.befund b ON p.patient_id = b.patient_id
GROUP BY 
    p.patient_id, b.beschreibung
HAVING 
    COUNT(b.befund_id) >= 1;
	
-- Welche Patienten haben im letzten Jahr mehr als einen Termin gehabt, bei dem ein Medikament verschrieben wurde? Zeigen Sie die Anzahl der Termine, die Medikamente, die verschrieben wurden, und die Anzahl der Befunde an
SELECT 
    p.vorname,
    p.nachname,
    COUNT(DISTINCT t.termin_id) AS anzahl_termine,  -- Anzahl der Termine
    GROUP_CONCAT(DISTINCT m.medikament_bezeichnung) AS verschriebene_medikamente,  -- Alle verschriebenen Medikamente
    COUNT(DISTINCT b.befund_id) AS anzahl_befunde  -- Anzahl der Befunde
FROM 
    patientenverwaltung.patient p
JOIN 
    patientenverwaltung.termin t ON p.patient_id = t.patient_id
JOIN 
    patientenverwaltung.befund b ON t.termin_id = b.termin_id
JOIN 
    patientenverwaltung.befund_has_medikament bhm ON b.befund_id = bhm.befund_id
JOIN 
    patientenverwaltung.medikament m ON bhm.medikament_id = m.medikament_id
WHERE 
    t.datum BETWEEN '2024-11-01' AND '2024-12-31'  -- Zeitraum: November und Dezember 2024
GROUP BY 
    p.patient_id
HAVING 
    COUNT(DISTINCT b.befund_id) >= 1  -- mindestens ein Befund pro Patient
ORDER BY 
    anzahl_termine DESC;  -- Sortierung nach der Anzahl der Termine
