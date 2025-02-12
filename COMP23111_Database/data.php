<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-" crossorigin="anonymous"></script>

    <script>
      function searchEmployee() {
        let search = document.getElementById("id").value;
        
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
          if (this.readyState === 4 && this.status === 200) {
            document.getElementById("searchResults").innerHTML = this.responseText;
          }
        };

        xhr.open("GET", "data_process/data_update_load.php?q=" + encodeURIComponent(search), true);
        xhr.send();
      }
      function searchEmployeePromotion() {
        let search = document.getElementById("promotionid").value;
        
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
          if (this.readyState === 4 && this.status === 200) {
            document.getElementById("searchResultsPromote").innerHTML = this.responseText;
          }
        };

        xhr.open("GET", "data_process/promotion_load.php?q=" + encodeURIComponent(search), true);
        xhr.send();
      }
      function searchTermination() {
        let search = document.getElementById("terminationid").value;
        
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
          if (this.readyState === 4 && this.status === 200) {
            document.getElementById("searchTermination").innerHTML = this.responseText;
          }
        };

        xhr.open("GET", "data_process/termination.php?q=" + encodeURIComponent(search), true);
        xhr.send();
      }
    </script>
  </head>
<body style="background-color : #2F2F2F;">
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Kilburnazon Employee Management</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="directory.php">Directory</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="data.php">Data</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="leave_management.php">Leave</a>
        </li>
        <li class="nav-item">
        <a class="nav-link" href="report.php">Report</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="position-absolute top-50 start-50 translate-middle">
  <div class="d-grid gap-2 mx-auto">
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newEmployee">
      New employee registration
      </button>
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateEmployee">
      Update employee information
      </button>
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#promotion">
      Promotion
      </button>
      <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#termination">
      Termination
      </button>
  </div>
</div>
   
<div class="modal fade" id="newEmployee" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">New employee registration</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="data_process/data_insert.php" method="post">
        
        <div class='mb-3'>
            <label for="uniqueID" class='form-label'>Employee ID</label>
            <input type="text" name="uniqueID" id="uniqueID" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="name" class='form-label'>Name</label>
            <input type="text" name="name" id="name" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="email" class='form-label'>Email address</label>
            <input type="email" name="email" id="email" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="position" class='form-label'>Position</label>
            <select name="position" id="position" class="form-control" required>
              <option value="bed">Back End Developer</option>
              <option value="jd">Junior Developer</option>
              <option value="fed">Front End Developer</option>
              <option value="cs">Cyber Security</option>
              <option value="dd">Delivery Driver</option>
              <option value="fw">Factory Worker</option>
              <option value="hso">Health & Safety Officer</option>
              <option value="ir">Industry Researcher</option>
              <option value="bd">Brand Developer</option>
              <option value="pd">Product Designer</option>
              <option value="acc">Accountant</option>
              <option value="fa">Financial Analyst</option>
            </select>
        </div>

        <div class='mb-3'>
            <label for="salary" class='form-label'>Salary</label>
            <input type="text" name="salary" id="salary" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="dob" class='form-label'>Date of Birth</label>
            <input type="date" name="dob" id="dob" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="location" class='form-label'>Location</label>
            <select name="location" id="location" class="form-control" required>
              <option value="birm">Birmingham Office</option>
              <option value="engnorth">England North Distribution Centre</option>
              <option value="engsouth">England South Distribution Centre</option>
              <option value="kilburn">Kilburn Building</option>
              <option value="london">London Office</option>
              <option value="norire">Northern Ireland Distribution Centre</option>
              <option value="scotland">Scotland Distribution Centre</option>
              <option value="wales">Wales Distribution Centre</option>
            </select>
        </div>

        <div class='mb-3'>
            <label for="home" class='form-label'>Home address</label>
            <input type="text" name="home" id="home" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="hireddate" class='form-label'>Hired date</label>
            <input type="date" name="hireddate" id="hireddate" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="leave" class='form-label'>Amount of Leave</label>
            <input type="text" name="leave" id="leave" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="contract" class='form-label'>Contract</label>
            <select name="contract" id="contract" class="form-control" required>
              <option value="full">Full-time</option>
              <option value="part">Part-time</option>
              <option value="free">Freelance</option>
              <option value="intern">Internship</option>
            </select>
        </div>

        <div class='mb-3'>
            <label for="nin" class='form-label'>National Insurance Number</label>
            <input type="text" name="nin" id="nin" class="form-control" required>
        </div>

        <div class='mb-3'>
            <label for="emername" class='form-label'>Emergency Name</label>
            <input type="text" name="emername" id="emername" class="form-control">
        </div>

        <div class='mb-3'>
            <label for="emerrel" class='form-label'>Emergency Relationship</label>
            <input type="text" name="emerrel" id="emerrel" class="form-control">
        </div>

        <div class='mb-3'>
            <label for="emerphone" class='form-label'>Emergency Phone</label>
            <input type="text" name="emerphone" id="emerphone" class="form-control">
        </div>
        <input type="submit" value="Submit" class="btn btn-primary">
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="updateEmployee" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Update details</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <input type="text" name="id" id="id" placeholder="Search by employee ID..." class="form-control"><br>
          <button type="button" class="btn btn-primary" onclick="searchEmployee()">Search</button>
        </form>
        <div id="searchResults" class="mt-3">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="promotion" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Employee promotion</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form>
        <input type="text" name="promotionid" id="promotionid" placeholder="Search by employee ID..." class="form-control"><br>
        <button type="button" class="btn btn-primary" onclick="searchEmployeePromotion()">Search</button>
      </form>
        <div id="searchResultsPromote" class="mt-3">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="termination" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Employee termination</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form>
        <input type="text" name="terminationid" id="terminationid" placeholder="Search by employee ID..." class="form-control"><br>
        <button type="button" class="btn btn-primary" onclick="searchTermination()">Search</button>
      </form>
        <div id="searchTermination" class="mt-3">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

    
</body>
</html>