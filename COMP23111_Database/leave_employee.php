<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave employee</title>
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

        xhr.open("GET", "leave_process/leave_status_load.php?q=" + encodeURIComponent(search), true);
        xhr.send();
      }
      function searchLeave() {
        let search = document.getElementById("leaveidsearch").value;
        
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
          if (this.readyState === 4 && this.status === 200) {
            document.getElementById("searchResultsApply").innerHTML = this.responseText;
          }
        };

        xhr.open("GET", "leave_process/application_load.php?q=" + encodeURIComponent(search), true);
        xhr.send();
      }
    </script>
    <style>
      .hidden {
        display: none;
      }
      .employee_content {
        display: flex;
        flex-direction: row;
        border: thin solid white;
        border-radius: 2em;
        padding: 2em;
        margin-top: 3em;
        color: white;
        justify-content: center;
      }
      .employee_content :hover {
        background-color: #494848;
      }
      .content_inner {
        display: flex;
        margin-left: 4em;
        flex-direction: column;
        justify-content: center;
      }
    </style>

</head>
<body style="background-color : #2F2F2F;">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
          <a class="navbar-brand" href="#">Kilburnazon Employee System</a>
        </div>
    </nav>
    <br>

    <div class="position-absolute top-50 start-50 translate-middle">
        <div class="d-grid gap-2 mx-auto">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#leaveStatus">
            Leave status
            </button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#leaveApplication">
            Leave application
            </button>
        </div>
    </div>

    <div class="modal fade" id="leaveStatus" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Leave status</h1>
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

    <div class="modal fade" id="leaveApplication" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Leave application</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form>
                    <input type="text" name="leaveidsearch" id="leaveidsearch" placeholder="Search by employee ID..." class="form-control"><br>
                    <button type="button" class="btn btn-primary" onclick="searchLeave()">Search</button>
                </form>
                <div id="searchResultsApply" class="mt-3">
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