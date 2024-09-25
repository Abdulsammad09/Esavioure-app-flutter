<?php
include('../connection.php');

error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get JSON input
    $data = json_decode(file_get_contents('php://input'), true);
    
    $hospital_name = $data['hospital_name'] ?? null;
    $mobile_address = $data['mobile'] ?? null;
    $ambulance_type = $data['ambulance_type'] ?? null;
    $zip_code = $data['zip_code'] ?? null;
    $status = $data['status'] ?? null;
    $driver_id = $data['driver_id'] ?? null;

    // Basic validation
    if (empty($hospital_name) || empty($mobile_address) || empty($ambulance_type) || empty($zip_code) || empty($status) || empty($driver_id)) {
        echo json_encode(["success" => false, "error" => "All fields are required."]);
        exit;
    }

    // Prepare and execute SQL statement
    $sql = "INSERT INTO ambulances (hospital_name, mobile, ambulance_type, zip_code, status, driver_id) VALUES (?, ?, ?, ?, ?, ?)";
    
    $stmt = $conn->prepare($sql);
    
    if (!$stmt) {
        echo json_encode(["success" => false, "error" => "Prepare Error: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("sssssi", $hospital_name, $mobile_address, $ambulance_type, $zip_code, $status, $driver_id);

    if ($stmt->execute()) {
        echo json_encode(["success" => true]);
    } else {
        error_log("Execution Error: " . $stmt->error);
        echo json_encode(["success" => false, "error" => "Database error. Please try again."]);
    }

    $stmt->close();
}

$conn->close();
?>
