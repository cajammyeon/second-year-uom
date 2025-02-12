<?php 
include "../db_details.php";

try {
    // Connect to tde database
    $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage();
    exit();
}

foreach ($_GET as $name_of_input => $value_of_input) {
    ${htmlspecialchars($name_of_input)} = htmlspecialchars($value_of_input);
}

$position_values = [
    "bed" => "Back End Developer",
    "jd" => "Junior Developer",
    "fed" => "Front End Developer",
    "fsd" => "Full Stack developer",
    "cs" => "Cyber Security",
    "dd" => "Delivery Driver",
    "fw" => "Factory Worker",
    "hso" => "Healtd & Safety Officer",
    "ir" => "Industry Researcher",
    "bd" => "Brand Developer",
    "pd" => "Product Designer",
    "acc" => "Accountant",
    "fa" => "Financial Analyst"
];

$sql = "SELECT position.department, leave_management.reasons, leave_management.total FROM employee 
INNER JOIN position ON position.position = employee.position 
INNER JOIN leave_management ON leave_management.employee_ID = employee.unique_ID 
WHERE leave_management.status = 'Approved'";

if ($start !== '') {
    $sql .= " AND leave_management.date_start >= :datestart";
};

if ($end !== '') {
    $sql .= " AND leave_management.date_end <= :dateend";
};
 
$stmt = $pdo->prepare($sql);

if ($start !== '') {
    $stmt->bindParam(":datestart", $start, PDO::PARAM_STR);
};

if ($end !== '') {
    $stmt->bindParam(":dateend", $end, PDO::PARAM_STR);
};

$stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

$vacation_operations = 0;
$vacation_marketing = 0;
$vacation_finance = 0;
$vacation_technology = 0;

$medical_operations = 0;
$medical_marketing = 0;
$medical_finance = 0;
$medical_technology = 0;

$emergency_operations = 0;
$emergency_marketing = 0;
$emergency_finance = 0;
$emergency_technology = 0;

$break_operations = 0;
$break_marketing = 0;
$break_finance = 0;
$break_technology = 0;

if (count($results) > 0) {
    foreach ($results as $row) {
        $variable = strtolower($row["reasons"]).'_'.strtolower($row["department"]);
        ${$variable} += $row["total"];
    };
};

$departments_total = array("operations", "finance", "marketing", "technology");
$reasons_total = array("vacation", "emergency", "break", "medical");
$total = 0;

foreach ($departments_total as $dept) {
    foreach ($reasons_total as $reas) {
        $varname = $reas.'_'.$dept;
        $total += ${$varname};
    }
}

echo "<table class='table table-striped' id='absent_summary' border='1'>
<tr>
    <th> </th>
    <th>Operations</th>
    <th>Finance</th>
    <th>Marketing</th>
    <th>Technology</th>
    <th>Total</th>
</tr>
<tr>
    <th>Vacation</th>
    <td>".$vacation_operations."</td>
    <td>".$vacation_finance."</td>
    <td>".$vacation_marketing."</td>
    <td>".$vacation_technology."</td>
    <td>".$vacation_operations + $vacation_finance + $vacation_technology + $vacation_marketing."</td>
</tr>
<tr>
    <th>Medical</th>
    <td>".$medical_operations."</td>
    <td>".$medical_finance."</td>
    <td>".$medical_marketing."</td>
    <td>".$medical_technology."</td>
    <td>".$medical_operations + $medical_finance + $medical_technology + $medical_marketing."</td>
</tr>
<tr>
    <th>Emergency</th>
    <td>".$emergency_operations."</td>
    <td>".$emergency_finance."</td>
    <td>".$emergency_marketing."</td>
    <td>".$emergency_technology."</td>
    <td>".$emergency_operations + $emergency_finance + $emergency_technology + $emergency_marketing."</td>
</tr>
<tr>
    <th>Break</th>
    <td>".$break_operations."</td>
    <td>".$break_finance."</td>
    <td>".$break_marketing."</td>
    <td>".$break_technology."</td>
    <td>".$break_operations + $break_finance + $break_technology + $break_marketing."</td>
</tr>
<tr>
    <th>Total</th>
    <td>".$break_operations + $medical_operations + $vacation_operations + $emergency_operations."</td>
    <td>".$break_finance + $medical_finance + $vacation_finance + $emergency_finance."</td>
    <td>".$break_marketing + $medical_marketing + $vacation_marketing + $emergency_marketing."</td>
    <td>".$break_technology + $medical_technology + $vacation_technology + $emergency_technology."</td>
    <td>".$total."</td>
</tr>
</table>";
?>