<?php
include('../connection.php');

// Check if the request method is POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the raw POST data
    $data = json_decode(file_get_contents("php://input"), true);

    // Check if data is not empty
    if ($data) {
        // Get data from the decoded JSON
        $hospitalName = $data['hospital_name'] ?? '';
        $driverName = $data['driver_name'] ?? '';
        $patientName = $data['patient_name'] ?? '';
        $pickupLocation = $data['pickup_location'] ?? '';
        $dropoffLocation = $data['dropoff_location'] ?? '';
        $contactNumber = $data['contact_number'] ?? '';
        $appointmentDate = $data['appointment_date'] ?? '';
        $serviceType = $data['service_type'] ?? '';
        $specialRequirements = $data['special_requirements'] ?? '';

        // Prepare and bind
        $stmt = $conn->prepare("INSERT INTO pre_planned_bookings (hospital_name, driver_name, patient_name, pickup_location, dropoff_location, contact_number, appointment_date, service_type, special_requirements) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssssss", $hospitalName, $driverName, $patientName, $pickupLocation, $dropoffLocation, $contactNumber, $appointmentDate, $serviceType, $specialRequirements);

        // Execute the statement
        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "New record created successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
        }

        // Close connection
        $stmt->close();
    } else {
        echo json_encode(["status" => "error", "message" => "No data received"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}

$conn->close();
?>
