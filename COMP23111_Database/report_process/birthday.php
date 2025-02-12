<?php 
include "db_details.php";

try {
    // Connect to the database
    $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage();
    exit();
}

$sql = "CALL birthday();";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo "
<table class='table table-striped' id='birthday_summary' border='1'>
<tr>
    <th>Employee ID</th>
    <th>Name</th>
    <th>Date of birth</th>
<tr>
";

if (count($results) > 0) {
    foreach ($results as $row) {
        echo "<tr>
            <td>".$row["unique_ID"]."</td>
            <td>".$row["employee_name"]."</td>
            <td>".$row["dob"]."</td>
        </tr>";
    };
};
echo "</table>";

?>