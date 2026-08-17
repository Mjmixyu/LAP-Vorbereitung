<?php
if (isset($_GET["delete"])) {
    $idFahrt = $_GET["delete"];

    $sql = "DELETE FROM Fahrt WHERE idFahrt = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$idFahrt]);

    header("Location: index.php");
    exit;
}
?>