<?php require 'connection.php';
header('Content-Type: application/json');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    try{
        $getall=$connection->query('SELECT * FROM route');
        $route=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($route);
        }
    catch(PDOException $err){
        http_response_code(500);
        echo json_encode(["error"=>"failed".$err->getMessage()]);
    }
} elseif ($method === 'POST') {
    if (isset($_GET['assign'])) {
          try {
        $body = json_decode(file_get_contents('php://input'), true);
        if (empty($body['route_id']) || empty($body['aircraft_id']) || empty($body['no_of_passengers']) || empty($body['ticket_price']) || empty($body['departure_date']) || empty($body['departure_time']) || empty($body['arrival_date']) || empty($body['arrival_time'])) {
        http_response_code(422);
        echo json_encode(['error' => 'Missing required fields']);
        exit;
    }
    $route = $connection->prepare("SELECT * FROM route WHERE route_id = ?");
    $route->execute([$body['route_id']]);
    if (!$route->fetch(PDO::FETCH_ASSOC)) {
        http_response_code(404);
        echo json_encode(['error' => 'Route does not exist']);
        exit;
    }
    $aircraft = $connection->prepare("SELECT * FROM aircraft WHERE aircraft_id = ?");
    $aircraft->execute([$body['aircraft_id']]);
    if (!$aircraft->fetch(PDO::FETCH_ASSOC)) {
        http_response_code(404);
        echo json_encode(['error' => 'Aircraft does not exist']);
        exit;
    }

    $stmt = $connection->prepare("INSERT INTO operations (route_id, aircraft_id, no_of_passengers, ticket_price, departure_date, departure_time, arrival_date, arrival_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->execute([$body['route_id'],$body['aircraft_id'],$body['no_of_passengers'],$body['ticket_price'],$body['departure_date'],$body['departure_time'],$body['arrival_date'],$body['arrival_time']]);
        http_response_code(200);
        echo json_encode(['message' => 'Assigned aircraft to route']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
    } else {
    try {
        $body = json_decode(file_get_contents('php://input'), true);
        if (empty($body['origin']) || empty($body['classification']) || empty($body['distance']) || empty($body['destination']) ) {
            http_response_code(422);
            echo json_encode(['error' => 'Missing required fields']);
            exit;
        }
        $stmt = $connection->prepare("INSERT INTO route (origin, classification, distance, destination) VALUES (?, ?, ?, ?)");
        $stmt->execute([$body['origin'], $body['classification'], $body['distance'], $body['destination']]);
        http_response_code(200);
        echo json_encode(['message' => 'Route created successfully']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
    } 
}
else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}