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
}elseif ($method === 'PATCH') {
    try {
        if (!isset($_GET['airline_id'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Airline ID is required']);
            exit;
        }
        $check = $connection->prepare("SELECT * FROM airline WHERE airline_id = ?");
        $check->execute([$_GET['airline_id']]);
        if (!$check->fetch(PDO::FETCH_ASSOC)) {
            http_response_code(404);
            echo json_encode(['error' => 'Airline does not exist']);
            exit;
        }
        $body = json_decode(file_get_contents('php://input'), true);
        $allowed = ['airline_name', 'phone_number', 'contact_person', 'address', 'current_balance'];
        $fields = []; $values = [];  
        foreach ($allowed as $field) {
            if (isset($body[$field])) {
                $fields[] = "$field = ?";
                $values[] = $body[$field];
            }
        }
        if (empty($fields)) {
            http_response_code(400);
            echo json_encode(['error' => 'No provided fields to update']);
            exit;
        }
        $values[] = $_GET['airline_id'];
        $sql = "UPDATE airline SET " . implode(', ', $fields) . " WHERE airline_id = ?";
        $stmt = $connection->prepare($sql);
        $stmt->execute($values);
        http_response_code(200);
        echo json_encode(['message' => 'Airline updated successfully']);

    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
}
    
elseif ($method === 'DELETE') {
    try{
        if(isset($_GET['airline_name'])){
        $check = $connection->prepare("SELECT * FROM airline WHERE airline_name = ?");
        $check->execute([$_GET['airline_name']]);
        $airline = $check->fetch(PDO::FETCH_ASSOC);
        if (!$airline) {
            http_response_code(404);
            echo json_encode(['error' => 'Airline not found']);
            exit;
        }
        $getall=$connection->prepare("DELETE FROM airline WHERE airline_name = ?");
        $getall->execute([$_GET['airline_name']]);
        http_response_code(200);
        $name=$_GET['airline_name'];
        echo json_encode(['message' => $name . ' deleted successfully']);
        }else {
            http_response_code(400);
            echo json_encode(['error' => 'Please provide the name of the airline you want to delete']);
        }
        }catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}