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

$sql = 'UPDATE employee SET
    employee_name = :employee,
    email = :email, 
    position = :position,
    salary = :salary, 
    dob = :dob, 
    office_location = :office,
    home_address = :home, 
    hired_date = :hired_date, 
    amount_of_leave = :leave, 
    contract = :contract,
    nin = :nin,
    emergency_name = :emername,
    emergency_relationship = :emerrel, 
    emergency_phone = :emerphone
WHERE unique_id = :id';

$stmt = $pdo->prepare($sql);
$stmt->execute([
    ":id" => $id,
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