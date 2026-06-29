<!-- basic search Beispiel -->
<!-- header einfügen -->
<?php
include('header.php');
?>

<!-- navbar einfügen - include_once um sicherzustellen dass es nur einmal eingefügt wird auch bei mehrfacher erwähnung im file -->
<?php include_once('nav.php') ?>

<!-- titel -->
<article id="welcome">
    <h1>Suchseite für Suchanfragen</h1>
</article>
<!-- container für Inhalt -->
<div class="container mt-5">
    <h2>Abfrage</h2>

    <!-- Suchformular -->
    <form action="" method="get">
      <!-- Eingabefeld -->
        <div class="form-group">
          <!-- Beschriftung fürs Suchfeld -->
            <label for="search">Suche nach Suchkriterium1, Suchkriterium2 oder Suchkriterium3:</label>
            <!-- Eingabefeld für den Suchbegriff -->
            <input type="text" class="form-control" id="search" name="search" required>
        </div>
        <!-- Abschicken der Suche -->
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
                SELECT m.*, h.spaltenname
                FROM modell m
                JOIN tabelle2 h ON m.fk_tabelle2_id = h.id
                WHERE m.Suchkriterium1 LIKE :search
                OR m.Suchkriterium2 LIKE :search
                OR m.Suchkriterium3 LIKE :search
            ");
            // Suchbegriff an den Platzhalter :search in der SQL-Abfrage binden
            $stmt->bindParam(':search', $search);
            // SQL-Abfrage ausführen
            $stmt->execute();

            // Ergebnis prüfen und Ausgabe generieren
            if ($stmt->rowCount() > 0) {

                echo "<h3>Gefundene Ergebnisse:</h3>";
                echo "<div class='table-responsive'>";
                echo "<table class='table table-bordered table-striped'>";

                // Tabellenkopf
                echo "<thead class='table-dark'>";
                echo "<tr>";
                echo "<th>ID</th>";
                echo "<th>Suchkriterium 1</th>";
                echo "<th>Suchkriterium 2</th>";
                echo "<th>Suchkriterium 3</th>";
                echo "<th>Zusatzspalte aus Tabelle 2</th>";
                echo "</tr>";
                echo "</thead>";

                echo "<tbody>";

                // Gefundene Datensätze ausgeben
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<tr>";

                    // Spaltennamen passend zum SELECT anpassen
                    echo "<td>{$row['id']}</td>";
                    echo "<td>{$row['Suchkriterium1']}</td>";
                    echo "<td>{$row['Suchkriterium2']}</td>";
                    echo "<td>{$row['Suchkriterium3']}</td>";
                    echo "<td>{$row['spaltenname']}</td>";

                    echo "</tr>";
                }

                echo "</tbody>";
                echo "</table>";
                echo "</div>";

            } else {
                // Wenn keine Ergebnisse gefunden wurden
                echo "<div class='alert alert-info mt-3'>Keine passenden Ergebnisse gefunden.</div>";
            }
        }
    } catch (PDOException $e) {
      // bei Fehler der Verbindung anzeigen
        echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
    } finally {
        $conn = null; // Verbindung schließen
    }
    ?>
</div>
<!-- footer einfügen -->
<?php include('footer.php');