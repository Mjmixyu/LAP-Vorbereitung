<?php
// Daten für Dropdowns laden
$kunden = $conn->query(
    "SELECT * FROM Kunde ORDER BY nachname"
)->fetchAll(PDO::FETCH_ASSOC);

$haltestellen = $conn->query(
    "SELECT * FROM Haltestelle ORDER BY bezeichnung"
)->fetchAll(PDO::FETCH_ASSOC);

$tarife = $conn->query(
    "SELECT * FROM Tarif ORDER BY bezeichnung"
)->fetchAll(PDO::FETCH_ASSOC);

// Filterwerte aus URL holen
$search = $_GET["search"] ?? "";
$tarifFilter = $_GET["tarif"] ?? "";

// Fahrten mit benötigten Daten laden
$sql = "SELECT
            Fahrt.*,
            Kunde.vorname,
            Kunde.nachname,
            Kunde.email,
            StartHaltestelle.bezeichnung AS startHaltestelle,
            EndHaltestelle.bezeichnung AS endHaltestelle,
            Tarif.bezeichnung AS tarifBezeichnung,
            Tarif.preis
        FROM Fahrt
        INNER JOIN Kunde
            ON Fahrt.FK_idKunde = Kunde.idKunde
        INNER JOIN Haltestelle AS StartHaltestelle
            ON Fahrt.FK_idStarthaltestelle = StartHaltestelle.idHaltestelle
        INNER JOIN Haltestelle AS EndHaltestelle
            ON Fahrt.FK_idEndhaltestelle = EndHaltestelle.idHaltestelle
        INNER JOIN Tarif
            ON Fahrt.FK_idTarif = Tarif.idTarif
        WHERE 1 = 1";

$params = [];

// Suchleiste
if ($search != "") {
    $sql .= " AND (
                Kunde.vorname LIKE ?
                OR Kunde.nachname LIKE ?
                OR Kunde.email LIKE ?
                OR StartHaltestelle.bezeichnung LIKE ?
                OR EndHaltestelle.bezeichnung LIKE ?
                OR Tarif.bezeichnung LIKE ?
              )";

    $searchValue = "%" . $search . "%";

    $params[] = $searchValue;
    $params[] = $searchValue;
    $params[] = $searchValue;
    $params[] = $searchValue;
    $params[] = $searchValue;
    $params[] = $searchValue;
}

// Tarif Dropdown Filter
if ($tarifFilter != "") {
    $sql .= " AND Fahrt.FK_idTarif = ?";
    $params[] = $tarifFilter;
}

$sql .= " ORDER BY Fahrt.idFahrt DESC";

$stmt = $conn->prepare($sql);
$stmt->execute($params);

$fahrten = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>