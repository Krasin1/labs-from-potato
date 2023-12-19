<?php 
    define('DB_HOST','localhost');
    define('DB_USER','root');
    define('DB_PASSWORD','mysql');
    define('DB_NAME','socialsite');

    $mysql = @new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
    if ($mysql -> connect_errno) exit('Ошибка подключения');
    $mysql -> set_charset('utf8');
//    $mysql -> close();
?>