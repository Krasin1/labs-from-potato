<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Изменить пользователя</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <style>
        table {
            border-spacing: 10px;
            border-collapse: separate;
            border: 1px solid black;
        }
        td {
            border: 1px solid black;
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>
<h1>Изменяемый пользователь:</h1>
<h3>Логин : ${user_login}</h3>
<h3>Почта : ${user_email}</h3>
<h3>Имя : ${user_name}</h3>
<h3>Фамилия : ${user_surname}</h3>
<h3>Номер телефона : ${user_phone}</h3>
<h3>Привилегии: ${user_role}</h3>

<div class="center" style="max-width: 60%; text-align: center">
<form action="/editUser" method="post" >
    <h1>Форма</h1>

    <% if (request.getSession().getAttribute("errorEdit") != null) { %>
        <div class="error_message" > ${errorEdit}</div>
    <%} %>

    <% if (request.getSession().getAttribute("sucEdit") != null) { %>
        <div class="success_message" > ${sucEdit}</div>
    <%} %>

    <div class="table-container">
        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-sub-container">
                <div class="row-item"> Введите новый пароль  </div>
                <div class="row-item"> <input class="input" type="password" name="passwordNew" placeholder="password">       </div>
            </div>
            <div class="row-sub-container">
                <div class="row-item"> Повторите пароль      </div>
                <div class="row-item"> <input class="input" type="password" name="passwordNewSecond" placeholder="password"> </div>
            </div>
        </div>

        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-item">Изменить логин : </div>
            <div class="row-item"><input class="input" type="text" name="login" placeholder="login"></div>
        </div>
        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-item">Изменить имя : </div>
            <div class="row-item"><input class="input" type="text" name="name" placeholder="Name"></div>
        </div>
        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-item">Изменить фамилию : </div>
            <div class="row-item"><input class="input" type="text" name="surname" placeholder="Surname"></div>
        </div>
        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-item">Изменить почту : </div>
            <div class="row-item"><input class="input" type="email" name="email" placeholder="you_mail@gmail.com"></div>
        </div>
        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-item">Изменить телефон : </div>
            <div class="row-item"><input type="text" placeholder="Телефон" name="phone" class="phone_mask input"></div>
            <script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js" type="text/javascript"></script>
            <script src="https://cdn.jsdelivr.net/npm/jquery.maskedinput@1.4.1/src/jquery.maskedinput.js"
                    type="text/javascript"></script>
            <script src="js/jquery.maskedinput.min.js"></script>
            <script> $(".phone_mask").mask("+7(999)999-99-99"); </script>
        </div>

        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-item">Выберите уровень доступа </div>
            <div style="text-align:left;">
                <p><input style="width:auto" type="radio" name="roleInput" value="user" id="user"><label for="user">Рядовой
                    пользователь</label></p>
                <p><input style="width:auto" type="radio" name="roleInput" value="salesman" id="salesman"><label for="salesman">Продавец</label>
                </p>
                <p><input style="width:auto" type="radio" name="roleInput" value="admin" id="admin"><label for="admin">Адимнистратор</label>
                </p>
            </div>
        </div>
    </div>
    <div style="margin-bottom: 30px;">
        <button class="button-primary" type="submit" style="width:45%">Обновить данные</button>
        <button class="button-primary" type="reset" style="width:45%">Сброс</button>
    </div>
</form>
</div>
</body>
</html>
