<?php
// Header einfügen
include('header.php');
?>
<?php include_once('nav.php') ?>
<article id="welcome">
    <h1>Suchseite für Smartphonemodelle</h1>
</article>
<div class="container mt-5">
    <h2>Abfrage</h2>
    <form action="" method="get">
        <div class="form-group">
            <label for="search">Suche nach Modellname, Display oder Prozessor:</label>
            <input type="text" class="form-control" id="search" name="search" required>
        </div>
        <button type="submit" class="btn btn-primary">Suchen</button>
    </form>

    <?php
    try {
        // Datenbankverbindung einbinden
        include('connect_database.php');

        // Überprüfen, ob ein Suchbegriff übermittelt wurde
        if (isset($_GET['search'])) {
            // Suchbegriff vorbereiten und für SQL LIKE-Operator formatieren
            $search = '%' . $_GET['search'] . '%';

            // SQL-Abfrage mit vorbereiteten Statements für mehr Sicherheit
            $stmt = $conn->prepare("
                SELECT m.*, h.hersteller
                FROM modell m
                JOIN hersteller h ON m.hersteller_id = h.id
                WHERE m.name LIKE :search
                OR m.display LIKE :search
                OR m.prozessor LIKE :search
            ");
            $stmt->bindParam(':search', $search);
            $stmt->execute();

            // Ergebnis prüfen und Ausgabe generieren
            if ($stmt->rowCount() > 0) {
                echo "<h3>Gefundene Smartphonemodelle:</h3>";
                echo "<div class='table-responsive'>";
                echo "<table class='table table-bordered'>";
                echo "<thead class='thead-dark'>";
                echo "<tr>";
                echo "<th>Modellname</th>";
                echo "<th>Display</th>";
                echo "<th>Akku</th>";
                echo "<th>Prozessor</th>";
                echo "<th>RAM</th>";
                echo "<th>Kamera</th>";
                echo "<th>Hersteller</th>";
                echo "</tr>";
                echo "</thead>";
                echo "<tbody>";
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<tr>";
                    echo "<td>{$row['name']}</td>";
                    echo "<td>{$row['display']}</td>";
                    echo "<td>{$row['akku']}</td>";
                    echo "<td>{$row['prozessor']}</td>";
                    echo "<td>{$row['ram']}</td>";
                    echo "<td>{$row['kamera']}</td>";
                    echo "<td>{$row['hersteller']}</td>";
                    echo "</tr>";
                }
                echo "</tbody>";
                echo "</table>";
                echo "</div>";
            } else {
                echo "<div class='alert alert-info mt-3'>Keine passenden Handymodelle gefunden.</div>";
            }
        }
    } catch (PDOException $e) {
        echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
    } finally {
        $conn = null; // Verbindung schließen
    }
    ?>
</div>
<?php include('footer.php') ?>
