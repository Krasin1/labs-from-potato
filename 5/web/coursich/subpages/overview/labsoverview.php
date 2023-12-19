<?php
require_once "../config.php";
// start the session
session_start();
// Check if the user is not logged in, then redirect the user to login page
if ($_SESSION["userLoggedIn"] !== true) {
    header("location: userstatus/login.php");
}
global $uploaded_files;
$uploaded_files = "";

include "helpFunctions.php";
$error = "";
if (isset($_FILES['file'])) {
    $target_path = 'uploads/';
	$target_path = $target_path.time().'_'.basename($_FILES['file']['name']);

    if(move_uploaded_file($_FILES['file']['tmp_name'], $target_path)) {
        $error = "The file ".basename( $_FILES['file']['name'])." has been uploaded";
    } else{
        $error = "There was an error uploading the file, please try again!";
    }

    if(strlen($error) > 0)
    {
        $error = '<p>'.$error.'</p>';
    }
}

/** List Loaded Files DATE_NAME_TYPE **/
//Read directory
if ($_SESSION['userStatus'] == 'donated' || $_SESSION['userStatus'] == 'admin') {
    $dh = opendir('uploads/');
    while (($file = readdir($dh)) !== false) {
        if($file != '.' && $file != '..') {
            $filename = 'uploads/'.$file;
            $parts = explode("_", $file);
            $size = formatBytes(filesize($filename));
            $added = date("m/d/Y", $parts[0]);
            $origName = $parts[1];

            $uploaded_files .= "<li><a href=\"$filename\" download>$origName</a> $size - $added</li>\n";
        }
    }
    closedir($dh);
    if(strlen($uploaded_files) == 0) {
        $uploaded_files = "<li><em>No files found</em></li>";
    }
} else {
    $uploaded_files .= '<form action="" method="post">
                        <p>Give me money to gain access to WebDev labs. pls...</p>
                        <p><input type="submit" name="donate" value="Donate" style="font-family: Share Tech Mono;
                                                                                    font-style: normal;
                                                                                    font-weight: 400;
                                                                                    font-size: 20px;
                                                                                    text-transform: uppercase;
                                                                                    position: relative;
                                                                                    display: inline-block;
                                                                                    padding: 0.5rem 1.1875rem;
                                                                                    cursor: pointer;
                                                                                    color: #e11900;
                                                                                    background: rgba(0,0,0,.3);
                                                                                    border: 0.125rem solid;
                                                                                    border-left: 0.5rem solid;
                                                                                    margin-top: 20px;
                                                                                    margin-bottom: 20px;
                                                                                    outline: none;"></p>
                        </form>';
}


$adminFileLoad = '';
if ($_SESSION['userStatus'] == 'admin') {
    $adminFileLoad = '<fieldset>
                            <legend><p>Add a new file to the storage</p></legend>
                            <form method="post" action="labsoverview.php" enctype="multipart/form-data">
                            <input type="hidden" name="MAX_FILE_SIZE" value="100000" />
                            <img src="chngfile.png" alt="" style="margin:30px;" />
                            <input type="file" name="file" style="display:block; 
                                                            postition:absolute; 
                                                            border: 1px solid; 
                                                            margin-top: -70px;
                                                            margin-left: 35%;
                                                            height:50px;
                                                            width:250px;
                                                            opacity: 0;
                                                            cursor: pointer;
                                                            "/></p>
                            <p><input type="submit" name="submit" value="upload" style="font-family: Share Tech Mono;
                                                                                        font-style: normal;
                                                                                        font-weight: 400;
                                                                                        font-size: 15px;
                                                                                        text-transform: uppercase;
                                                                                        position: relative;
                                                                                        display: inline-block;
                                                                                        padding: 0.5rem 1.1875rem;
                                                                                        cursor: pointer;
                                                                                        color: #e11900;
                                                                                        background: rgba(0,0,0,.3);
                                                                                        border: 0.125rem solid;
                                                                                        border-left: 0.5rem solid;
                                                                                        margin-top: 10px;
                                                                                        margin-bottom: 10px;
                                                                                        outline: none;" /></p>
                            </form>
                        </fieldset>';
}
?>
<!DOCTYPE html>
<html lang="en">
<title>Labs</title>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Oxanium&family=Share+Tech+Mono&display=swap" rel="stylesheet">
    <link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
    <link href="../../styles/styles.css" rel="stylesheet">
    <link href="../../styles/fileMenu.css" rel="stylesheet">
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
            <a href="../account/yourAccount.php">
                <i class="fas fa-address-card"></i>
                <span>Account</span>
            </a>
            <a href="labsoverview.php">
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
    
<div class="Main_Window" style="margin-top:50px;">
    <h2 style="margin-bottom:30px;">Online File Storage</h2>
    <?=$adminFileLoad?>
    <fieldset>
        <legend><p>Uploaded files</p></legend>
        <ul id="files">
            <?php 
                if (isset($_POST['donate'])) {
                    ?> <script>alert("Я как будто бы получил деньги... Но у меня нет ИНН и организации с сотрудниками и налогами >:')");</script><?php

                    //Это произойдет после выполнения запроса в SperEquaring и получения чека
                    //.... $response = curl_exec($myCurl); curl_close($myCurl); ....
                    // + запись в бд с услугами donates с историей платы и ссылками на чек и т.д....

                    $userId = $_SESSION['userId'];
                    $query = "UPDATE users SET status='donated' WHERE id=$userId";
                    $statement = $db->prepare($query);
                    $statement->execute();
                    $_SESSION['userStatus'] = 'donated';
                } 
                echo $uploaded_files; 
            ?>
        </ul>
    </fieldset>
</div>
    <?=$error?>
<div style="height:100px; width:100%; margin-top:0; background-color:#000000; background-image:url(../../styles/accbg.gif); color:#ffffff;"></div>
</html>