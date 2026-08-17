<?php
require_once("database.php");
require_once("delete.php");
require_once("add.php");
require_once("update.php");
require_once("filter.php");
require_once("edit.php");

include("header.php");
?>

<h1 class="mb-4">
    Fahrten
</h1>

<!-- ------------------------------------------------ -->
<!-- FILTER UND SUCHE -->
<!-- ------------------------------------------------ -->
<form method="GET" class="row g-2 mb-4">
    <div class="col-md-5">
        <input
            type="text"
            name="search"
            class="form-control"
            placeholder="Suchen..."
            value="<?= htmlspecialchars($search) ?>">
    </div>

    <div class="col-md-3">
        <select name="tarif" class="form-select">
            <option value="">
                Alle Tarife
            </option>
            <?php foreach ($tarife as $tarif): ?>
                <option
                    value="<?= $tarif["idTarif"] ?>"
                    <?php if ($tarifFilter == $tarif["idTarif"]) echo "selected"; ?>>
                    <?= htmlspecialchars($tarif["bezeichnung"]) ?>
                </option>
            <?php endforeach; ?>
        </select>
    </div>

    <div class="col-md-2">
        <button
            type="submit"
            class="btn btn-primary w-100">
            Filtern
        </button>
    </div>

    <div class="col-md-2">
        <a
            href="index.php"
            class="btn btn-secondary w-100">
            Zurücksetzen
        </a>
    </div>
</form>

<!-- ------------------------------------------------ -->
<!-- FAHRT BEARBEITEN -->
<!-- ------------------------------------------------ -->
<?php if ($editFahrt): ?>
    <div class="card mb-4">
        <div class="card-header">
            <strong>
                Fahrt bearbeiten
            </strong>
        </div>

        <div class="card-body">
            <form method="POST">
                <input
                    type="hidden"
                    name="idFahrt"
                    value="<?= $editFahrt["idFahrt"] ?>">

                <div class="row g-3">

                    <!-- Kunde -->
                    <div class="col-md-4">
                        <label class="form-label">
                            Kunde
                        </label>
                        <select
                            name="FK_idKunde"
                            class="form-select"
                            required>
                            <?php foreach ($kunden as $kunde): ?>
                                <option
                                    value="<?= $kunde["idKunde"] ?>"
                                    <?php if ($editFahrt["FK_idKunde"] == $kunde["idKunde"]) echo "selected"; ?>>
                                    <?= htmlspecialchars($kunde["vorname"] . " " . $kunde["nachname"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <!-- Starthaltestelle -->
                    <div class="col-md-4">
                        <label class="form-label">
                            Starthaltestelle
                        </label>
                        <select
                            name="FK_idStarthaltestelle"
                            class="form-select"
                            required>
                            <?php foreach ($haltestellen as $haltestelle): ?>
                                <option
                                    value="<?= $haltestelle["idHaltestelle"] ?>"
                                    <?php if ($editFahrt["FK_idStarthaltestelle"] == $haltestelle["idHaltestelle"]) echo "selected"; ?>>
                                    <?= htmlspecialchars($haltestelle["bezeichnung"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <!-- Endhaltestelle -->
                    <div class="col-md-4">
                        <label class="form-label">
                            Endhaltestelle
                        </label>
                        <select
                            name="FK_idEndhaltestelle"
                            class="form-select"
                            required>
                            <?php foreach ($haltestellen as $haltestelle): ?>
                                <option
                                    value="<?= $haltestelle["idHaltestelle"] ?>"
                                    <?php if ($editFahrt["FK_idEndhaltestelle"] == $haltestelle["idHaltestelle"]) echo "selected"; ?>>
                                    <?= htmlspecialchars($haltestelle["bezeichnung"]) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <!-- Tarif -->
                    <div class="col-md-4">
                        <label class="form-label">
                            Tarif
                        </label>
                        <select
                            name="FK_idTarif"
                            class="form-select"
                            required>
                            <?php foreach ($tarife as $tarif): ?>
                                <option
                                    value="<?= $tarif["idTarif"] ?>"
                                    <?php if ($editFahrt["FK_idTarif"] == $tarif["idTarif"]) echo "selected"; ?>>
                                    <?= htmlspecialchars($tarif["bezeichnung"]) ?>
                                    -
                                    <?= htmlspecialchars($tarif["preis"]) ?> €
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <!-- Startzeit -->
                    <div class="col-md-4">
                        <label class="form-label">
                            Startzeit
                        </label>
                        <input
                            type="datetime-local"
                            name="startzeit"
                            class="form-control"
                            value="<?= date("Y-m-d\TH:i", strtotime($editFahrt["startzeit"])) ?>"
                            required>
                    </div>

                    <!-- Endzeit -->
                    <div class="col-md-4">
                        <label class="form-label">
                            Endzeit
                        </label>
                        <input
                            type="datetime-local"
                            name="endzeit"
                            class="form-control"
                            value="<?= date("Y-m-d\TH:i", strtotime($editFahrt["endzeit"])) ?>"
                            required>
                    </div>

                    <!-- Bezahlt -->
                    <div class="col-md-4">
                        <div class="form-check mt-4">
                            <input
                                type="checkbox"
                                name="fahrtbezahlt"
                                class="form-check-input"
                                id="editFahrtbezahlt"
                                <?php if ($editFahrt["fahrtbezahlt"] == 1) echo "checked"; ?>>
                            <label
                                class="form-check-label"
                                for="editFahrtbezahlt">
                                Fahrt bezahlt
                            </label>
                        </div>
                    </div>
                </div>

                <button
                    type="submit"
                    name="update"
                    class="btn btn-primary mt-3">
                    Speichern
                </button>

                <a
                    href="index.php"
                    class="btn btn-secondary mt-3">
                    Abbrechen
                </a>
            </form>
        </div>
    </div>
<?php endif; ?>

<!-- ------------------------------------------------ -->
<!-- NEUE FAHRT -->
<!-- ------------------------------------------------ -->
<div class="card mb-4">
    <div class="card-header">
        <strong>
            Neue Fahrt hinzufügen
        </strong>
    </div>

    <div class="card-body">
        <form method="POST">
            <div class="row g-3">

                <!-- Kunde -->
                <div class="col-md-4">
                    <label class="form-label">
                        Kunde
                    </label>
                    <select
                        name="FK_idKunde"
                        class="form-select"
                        required>
                        <option value="">
                            Kunde auswählen
                        </option>
                        <?php foreach ($kunden as $kunde): ?>
                            <option value="<?= $kunde["idKunde"] ?>">
                                <?= htmlspecialchars($kunde["vorname"] . " " . $kunde["nachname"]) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <!-- Starthaltestelle -->
                <div class="col-md-4">
                    <label class="form-label">
                        Starthaltestelle
                    </label>
                    <select
                        name="FK_idStarthaltestelle"
                        class="form-select"
                        required>
                        <option value="">
                            Starthaltestelle auswählen
                        </option>
                        <?php foreach ($haltestellen as $haltestelle): ?>
                            <option value="<?= $haltestelle["idHaltestelle"] ?>">
                                <?= htmlspecialchars($haltestelle["bezeichnung"]) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <!-- Endhaltestelle -->
                <div class="col-md-4">
                    <label class="form-label">
                        Endhaltestelle
                    </label>
                    <select
                        name="FK_idEndhaltestelle"
                        class="form-select"
                        required>
                        <option value="">
                            Endhaltestelle auswählen
                        </option>
                        <?php foreach ($haltestellen as $haltestelle): ?>
                            <option value="<?= $haltestelle["idHaltestelle"] ?>">
                                <?= htmlspecialchars($haltestelle["bezeichnung"]) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <!-- Tarif -->
                <div class="col-md-4">
                    <label class="form-label">
                        Tarif
                    </label>
                    <select
                        name="FK_idTarif"
                        class="form-select"
                        required>
                        <option value="">
                            Tarif auswählen
                        </option>
                        <?php foreach ($tarife as $tarif): ?>
                            <option value="<?= $tarif["idTarif"] ?>">
                                <?= htmlspecialchars($tarif["bezeichnung"]) ?>
                                -
                                <?= htmlspecialchars($tarif["preis"]) ?> €
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <!-- Startzeit -->
                <div class="col-md-4">
                    <label class="form-label">
                        Startzeit
                    </label>
                    <input
                        type="datetime-local"
                        name="startzeit"
                        class="form-control"
                        required>
                </div>

                <!-- Endzeit -->
                <div class="col-md-4">
                    <label class="form-label">
                        Endzeit
                    </label>
                    <input
                        type="datetime-local"
                        name="endzeit"
                        class="form-control"
                        required>
                </div>

                <!-- Bezahlt -->
                <div class="col-md-4">
                    <div class="form-check mt-4">
                        <input
                            type="checkbox"
                            name="fahrtbezahlt"
                            class="form-check-input"
                            id="fahrtbezahlt">
                        <label
                            class="form-check-label"
                            for="fahrtbezahlt">
                            Fahrt bezahlt
                        </label>
                    </div>
                </div>
            </div>

            <button
                type="submit"
                name="add"
                class="btn btn-success mt-3">
                Hinzufügen
            </button>
        </form>
    </div>
</div>

<!-- ------------------------------------------------ -->
<!-- TABELLE -->
<!-- ------------------------------------------------ -->
<div class="table-responsive">
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Kunde</th>
                <th>E-Mail</th>
                <th>Start</th>
                <th>Ende</th>
                <th>Startzeit</th>
                <th>Endzeit</th>
                <th>Tarif</th>
                <th>Preis</th>
                <th>Bezahlt</th>
                <th>Aktionen</th>
            </tr>
        </thead>

        <tbody>
            <?php foreach ($fahrten as $fahrt): ?>
                <tr>
                    <td>
                        <?= $fahrt["idFahrt"] ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["vorname"] . " " . $fahrt["nachname"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["email"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["startHaltestelle"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["endHaltestelle"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["startzeit"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["endzeit"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["tarifBezeichnung"]) ?>
                    </td>
                    <td>
                        <?= htmlspecialchars($fahrt["preis"]) ?> €
                    </td>
                    <td>
                        <?php if ($fahrt["fahrtbezahlt"] == 1): ?>
                            <span class="badge bg-success">
                                Ja
                            </span>
                        <?php else: ?>
                            <span class="badge bg-danger">
                                Nein
                            </span>
                        <?php endif; ?>
                    </td>
                    <td>
                        <a
                            href="index.php?edit=<?= $fahrt["idFahrt"] ?>"
                            class="btn btn-warning btn-sm">
                            Bearbeiten
                        </a>

                        <a
                            href="index.php?delete=<?= $fahrt["idFahrt"] ?>"
                            class="btn btn-danger btn-sm"
                            onclick="return confirm('Fahrt wirklich löschen?')">
                            Löschen
                        </a>
                    </td>
                </tr>
            <?php endforeach; ?>

            <?php if (count($fahrten) == 0): ?>
                <tr>
                    <td colspan="11" class="text-center">
                        Keine Fahrten gefunden.
                    </td>
                </tr>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?php include("footer.php"); ?>