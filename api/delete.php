<?php

error_reporting(E_ALL);
header('Content-Type: application/json');

if(!isset($_GET['id'])) {
	http_response_code(500);
	die(
		json_encode([
			'message' => 'Parameter id is required'
		])
	);
}

$id = $_GET['id'];

$db = mysqli_connect('localhost', 'root', 'root', 'test');
$sql = "DELETE FROM users WHERE id = $id";
$query = mysqli_query($db, $sql);

if($query) {
		echo json_encode([
			'message' => 'success',
		], JSON_NUMERIC_CHECK);
}

?>