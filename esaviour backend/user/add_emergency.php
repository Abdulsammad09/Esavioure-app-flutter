<?php
include('../connection.php');
header("Content-Type: application/json");



// Function to sanitize inputs
function sanitize_input($data) {
    return htmlspecialchars(strip_tags(trim($data)));
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve and sanitize POST data
    $hospital_name = isset($_POST['hospital_name']) ? sanitize_input($_POST['hospital_name']) : null;
    $patient_name = isset($_POST['patient_name']) ? sanitize_input($_POST['patient_name']) : null;
    $basic_and_advance_type = isset($_POST['basic_and_advance_type']) ? sanitize_input($_POST['basic_and_advance_type']) : null;
    $number = isset($_POST['number']) ? sanitize_input($_POST['number']) : null;
    $zip_code = isset($_POST['zip_code']) ? sanitize_input($_POST['zip_code']) : null;

    // Validate required fields
    if (!$hospital_name || !$patient_name || !$basic_and_advance_type || !$number || !$zip_code) {
        echo json_encode(["status" => "error", "message" => "All fields are required."]);
        exit();
    }

    // Prepare an SQL statement to prevent SQL injection
    $stmt = $conn->prepare("INSERT INTO emergency (hospital_name, patient_name, basic_and_advance_type, number, zip_code) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $hospital_name, $patient_name, $basic_and_advance_type, $number, $zip_code);

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
