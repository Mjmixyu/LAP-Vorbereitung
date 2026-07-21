<?php
include_once('db.php');
include_once('header.php');

// Bestehende Kunden laden
$kundenStmt = $conn->query(
    "SELECT
        Kundennummer,
        Vorname,
        Nachname,
        `E-Mail-Adresse`
     FROM Kunde
     ORDER BY Nachname, Vorname"
);
$kunden = $kundenStmt->fetchAll(PDO::FETCH_ASSOC);

// Für den Filter alle Ladestationen laden
$stationenStmt = $conn->query(
    "SELECT
        Stationsnummer,
        Bezeichnung
     FROM Ladestation
     ORDER BY Bezeichnung"
);
$stationen = $stationenStmt->fetchAll(PDO::FETCH_ASSOC);


// Tarife für die Combobox laden
$tarifeStmt = $conn->query(
    "SELECT
        idTarif,
        PreisProStunde,
        `Startgebühr`
     FROM Tarif
     ORDER BY idTarif"
);
$tarife = $tarifeStmt->fetchAll(PDO::FETCH_ASSOC);

?>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.php">Ladestation Manager</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="kundenDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Kunden
                    </a>
                    <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="kundenDropdown">
                        <?php foreach ($kunden as $kunde) { ?>
                            <li><a class="dropdown-item" href="index.php?kunde=<?= (int) $kunde['Kundennummer'] ?>"><?= htmlspecialchars($kunde['Vorname'] . ' ' . $kunde['Nachname']) ?></a></li>
                        <?php } ?>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="ladestationDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Ladestationen
                    </a>
                    <ul class="dropdown-menu dropdown-menu-light" aria-labelledby="ladestationDropdown">
                        <?php foreach ($stationen as $station) { ?>
                            <li><a class="dropdown-item" href="index.php?station=<?= (int) $station['Stationsnummer'] ?>"><?= htmlspecialchars($station['Bezeichnung']) ?></a></li>
                        <?php } ?>
                    </ul>
                </li>
                <a href="index.php" class="btn btn-outline-secondary">
                    Filter zurücksetzen
                </a>
            </ul>
        </div>
        <form class="d-flex ms-auto mt-2 mt-lg-0">
            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-primary" type="submit">Search</button>
        </form>
    </div>
</nav>