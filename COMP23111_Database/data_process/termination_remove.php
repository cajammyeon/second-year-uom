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

$id = $_GET["id"];
$logger_ID = $_GET["loggerid"];

$stmt = $pdo->prepare("DELETE FROM employee WHERE unique_ID = :id");
$stmt->execute([":id" => $id]);

$stmt = $pdo->prepare("UPDATE employee_termination SET logger_ID = :logger WHERE unique_ID = :id");
$stmt->execute([":logger" => $logger_ID, ":id" => $id]);

header("Location: ../data.php");
exit();

?>