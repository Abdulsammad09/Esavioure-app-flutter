<?php
// Include your database connection file
include '../connection.php'; // Adjust the path as necessary

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Check if keys exist in the POST request
    if (isset($_POST['id']) && !empty($_POST['id']) && isset($_POST['status']) && !empty($_POST['status'])) {
        // Get the id and status from POST request
        $id = $_POST['id'];
        $status = $_POST['status'];

        // Check if the status is a valid ENUM value
        $validStatuses = ['waiting_list', 'accept', 'complete'];
        if (in_array($status, $validStatuses)) {
            // Prepare the update query
            $sql = "UPDATE emergency SET status = ? WHERE id = ?";
            $stmt = $conn->prepare($sql);
            
            if ($stmt) {
                $stmt->bind_param('si', $status, $id);
                if ($stmt->execute()) {
                    echo "Status updated successfully";
                } else {
                    echo "Error updating status: " . $stmt->error;
                }
                $stmt->close();
            } else {
                echo "Error preparing statement: " . $conn->error;
            }
        } else {
            echo "Invalid status value";
        }
    } else {
        echo "Required fields missing";
    }
} else {
    echo "Invalid request method";
}

// Close the connection
$conn->close();
?>
