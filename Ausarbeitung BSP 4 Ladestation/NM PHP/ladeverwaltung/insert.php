<?php

include_once('db.php');

// Formulardaten auslesen
$kunde = isset($_POST['kunde'])
    ? (int) $_POST['kunde']
    : 0;

$ladestation = isset($_POST['ladestation'])
    ? (int) $_POST['ladestation']
    : 0;

$tarif = isset($_POST['tarif'])
    ? (int) $_POST['tarif']
    : 0;

// Fehlermeldungen sammeln
$fehler = '';

if (empty($kunde)) {
    $fehler .= 'Kein Kunde gewählt!<br>';
}

if (empty($ladestation)) {
    $fehler .= 'Keine Ladestation gewählt!<br>';
}

if (empty($tarif)) {
    $fehler .= 'Kein Tarif gewählt!<br>';
}

// Fehler ausgeben
if (!empty($fehler)) {

    echo '<h2>Fehler</h2>';
    echo '<b>' . $fehler . '</b>';
    echo '<br>';
    echo '<a href="index.php">Zurück</a>';
} else {

    // Neuen Ladevorgang speichern
    $stmt = $conn->prepare(
        "INSERT INTO Ladevorgang
        (
            Startzeit,
            Endzeit,
            Kilowattstunden,
            fkKunde,
            fkLadestation,
            fkTarif
        )
        VALUES
        (
            NOW(),
            NULL,
            0,
            :kunde,
            :ladestation,
            :tarif
        )"
    );

    $stmt->execute([
        'kunde' => $kunde,
        'ladestation' => $ladestation,
        'tarif' => $tarif
    ]);

    // Nach dem Speichern zurück zur Übersicht
    header('Location: index.php');
    exit;
}
