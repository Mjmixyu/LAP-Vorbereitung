<!-- basic insert Beispiel -->
<!-- header einfügen -->
<?php
include('header.php');
?>

<!-- navbar einfügen - include_once um sicherzustellen dass es nur einmal eingefügt wird auch bei mehrfacher erwähnung im file -->
<?php include_once('nav.php') ?>

<!-- titel -->
<article id="welcome">
    <h1>Neue Daten einfügen</h1>
</article>
<!-- container für Inhalt -->
<div class="container mt-5">
    <h2>Daten eingeben</h2>

    <?php
    // Datenbankverbindung
    include('connect_database.php');

    // Prüft, ob das Formular mit der POST-Methode abgeschickt wurde
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        try {
            // Werte aus dem Formular abrufen und leere Felder überprüfen
            $wert1 = $_POST['wert1'] ?? '';
            $wert2 = $_POST['wert2'] ?? '';
            $wert3 = $_POST['wert3'] ?? '';

            // Eingabefelder überprüfen
            if ($wert1 && $wert2 && $wert3) {
                // Prepared Statement zur Vermeidung von SQL-Injections
                $stmt = $conn->prepare("
                    INSERT INTO modell (spalte1, spalte2, spalte3)
                    VALUES (:wert1, :wert2, :wert3)
                ");

                // Daten binden
                $stmt->bindParam(':wert1', $wert1);
                $stmt->bindParam(':wert2', $wert2);
                $stmt->bindParam(':wert3', $wert3);

                // Abfrage ausführen
                $stmt->execute();
                // bei Erfolg meldung zum Bestätigen
                echo "<div class='alert alert-success mt-3'>Daten erfolgreich hinzugefügt!</div>";
            } else {
              // bei Fehlern Meldung zum Hinweisen
                echo "<div class='alert alert-danger mt-3'>Bitte alle Felder ausfüllen!</div>";
            }
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
        }
    }
    ?>

    <!-- Formular zum Hinzufügen eines neuen Datensatzes -->
    <form action="" method="post">
        <!-- Eingabefeld für einen Datensatz -->
        <div class="form-group">
            <label for="name">Wert1:</label>
            <input type="text" class="form-control" id="wert1" name="wert1" required>
        </div>
        <div class="form-group">
            <label for="display">Wert2:</label>
            <input type="text" class="form-control" id="wert2" name="wert2" required>
        </div>
        <div class="form-group">
            <!-- Beschriftung für das Dropdown -->
            <label for="wert3">Wert3:</label>
            <!-- Dropdown-Feld für Wert3 -->
            <select class="form-control" id="wert3" name="wert3" required>
                <!-- Leere Standardauswahl -->
                <option value="">Bitte Wert3 auswählen</option>

                <?php
                // Werte für das Dropdown aus der Datenbank holen
                $wert3Stmt = $conn->query("SELECT id, bezeichnung FROM tabelle_wert3");
                // Jeden Datensatz als Auswahlmöglichkeit ausgeben
                while ($wert3 = $wert3Stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<option value='{$wert3['id']}'>{$wert3['bezeichnung']}</option>";
                }
                ?>
            </select>
        </div>
        <!-- Button zum Abschickend er Daten -->
        <button type="submit" class="btn btn-primary">Hinzufügen</button>
    </form>
</div>
<!-- footer einfügen -->
<?php include('footer.php') ?>