<?php
// Include database connection
include "../db_conn.php";

try {
    // Retrieve all pins from the database
    $stmt = $pdo->query("SELECT * FROM pins");
    $pins = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Return the pins as JSON
    echo json_encode($pins);
} catch (Exception $e) {
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
?>
