<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

$conn = mysqli_connect('localhost','root','','esaviour');

if (!$conn) {
    echo "database fail";
}


?>