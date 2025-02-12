<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Directory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-" crossorigin="anonymous"></script>

    <script>
      function liveSearch() {

          let search = document.getElementById("search").value;

          // If input is empty, clear results
          if (search === "") {
              document.getElementById("searchResult").replaceChildren();
              return;
          }

          document.getElementById('initial_load').replaceChildren();

          const xhr = new XMLHttpRequest();
          xhr.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {
                    document.getElementById("searchResult").innerHTML = this.responseText;
                }
          };
            
          // Send the query to the PHP script
          xhr.open("GET", "directory_process/live_search.php?q=" + encodeURIComponent(search), true);
          xhr.send();
        }
    </script>
    <style>
      .employee_content {
        display: flex;
        flex-direction: row;
        border: medium solid #3A3B3C;
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
      <br>
      
      <div class="container d-flex justify-content-center mt-3">
        <div class="col-md-10">
          <input id="search" name="search" onkeyup="liveSearch()" type="text" class="form-control" aria-label="Search employee" placeholder="Search for employee (name, id, email)">
        </div><br>
      </div>

      <div class="container d-flex justify-content-center initial_load" id='initial_load' style="display:flex; flex-direction: column; width:900px">
      <?php include 'directory_process/initial_load.php'?>
      </div>
      <div class="container d-flex justify-content-center" id="searchResult" style="display:flex; flex-direction: column; width:900px">
      </div>

</body>
</html>