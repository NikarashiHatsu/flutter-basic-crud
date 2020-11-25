<?php

error_reporting(E_ALL);
header('Content-Type: application/json');

if(!isset($_GET['id']) && !isset($_GET['username'])) {
	http_response_code(500);
	die(
		json_encode([
			'message' => 'Parameter id and username is required'
		])
	);
}

$id = $_GET['id'];
$username = $_GET['username'];

$db = mysqli_connect('localhost', 'root', 'root', 'test');
$sql = "UPDATE users SET username = '$username' WHERE id = $id";
$query = mysqli_query($db, $sql);

if($query) {
		echo json_encode([
			'message' => 'success',
		], JSON_NUMERIC_CHECK);
}

?>