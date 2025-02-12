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

$stmt = $pdo->prepare("SELECT * FROM employee INNER JOIN position ON position.position = employee.position WHERE employee.unique_ID = :id");
$stmt->execute([':id' => $query]);

$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($results) > 0) {
    $employee_details = $results[0];
        echo '
        <form action="data_process/data_update.php" method="post">
        
        <div class="mb-3">
            <label for="id" class="form-label">ID</label>
            <input type="text" name="id" id="id" class="form-control" value="'.$employee_details["unique_ID"].'" readonly="true" required>
        </div>

        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" name="name" id="name" class="form-control" value="'.$employee_details["employee_name"].'" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" name="email" id="email" class="form-control" value="'.$employee_details["email"].'" required>
        </div>
        ';

        echo '
        <div class="mb-3">
        <label for="position" class="form-label">Position</label>
        <select name="position" id="position" class="form-control" required>        
            <option value="bed" '.(($employee_details["position"] == "Back End Developer") ? "selected":"").'>Back End Developer</option>
            <option value="jd" '.(($employee_details["position"] == "Junior Developer") ? "selected":"").'>Junior Developer</option>
            <option value="fed" '.(($employee_details["position"] == "Front End Developer") ? "selected":"").'>Front End Developer</option>
            <option value="cs" '.(($employee_details["position"] == "Cyber Security") ? "selected":"").'>Cyber Security</option>
            <option value="dd" '.(($employee_details["position"] == "Delivery Driver") ? "selected":"").'>Delivery Driver</option>
            <option value="fw" '.(($employee_details["position"] == "Factory Worker") ? "selected":"").'>Factory Worker</option>
            <option value="hso" '.(($employee_details["position"] == "Health & Safety Officer") ? "selected":"").'>Health & Safety Officer</option>
            <option value="ir" '.(($employee_details["position"] == "Industry Researcher") ? "selected":"").'>Industry Researcher</option>
            <option value="bd" '.(($employee_details["position"] == "Brand Developer") ? "selected":"").'>Brand Developer</option>
            <option value="pd" '.(($employee_details["position"] == "Prduct Designer") ? "selected":"").'>Product Designer</option>
            <option value="acc" '.(($employee_details["position"] == "Accountant") ? "selected":"").'>Accountant</option>
            <option value="fa" '.(($employee_details["position"] == "Financial Analyst") ? "selected":"").'>Financial Analyst</option>
        </select>
        </div>
        ';

        echo '
        <div class="mb-3">
            <label for="salary" class="form-label">Salary</label>
            <input type="text" name="salary" id="salary" class="form-control" value="'.$employee_details["salary"].'" required>
        </div>

        <div class="mb-3">
            <label for="dob" class="form-label">Date of Birth</label>
            <input type="date" name="dob" id="dob" class="form-control" value="'.$employee_details["dob"].'" required>
        </div>
        ';

        echo '
            <div class="mb-3">
            <label for="location" class="form-label">Location</label>
            <select name="location" id="location" class="form-control" required>
            <option value="birm" '.(($employee_details["office_location"] == "Birmingham Office") ? "selected":"").'>Birmingham Office</option>
            <option value="engnorth" '.(($employee_details["office_location"] == "England North Distribution Centre") ? "selected":"").'>England North Distribution Centre</option>
            <option value="engsouth" '.(($employee_details["office_location"] == "England South Distribution Centre") ? "selected":"").'>England South Distribution Centre</option>
            <option value="kilburn" '.(($employee_details["office_location"] == "Kilburn Building") ? "selected":"").'>Kilburn Building</option>
            <option value="london" '.(($employee_details["office_location"] == "London Office") ? "selected":"").'>London Office</option>
            <option value="norire" '.(($employee_details["office_location"] == "Northern Ireland Distribution Centre") ? "selected" :"").'>Northern Ireland Distribution Centre</option>
            <option value="scotland" '.(($employee_details["office_location"] == "Scotland Distribution Centre") ? "selected":"").'>Scotland Distribution Centre</option>
            <option value="wales" '.(($employee_details["office_location"] == "Wales Distribution Centre") ? "selected":"").'>Wales Distribution Centre</option>
            </select>
            </div>
        ';

        echo '
        <div class="mb-3">
            <label for="home" class="form-label">Home address</label>
            <input type="text" name="home" id="home" class="form-control" value="'.$employee_details["home_address"].'" required>
        </div>

        <div class="mb-3">
            <label for="hireddate" class="form-label">Hired date</label>
            <input type="date" name="hireddate" id="hireddate" class="form-control" value="'.$employee_details["hired_date"].'" required>
        </div>

        <div class="mb-3">
            <label for="leave" class="form-label">Amount of Leave</label>
            <input type="text" name="leave" id="leave" class="form-control" value="'.$employee_details["amount_of_leave"].'" required>
        </div>
        ';
        
        echo '
        <div class="mb-3">
        <label for="contract" class="form-label">Contract</label>
        <select name="contract" id="contract" class="form-control" required>
        <option value="full" '.(($employee_details["contract"] == "Full-time") ? "selected":"").'>Full-time</option>
        <option value="part" '.(($employee_details["contract"] == "Part_time") ? "selected":"").'>Part-time</option>
        <option value="free" '.(($employee_details["contract"] == "Freelance") ? "selected":"").'>Freelance</option>
        <option value="intern" '.(($employee_details["contract"] == "Internship") ? "selected":"").'>Internship</option>
        </select>
        </div>
        ';
        
        
        echo '
        <div class="mb-3">
            <label for="nin" class="form-label">National Insurance Number</label>
            <input type="text" name="nin" id="nin" class="form-control" value="'.$employee_details["nin"].'" required>
        </div>

        <div class="mb-3">
            <label for="emername" class="form-label">Emergency Name</label>
            <input type="text" name="emername" id="emername" class="form-control" value="'.$employee_details["emergency_name"].'">
        </div>

        <div class="mb-3">
            <label for="emerrel" class="form-label">Emergency Relationship</label>
            <input type="text" name="emerrel" id="emerrel" class="form-control" value="'.$employee_details["emergency_relationship"].'">
        </div>

        <div class="mb-3">
            <label for="emerphone" class="form-label">Emergency Phone</label>
            <input type="text" name="emerphone" id="emerphone" class="form-control" value="'.$employee_details["emergency_phone"].'">
        </div>
        <input type="submit" value="Submit" class="btn btn-primary">
        </form>
        ';
} else {
    echo "No results found";
}

?>