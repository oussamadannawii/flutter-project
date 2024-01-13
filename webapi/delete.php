<?php
// Include your database connection code here
include "conn.php";
// Check if the 'id' parameter is set
if (isset($_POST['id'])) {
    $userId = $_POST['id'];

    // Assuming $conn is your database connection
    // Adjust the table name and column names accordingly
    $sql = "DELETE FROM user_info WHERE id = $userId";

    if (mysqli_query($conn, $sql)) {
        // Successful deletion
        echo json_encode(['status' => 'success', 'message' => 'User deleted successfully']);
    } else {
        // Failed to delete
        echo json_encode(['status' => 'error', 'message' => 'Failed to delete user']);
    }
} else {
    // 'id' parameter is not set
    echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
}
?>
