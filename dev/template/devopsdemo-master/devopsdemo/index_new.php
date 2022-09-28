<?php
$mysqli = new mysqli("137.135.109.135","simplelamp","netsaint-1","simple_lamp");
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
echo $mysqli->host_info . "\n";

$res = $mysqli->query("SELECT * FROM upload_images");

while ($row = $res->fetch_assoc()) {
    echo " id = " . $row['id'] . "\n";
}
