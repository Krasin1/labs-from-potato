<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Добавить пользователя</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <style>
        .block {
            margin-left: auto;
            margin-right: auto;
            width: 30em;
        }

        input {
            width: 30em;
        }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>

    <form action="addUser" method="post" class="block">
        <h1>Новый пользователь</h1>

        <div> ${errorAddUser} </div>
        <div> ${successAddUser}</div>

        <p>Введите логин</p>
        <input type="text" name="login" placeholder="login" required>
        <table style="margin: 0;padding: 0;">
            <tr>
                <td>Введите пароль</td>
                <td>Повторите пароль</td>
            </tr>
            <tr>
                <td><input class="input" type="password" name="password" style="margin-left: 0; width:14em;"
                           placeholder="password" required></td>
                <td><input class="input" type="password" name="passwordSecond" style="margin-left: 0;width:14em;"
                           placeholder="password" required></td>
            </tr>
        </table>
        <p>Введите имя</p>
        <input class="input" type="text" name="name" placeholder="Name" required>
        <p>Введите фамилию</p>
        <input class="input"  type="text" name="surname" placeholder="Surname" required>
        <p>Введите почту</p>
        <input  class="input" type="email" name="email" placeholder="you_mail@gmail.com" required>
        <p>Введите номер телефона</p>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery.maskedinput@1.4.1/src/jquery.maskedinput.js"
                type="text/javascript"></script>
        <script src="js/jquery.maskedinput.min.js"></script>
        <input type="text" placeholder="Телефон" name="phone" class="phone_mask input" required>
        <script> $(".phone_mask").mask("+7(999)999-99-99"); </script>
        <p>Выберите уровень доступа</p>
        <div style="text-align:left;">
            <p><input style="width:auto" type="radio" name="roleInput" value="user" id="user" checked><label for="user">Рядовой
                пользователь</label></p>
            <p><input style="width:auto" type="radio" name="roleInput" value="salesman" id="salesman"><label for="salesman">Продавец</label>
            </p>
            <p><input style="width:auto" type="radio" name="roleInput" value="admin" id="admin"><label for="admin">Адимнистратор</label>
            </p>
        </div>

        <button class="button-primary" type="submit" style="padding-left: 0;margin-left: 0;width: 14em;">Добавить</button>
        <button class="button-primary" type="reset" style="padding-left: 0;margin-left: 0;width: 14em;">Сброс</button>
    </form>
</body>
</html>
