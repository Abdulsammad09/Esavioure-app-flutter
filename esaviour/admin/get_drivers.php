<?php
header('Content-Type: application/json'); // Set content type to JSON
header("Access-Control-Allow-Origin: *"); // Allow all origins (for testing purposes)
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include('../connection.php');

// Prepare the query to select drivers
$sql = "SELECT id, name FROM userss WHERE role = 'driver'"; // Ensure 'id' and 'name' are correct fields
$result = $conn->query($sql);

$drivers = [];

// Check if there are any results
if ($result->num_rows > 0) {
    // Fetch the results and store them in the $drivers array
    while ($row = $result->fetch_assoc()) {
        $drivers[] = $row;  // Store id and name of the driver
    }
}

// Output the drivers as JSON
echo json_encode($drivers);

// Close the database connection
$conn->close();
?>
