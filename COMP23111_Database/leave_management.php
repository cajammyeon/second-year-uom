<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leave management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-" crossorigin="anonymous"></script>
    <style>
        .application {
            display: flex;
            flex-direction: column;
            flex-wrap: wrap;
            border: medium solid #3A3B3C;
            border-radius: 2em;
            padding: 2em;
            margin: 3em;
            color: white;
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
<div style="display:flex; flex-direction: row; flex-wrap : wrap;">
    <?php include "leave_process/management_load.php"?>
</div>
</body>
</html>