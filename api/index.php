<?php

error_reporting(E_ALL);
header('Content-Type: application/json');

$db = mysqli_connect('localhost', 'root', 'root', 'test');
$sql = "SELECT * FROM users";
$query = mysqli_query($db, $sql);
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);

echo json_encode($data, JSON_NUMERIC_CHECK);

?>