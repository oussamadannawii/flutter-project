<?php 
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
$servername = 'localhost';
$username = 'root'; // Or your database username
$password = ''; // Your database password
$dbname = 'application';
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}?>