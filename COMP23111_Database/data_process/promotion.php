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

foreach ($_POST as $name_of_input => $value_of_input) {
    ${htmlspecialchars($name_of_input)} = htmlspecialchars($value_of_input);
}

$sql = 'UPDATE employee SET
    salary = :salary 
WHERE unique_ID = :id';

$newsalary = $salary + $salary*($percent / 100);

$stmt = $pdo->prepare($sql);
$stmt->execute([
    ":id" => $id,
    ":salary" => $newsalary,
]);

header("Location: ../data.php");
exit();

?>