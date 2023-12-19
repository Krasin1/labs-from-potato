<?php
require_once('../config.php');
function checkUserExists($mysqli, $loginCheck, $emailCheck)
{
    $stmt = $mysqli->prepare("SELECT * FROM users WHERE name=? or email=?"); 
    $stmt->bind_param("ss", $loginCheck, $emailCheck);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
}
?>