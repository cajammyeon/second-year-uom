<?php

// nahhh see if I want to implement this
include "../db_details.php";

try {
    // Connect to the database
    $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage();
    exit();
}

$sql = "SELECT salary, position FROM employee WHERE 1=1";
$stmt = $pdo->prepare($sql);
$stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo "<table class='table table-striped' id='payroll_summary' border='1'>
<tr>
    <th>Role</th>
    <th>Total basic</th>
    <th>Total bonuses</th>
    <th>Total incentives</th>
    <th>Total allowances</th>
    <th>Total taxes</th>
    <th>Total insurance</th>
    <th>Total retirement</th>
    <th>Total final payroll</th>
</tr>";

$position_values = [
    "bed" => "Back End Developer",
    "jd" => "Junior Developer",
    "fed" => "Front End Developer",
    "fsd" => "Full Stack Developer",
    "cs" => "Cyber Security",
    "dd" => "Delivery Driver",
    "fw" => "Factory Worker",
    "hso" => "Health & Safety Officer",
    "ir" => "Industry Researcher",
    "bd" => "Brand Developer",
    "pd" => "Product Designer",
    "acc" => "Accountant",
    "fa" => "Financial Analyst"
];

foreach ($position_values as $key => $value) {
    ${$key} = 0;
}
$total = 0;

if (count($results) > 0) {
    foreach ($results as $row) {
        ${array_search($row["position"], $position_values)} += $row["salary"];  
    };
    foreach ($position_values as $dept => $value) {
        $temp_bal = ${$dept} * (0.1);
        $temp_first_bal = ${$dept} + 3 * ($temp_bal);
        $temp_ded = $temp_first_bal * (0.1);
        $temp_final_bal = $temp_first_bal - 3 * ($temp_ded);
        $total += $temp_final_bal;
        echo "<tr>
            <td>".$value."</td>
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