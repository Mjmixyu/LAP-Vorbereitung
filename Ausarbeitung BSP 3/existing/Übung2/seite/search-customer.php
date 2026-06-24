<?php
include('header.php');
?>
<?php include_once('nav.php') ?>
<article id="welcome">
    <h1>Smartphone nach Kunde suchen</h1>
</article>
<div class="container mt-5">
    <h2>Wählen Sie einen Kunden aus</h2>

    <?php
    // Datenbankverbindung einbinden
    include('connect_database.php');

    // Wenn das Formular abgeschickt wurde, die Auswahl des Kunden anzeigen und das Smartphone zuordnen
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $kunde_id = $_POST['kunde_id']; // Kunden-ID aus der Auswahl

        if ($kunde_id) {
            try {
                // Kundenname anhand der ausgewählten Kunden-ID abrufen
                $stmt_kunde = $conn->prepare("SELECT vorname, nachname FROM kunde WHERE id = :kunde_id");
                $stmt_kunde->bindParam(':kunde_id', $kunde_id);
                $stmt_kunde->execute();

                $kunde = $stmt_kunde->fetch(PDO::FETCH_ASSOC);
                if ($kunde) {
                    // Kunde in Bootstrap Blau anzeigen
                    echo "<h3>Smartphone des Kunden: <span class='text-primary'>{$kunde['vorname']} {$kunde['nachname']}</span></h3>";
                } else {
                    echo "<div class='alert alert-info mt-3'>Kunde nicht gefunden.</div>";
                    exit; // Beendet das Skript, falls der Kunde nicht existiert
                }

                // Smartphones des Kunden abrufen
                $stmt_smartphones = $conn->prepare("
                    SELECT m.name, m.display, m.akku, m.prozessor, m.ram, m.kamera
                    FROM modell m
                    JOIN verkauf v ON m.id = v.modell_id
                    WHERE v.kunde_id = :kunde_id
                ");
                $stmt_smartphones->bindParam(':kunde_id', $kunde_id);
                $stmt_smartphones->execute();

                if ($stmt_smartphones->rowCount() > 0) {
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
                    echo "</tr>";
                    echo "</thead>";
                    echo "<tbody>";
                    while ($row = $stmt_smartphones->fetch(PDO::FETCH_ASSOC)) {
                        echo "<tr>";
                        echo "<td>{$row['name']}</td>";
                        echo "<td>{$row['display']}</td>";
                        echo "<td>{$row['akku']}</td>";
                        echo "<td>{$row['prozessor']}</td>";
                        echo "<td>{$row['ram']}</td>";
                        echo "<td>{$row['kamera']}</td>";
                        echo "</tr>";
                    }
                    echo "</tbody>";
                    echo "</table>";
                    echo "</div>";
                } else {
                    echo "<div class='alert alert-info mt-3'>Keine Smartphones für diesen Kunden gefunden.</div>";
                }
            } catch (PDOException $e) {
                echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
            }
        } else {
            echo "<div class='alert alert-danger mt-3'>Bitte wählen Sie einen Kunden aus.</div>";
        }
    }
    ?>

    <!-- Formular zur Auswahl eines Kunden -->
    <form action="" method="post">
        <div class="form-group">
            <label for="kunde_id">Kunde auswählen:</label>
            <select class="form-control w-auto" id="kunde_id" name="kunde_id" required>
                <option value="">Wählen Sie einen Kunden aus</option>
                <?php
                // Kundenoptionen aus der Datenbank abrufen
                try {
                    $kundenStmt = $conn->query("SELECT id, vorname, nachname FROM kunde");
                    if ($kundenStmt === false) {
                        throw new Exception("Fehler beim Abrufen der Kunden.");
                    }

                    // Überprüfen, ob Kunden vorhanden sind
                    if ($kundenStmt->rowCount() > 0) {
                        while ($kunde = $kundenStmt->fetch(PDO::FETCH_ASSOC)) {
                            echo "<option value='{$kunde['id']}'>{$kunde['vorname']} {$kunde['nachname']}</option>";
                        }
                    } else {
                        echo "<option value=''>Keine Kunden gefunden</option>";
                    }
                } catch (Exception $e) {
                    echo "Fehler: " . $e->getMessage();
                }
                ?>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Suchen</button>
    </form>
</div>
<?php include('footer.php') ?>
