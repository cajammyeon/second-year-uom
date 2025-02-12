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

$stmt = $pdo->prepare("SELECT * FROM employee WHERE unique_ID = :id");
$stmt->execute([':id' => $query]);

$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($results) > 0) {
    $employee_details = $results[0];
    echo '
    <form action="data_process/promotion.php" method="post">
    <div class="mb-3">
            <label for="id" class="form-label">ID</label>
            <input type="text" name="id" id="id" class="form-control" value="'.$employee_details["unique_ID"].'" readonly="true" required>
    </div>
    <div class="mb-3">
            <label for="salary" class="form-label">Salary</label>
            <input type="text" name="salary" id="salary" class="form-control" value="'.$employee_details["salary"].'" readonly="true" required>
    </div>
    <div class="mb-3">
            <label for="percent" class="form-label">Percentage increase</label>
            <input type="text" name="percent" id="id" class="form-control" required>
    </div>
    <input type="submit" value="Submit" class="btn btn-primary">
    </form>
    ';
} else {
    echo "No results found";
}

?>