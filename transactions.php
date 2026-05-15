<?php require 'connection.php'

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    
} elseif ($method === 'POST') {
    
} else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}