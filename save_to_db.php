<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = ""; // Replace with your MySQL password
$dbname = "auth"; // Replace with your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get JSON data from the request
$data = json_decode(file_get_contents('php://input'), true);

if ($data) {
    foreach ($data as $item) {
        $key = $conn->real_escape_string($item['key']);
        $value = $conn->real_escape_string($item['value']);

        // Insert into the database
        $sql = "INSERT INTO local_storage (storage_key, storage_value) VALUES ('$key', '$value')";

        if (!$conn->query($sql)) {
            echo "Error: " . $conn->error;
        }
    }
    echo "Data saved successfully!";
} else {
    echo "No data received!";
}

$conn->close();
?>
