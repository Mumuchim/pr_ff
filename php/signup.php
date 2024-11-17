<?php 

if (isset($_POST['fname']) && 
    isset($_POST['lname']) && 
    isset($_POST['email']) &&  
    isset($_POST['pass']) && 
    isset($_POST['role'])) { // Check if role is set

    include "../db_conn.php";

    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $email = $_POST['email'];
    $pass = $_POST['pass'];
    $role = $_POST['role']; // Capture the role

    $data = "fname=" . $fname . "&lname=" . $lname . "&email=" . $email;
    
    if (empty($fname)) {
        $em = "First name is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($lname)) {
        $em = "Last name is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($email)) {
        $em = "Email is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($pass)) {
        $em = "Password is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($role) || !in_array($role, ['student', 'admin'])) { // Validate role
        $em = "Invalid role selected";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else {
        // Hashing the password
        $pass = password_hash($pass, PASSWORD_DEFAULT);

        // Insert into Database
        $sql = "INSERT INTO users (fname, lname, email, password, role) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$fname, $lname, $email, $pass, $role]); // Include role in the query

        header("Location: ../index.php?success=Your account has been created successfully");
        exit;
    }

} else {
    header("Location: ../index.php?error=error");
    exit;
}
