<?php require_once'dbconn.php' ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>"Prak 1"</title>
</head>

<body bgcolor="#f05fbb">

    <center><a href="index.png" target="_blank"><img src="index.png" width="150" height="150"> </a></center>
    <hr width="80%" size="5" color="cyan">
    
    <table border="2" width="80%" align="center" bgcolor="#f5f5f5">
        <tr>
            <th>
                <a href="index.html">Главная</a>
            </th>
            <th bgcolor="Lime">
                <a href="https://hermitagemuseum.ru/">Государственный Эрмитаж </a>
            </th>
            <th bgcolor="Cyan">
                <a href="https://www.spb-guide.ru/admiraltejstvo.htm">Здание главного Адмиралтейства </a>
            </th>
            <th bgcolor="DeepPink">
                <a href="https://petropavlovskaya.org/">Петропавловская крепость </a>
            </th>
            <th bgcolor="Gold">
                <a href="https://mos-holidays.ru/spb/dostoprimechatelnosti/smolnyjmonastyr/">Смольный монастырь </a>
            </th>
        </tr>
    </table>


    <p align="justify"><font face="Arial" size="4" color="navy">На нашей планете есть множество естественных и искусственных объектов, которые
    поражают наше воображение. Это <b><i>пирамиды</i></b> в Египте и Мексике, истуканы на острове Пасхи,
    дворец <b>Тадж-Махал</b> в Индии, Стоунхендж в Великобритании, Ниагарский водопад в Канаде,
    <u>Большой каньон</u> в Колорадо и многие другие. Их называют «Чудеса света». Ежегодно сотни
    тысяч туристов приезжают посмотреть на эти диковины, принося ощутимый доход
    государствам, на территории которых они расположены.</font></p>

    <p align="justify"><font face="Arial" size="4" color="navy">Однако не обязательно ехать в далекие страны, чтобы увидеть удивительные
    природные ландшафты, памятники старины и произведения архитектуры. В нашей стране
    тоже есть уникальные объекты, которые находятся в одном из самых красивых городов
    России. Представляем Вам Санкт-Петербург.</font></p>

    <table align="center">
        <tr>
            <td>
                <ul type="circle">
                    <font face="Arial" size="4" color="navy">
                        <li> Медный Всадник</li>
                        <li> Государственный Эрмитаж </li>
                        <li> Крейсер «Аврора» </li>
                        <li> Здание главного Адмиралтейства </li>
                        <li> Петропавловская крепость </li>
                        <li> Львы Санкт-Петербурга </li>
                        <li> Кунсткамера </li>
                        <li> Стрелка Васильевского острова </li>
                        <li> Исаакиевский собор </li>
                        <li> Храм Спаса-на-Крови </li>
                        <li> Смольный монастырь </li>
                        <li> Летний сад </li>
                    </font>
                </ul>
            </td>
        </tr>
    </table>

    <table border="1" align="center">
        <tr align="center" valign="center">
        <td> Медный Всадник</td>
        <td> Государственный Эрмитаж</td>
        <td> Крейсер «Аврора» </td>
        </tr>
        <tr align="center" valign="center"></tr>
        <td> Здание главного Адмиралтейства</td>
        <td> Петропавловская крепость</td>
        <td> Львы Санкт-Петербурга </td>
        </tr>
        <tr align="center" valign="center">
        <td> Кунсткамера</td>
        <td> Стрелка Васильевского острова</td>
        <td>Исаакиевский собор</td>
        </tr>
        <tr align="center" valign="center"></tr>
        <td> Храм Спаса-на-Крови</td>
        <td>Смольный монастырь</td>
        <td> Летний сад</td>
        </tr>
    </table>

    <footer align="center">
        <form method="post" aligh>
         <h3> Анкета пользователя</h3>
         <table align="center">
         <tr>
         <td> Логин: </td>
         <td> <input type="text" name="login" size="30"></td>
         <td> Пароль: </td>
         <td> <input type="password" name="password" size="10"></td></tr>
         <tr>
         <td> Город: </td>
         <td> <select name="city">
         <option value="Moscow"> Москва
         <option selected=2 value="Saint-Petersburg"> Санкт-Петербург
         <option value="Kazan"> Казань
         <option value="Murmansk"> Мурманск
         <option value="Other oprtion"> Другой...
         </select> </td></tr>
         <tr>
         <td> Почта: </td>
         <td> <input type="email" name="mail" size="30"></td>
         </tr>
         </table>
         <h4> Укажите свою возрастную группу </h4>
         <input type="radio" name="age" value="child"> 7-12 лет
         <input type="radio" name="age" value="junior" checked> 13-20 лет
         <input type="radio" name="age" value="adult"> от 20 лет
        
         <h4> Укажите свои увлечения </h4>
         <input type="checkbox" name="hobby" value="computers"> Компьютеры
         <input type="checkbox" name="hobby" value="art"> Литература
         <input type="checkbox" name="hobby" value="music"> Музыка
         <input type="checkbox" name="hobby" value="avto"> Автомобили
         <input type="checkbox" name="hobby" value="sport"> Спорт
         <br>
         <input type="submit" value="Отправить">
         <input type="reset" value="Очистить">
        </form>
    </footer>
    
    <?php
        if (strlen(trim($_POST["login"])) > 2 && strlen(trim($_POST["login"])) < 16) {
            if ((strlen(trim($_POST['password'])) < 16 && strlen(trim($_POST['password'])) > 9)) {
            $hashedPass = password_hash($_POST['password'], PASSWORD_DEFAULT);
            $sql = mysqli_query($mysql, "INSERT INTO `users` (`login`, `password`, `city`, `email`, `age`, `hobby`) 
            VALUES ('{$_POST['login']}', '{$hashedPass}', '{$_POST['city']}', '{$_POST['mail']}', '{$_POST['age']}', '{$_POST['hobby']}')");
                if ($sql) {
                    echo '<p>Данные успешно добавлены в таблицу.</p>';
                } else {
                    echo '<p>Произошла ошибка: '.mysqli_error($mysql).'</p>';
                }
            } else { ?>
                <script>alert("Password must be at least 10 characters and max 15 ch.")</script> <?
          }
        } else { ?>
            <script> alert("Login must be at least 3 characters long and max 15"); </script><? 
        }
?>

</body>
</html>