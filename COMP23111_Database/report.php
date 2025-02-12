<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

    <script>
    function tableToCSV() {

        let csv_data = [];

        let rows = document.getElementsByTagName('tr');
        for (let i = 0; i < rows.length; i++) {
            let cols = rows[i].querySelectorAll('td,th');
            let csvrow = [];
            for (let j = 0; j < cols.length; j++) {
                csvrow.push(cols[j].innerHTML);
            }

            csv_data.push(csvrow.join(","));
        }
        csv_data = csv_data.join('\n');
        downloadCSVFile(csv_data);
    }
    function downloadCSVFile(csv_data) {
        CSVFile = new Blob([csv_data], { type: "text/csv" });

        let temp_link = document.createElement('a');
        temp_link.download = "report.csv";

        let url = window.URL.createObjectURL(CSVFile);
        temp_link.href = url;
        temp_link.style.display = "none";
        document.body.appendChild(temp_link);
        temp_link.click();
        document.body.removeChild(temp_link);
    }
    function search() {
        let department = document.getElementById("department").value;
        let role = document.getElementById("role").value;
        let start = document.getElementById("start").value;
        let end = document.getElementById("end").value;

        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("searchResultsApply").innerHTML = this.responseText;
            }
        };

        xhr.open("GET", "report_process/payroll.php?department=" + encodeURIComponent(department) + "&role=" + encodeURIComponent(role) + "&start=" + encodeURIComponent(start) + "&end=" + encodeURIComponent(end), true);
        xhr.send();
    }
    function searchDept() {

        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("searchResultsApply").innerHTML = this.responseText;
            }
        };

        xhr.open("GET", "report_process/payrolldept.php", true);
        xhr.send();
    }
    function searchRole() {

    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("searchResultsApply").innerHTML = this.responseText;
        }
    };

    xhr.open("GET", "report_process/payrollrole.php", true);
    xhr.send();
    }
    function absent() {
        let start = document.getElementById("startAbs").value;
        let end = document.getElementById("endAbs").value;

        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("searchAbsent").innerHTML = this.responseText;
            }
        };

        xhr.open("GET", "report_process/absent.php?start=" + encodeURIComponent(start) + "&end=" + encodeURIComponent(end), true);
        xhr.send();
    }
    function audit() {
        let start = document.getElementById("startAbs").value;
        let end = document.getElementById("endAbs").value;

        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (this.readyState === 4 && this.status === 200) {
                document.getElementById("searchAudit").innerHTML = this.responseText;
            }
        };

        xhr.open("GET", "report_process/audit.php?start=" + encodeURIComponent(start) + "&end=" + encodeURIComponent(end), true);
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
</nav>

<div class="position-absolute top-50 start-50 translate-middle">
  <div class="d-grid gap-2 mx-auto">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#payrollSummary">
        Payroll Summary
        </button>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#absenteeismSummary">
        Absenteeism Summary
        </button>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#birthdaySummary">
        Birthday
        </button>
  </div>
</div>

<div class="modal fade" id="payrollSummary" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Payroll Summary</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">      
        <form action="report_process/payroll.php" method="get">
            <label for="department">Department</label>
            <select name="department" id="department" class="form-control">
                <option value="All" selected>All</option>
                <option value="Operations">Operations</option>
                <option value="Finance">Finance</option>
                <option value="Marketing">Marketing</option>
                <option value="Technology">Technology</option>
            </select>
            <label for="role">Position</label>
            <select name="role" id="role" class="form-control">
                <option value="all" selected>All</option>
                <option value="hso">Health & Safety Officer</option>
                <option value="fw">Factory Worker</option>
                <option value="dd">Delivery Driver</option>
                <option value="acc">Accountant</option>
                <option value="fa">Financial Analyst</option>
                <option value="bd">Brand Developer</option>
                <option value="ir">Industry Researcher</option>
                <option value="pd">Product Designer</option>
                <option value="fed">Front End Developer</option>
                <option value="bed">Back End Developer</option>
                <option value="fsd">Full Stack Developer</option>
                <option value="jd">Junior Developer</option>
                <option value="cs">Cyber Security</option>
            </select>
            <label for="start">Start date</label>
            <input type="date" name="start" id="start" class="form-control">
            <label for="end">End date</label>
            <input type="date" name="end" id="end" class="form-control"><br>
            <button type="button" class="btn btn-primary" onclick="search()">Summarise(by filter)</button>
            <button type="button" class="btn btn-secondary" onclick="searchDept()">By department</button>
            <button type="button" class="btn btn-secondary" onclick="searchRole()">By role</button>
        </form>
        <div id="searchResultsApply" class="mt-3">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="tableToCSV();" data-bs-dismiss="modal">Export to CSV</button>
        <button type="button" class="btn btn-primary" id="payroll_export" data-bs-dismiss="modal">Export to PDF</button>
      </div>
    </div>
  </div>
</div>

<script>
  document.getElementById("payroll_export").addEventListener('click', function () {
      // Import jsPDF
      const { jsPDF } = window.jspdf;

      // Create a new instance of jsPDF
      const doc = new jsPDF();

      // Use autoTable to parse HTML table
      doc.autoTable({ html: '#payroll_summary' });

      // Save the PDF
      doc.save('payroll.pdf');
    });
</script>

<div class="modal fade" id="absenteeismSummary" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Absenteeism Summary</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">      
        <form action="report_process/absent.php" method="get">
            <label for="start">Start date</label>
            <input type="date" name="startAbs" id="startAbs" class="form-control">
            <label for="end">End date</label>
            <input type="date" name="endAbs" id="endAbs" class="form-control"><br>
            <button type="button" class="btn btn-primary" onclick="absent()">Summarise</button>
        </form>
        <div id="searchAbsent" class="mt-3">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="tableToCSV();" data-bs-dismiss="modal">Export to CSV</button>
        <button type="button" class="btn btn-primary" id="absent_export" data-bs-dismiss="modal">Export to PDF</button>
      </div>
    </div>
  </div>
</div>

<script>
  document.getElementById("absent_export").addEventListener('click', function () {
      // Import jsPDF
      const { jsPDF } = window.jspdf;

      // Create a new instance of jsPDF
      const doc = new jsPDF();

      // Use autoTable to parse HTML table
      doc.autoTable({ html: '#absent_summary' });

      // Save the PDF
      doc.save('absent.pdf');
    });
</script>

<div class="modal fade" id="birthdaySummary" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Birthday</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <?php include "report_process/birthday.php" ?>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>