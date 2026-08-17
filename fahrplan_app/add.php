<?php
if (isset($_POST["add"])) {
    $fahrtbezahlt = isset($_POST["fahrtbezahlt"]) ? 1 : 0;
    $startzeit = $_POST["startzeit"];
    $endzeit = $_POST["endzeit"];
    $FK_idKunde = $_POST["FK_idKunde"];
    $FK_idStarthaltestelle = $_POST["FK_idStarthaltestelle"];
    $FK_idTarif = $_POST["FK_idTarif"];
    $FK_idEndhaltestelle = $_POST["FK_idEndhaltestelle"];

    $sql = "INSERT INTO Fahrt
            (fahrtbezahlt, startzeit, endzeit, FK_idKunde, FK_idStarthaltestelle, FK_idTarif, FK_idEndhaltestelle)
            VALUES (?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    $stmt->execute([
        $fahrtbezahlt,
        $startzeit,
        $endzeit,
        $FK_idKunde,
        $FK_idStarthaltestelle,
        $FK_idTarif,
        $FK_idEndhaltestelle
    ]);

    header("Location: index.php");
    exit;
}
?>