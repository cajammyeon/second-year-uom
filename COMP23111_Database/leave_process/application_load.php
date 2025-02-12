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
    $current = $results[0];
    echo '
    <form action="leave_process/leave_application.php" method="post">
    <div class="mb-3">
        <label for="leaveid" class="form-label">Employee ID</label>
        <input type="text" name="leaveid" id="leaveid" class="form-control" value="'.htmlspecialchars($current["unique_ID"]).'" readonly="true" required>
    </div>
    <div class="mb-3">
        <label for="startdate" class="form-label">Start date</label>
        <input type="date" name="startdate" id="startdate" class="form-control" required>
    </div>
    <div class="mb-3">
        <label for="enddate" class="form-label">End date</label>
        <input type="date" name="enddate" id="enddate" class="form-control" required>
    </div>
    <div class="mb-3">
        <label for="reasons" class="form-label">Reasons</label>
        <select name="reasons" id="reasons" class="form-control" required>
            <option value="Vacation">Vacation</option>
            <option value="Medical">Medical</option>
            <option value="Emergency">Emergency</option>
            <option value="Break">Break</option>
        </select>
    </div>
    <input type="submit" value="Submit" class="btn btn-primary">
    </form>
    ';
} else {
    echo "No results found";
}

?>

