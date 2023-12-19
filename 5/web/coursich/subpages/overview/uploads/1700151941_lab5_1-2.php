<?php require_once 'dbconnect.php' ?>

<?php
    $sql = mysqli_query($mysql, 'SELECT `id`, `nickname`, `login`, `email`, `status` FROM `users`');
    while ($result = mysqli_fetch_array($sql)) {
        echo "Номер пользователя {$result['id']}".'<br>';
        echo "Имя: {$result['nickname']}".'<br>';
        echo "Логин: {$result['login']}".'<br>';
        echo "E-mail: {$result['email']}".'<br>';
        echo "Статус: {$result['status']}".'<br>'.'<br>';
    }
    $mysql -> close();
?>