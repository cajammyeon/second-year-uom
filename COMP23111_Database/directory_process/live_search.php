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

// Get the search query parameter
$query = htmlspecialchars($_GET["q"]);

if (trim($query) !== '') {
    // Prepare the SQL query with a LIKE operator for partial matching
    $stmt = $pdo->prepare("SELECT * FROM employee INNER JOIN position ON position.position = employee.position WHERE employee_name LIKE :query OR unique_ID LIKE :query OR email LIKE :query;");
    $stmt->execute(['query' =>'%'.$query.'%']);

    // Fetch and display the results
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (count($results) > 0) {
        foreach ($results as $row) {
            echo "<div class='employee_content' role='button' data-bs-toggle='modal' data-bs-target='#staticBackdrop". $row["unique_ID"] . "'>
                <img style='width:200px;height:200px;border-radius:100px;' src=". htmlspecialchars($row['profile_picture'])."><br>
                <div class='content_inner'>
                <h2>" . htmlspecialchars($row['employee_name']) . "</h2>
                <p>" . htmlspecialchars($row['position']) . "</p>
                <p>" . htmlspecialchars($row['department']) . "</p>
                <p>" . htmlspecialchars($row['email']) . "</p>
                </div>
                </div>";

            echo '
            <div class="modal fade" id="staticBackdrop'. $row["unique_ID"] . '" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-header">
                  <h1 class="modal-title fs-5" id="staticBackdropLabel">Employee details</h1>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <h2>'.htmlspecialchars($row['employee_name']).'</h2>
                  <p> Employee ID : '.htmlspecialchars($row['unique_ID']).'</p>
                  <p> Position : '.htmlspecialchars($row['position']).'</p>
                  <p> Department : '.htmlspecialchars($row['department']).'</p>                  
                  <p> Date of birth : '.htmlspecialchars($row['dob']).'</p>
                  <p> Email address : '.htmlspecialchars($row['email']).'</p>
                  <p> Home address : '.htmlspecialchars($row['home_address']).'</p>
                  <p> Start date : '.htmlspecialchars($row['hired_date']).'</p>
                  <p> Office location : '.htmlspecialchars($row['office_location']).'</p>
                  <p> Contract : '.htmlspecialchars($row['contract']).'</p>
                  <p> Leave amount left : '.htmlspecialchars($row['amount_of_leave']).'</p>
                  </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
              </div>
            </div>
          </div>          
            ';
        }
    } else {
        echo "<div id='employee_content' name='employee_content' class='employee_content' style='color : white; margin : 2em;'>";
        echo "<h2> No results found </h2>";
        echo "</div>";
    }
} else {
    echo "No results found";
}
?>
