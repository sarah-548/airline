<?php require 'connection.php';
header('Content-Type: application/json');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    try{
        if(isset($_GET['summary'])){
        $getall=$connection->query('SELECT a.airline_name, a.current_balance, COUNT(t.transaction_id) AS total_transactions,
        SUM(CASE WHEN t.transaction_type = "sell" THEN t.amount ELSE 0 END) AS total_income,
        SUM(CASE WHEN t.transaction_type = "buy" THEN t.amount ELSE 0 END) AS total_expenses,
        SUM(CASE WHEN t.transaction_type = "sell" THEN t.amount ELSE -t.amount END) AS net_balance
        FROM airline a LEFT JOIN transactions t ON a.airline_id = t.airline_id
        GROUP BY a.airline_id, a.airline_name, a.current_balance');
        $transactions=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($transactions);
        }
        else{
        $getall=$connection->query('SELECT * FROM transactions');
        $transactions=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($transactions);}}
    catch(PDOException $err){
        http_response_code(500);
        echo json_encode(["error"=>"failed".$err->getMessage()]);
    }
} /*elseif ($method === 'POST') {
    
}*/ else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}