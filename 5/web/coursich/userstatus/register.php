<?php

require_once "../subpages/config.php";
require_once "../subpages/session.php";
global $error, $success;

$success = false;
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['submit'])) {

    $nickname = trim($_POST['name']);
    $email = trim($_POST['email']);
    $entered_password = trim($_POST['password']);
    $confirm_password = trim($_POST["confirm_password"]);
    $password_hash = password_hash($entered_password, PASSWORD_BCRYPT);

    if($statement = $db->prepare("SELECT * FROM users WHERE email = ? OR name = ?")) {
        $error = '';
        $statement->bind_param('ss', $email, $nickname);
        $statement->execute();
        // Store the result so we can check if the account exists in the database.
        $statement->store_result();
        if ($statement->num_rows > 0) {
            $error .= '<div class="errorBar">This user is already exists!</div>';
        } else {
            // Validate password
            if (strlen($entered_password ) < 6) {
                $error .= '<div class="hintBar">Password must have atleast 6 characters.</div>';
            }
            // Validate confirm password
            if (empty($confirm_password)) {
                $error .= '<div class="hintBar">Please confirm a password.</div>';
            } else {
                if (empty($error) && ($entered_password != $confirm_password)) {
                    $error .= '<div class="errorBar">Password did not match.</div>';
                }
            }
            if (empty($error) ) {
                $InserQuery = $db->prepare("INSERT INTO users (name, email, password, status) VALUES (?, ?, ?, 'regular');");
                $InserQuery->bind_param("sss", $nickname, $email, $password_hash);
                $result = $InserQuery->execute();
                if ($result) {
                    $error .= '<div class="successBar">Your registration was successful! Redirecting...</div>';

                    header("refresh:5; url=login.php");
                } else {
                    $error .= '<div class="errorBar">Something went wrong!</div>';
                }
            }
        }
        $statement->close();
    }
    // Close DB connection
    mysqli_close($db);
}
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign Up</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Oxanium&family=Share+Tech+Mono&display=swap" rel="stylesheet">
        <link href="../styles/register.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <div class="registration_form">
                <h2>Register form</h2>
                <p style="margin-bottom: 20px;">Please fill this form to create an account.</p>
                <form action="" method="post">
                    <div class="form-group">
                        <label>Nickname</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>    
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" class="form-control" required />
                    </div>    
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label>Confirm Password</label>
                        <input type="password" name="confirm_password" class="form-control" required>
                    </div><br>
                    <?=$error;?>
                    <div class="button-to-verify" style="margin-top: 20px;">
                        <input type="submit" name="submit" class="GTFObutton" value="Submit">
                        <p style="font-size: 20px; margin-top: 10px;">Already have an account? <a href="login.php" style="color: red;">Login here</a>.</p>
                    </div>
                </form>
            </div>
        </div>    
    </body>
</html>