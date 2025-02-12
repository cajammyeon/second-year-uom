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

// process selection from value to real value
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

$location_values = [
    "birm" => "Birmingham Office",
    "engnorth" => "England North Distribution Centre",
    "engsouth" => "England SOuth Distribution Centre",
    "kilburn" => "Kilburn Building",
    "london" => "London Office",
    "norire" => "Northern Ireland Distribution Centre",
    "scotland" => "Scotland Distribution Centre",
    "wales" => "Wales Distribution Centre"
];

$contract_values = [
    "full" => "Full-time",
    "part" => "Part-time",
    "free" => "Freelance",
    "intern" => "Internship"
];

$sql = "INSERT INTO employee (unique_ID, employee_name, email, position, salary, dob, office_location, home_address, hired_date, amount_of_leave, contract, nin, emergency_name, emergency_relationship, emergency_phone)
VALUES (:id, :employee, :email, :position, :salary, :dob, :office, :home, :hired_date, :leave, :contract, :nin, :emername, :emerrel, :emerphone)";
$stmt = $pdo->prepare($sql);
$stmt->execute([
    ":id" => $uniqueID,
    ":employee" => $name,
    ":email" => $email,
    ":position" => $position_values[$position],
    ":salary" => $salary,
    ":dob" => $dob,
    ":office" => $location_values[$location],
    ":home" => $home,
    ":hired_date" => $hireddate,
    ":leave" => $leave,
    ":contract" => $contract_values[$contract], 
    ":nin" => $nin, 
    ":emername" => $emername, 
    ":emerrel" => $emerrel, 
    ":emerphone" => $emerphone
]);

header("Location: ../data.php");
exit();

?>