<?php require 'connection.php';
header('Content-Type: application/json');

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    try{
        if(isset($_GET['summary'])){
        $getall=$connection->query('SELECT a.airline_name, a.current_balance, 
        COUNT(t.transaction_id) AS total_transactions,
        SUM(CASE WHEN t.transaction_type = "sell" THEN t.amount ELSE 0 END) AS total_income,
        SUM(CASE WHEN t.transaction_type = "buy" THEN t.amount ELSE 0 END) AS total_expenses,
        SUM(CASE WHEN t.transaction_type = "sell" THEN t.amount ELSE -t.amount END) AS net_balance
        FROM airline a LEFT JOIN transactions t ON a.airline_id = t.airline_id
        GROUP BY a.airline_id, a.airline_name, a.current_balance');
        $transactions=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($transactions);}       
        else{
        $getall=$connection->query('SELECT * FROM transactions');
        $transactions=$getall->fetchAll(PDO::FETCH_ASSOC);
        http_response_code(200);
        echo json_encode($transactions);}
        }
    catch(PDOException $err){
        http_response_code(500);
        echo json_encode(["error"=>"failed".$err->getMessage()]);
    }
} 
elseif ($method === 'POST') {
    try{
  $body=json_decode(file_get_contents('php://input'),true);
  if(empty($body['amount']) || empty($body['description']) || empty($body['airline_id']) || empty($body['date'])|| empty($body['transaction_type'])){
        http_response_code(422);
        echo json_encode(["error"=>"Missing required field"]);
        exit;
  }  
  if($body['transaction_type']!="sell" && $body['transaction_type']!="buy"){
        http_response_code(400);
        echo json_encode(["error"=>"Type has to be either sell or buy"]);
        exit;  
  }  
  if($body['transaction_type']=="buy" && (empty($body['category']) || ($body['category']!="maintenance" && $body['category']!="operating costs"))){
        http_response_code(422);
        echo json_encode(["error"=>"Category cannot be empty in case of a buy transaction, it also cannot be anything but maintenance or operating costs."]);
        exit;
  }  
  $check=$connection->prepare('SELECT * FROM airline WHERE airline_id = ?');
  $check->execute([$body['airline_id']]);
  if(!$check->fetch(PDO::FETCH_ASSOC)){
        http_response_code(404);
        echo json_encode(["error"=>"Airline does not exist"]);
        exit;
  }
   
        $connection->beginTransaction();
        $stmt = $connection->prepare("INSERT INTO transactions (amount, description, airline_id, date, transaction_type, transaction_category) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([
            $body['amount'],
            $body['description'],
            $body['airline_id'],
            $body['date'],
            $body['transaction_type'],
            $body['transaction_type'] === 'buy' ? $body['category'] : null
        ]);

        if ($body['transaction_type'] === 'sell') {
            $update = $connection->prepare("UPDATE airline SET current_balance = current_balance + ? WHERE airline_id = ?");
        } else {
            $update = $connection->prepare("UPDATE airline SET current_balance = current_balance - ? WHERE airline_id = ?");
        }
        $update->execute([$body['amount'], $body['airline_id']]);

        $connection->commit();
        http_response_code(200);
        echo json_encode(['message' => 'Transaction created successfully']);

}
catch(PDOException $err){
        http_response_code(500);
        echo json_encode(["error"=>"failed".$err->getMessage()]);
    }
} 
else {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
}