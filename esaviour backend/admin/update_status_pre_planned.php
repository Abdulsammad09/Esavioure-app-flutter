<?php
include('../connection.php');
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Function to sanitize inputs
function sanitize_input($data) {
    return htmlspecialchars(strip_tags(trim($data)));
}

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $id = isset($input['id']) ? sanitize_input($input['id']) : null;
    $status = isset($input['status']) ? sanitize_input($input['status']) : null;

    if (!$id || !$status) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "ID and Status are required."]);
        exit();
    }

    // Prepare an SQL statement to prevent SQL injection
    $stmt = $conn->prepare("UPDATE pre_planned_bookings SET status = ? WHERE id = ?");
    $stmt->bind_param("si", $status, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            echo json_encode(["status" => "success", "message" => "Status updated successfully"]);
        } else {
            http_response_code(404);
            echo json_encode(["status" => "error", "message" => "No record found with the given ID"]);
        }
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => "Error: " . $stmt->error]);
    }

    $stmt->close();
} else {
    http_response_code(405);
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}

$conn->close();
?>
