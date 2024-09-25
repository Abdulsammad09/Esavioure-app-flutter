<?php
include('../connection.php');
header('Content-Type: application/json');
$method = $_SERVER['REQUEST_METHOD'];
$userId = $_GET['id'] ?? null;

if ($method === 'GET' && $userId) {
    $stmt = $conn->prepare("SELECT id, email, name, phone FROM userss WHERE id = ?");
    $stmt->bind_param("i", $userId);
    
    if ($stmt->execute()) {
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            echo json_encode(['success' => true, 'user' => $user]);
        } else {
            echo json_encode(['success' => false, 'message' => 'User not found']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Query execution failed']);
        error_log($stmt->error); // Log the error
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request']);
}

$conn->close();
