<?php
$dsn = 'mysql:host=localhost;dbname=airline_org';
$user = 'root';
$pass = '';
try{
$connection = new PDO($dsn,$user,$pass);
$connection->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);

}catch(PDOException $err){
    echo json_encode(["error" => "connection failed :(" . $err->getMessage()]);
    exit;
}
