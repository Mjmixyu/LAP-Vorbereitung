<?php

include_once('datenbank.php');

//id aus versteckten formfeld holen udn andere eingegebene daten holen
$idKunde = $_POST['idKunde'] ?? '';
$vorname = $_POST['vorname'] ?? '';
$nachname = $_POST['nachname'] ?? '';
$email = $_POST['email'] ?? '';

//wenn eine valide id gefunden wurde
if ($idKunde !== '') {

//update sql script mit insert von den eingegebenen daten placeholdern
    $sql = "UPDATE kunde
            SET vorname = :vorname,
                nachname = :nachname,
                email = :email
            WHERE idKunde = :idKunde";

    $stmt = $conn->prepare($sql);

    //daten mitgeben
    $stmt->execute([
        'vorname' => $vorname,
        'nachname' => $nachname,
        'email' => $email,
        'idKunde' => $idKunde
    ]);
}

//redirect zur main page mit reload um üänderungen zu zeigen
header("Location: index.php");
exit();