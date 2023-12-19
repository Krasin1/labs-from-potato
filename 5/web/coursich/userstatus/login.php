<?php
require_once "../subpages/session.php";
global $error, $nameBD;
$error = '';

if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])) {

    $email = trim($_POST['email']);
    $entered_password = trim($_POST['password']);

    // validate if email is empty
    if (empty($email)) {
        $error .= '<div class="hintBar">Please enter email.</div>';
    }

    // validate if password is empty
    if (empty($entered_password)) {
        $error .= '<div class="hintBar">Please enter your password.</div>';
    }

    if (empty($error)) {
        $query = "SELECT id, name, password, email, fullname, description, status FROM users WHERE email = (?)";
        if($statement = $db->prepare($query)) {
            $statement->bind_param('s', $email);
            $statement->execute();
            $statement->bind_result($idDB, $nameDB, $passwordDB, $emailDB, $fullnameDB, $descriptionDB, $status);
            $statement->fetch();
            // echo $nameDB;
            if ($emailDB==$email) { 
                if (password_verify($entered_password, $passwordDB)) {
                    $_SESSION["userLoggedIn"] = true;
                    $_SESSION["userId"] = $idDB;
                    $_SESSION["userLogin"] = $nameDB;
                    $_SESSION["userEmail"] = $emailDB;
                    $_SESSION["userPassword"] = $passwordDB;
                    $_SESSION["userFullname"] = $fullnameDB;
                    $_SESSION["userDescription"] = $descriptionDB;
                    $_SESSION["userStatus"] = $status;
                    // Redirect the user to welcome page
                    header("location: ../welcome.php");
                    exit;
                } else {
                    $error .= '<div class="hintBar">The password is not valid.</div>';
                }
            } else {
                $error .= '<div class="hintBar">No user exist with that email address.</div>';
            }
        }
        $statement->close();
    }
    // Close connection
    mysqli_close($db);
}
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Oxanium&family=Share+Tech+Mono&display=swap" rel="stylesheet">
        <link href="../styles/register.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h2>Login</h2>
                    <p>Please fill in your email and password.</p>
                    <form action="" method="post">
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" name="email" class="form-control" required />
                        </div>    
                        <div class="form-group">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" required>
                        </div><br>
                        <?=$error;?>
                        <div class="button-to-verify">
                            <input type="submit" name="submit" class="GTFObutton" value="Submit" style="margin-top: 4%; margin-right: 0%; margin-bottom: 2%;">
                        </div>
                        <p>Don't have an account? <a href="register.php" style="color:red; font-size: 20px;">Register here</a>.</p>
                    </form>
                </div>
            </div>
        </div>    
    </body>
</html>
