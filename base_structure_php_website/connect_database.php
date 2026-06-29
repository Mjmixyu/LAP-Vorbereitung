<!-- Daten entsprechend der erstellten DB ausfüllen um Verbindung herzustellen -->
<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "datenbanknamexyxyxyxyxyxyxyxxyxyxyxyxyxyx";

# versuchen neue Verbindung mit angegebenen Daten zu erstellen
#bei fail - Text ausgeben
try {
  $conn = new PDO("mysql:host=$servername;dbname=$database", $username, $password);
  // setzt PDO erros Mode auf exception
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  //bei Bedarf anzeigen lassen
  //echo "Connected successfully";
} catch(PDOException $e) {
  echo "Connection failed: " . $e->getMessage();
}
?> 
