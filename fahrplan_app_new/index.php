<?php
include('header.php');
include('navbar.php');
include_once('database.php');

// normalerweise sollten solche statements kurz vor dem benutzen erstellt werden, für LAP beispiel jedoch mir egal

// array anlegen ohne daten
$kunden = [];
//prepared statement anlegen - $conn ist für die db connection aus database.php
$selectAllKundenStmt = $conn->prepare("SELECT * FROM kunde");
// statement ausführen und in $stmt variable ergebnisse speichern
$selectAllKundenStmt->execute();
// ergebnisse aus stmt fetchen und in das kunden array spechern
$kunden = $selectAllKundenStmt->fetchAll();
?>

<!-- responsive html body-->
<body class="d-flex flex-column vh-100">
    <div>
        <!-- ms (margin start) me (end) mt (top) mb (bottom) -->
        <header class="ms-3">
            <h3 style="color: blue;" class="mt-3"> Fahrplan App </h3>
            <p>
                Diese Website tut nichts.
                Datensätze in Datenbank einfügen <br>
                Datenstze sortiert anzeigen
                bisschen andere Sachen
            </p>
        </header>
    </div>
    <!-- align um den div bereich auszurichten für z.B. search sollte ganz rechts angezeigt werden -->
    <div class="ms-3 me-3" align="right">
        <form class="d-flex col-4">
            <input class="form-control me-2" type="search" placeholder="Search..." aria-label="Search">
            <button class="btn btn-outline-primary" type="submit">Search</button>

            <div class="dropdown ms-2">
                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                    Sortieren nach...
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                    <li><a class="dropdown-item" href="#">Absteigend</a></li>
                    <li><a class="dropdown-item" href="#">Aufsteigend</a></li>
                </ul>
            </div>
        </form>

        <table class="table table-striped">
            <div class="table responsive">
                <!-- zuerst werden die tabellen überschrifeten angelegt -->
                <thread>
                    <tr>
                        <th>#</th>
                        <th>Vorname</th>
                        <th>Nachname</th>
                        <th>E-Mail</th>
                    </tr>
                </thread>
                <tbody>
                    <!-- im body werden die daten über php mit foreach aus dem kunden array geholt und in die tabelle eingefügt -->
                    <?php
                    foreach ($kunden as $kunde) {
                    ?>
                        <tr>
                            <!-- fürs einfügen benutzt man die variable die (in dem fall) kunde enthält und die dazugehörige spaltenbezeichnung aus der db -->
                            <td><?php echo $kunde['idKunde']; ?></td>
                            <td><?php echo $kunde['vorname']; ?></td>
                            <td><?php echo $kunde['nachname']; ?></td>
                            <td><?php echo $kunde['email']; ?></td>
                        </tr>
                    <?php
                    }
                    ?>

                </tbody>
            </div>
        </table>
    </div>
    <div align="center">
        <button class="btn btn-primary col-2 ms-3" align="senter" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
            neuen Kunden anlegen
        </button>
    </div>
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Neuen Kunden anlegen</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            Hier können Sie einen neuen Kunden anlegen. <br>
            <!-- form zum anlegen -->
            <form class="row g-3" method="post">
                <div class="col-md-6">
                    <label for="inputVorname" name="formVorname" class="form-label">Vorname</label>
                    <input type="text" class="form-control" id="inputVorname">
                </div>
                <div class="col-md-6">
                    <label for="inputNachname" name="formNachname" class="form-label">Nachname</label>
                    <input type="text" class="form-control" id="inputNachname">
                </div>
                <div class="col-12">
                    <label for="inputEmail" name="formEmail" class="form-label">E-Mail</label>
                    <input type="email" class="form-control" id="inputEmail" placeholder="example@domain.com">
                </div>
            </form>

        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Kunden anlegen</button>
        </div>
        </div>
    </div>
    </div>
</body>

<?php
include('footer.php');
?>