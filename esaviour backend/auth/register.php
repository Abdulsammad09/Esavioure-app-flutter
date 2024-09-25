<?php
include('../connection.php');
header('Content-Type: application/json');


// Get the raw POST data from the request
$input = file_get_contents('php://input');

// Check if input is empty
if (empty($input)) {
    echo json_encode(['success' => false, 'message' => 'No input data received']);
    exit();
}

// Decode the JSON data into an associative array
$data = json_decode($input, true);

// Check if JSON decoding failed
if (is_null($data)) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON data']);
    exit();
}

// Check if all required fields are present
if (!isset($data['name']) || !isset($data['email']) || !isset($data['password']) || !isset($data['phone'])) {
    echo json_encode(['success' => false, 'message' => 'Missing required fields']);
    exit();
}

// Extract individual fields
$name = $data['name'];
$email = $data['email'];
$password = password_hash($data['password'], PASSWORD_DEFAULT); // Hash the password for security
$phone = $data['phone'];
$role = 'user'; 

// Prepare SQL query to insert the data
$stmt = $conn->prepare("INSERT INTO userss (name, email, password, phone,role) VALUES (?, ?, ?, ?,?)");
$stmt->bind_param("sssss", $name, $email, $password, $phone,$role);

// Execute the query
if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Registration successful']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to register user: ' . $stmt->error]);
}

// Close the statement and connection
$stmt->close();
$conn->close();
?>
