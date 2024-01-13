<?php include 'conn.php';
$sql = "SELECT * FROM user_info";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $rows = array();
    // Fetch rows as associative array
    while($row = $result->fetch_assoc()) {
        $rows[] = $row;
        
    }
    // Set response header to JSON
    header('Content-Type: application/json');
    // Return fetched data as JSON
    echo json_encode($rows);
} else {
    echo "0 results";
}
$conn->close();
?>