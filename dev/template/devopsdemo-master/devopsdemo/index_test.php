<?php
/* Connect to a MySQL database using driver invocation */
$dsn = 'mysql:dbname=simple_lamp;host=137.135.109.135;port=3306';
$user = 'simplelamp';
$password = 'netsaint-1';

try {
    $con = new PDO($dsn, $user, $password);
    $query = sprintf("select * from upload_images") ;
    print "connected";
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}

$result = mysql_query("$query");

if(mysql_query($con, $query)){
  echo "table empty";}
  else{
  echo("Error description: " . mysql_error($con));}

?>
