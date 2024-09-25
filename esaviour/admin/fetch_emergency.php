<?php
header('Content-Type: application/json'); // Set content type to JSON
header("Access-Control-Allow-Origin: *"); // Allow all origins (for testing purposes)
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include('../connection.php');

// Prepare the query to select emergency data
$sql = "SELECT * FROM emergency"; // Fetch all columns from the emergency table
$result = $conn->query($sql);

$emergency_data = [];

// Check if there are any results
if ($result->num_rows > 0) {
    // Fetch the results and store them in the $emergency_data array
    while ($row = $result->fetch_assoc()) {
        $emergency_data[] = $row;  // Store the entire row
    }
}

// Output the emergency data as JSON
echo json_encode($emergency_data);

// Close the database connection
$conn->close();
?>
