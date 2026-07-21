<!-- tabelle mit allen ladevorängen -->
<!-- status berechnen NULL -> läuft, vorhanden -> abgeschlossen -->
<!-- preis berechnen und anzeigen -->
<!-- bei laufenden vorgängen noch kein preis -->
<!-- filterfunktion -->
<!-- dropdown -->
<!-- suchfeld -->
<!-- prepared statements! -->
<!-- neuen ladevorgang einfügen -->
<!-- ladevorgang löschen + updaten (als übung) -->
<!-- testprotokoll -->
<!-- dokumentation (md?) -->
<?php
include_once('db.php');
include_once('header.php');
include_once('nav.php');

// $data = [];
// $selectData = "SELECT lv.idLadevorgang, lv.Startzeit, lv.Endzeit, TIMEDIFF(lv.Endzeit, lv.Startzeit) AS ladezeit, lv.Kilowattstunden AS 'geladene Kilowattstunden',
//  t.idTarif, ls.Status, (Kilowattstunden * PreisProStunde) + t.Startgebühr AS preis, k.`E-Mail-Adresse` 
//  FROM ladevorgang lv 
//  JOIN tarif t ON lv.fkTarif = t.idTarif 
//  JOIN ladestation ls ON lv.fkLadestation = ls.Stationsnummer 
//  JOIN kunde k ON lv.fkKunde = k.Kundennummer;";
// $stmt = $conn->prepare($selectData);
// $stmt->execute();
// $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$filterKunde = isset($_GET['kunde'])
    ? (int) $_GET['kunde']
    : 0;

$filterStation = isset($_GET['station'])
    ? (int) $_GET['station']
    : 0;

$search = isset($_GET['search'])
    ? trim($_GET['search'])
    : '';

/*
 * Grundabfrage: Liefert immer dieselben Spalten.
 * Die Filter werden anschließend mit AND ergänzt.
 */
$sql = "
    SELECT
        lv.idLadevorgang,
        lv.Startzeit,
        lv.Endzeit,

        TIMEDIFF(
            lv.Endzeit,
            lv.Startzeit
        ) AS Ladezeit,

        lv.Kilowattstunden AS GeladeneKilowattstunden,

        t.idTarif,

        ls.Stationsnummer,
        ls.Bezeichnung AS Ladestation,

        k.`E-Mail-Adresse` AS KundenEmail,

        CASE
            WHEN lv.Endzeit IS NULL THEN 'läuft'
            ELSE 'abgeschlossen'
        END AS Vorgangsstatus,

        CASE
            WHEN lv.Endzeit IS NULL THEN NULL
            ELSE
                lv.Kilowattstunden * t.PreisProStunde
                + t.`Startgebühr`
        END AS Preis

    FROM Ladevorgang lv

    JOIN Tarif t
        ON lv.fkTarif = t.idTarif

    JOIN Ladestation ls
        ON lv.fkLadestation = ls.Stationsnummer

    JOIN Kunde k
        ON lv.fkKunde = k.Kundennummer

    WHERE 1 = 1
";

$parameter = [];

/*
 * Kundenfilter
 */
if ($filterKunde > 0) {
    $sql .= " AND k.Kundennummer = :kunde";
    $parameter['kunde'] = $filterKunde;
}

/*
 * Stationsfilter
 */
if ($filterStation > 0) {
    $sql .= " AND ls.Stationsnummer = :station";
    $parameter['station'] = $filterStation;
}

/*
 * Freitextsuche nach Name, E-Mail und Station.
 */
if ($search !== '') {
    $sql .= "
        AND CONCAT_WS(
            ' ',
            k.Vorname,
            k.Nachname,
            k.`E-Mail-Adresse`,
            ls.Bezeichnung
        ) LIKE :search
    ";

    $parameter['search'] = '%' . $search . '%';
}

$sql .= " ORDER BY lv.idLAdevorgang ASC";

$stmt = $conn->prepare($sql);
$stmt->execute($parameter);

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<div class="container-fluid text-center">
    <table class="table">
        <thead>
            <tr>
                <th scope="col">#ID</th>
                <th scope="col">Kunde Email</th>
                <th scope="col">Ladezeit</th>
                <th scope="col">Startzzeit</th>
                <th scope="col">Endzeit</th>
                <th scope="col">geladene Kilowattstunden</th>
                <th scope="col">Tarif</th>
                <th scope="col">Status</th>
                <th scope="col">Preis</th>
                <th scope="col">Ladestation</th>
            </tr>
        </thead>
        <tbody>
            <?php
            foreach ($data as $eachdata) {
            ?>
                <tr>
                    <!-- htmlspecialchars immer angeben! zu faul fürs beispiel :3 -->
                    <td><?= htmlspecialchars($eachdata['idLadevorgang']) ?></td>
                    <td><?= $eachdata['KundenEmail'] ?></td>
                    <td><?= $eachdata['Ladezeit'] ?></td>
                    <td><?= $eachdata['Startzeit'] ?></td>
                    <td><?= $eachdata['Endzeit'] ?></td>
                    <td><?= $eachdata['GeladeneKilowattstunden'] ?></td>
                    <td><?= $eachdata['idTarif'] ?></td>
                    <td><?= $eachdata['Vorgangsstatus'] ?></td>
                    <td><?= $eachdata['Preis'] ?></td>
                    <td><?= $eachdata['Ladestation'] ?></td>
                </tr>
            <?php } ?>
        </tbody>
    </table>

    <div class="text-center">
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
            Neuen Ladevorgang hinzufügen
        </button>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Neuer Ladevorgang</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form action="insert.php" method="post">

                    <div class="modal-body">

                        <div class="mb-3">
                            <label for="kunde" class="form-label">
                                Kunde
                            </label>

                            <select
                                class="form-select"
                                id="kunde"
                                name="kunde">
                                <option value="">WÄHLEN</option>

                                <?php foreach ($kunden as $kunde) { ?>
                                    <option value="<?= (int) $kunde['Kundennummer'] ?>">
                                        <?= htmlspecialchars(
                                            $kunde['Vorname'] . ' ' . $kunde['Nachname']
                                        ) ?>
                                    </option>
                                <?php } ?>
                            </select>
                        </div>


                        <div class="mb-3">
                            <label for="ladestation" class="form-label">
                                Ladestation
                            </label>

                            <select
                                class="form-select"
                                id="ladestation"
                                name="ladestation">
                                <option value="">WÄHLEN</option>

                                <?php foreach ($stationen as $station) { ?>
                                    <option value="<?= (int) $station['Stationsnummer'] ?>">
                                        <?= htmlspecialchars(
                                            $station['Bezeichnung']
                                        ) ?>
                                    </option>
                                <?php } ?>
                            </select>
                        </div>


                        <div class="mb-3">
                            <label for="tarif" class="form-label">
                                Tarif
                            </label>

                            <select
                                class="form-select"
                                id="tarif"
                                name="tarif">
                                <option value="">WÄHLEN</option>

                                <?php foreach ($tarife as $tarif) { ?>
                                    <option value="<?= (int) $tarif['idTarif'] ?>">
                                        Tarif <?= (int) $tarif['idTarif'] ?>
                                        –
                                        <?= number_format(
                                            (float) $tarif['PreisProStunde'],
                                            2,
                                            ',',
                                            '.'
                                        ) ?> € pro kWh
                                    </option>
                                <?php } ?>
                            </select>
                        </div>

                    </div>

                    <div class="modal-footer">

                        <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">
                            Abbrechen
                        </button>

                        <button
                            type="submit"
                            class="btn btn-primary">
                            Speichern
                        </button>

                    </div>

                </form>

            </div>
        </div>
    </div>

    <?php include_once('footer.php'); ?>