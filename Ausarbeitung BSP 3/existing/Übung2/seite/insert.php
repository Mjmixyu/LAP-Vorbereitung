<?php
include('header.php');
?>
<?php include_once('nav.php') ?>
<article id="welcome">
    <h1>Neues Smartphone hinzufügen</h1>
</article>
<div class="container mt-5">
    <h2>Smartphone-Daten eingeben</h2>

    <?php
    // Datenbankverbindung
    include('connect_database.php');

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        try {
            // Werte aus dem Formular abrufen und leere Felder überprüfen
            $name = $_POST['name'] ?? '';
            $display = $_POST['display'] ?? '';
            $akku = $_POST['akku'] ?? '';
            $prozessor = $_POST['prozessor'] ?? '';
            $ram = $_POST['ram'] ?? '';
            $kamera = $_POST['kamera'] ?? '';
            $hersteller_id = $_POST['hersteller_id'] ?? '';

            // Eingabefelder überprüfen
            if ($name && $display && $akku && $prozessor && $ram && $kamera && $hersteller_id) {
                // Prepared Statement zur Vermeidung von SQL-Injections
                $stmt = $conn->prepare("
                    INSERT INTO modell (name, display, akku, prozessor, ram, kamera, hersteller_id)
                    VALUES (:name, :display, :akku, :prozessor, :ram, :kamera, :hersteller_id)
                ");

                // Daten binden
                $stmt->bindParam(':name', $name);
                $stmt->bindParam(':display', $display);
                $stmt->bindParam(':akku', $akku);
                $stmt->bindParam(':prozessor', $prozessor);
                $stmt->bindParam(':ram', $ram);
                $stmt->bindParam(':kamera', $kamera);
                $stmt->bindParam(':hersteller_id', $hersteller_id);

                // Abfrage ausführen
                $stmt->execute();
                echo "<div class='alert alert-success mt-3'>Smartphone erfolgreich hinzugefügt!</div>";
            } else {
                echo "<div class='alert alert-danger mt-3'>Bitte alle Felder ausfüllen!</div>";
            }
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
        }
    }
    ?>

    <form action="" method="post">
        <div class="form-group">
            <label for="name">Modellname:</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="display">Display:</label>
            <input type="text" class="form-control" id="display" name="display" required>
        </div>
        <div class="form-group">
            <label for="akku">Akku (mAh):</label>
            <input type="text" class="form-control" id="akku" name="akku" required>
        </div>
        <div class="form-group">
            <label for="prozessor">Prozessor:</label>
            <input type="text" class="form-control" id="prozessor" name="prozessor" required>
        </div>
        <div class="form-group">
            <label for="ram">RAM (GB):</label>
            <input type="text" class="form-control" id="ram" name="ram" required>
        </div>
        <div class="form-group">
            <label for="kamera">Kamera (MP):</label>
            <input type="text" class="form-control" id="kamera" name="kamera" required>
        </div>
        <div class="form-group">
            <label for="hersteller_id">Hersteller:</label>
            <select class="form-control" id="hersteller_id" name="hersteller_id" required>
                <option value="">Wählen Sie einen Hersteller aus</option>
                <?php
                // Herstelleroptionen aus der Datenbank abrufen
                $herstellerStmt = $conn->query("SELECT id, hersteller FROM hersteller");
                while ($hersteller = $herstellerStmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<option value='{$hersteller['id']}'>{$hersteller['hersteller']}</option>";
                }
                ?>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Hinzufügen</button>
    </form>
</div>
<?php include('footer.php') ?>
