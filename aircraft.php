<?php require 'connection.php';
header('Content-Type: application/json');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    try{
        $getall=$connection->query('SELECT * FROM aircraft');
        $aircraft=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($aircraft);}
    catch(PDOException $err){
        http_response_code(500);
        echo json_encode(["error"=>"failed".$err->getMessage()]);
    }
} elseif ($method === 'POST') {
    
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}