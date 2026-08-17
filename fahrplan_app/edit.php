<?php
$editFahrt = null;

if (isset($_GET["edit"])) {
    $idFahrt = $_GET["edit"];

    $sql = "SELECT * FROM Fahrt WHERE idFahrt = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$idFahrt]);

    $editFahrt = $stmt->fetch(PDO::FETCH_ASSOC);
}
?>