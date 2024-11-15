<?php
// Include database connection
include "../db_conn.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $pinId = $_POST['pinId'];
    $top = $_POST['top'];
    $left = $_POST['left'];
    $imgSrc = $_POST['imgSrc'];

    try {
        // Insert pin data into the database
        $stmt = $pdo->prepare("INSERT INTO pins (pin_id, top, left, img_src) VALUES (?, ?, ?, ?)");
        $stmt->execute([$pinId, $top, $left, $imgSrc]);
        
        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
