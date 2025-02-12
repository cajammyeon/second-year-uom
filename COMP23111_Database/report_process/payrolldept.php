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

$sql = "SELECT employee.salary, position.department FROM employee INNER JOIN position ON position.position = employee.position WHERE 1=1";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo "<table class='table table-striped' id='payroll_summary' border='1'>
<tr>
    <th>Department</th>
    <th>Total basic</th>
    <th>Total bonuses</th>
    <th>Total incentives</th>
    <th>Total allowances</th>
    <th>Total taxes</th>
    <th>Total insurance</th>
    <th>Total retirement</th>
    <th>Total final payroll</th>
</tr>";

$Finance = 0;
$Operations = 0;
$Technology = 0;
$Marketing = 0;
$total = 0;

$departments_list = ["Finance", "Operations", "Technology", "Marketing"];

if (count($results) > 0) {
    foreach ($results as $row) {
        ${$row["department"]} += $row["salary"];   
    };
    foreach ($departments_list as $dept) {
        $temp_bal = ${$dept} * (0.1);
        $temp_first_bal = ${$dept} + 3 * ($temp_bal);
        $temp_ded = $temp_first_bal * (0.1);
        $temp_final_bal = $temp_first_bal - 3 * ($temp_ded);
        $total += $temp_final_bal;
        echo "<tr>
            <td>".$dept."</td>
            <td>".${$dept}."</td>
            <td>".$temp_bal."</td>
            <td>".$temp_bal."</td>
            <td>".$temp_bal."</td>
            <td>".$temp_ded."</td>
            <td>".$temp_ded."</td>
            <td>".$temp_ded."</td>
            <td>".$temp_final_bal."</td>
        ";
    };
    echo "<tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td>".$total."</td>
    </tr>";
    echo "</table>";
} else {
    echo "<tr>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>";
};

?>