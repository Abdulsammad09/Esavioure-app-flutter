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
    // Retrieve and sanitize POST data
    $id = isset($_POST['id']) ? sanitize_input($_POST['id']) : null;
    $status = isset($_POST['status']) ? sanitize_input($_POST['status']) : null;

    // Validate required fields
    if (!$id || !$status) {
        echo json_encode(["status" => "error", "message" => "ID and Status are required."]);
        exit();
    }

    // Prepare an SQL statement to prevent SQL injection
    $stmt = $conn->prepare("UPDATE non_emergency SET status = ? WHERE id = ?");
    $stmt->bind_param("si", $status, $id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            echo json_encode(["status" => "success", "message" => "Status updated successfully"]);
        } else {
            echo json_encode(["status" => "error", "message" => "No record found with the given ID"]);
        }
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
