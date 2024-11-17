<?php
session_start();

// Enable detailed error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    include "db_conn.php"; // Ensure this file contains the correct database connection

    // Collect form data
    $title = $_POST['title'] ?? '';
    $details = $_POST['details'] ?? '';
    $type = $_POST['type'] ?? '';
    $date = $_POST['date'] ?? '';
    $name = $_POST['name'] ?? '';

    // Log input data for debugging
    file_put_contents('debug.log', "Form Data:\nTitle: $title\nDetails: $details\nType: $type\nDate: $date\nName: $name\n", FILE_APPEND);

    // Handle file upload
    if (isset($_FILES['image']['name']) && !empty($_FILES['image']['name'])) {
        $img_name = $_FILES['image']['name'];
        $tmp_name = $_FILES['image']['tmp_name'];
        $error = $_FILES['image']['error'];

        if ($error === 0) {
            $img_ex = pathinfo($img_name, PATHINFO_EXTENSION);
            $img_ex_to_lc = strtolower($img_ex);

            $allowed_exs = array('jpg', 'jpeg', 'png');
            if (in_array($img_ex_to_lc, $allowed_exs)) {
                $new_img_name = uniqid("IMG-", true) . '.' . $img_ex_to_lc;
                $img_upload_path = '../upload/' . $new_img_name;
                move_uploaded_file($tmp_name, $img_upload_path);
            } else {
                die("Invalid file type.");
            }
        } else {
            die("Error uploading file.");
        }
    }

    try {
        // Insert data into database
        $sql = "INSERT INTO report (title, details, type, image, date, name) 
                VALUES (?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$title, $details, $type, $new_img_name, $date, $name]);

        // Log success
        file_put_contents('debug.log', "Database insert successful.\n", FILE_APPEND);

        // Redirect with success message
        header("Location: ../index.php?success=Report submitted successfully");
    } catch (PDOException $e) {
        // Log error
        file_put_contents('debug.log', "Database error: " . $e->getMessage() . "\n", FILE_APPEND);
        die("Database error: " . $e->getMessage());
    }
} else {
    die("Invalid request.");
}
?>
