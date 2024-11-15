<?php 

if (isset($_POST['title']) && 
    isset($_POST['details']) &&  
    isset($_POST['type']) &&  
    isset($_POST['date'])) {

    include "../db_conn.php";

    $title = $_POST['title'];
    $details = $_POST['details'];
    $type = $_POST['type'];
    $date = $_POST['date'];

    $data = "title=" . $title . "&details=" . $details . "&type=" . $type . "&date=" . $date;

    if (empty($title)) {
        $em = "Title is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($details)) {
        $em = "Details are required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($type)) {
        $em = "Type is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else if (empty($date)) {
        $em = "Date is required";
        header("Location: ../index.php?error=$em&$data");
        exit;
    } else {

        // Handle image upload if provided
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

                    // Insert into the `report` table with the uploaded image
                    $sql = "INSERT INTO report (title, details, type, image, date) 
                            VALUES (?, ?, ?, ?, ?)";
                    $stmt = $conn->prepare($sql);
                    $stmt->execute([$title, $details, $type, $new_img_name, $date]);

                    header("Location: ../index.php?success=Report submitted successfully");
                    exit;
                } else {
                    $em = "You can't upload files of this type";
                    header("Location: ../index.php?error=$em&$data");
                    exit;
                }
            } else {
                $em = "Unknown error occurred!";
                header("Location: ../index.php?error=$em&$data");
                exit;
            }
        } else {
            // Insert into the `report` table without an image (use default)
            $sql = "INSERT INTO report (title, details, type, date) 
                    VALUES (?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->execute([$title, $details, $type, $date]);

            header("Location: ../index.php?success=Report submitted successfully");
            exit;
        }
    }
} else {
    header("Location: ../index.php?error=Missing required fields");
    exit;
}
