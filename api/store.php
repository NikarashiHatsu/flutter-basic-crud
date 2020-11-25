<?php

error_reporting(E_ALL);
header('Content-Type: application/json');

if(!isset($_GET['username'])) {
	http_response_code(500);
	die(
		json_encode([
			'message' => 'Parameter username is required'
		])
	);
} else {
	$username = $_GET['username'];
}

$db = mysqli_connect('localhost', 'root', 'root', 'test');
$sql = "INSERT INTO users(username) VALUES('$username')";
$query = mysqli_query($db, $sql);

if($query) {
		echo json_encode([
			'message' => 'success',
		], JSON_NUMERIC_CHECK);
}

?>