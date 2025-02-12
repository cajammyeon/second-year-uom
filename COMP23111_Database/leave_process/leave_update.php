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

foreach ($_POST as $name_of_input => $value_of_input) {
    ${htmlspecialchars($name_of_input)} = htmlspecialchars($value_of_input);
}

$stmt = $pdo->prepare("UPDATE leave_management SET
status = :status,
comment = :comment
WHERE leave_key = :id");

$stmt->execute([
    ":status" => $status,
    ":comment" => $comments,
    ":id" => $leavekey
]);

if (!strcmp($status, "Approved")) {
    $stmt = $pdo->prepare("SELECT amount_of_leave FROM employee WHERE unique_ID = :id");
    $stmt->execute(["id" => $leaveid]);
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $balance = $results[0]["amount_of_leave"] - $total;
    
    $stmt = $pdo->prepare("UPDATE employee SET amount_of_leave = $balance WHERE unique_ID = :id");
    $stmt->execute([":id" => $leaveid]);
}

header("Location: ../leave_management.php");
exit();

?>