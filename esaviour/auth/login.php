<?php
include('../connection.php');
header('Content-Type: application/json');

$input = file_get_contents('php://input');
error_log($input); // Log raw input for debugging

if (empty($input)) {
    echo json_encode(['success' => false, 'message' => 'No input data received']);
    exit();
}

$data = json_decode($input, true);
error_log(print_r($data, true)); // Log decoded JSON

if (is_null($data)) {
    echo json_encode(['success' => false, 'message' => 'Invalid JSON data']);
    exit();
}

if (!isset($data['email']) || !isset($data['password'])) {
    echo json_encode(['success' => false, 'message' => 'Email and password are required']);
    exit();
}

$email = $data['email'];
$password = $data['password'];

// Prepare SQL query to find the user by email
$stmt = $conn->prepare("SELECT id, name, email, password, role FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        echo json_encode([
            'success' => true,
            'message' => 'Login successful',
            'user' => [
                'id' => $user['id'],
                'name' => $user['name'],
                'email' => $user['email'],
                'role' => $user['role']
            ]
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid credentials']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'User not found']);
}

$stmt->close();
$conn->close();
?>
