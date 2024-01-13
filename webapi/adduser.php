<?php
session_start();
include 'conn.php';
if($_SERVER['REQUEST_METHOD']=='POST'){
$username=$_POST['username'];
$location=$_POST['relocation'];
$payment=$_POST['payment'];
$regs=$_POST['regtype'];
$insertQuery = "INSERT INTO user_info (name,location,payment,RegType,date) values ('$username','$location','$payment','$regs',NOW())";
$stmt=$conn->query($insertQuery);
if($stmt){
echo json_encode(array("status" =>"done"));
}}else{
echo json_encode(array("status" => "failure"));
}
?>