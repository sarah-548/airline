<?php require 'connection.php';
header('Content-Type: application/json');

$method = $_SERVER['REQUEST_METHOD'];

/*if ($method === 'GET') {
    
} else*/if ($method === 'POST') {
    try {
        $body = json_decode(file_get_contents('php://input'), true);

        if (empty($body['name']) || empty($body['birth_date']) || empty($body['gender']) || empty($body['position']) || empty($body['airline_name'])) {
            http_response_code(422);
            echo json_encode(['error' => 'Missing required fields']);
            exit;
        }

        $stmt = $connection->prepare("INSERT INTO employee (name, birth_date, gender, position, airline_name) VALUES (?, ?, ?, ?, ?)");
        $stmt->execute([$body['name'], $body['birth_date'], $body['gender'], $body['position'], $body['airline_name']]);
        http_response_code(200);
        echo json_encode(['message' => 'Employee added successfully']);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => $e->getMessage()]);
    }
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}