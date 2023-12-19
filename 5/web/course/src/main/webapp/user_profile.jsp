<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Смена данных</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/header.jsp"/>
<h1>Текущий профиль:</h1>
<h3>Логин : ${login}</h3>
<h3>Почта : ${email}</h3>
<h3>Имя : ${name}</h3>
<h3>Фамилия : ${surname}</h3>
<h3>Номер телефона : ${phone}</h3>

<div class="center" style="max-width: 80%; text-align: center">
<form action="/account" method="post">
    <h1>Форма для изменения данных</h1>

    <% if (request.getSession().getAttribute("error") != null) { %>
        <div class="error_message" > ${error}</div>
    <%} %>

    <% if (request.getSession().getAttribute("suc") != null) { %>
        <div class="success_message" > ${suc}</div>
    <%} %>


    <div class="table-container" >
        <div class="table-row" style="margin: 0; padding: 0;">
            <div class="row-sub-container">
                <div class="row-item"> Введите старый пароль </div>
                <div class="row-item"> <input class="input" type="password" name="passwordOld" placeholder="password">       </div>
            </div>
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
    </div>
    <p>
        <button type="submit" class="button-primary">Обновить данные</button>
        <button type="reset" class="button-primary">Сброс</button>
    </p>
</div>
</body>
</html>
