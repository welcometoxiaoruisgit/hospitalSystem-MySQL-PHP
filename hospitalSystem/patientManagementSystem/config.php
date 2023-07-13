<?php
$servername = "localhost";
$username = "root";
$password = "661158";
$dbname = "hospitals";

$conn = mysqli_connect($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    echo"<script>alert('Failed to connect£¡')</script>";
}
?>
