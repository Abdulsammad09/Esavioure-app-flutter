<?php
include('../connection.php');
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *"); // Adjust as needed for security
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Function to sanitize inputs
function sanitize_input($data) {
    return htmlspecialchars(strip_tags(trim($data)));
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve and sanitize POST data
    $hospital_name = isset($_POST['hospital_name']) ? sanitize_input($_POST['hospital_name']) : null;
    $driver_name = isset($_POST['driver_name']) ? sanitize_input($_POST['driver_name']) : null;
    $patient_name = isset($_POST['patient_name']) ? sanitize_input($_POST['patient_name']) : null;
    $contact_number = isset($_POST['contact_number']) ? sanitize_input($_POST['contact_number']) : null;
    $special_requirements = isset($_POST['special_requirements']) ? sanitize_input($_POST['special_requirements']) : null;

    // Validate required fields
    if (!$hospital_name || !$driver_name || !$patient_name || !$contact_number) {
        echo json_encode(["status" => "error", "message" => "Hospital Name, Driver Name, Patient Name, and Contact Number are required."]);
        exit();
    }

    // Optional: Validate contact number format
    if (!preg_match("/^\+?\d{10,15}$/", $contact_number)) {
        echo json_encode(["status" => "error", "message" => "Invalid contact number format."]);
        exit();
    }

    // Prepare an SQL statement to prevent SQL injection
    $stmt = $conn->prepare("INSERT INTO non_emergency (hospital_name, driver_name, patient_name, contact_number, special_requirements, status) VALUES (?, ?, ?, ?, ?, 'waiting_list')");
    $stmt->bind_param("sssss", $hospital_name, $driver_name, $patient_name, $contact_number, $special_requirements);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Data submitted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
    }

    // Close the statement and connection
    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}

$conn->close();
?>
