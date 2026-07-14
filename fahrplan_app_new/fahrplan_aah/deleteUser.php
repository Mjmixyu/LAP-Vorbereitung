<?php
include_once('datenbank.php');

$idKunde = $_POST['idKunde'];
$sql = $conn->prepare("DELETE FROM kunde WHERE idKunde = " . $idKunde);
$sql->execute();

header("Location: index.php");
exit();
