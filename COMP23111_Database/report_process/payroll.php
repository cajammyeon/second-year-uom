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
    "hso" => "Health & Safety Officer",
    "ir" => "Industry Researcher",
    "bd" => "Brand Developer",
    "pd" => "Product Designer",
    "acc" => "Accountant",
    "fa" => "Financial Analyst"
];

$sql = "SELECT * FROM employee INNER JOIN position ON position.position = employee.position WHERE 1=1";

if ($department !== "All") {
    $sql .= " AND position.department = :department";
};

if ($role !== "all") {
    $sql .= " AND employee.position = :role";
};

$stmt = $pdo->prepare($sql);

if ($department !== "All") {
    $stmt->bindParam(":department", $department, PDO::PARAM_STR);
};

if ($role !== "all") {
    $stmt->bindParam(":role", $position_values[$role], PDO::PARAM_STR);
};

$stmt->execute();
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

$month_count = date_diff(date_create($start), date_create($end));
$month_count = $month_count->format("%a");
$month_count = floor($month_count/30);

echo "<table class='table table-striped' id='payroll_summary' border='1'>
<tr>
    <th>Name</th>
    <th>Department</th>
    <th>Position</th>
    <th>Basic Salary</th>
    <th>Bonuses</th>
    <th>Incentives</th>
    <th>Other Allowances</th>
    <th>Taxes</th>
    <th>Insurance</th>
    <th>Retirement contribution</th>
    <th>Balance</th>
</tr>";

if (count($results) > 0) {
    foreach ($results as $row) {
        $salary = $row["salary"] * ($month_count == 0 ? 1 : $month_count);
        $bonuses = $salary * (0.1);
        $incentives = $salary * (0.1);
        $allowances = $salary * (0.1);
        $earlybalance = $salary + $bonuses + $incentives + $allowances;
        $taxes = $earlybalance * (0.1);
        $insurance = $earlybalance * (0.1);
        $retirement = $earlybalance * (0.1);
        $balance = $earlybalance - $taxes - $insurance - $retirement;
        echo "<tr>
            <td>".htmlspecialchars($row["employee_name"])."</td>
            <td>".htmlspecialchars($row["department"])."</td>
            <td>".htmlspecialchars($row["position"])."</td>
            <td>".htmlspecialchars($salary)."</td>
            <td>".htmlspecialchars($bonuses)."</td>
            <td>".htmlspecialchars($incentives)."</td>
            <td>".htmlspecialchars($allowances)."</td>
            <td>".htmlspecialchars($taxes)."</td>
            <td>".htmlspecialchars($insurance)."</td>
            <td>".htmlspecialchars($retirement)."</td>
            <td>".htmlspecialchars($balance)."</td>
        </tr>";
    };
};
echo "</table>";
?>