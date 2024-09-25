<?php
header('Content-Type: application/json'); // Set content type to JSON
header("Access-Control-Allow-Origin: *"); // Allow all origins (for testing purposes)
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include('../connection.php');

// Prepare the query to select ambulances and their associated drivers
$sql = "
    SELECT 
        ambulances.id AS ambulance_id, 
        ambulances.hospital_name, 
        userss.name AS driver_name, 
        userss.phone AS mobile, 
        ambulances.ambulance_type, 
        ambulances.zip_code, 
        ambulances.status, 
        ambulances.driver_id 
    FROM 
        ambulances 
    JOIN 
        userss ON ambulances.driver_id = userss.id 
    WHERE 
        userss.role = 'driver' AND 
        ambulances.status = 'available'
";

$result = $conn->query($sql);

$data = [];

// Check if there are any results
if ($result->num_rows > 0) {
    // Fetch the results and store them in the $data array
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;  // Store ambulance data along with driver data
    }
}

// Output the data as JSON
echo json_encode($data);

// Close the database connection
$conn->close();
?>
