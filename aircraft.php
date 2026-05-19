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
    try {
        $body = json_decode(file_get_contents('php://input'), true);
        if (empty($body['model']) || empty($body['airline_name']) || empty($body['capacity'])) {
            http_response_code(422);
            echo json_encode(['error' => 'Missing required fields']);
            exit;
        }

        $stmt = $connection->prepare("INSERT INTO aircraft (model, airline_name, capacity) VALUES (?, ?, ?)");
        $stmt->execute([$body['model'], $body['airline_name'], $body['capacity']]);
        http_response_code(200);
        echo json_encode(['message' => 'Aircraft added successfully']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
    
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}