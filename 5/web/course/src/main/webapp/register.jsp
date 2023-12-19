<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <style>
        .block {
            margin-left: auto;
            margin-right: auto;
            width: 25em;
        }
        * {margin: 5px; padding: 5px;}
        input {
            width:100%;
        }
    </style>
</head>
<body>
<div style="display: flex; ">
    <div><form action="/"> <button class="button-primary">На главную</button> </form></div>
    <div><form action="login"> <button class="button-primary">Вход</button> </form></div>
</div>
    <form action="register" method="post" class="block">
        <h1>Регистрация</h1>

        <% if(request.getSession().getAttribute("errorInput") != null) { %>
        <div class="error_message"> ${errorInput} </div>
        <%}%>
        <% if(request.getSession().getAttribute("success") != null) { %>
        <div class="success_message"> ${success} </div>
        <%}%>

        <p>Введите логин</p>
        <input  class="input" type="text"  name="login" placeholder="login" required>
        <table style="margin: 0;padding: 0;">
            <tr>
                <td>Введите пароль</td>
                <td>Повторите пароль</td>
            </tr>
            <tr>
                <td><input  class="input" type="password" name="password" style="margin-left: 0; width:14em;" placeholder="password" required></td>
                <td><input  class="input" type="password" name="passwordSecond" style="margin-left: 0; width:14em;" placeholder="password" required></td>
            </tr>
        </table>
        <p>Введите имя</p>
        <input  class="input" type="text" name="name" placeholder="Name" required>
        <p>Введите фамилию</p>
        <input class="input"  type="text" name="surname" placeholder="Surname" required>
        <p>Введите почту</p>
        <input  class="input" type="email" name="email" placeholder="you_mail@gmail.com" required>
        <p>Введите номер телефона</p>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js" type="text/javascript"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery.maskedinput@1.4.1/src/jquery.maskedinput.js" type="text/javascript"></script>
        <script src="js/jquery.maskedinput.min.js"></script>
        <input type="text" placeholder="Телефон" name="phone" class="phone_mask input" required>
        <script> $(".phone_mask").mask("+7(999)999-99-99"); </script>
        <div style="display: flex; justify-content: space-between">
            <button class="button-primary" type="submit" style="width:40%">Регистрация</button>
            <button class="button-primary" type="reset" style="width:40%;">Сброс</button>
        </div>
    </form>
</body>
</html>
