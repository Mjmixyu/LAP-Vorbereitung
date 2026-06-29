<!-- Klasse für Navbar anlegen -->
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <!-- Container für Inhalt erstellen -->
  <div class="container-fluid">
    <!-- Link zur Startseite/index mit buttons um navbar auf kleinen Geräten -->
    <a class="navbar-brand" href="index.php">Startseite</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <!-- aufklappbarer Bereich -->
    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- alle ELemente im Navbar -->
      <ul class="navbar-nav">
        <!-- list item mit link zur Seite/zum file der Seite und Text auf dne man clickt -->
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="search.php">Suche</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="insert.php">Einfügen</a>
        </li>
      </ul>
    </div>
  </div>
</nav>