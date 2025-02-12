<?php
include "../db_details.php";

try {
    // Connect to the database
    $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage();
    exit();
}

$query = htmlspecialchars($_GET["q"]);

$stmt = $pdo->prepare("SELECT * FROM leave_management WHERE employee_ID = :id");
$stmt->execute([':id' => $query]);

$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($results) > 0) {
    $today = date("Y-m-d");
    foreach ($results as $row) {
        if ($today < $row["date_end"]) {
            echo '
            <p> Start date : '.htmlspecialchars($row['date_start']).'</p>
            <p> End date : '.htmlspecialchars($row['date_end']).'</p>
            <p> Total : '.htmlspecialchars($row['total']).'</p>
            <p> Reason : '.htmlspecialchars($row['reasons']).'</p>
            <p> Status : '.htmlspecialchars($row['status']).'</p>
            <p> Comment : '.htmlspecialchars($row['comment']).'</p>
            ';
        }
    }
} else {
    echo "No results found";
}

?>