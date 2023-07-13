<!DOCTYPE html>
<html>
<head>
    <title>Patient Management</title>
	<link rel="stylesheet" type="text/css" href="patientManagement.css">
</head>
<body>

<div class="web">

<h1>Patient Management</h1>

<!-- Add patient -->
<form action="" method="post">
	<input type="text" name="patID" placeholder="Patient ID">
    <input type="text" name="patName" placeholder="Patient Name">
    <input type="text" name="patGender" placeholder="Patient Gender">
    <input type="text" name="patAge" placeholder="Patient Age">
    <input type="text" name="patPhoneNum" placeholder="Patient Phone Number">
    <input type="text" name="disease" placeholder="Disease">
    <input type="text" name="treatment" placeholder="Treatment">
    <input type="text" name="days" placeholder="Course">
    <input type="text" name="primaryDocID" placeholder="Primary Doctor ID">
    <input type="text" name="patLocation" placeholder="Patient Location">
    <input type="text" name="admitLocation" placeholder="Admitted Location">

    <button type="submit" name="add_patient">Add Patient</button>
</form>
<br>

<!-- Update patient -->
<form action="" method="post">
    <input type="text" name="patID" placeholder="Patient ID">
    <input type="text" name="disease" placeholder="New Disease">
    <input type="text" name="treatment" placeholder="New Treatment">
	<input type="text" name="days" placeholder="New Course">

    <button type="submit" name="update_patient">Update Patient</button>
</form>
<br>

<!-- Delete patient -->
<form action="" method="post">
    <input type="text" name="patID" placeholder="Patient ID">

    <button type="submit" name="delete_patient">Delete Patient</button>
</form>
<br>


<?php
include 'config.php';

if (isset($_POST['add_patient'])) {
    $patID = $_POST['patID'];
    $patName = $_POST['patName'];
    $patGender = $_POST['patGender'];
    $patAge = $_POST['patAge'];
    $patPhoneNum = $_POST['patPhoneNum'];
    $disease = $_POST['disease'];
    $treatment = $_POST['treatment'];
    $days = $_POST['days'];
    $primaryDocID = $_POST['primaryDocID'];
    $patLocation = $_POST['patLocation'];
    $admitLocation = $_POST['admitLocation'];

    $sql = "insert into patient (patID, patName, patGender, patAge, patPhoneNum, disease, treatment, days, primaryDocID, patLocation, admitLocation)
            values ('$patID', '$patName', '$patGender', '$patAge', '$patPhoneNum', '$disease', '$treatment', '$days', '$primaryDocID', '$patLocation', '$admitLocation')";

    if (mysqli_query($conn,$sql) == 1) {
        echo "<script>alert('New patient record created successfully!');window.history.go(-1)</script>";
    } else {
        echo "<script>alert('Please enter the correct patient information£¡');window.history.go(-1)</script>";
    }
}

if (isset($_POST['update_patient'])) {
	$patID = $_POST['patID'];
    $disease = $_POST['disease'];
    $treatment = $_POST['treatment'];
    $days = $_POST['days'];

    $sql = "update patient set disease = '$disease', treatment = '$treatment', days = '$days'
            where patID = '$patID'";

    if (mysqli_query($conn,$sql) == 1) {
        echo "<script>alert('Patient record updated successfully!');window.history.go(-1)</script>";
    } else {
        echo "<script>alert('Please enter the correct patient information£¡');window.history.go(-1)</script>";
    }
}

if (isset($_POST['delete_patient'])) {
    $patID = $_POST['patID'];

    $sql = "delete from patient where patID = '$patID'";

    if (mysqli_query($conn,$sql) == 1) {
        echo "<script>alert('Patient record deleted successfully!');window.history.go(-1)</script>";
    } else {
        echo "<script>alert('Please enter the correct patient information£¡');window.history.go(-1)</script>";
    }
}

$sql = "select * from patient"; 
$result = mysqli_query($conn,$sql);

$sql1 = "select t.patientID, t.doctorID, d.docName, d.hospName from treatment t,doctor d where t.doctorID = d.docID";
$result1 = mysqli_query($conn,$sql1);
?>


<style>
    table {
        border-collapse: separate;
        border-spacing: 0;
        width: 100%;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
</style>

<table>
	<caption>Patient Information</caption>
    <tr>
        <th>ID</th>
        <th>Name</th>
		<th>Gender</th>
		<th>Age</th>
		<th>Phone Number</th>
		<th>Disease</th>
		<th>Treatment</th>
		<th>Course</th>
		<th>Primary Doctor</th>
		<th>Address</th>
		<th>Admitted Location</th>	
    </tr>
    <?php while ($row = mysqli_fetch_array($result)): ?>
        <tr>
		<?php
            echo "<td>".$row[1]."</td>";
            echo "<td>".$row[2]."</td>";
			echo "<td>".$row[3]."</td>";
			echo "<td>".$row[4]."</td>";
			echo "<td>".$row[5]."</td>";
			echo "<td>".$row[6]."</td>";
			echo "<td>".$row[7]."</td>";
			echo "<td>".$row[8]."</td>";
			echo "<td>".$row[9]."</td>";
			echo "<td>".$row[10]."</td>";
			echo "<td>".$row[11]."</td>";
			?>
        </tr>
    <?php endwhile; ?>
</table>

<style>
    table {
        border-collapse: separate;
        border-spacing: 0;
        width: 100%;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
</style>
<br><br>

<table>
	<caption>Treatment Information</caption>
    <tr>
        <th>Patient ID</th>
        <th>Doctor ID</th>
		<th>Doctor Name</th>
		<th>Hospital Name</th>
    </tr>
    <?php while ($row = mysqli_fetch_array($result1)): ?>
        <tr>
		<?php
            echo "<td>".$row[0]."</td>";
            echo "<td>".$row[1]."</td>";
			echo "<td>".$row[2]."</td>";
			echo "<td>".$row[3]."</td>";
			?>
        </tr>
    <?php endwhile; ?>
</table>


 </div>
 
</body>
</html>

<?php mysqli_close($conn); ?>
