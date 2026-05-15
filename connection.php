<?php
$dsn = 'mysql:host=localhost;dbname=airline_org';
$user = 'root';
$pass = '';
try{
$connection = new PDO($dsn,$user,$pass);
$connection->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
echo "connected :) <br>";

}catch(PDOException $err){
    echo "connection failed :( <br>" . "Error : " . $err->getMessage();
}
