    <?php
    header('Content-Type: application/json'); // Set content type to JSON
    header("Access-Control-Allow-Origin: *"); // Allow all origins (for testing purposes)
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    header("Access-Control-Allow-Headers: Content-Type");

    include('../connection.php');

    // Prepare the query to select pre-planned bookings data
    $sql = "SELECT * FROM pre_planned_bookings"; // Fetch all columns from the table
    $result = $conn->query($sql);

    $pre_planned_data = [];

    // Check if there are any results
    if ($result->num_rows > 0) {
        // Fetch the results and store them in the $pre_planned_data array
        while ($row = $result->fetch_assoc()) {
            $pre_planned_data[] = $row;  // Store the entire row
        }
    }

    // Output the pre-planned data as JSON
    echo json_encode($pre_planned_data);

    // Close the database connection
    $conn->close();
    ?>
