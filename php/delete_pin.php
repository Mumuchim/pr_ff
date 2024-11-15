<?php
// Include database connection
include "../db_conn.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $pinId = $_POST['pinId'];

    try {
        // Delete the pin from the database
        $stmt = $pdo->prepare("DELETE FROM pins WHERE pin_id = ?");
        $stmt->execute([$pinId]);

        echo json_encode(['status' => 'success']);
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}
?>
