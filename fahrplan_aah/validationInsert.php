<?php
include_once('datenbank.php');
$vorname = $nachname = $email = '';
$nameErr = $emailErr = $nachnameErr = "";

$vorname = htmlspecialchars($_POST['vorname']);
$nachname = htmlspecialchars($_POST['nachname']);
$email = htmlspecialchars($_POST['email']);

if ($vorname !== '' ?? $nachname !== '' ?? $email !== '') {
    $inserftSql = "INSERT INTO kunde (vorname, nachname, email) VALUES (:vorname, :nachname, :email)";
    if ($insert = $conn->prepare($inserftSql)) {
        $insert->execute(['vorname' => $vorname, 'nachname' => $nachname, 'email' => $email]);
    }

    header("Location: index.php");
    exit();
}
