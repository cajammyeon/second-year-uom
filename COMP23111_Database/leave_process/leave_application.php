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

$date_startdate = date_create($startdate);
$date_enddate = date_create($enddate);
date_modify($date_enddate, "+1 days");
$total = date_diff($date_startdate, $date_enddate);

$sql = "INSERT INTO leave_management (employee_ID, date_start, date_end, reasons, total)
VALUES (:id, :date_start, :date_end, :reasons, :total)";
$stmt = $pdo->prepare($sql);
$stmt->execute([
    ":id" => $leaveid,
    ":date_start" => $startdate,
    ":date_end" => $enddate,
    ":reasons" => $reasons,
    ":total" => $total->format("%a")
]);

header("Location: ../leave_employee.php");
exit();

?>