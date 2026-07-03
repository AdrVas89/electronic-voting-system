<?php
session_start();

$host = "localhost";
$user = "root";
$password = "";
$database = "electronic_voting_system";

$conn = new mysqli($host, $user, $password, $database);
// Starts the session so user login information can be stored across pages
session_start();

// Database connection details for the local MySQL database
if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}
?>