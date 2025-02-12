<?php
include "db_details.php";

try {
    // Connect to the database
    $pdo = new PDO("mysql:host=$host;port=3306;dbname=$dbname", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo "Database connection failed: " . $e->getMessage();
    exit();
}

$stmt = $pdo->prepare("SELECT * FROM leave_management WHERE status='Requested' OR status='Pending'");
$stmt->execute();

$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($results) > 0) {
    $today = date("Y-m-d");
    foreach ($results as $row) {
        if ($today < $row["date_end"]) {
            echo '
            <div class="application" id="application" name="application">
                <form action="leave_process/leave_update.php" method="post">
                <div class="mb-3">
                    <input type="hidden" name="leavekey" id="leavekey" class="form-control" value="'.htmlspecialchars($row["leave_key"]).'" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="leaveid" class="form-label">Employee ID</label>
                    <input type="text" name="leaveid" id="leaveid" class="form-control" value="'.htmlspecialchars($row["employee_ID"]).'" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="startdate" class="form-label">Start date</label>
                    <input type="date" name="startdate" id="startdate" class="form-control" value="'.htmlspecialchars($row["date_start"]).'" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="enddate" class="form-label">End date</label>
                    <input type="date" name="enddate" id="enddate" class="form-control" value="'.htmlspecialchars($row["date_end"]).'" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="total" class="form-label">Total days</label>
                    <input type="text" name="total" id="total" class="form-control" value="'.htmlspecialchars($row["total"]).'" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="reasons" class="form-label">Reasons</label>
                    <input type="text" name="reasons" id="reasons" class="form-control" value="'.htmlspecialchars($row["reasons"]).'" readonly="true">
                </div>
                <div class="mb-3">
                    <label for="comments" class="form-label">Comments</label>
                    <input type="text" name="comments" id="comments" class="form-control" value="'.htmlspecialchars($row["comment"]).'">
                </div>
                <div class="mb-3">
                    <label for="status" class="form-label">Status</label>
                    <select name="status" id="status" class="form-control">
                        <option value="Approved" '.(($row["status"] == "Approved") ? "selected":"").'>Approved</option>
                        <option value="Rejected" '.(($row["status"] == "Rejected") ? "selected":"").'>Rejected</option>
                        <option value="Pending" '.(($row["status"] == "Pending") ? "selected":"").'>Pending</option>
                        <option value="Requested" '.(($row["status"] == "Requested") ? "selected":"").'>Requested</option>
                    </select>
                </div>
                <input type="submit" value="Submit" class="btn btn-primary">
                </form>
            </div>
            ';
        }
    }
} else {
    echo "<p style='color:white'>No application pending...</p>";
}

?>