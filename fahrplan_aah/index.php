<?php
include_once('header.php');
include_once('datenbank.php');
include_once('nav.php');

$kunden = [];
$stmt = $conn->prepare("SELECT * FROM kunde");
$stmt->execute();
$kunden = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="row mb-2 mt-2 justify-content-end">
    <form class="col-4">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
    </form>
</div>

<table class="table">
    <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Vorname</th>
            <th scope="col">Nachname</th>
            <th scope="col">Email</th>
        </tr>
    </thead>
    <tbody>
        <?php
        foreach ($kunden as $kunde) {
        ?>
            <tr>

                <td>
                    <?php echo $kunde['idKunde'] ?>
                </td>
                <td>
                    <?php echo $kunde['vorname'] ?>
                </td>
                <td>
                    <?php echo $kunde['nachname'] ?>
                </td>
                <td>
                    <?php echo $kunde['email'] ?>
                </td>
                <td>
                    <!-- ENT_QUOTES is needed if the data is being substituted into an HTML attribute, e.g.-->
                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#updateModal"
                        data-id="<?php echo $kunde['idKunde']; ?>"
                        data-vorname="<?php echo htmlspecialchars($kunde['vorname'], ENT_QUOTES); ?>"
                        data-nachname="<?php echo htmlspecialchars($kunde['nachname'], ENT_QUOTES); ?>"
                        data-email="<?php echo htmlspecialchars($kunde['email'], ENT_QUOTES); ?>">
                        update
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
                        delete
                    </button>
                </td>
            </tr>
        <?php
        }
        ?>
    </tbody>
</table>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
    Neuen Kunden einfügen
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Neuen Kunden hinzufügen</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="POST" action="validationInsert.php">
                    <div class="mb-3">
                        <label class="form-label">Vorname</label>
                        <input type="text" class="form-control" name="vorname">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nachname</label>
                        <input type="text" class="form-control" name="nachname">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email">

                    </div>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Kunden hinzufügen</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Möchten Sie drn Benutzer wirklich löschen?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="POST" action="deleteUser.php">
                    <input type="hidden" name="idKunde" value="<?php echo $kunde['idKunde']; ?>">

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger">Benutzer löschen</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Kunden bearbeiten</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="POST" action="updateUser.php">
                    <!-- wird an action php file übergeben um festzustellen welcher user gerade bearbeitwet wird - das Feld wird aber nicht angezeigt -->
                    <input type="hidden" name="idKunde" id="updateIdKunde">

                    <div class="mb-3">
                        <label class="form-label">Vorname</label>
                        <input type="text" class="form-control" name="vorname" id="updateVorname">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nachname</label>
                        <input type="text" class="form-control" name="nachname" id="updateNachname">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" id="updateEmail">

                    </div>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Änderungen speichern</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // sucht das Updatemodal und speichert es in variable
    const updateModal = document.getElementById('updateModal');

    //hiermit wird gewartet bis das modal geöffnet wird um fortzufahren
    updateModal.addEventListener('show.bs.modal', function(event) {
        //button auf den geclicked wird
        const updateButton = event.relatedTarget;

        //daten einlesen von den zuvor geholten werten
        const idKunde = updateButton.getAttribute('data-id');
        const vorname = updateButton.getAttribute('data-vorname');
        const nachname = updateButton.getAttribute('data-nachname');
        const email = updateButton.getAttribute('data-email');

        // value des feldes darauf setzen
        document.getElementById('updateIdKunde').value = idKunde;
        document.getElementById('updateVorname').value = vorname;
        document.getElementById('updateNachname').value = nachname;
        document.getElementById('updateEmail').value = email;
    });
</script>

<?php
include_once('footer.php');
?>