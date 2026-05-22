<?php require 'connection.php';
header('Content-Type: application/json');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    try{
        if(isset($_GET['airline_id'])){
        $getall=$connection->prepare("SELECT * FROM airline WHERE airline_id = ?");
        $getall->execute([$_GET['airline_id']]);
        $airline=$getall->fetchAll(PDO::FETCH_ASSOC);
        if(!$airline) http_response_code(404);
        else{
        http_response_code(200);
        echo json_encode($airline);}
        }
        elseif(isset($_GET['airline_name'])){
        $getall=$connection->prepare("SELECT * FROM airline WHERE airline_name = ?");
        $getall->execute([$_GET['airline_name']]);
        $airline=$getall->fetchAll(PDO::FETCH_ASSOC);
        if(!$airline) http_response_code(404);
        else{
        http_response_code(200);
        echo json_encode($airline);}
        }
        else{
        $getall=$connection->query('SELECT * FROM airline');
        $airline=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($airline);}
        }
    catch(PDOException $err){
        http_response_code(500);
        echo json_encode(["error"=>"failed".$err->getMessage()]);
    }
} elseif ($method === 'POST') {
    try {
        $body = json_decode(file_get_contents('php://input'), true);

        if (empty($body['airline_name']) || empty($body['phone_number']) || empty($body['contact_person']) || empty($body['address']) || empty($body['current_balance'])) {
            http_response_code(422);
            echo json_encode(['error' => 'Missing required fields']);
            exit;
        }

        $stmt = $connection->prepare("INSERT INTO airline (airline_name, phone_number, contact_person, address, current_balance) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$body['airline_name'], $body['phone_number'], $body['contact_person'], $body['address'], $body['current_balance']]);
        http_response_code(200);
        echo json_encode(['message' => 'Airline created successfully']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}/* elseif ($method === 'PATCH') {
    
} elseif ($method === 'DELETE') {
    
}*/ else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}