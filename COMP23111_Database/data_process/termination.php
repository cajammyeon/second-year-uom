<?php
include "../db_details.php";

try {
    // Connect to the database
    $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage();
    exit();
};

$id = $_GET["q"];
$stmt= $pdo->prepare("SELECT unique_ID FROM employee WHERE unique_ID = :id ");
$stmt->execute([":id" => $id]);
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($results) > 0) {
    echo "
        <form action='data_process/termination_remove.php' method='get'>
        <div class='mb-3'>
            <label for='id' class='form-label'>ID</label>
            <input type='text' name='id' id='id' class='form-control' value='".$results[0]["unique_ID"]."' readonly='true' required>
        </div>
        <div class='mb-3'>
            <label for='loggerid' class='form-label'>Logger ID</label>
            <input type='text' name='loggerid' id='loggerid' class='form-control' required>
        </div>
        <input type='submit' value='Terminate' class='btn btn-danger'>
    ";
} else {
    echo "No results found";
}

?>