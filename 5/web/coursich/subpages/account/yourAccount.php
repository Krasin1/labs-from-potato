<?php
require_once "../config.php";
require_once "checkFunctions.php";
session_start();
global $error;
$error = '';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])) {

    $name = trim($_POST['name']);
    $email = trim($_POST['email']);
    $entered_password = trim($_POST['password']);
    $real_passwordVerify = trim($_POST['passwordVerify']);
    $nickname = $_POST['fullname'];
    $description = $_POST['description'];
    $userID = $_SESSION['userId'];

    $user = checkUserExists($db, $name, $email);
    if ($user) {
        if ($user['name'] == $name) {
            $error = '<div style="background: rgb(104, 0, 0);
                        border: 0.125rem solid;
                        padding: 8px;
                        border-radius: 10px;
                        display:inline-block;
                        color: rgb(184, 0, 0);">This username is already taken</div>';
        } else if ($user['email'] == $email) {
            $error = '<div style="background: rgb(104, 0, 0);
                        border: 0.125rem solid;
                        padding: 8px;
                        border-radius: 10px;
                        display:inline-block;
                        color: rgb(184, 0, 0);">This email is already taken</div>';
        }
    }

    if(!empty($name) && empty($error)) {
        $query = "UPDATE users SET name=(?) WHERE id=$userID";
        $statement = $db->prepare($query);
        $statement->bind_param('s', $name);
        $statement->execute();
        $_SESSION['userLogin'] = $name;
        $error = '<div style="background: rgb(28, 0, 104);
                            border: 0.125rem solid;
                            padding: 8px;
                            border-radius: 10px;
                            display:inline-block;
                            color: rgb(28, 0, 184);"> Info has been changed. </div>';
    }
    if(!empty($email) && empty($error)) {
        $query = "UPDATE users SET email=(?) WHERE id=$userID";
        $statement = $db->prepare($query);
        $statement->bind_param('s', $email);
        $statement->execute();
        $_SESSION['userEmail'] = $email;
        $error = '<div style="background: rgb(28, 0, 104);
                            border: 0.125rem solid;
                            padding: 8px;
                            border-radius: 10px;
                            display:inline-block;
                            color: rgb(28, 0, 184);"> Info has been changed. </div>';
    }
    if(!empty($nickname)) {
        $query = "UPDATE users SET fullname=(?) WHERE id=$userID";
        $statement = $db->prepare($query);
        $statement->bind_param('s', $nickname);
        $statement->execute();
        $_SESSION['userFullname'] = $nickname;
        $error = '<div style="background: rgb(28, 0, 104);
                            border: 0.125rem solid;
                            padding: 8px;
                            border-radius: 10px;
                            display:inline-block;
                            color: rgb(28, 0, 184);"> Info has been changed. </div>';
    }
    if(!empty($description)) {
        $query = "UPDATE users SET description=(?) WHERE id=$userID";
        $statement = $db->prepare($query);
        $statement->bind_param('s', $description);
        $statement->execute();
        $_SESSION['userDescription'] = $description;
        $error = '<div style="background: rgb(28, 0, 104);
                            border: 0.125rem solid;
                            padding: 8px;
                            border-radius: 10px;
                            display:inline-block;
                            color: rgb(28, 0, 184);"> Info has been changed. </div>';
    }
    if (!empty($entered_password)) {
        if ($entered_password!=$real_passwordVerify) {
            $error = '<div style="background: rgb(104, 85, 0);
                                border: 0.125rem solid;
                                padding: 8px;
                                border-radius: 10px;
                                display:inline-block;
                                color: rgb(184, 150, 0);">Password did not match.</div>';
        } else if (password_verify($entered_password, $_SESSION['userPassword'])) {
            $error = '<div style="background: rgb(104, 85, 0);
                                border: 0.125rem solid;
                                padding: 8px;
                                border-radius: 10px;
                                display:inline-block;
                                color: rgb(184, 150, 0);">This password is already in use</div>';
        } else {
            $hashedPass = password_hash($entered_password, PASSWORD_BCRYPT);
            $query = "UPDATE users SET password=(?) WHERE id=$userID";
            $statement = $db->prepare($query);
            $statement->bind_param('s', $hashedPass);
            $statement->execute();
            $_SESSION['userPassword'] = $hashedPass;
            $_SESSION['password_changed'] = true;
            header("location: ../../userstatus/login.php");
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Oxanium&family=Share+Tech+Mono&display=swap" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
    <link href="../../styles/styles.css" rel="stylesheet">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?=$_SESSION['userLogin']?></title>
</head>
<body>
    <div style="position:-webkit-sticky; 
                position:sticky; 
                top:0;
                color:#cf0101;
                background-color: #000000;
                background-image: url(../../styles/accbg.gif);
                height: 50px;
                width: 100%">
    </div>

    <div>
        <input type="checkbox" id="check">
        <label for="check">
            <i class="fas fa-bars" id="btn"></i>
            <i class="fas fa-times" id="cancel"></i>
        </label>
        <div class="sidebar">
            <header class="glitch" style="background-image: url(../../styles/accbg.gif);">Menu</header>
            <a href="../../welcome.php" class="active">
                <i class="fas fa-qrcode"></i>
                <span>Dashboard</span>
            </a>
            <a href="yourAccount.php">
                <i class="fas fa-address-card"></i>
                <span>Account</span>
            </a>
            <a href="../overview/labsoverview.php">
                <i class="fas fa-stream"></i>
                <span>Labs overview</span>
            </a>
            
            <!-- IN PROGGRESS -->
            <a href="#">
                <i class="fas fa-calendar"></i>
                <span>Events</span>
            </a>
            <a href="#">
                <i class="far fa-question-circle"></i>
                <span>About</span>
            </a>
            <a href="#">
                <i class="fas fa-sliders-h"></i>
                <span>Services</span>
            </a>
            <!-- IN PROGGRESS -->

            <a target="_blank" rel="noopener noreferrer" href="https://vk.com/wemik2323">
                <i class="far fa-envelope"></i>
                <span>Contact</span>
            </a>
            <a href="../../userstatus/logout.php">
                <i class="far fa-address-card"></i>
                <span>Log Out</span>
            </a>
        </div>
    </div>
</body>
    
<div class="Main_Window" style="margin-top:0;">
    <h2 style="margin-top:40px; margin-bottom: 40px;">Your profile</h2>
    <center><form action="" method="post" style="width:600px; height: 100%;">
        <p style="margin:3%;">Your nickname: <?=$_SESSION["userLogin"]?>#<?=$_SESSION['userId']?></p>
        <div class="form-example">
            <label style="color: #ffffff; font-family:Share Tech Mono;" for="name">Change your nickname: </label>
            <input type="text" name="name" id="name" value=""/>
        </div>
        <p style="margin:3%;">Your email: <?=$_SESSION['userEmail']?></p>
        <div class="form-example">
            <label style="color: #ffffff;font-family:Share Tech Mono;" for="email">Change your email: </label>
            <input type="email" name="email" id="email" value=""/>
        </div>
        <p style="margin:3%;">Change password:</p>
        <div>
            <label style="color: #ffffff;font-family:Share Tech Mono;" for="password">Enter a new password: </label>
            <input type="password" name="password" id="password" value=""/>
        </div>
        <div style="margin:2%;">
            <label style="color: #ffffff;font-family:Share Tech Mono;" for="password">Verify your password: </label>
            <input type="password" name="passwordVerify" id="passwordVerify" value=""/>
        </div>
        <p style="margin:3%;">Full name: <?=$_SESSION['userFullname']?></p>
        <div>
            <label style="color: #ffffff;font-family:Share Tech Mono;" for="password">Change your full name: </label>
            <input type="text" name="fullname" id="fullname" value=""/>
        </div>
        <p style="margin:3%;">Description: <?=$_SESSION['userDescription']?></p>
        <div>
            <label style="color: #ffffff;font-family:Share Tech Mono;" for="password">Change description: </label>
            <input type="text" name="description" id="description" value=""/>
        </div><br>
        <?=$error;?>
        <div>
            <input type="submit" name="submit" style="font-family: Share Tech Mono;
            font-style: normal;
            font-weight: 400;
            font-size: 20px;
            text-transform: uppercase;
            position: relative;
            display: inline-block;
            padding: 0.75rem 1.1875rem;
            cursor: pointer;
            color: #e11900;
            background: rgba(0,0,0,.3);
            border: 0.125rem solid;
            border-left: 0.5rem solid;
            margin-top: 4%;
            outline: none;" 
            value="Submit" style="margin-top: 4%; margin-right: 0%; margin-bottom: 2%;">
        </div>
    </form></center>
</div>
<div style="bottom:0;height:100px; width:100%; margin-top:0; background-color:#000000; background-image:url(../../styles/accbg.gif); color:#ffffff;"></div>
</html>