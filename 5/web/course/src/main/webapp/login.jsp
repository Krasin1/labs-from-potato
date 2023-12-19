<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Вход</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <style>
        .block {
            margin-left: auto;
            margin-right: auto;
            width: 20em;
        }

        * {
            margin: 5px;
            padding: 5px;
        }
    </style>
</head>
<body>
<% String id = (String) request.getSession().getAttribute("role");
    if (id != null) { %>
<jsp:include page="header.jsp"/>
<%} else {%>
<form action="/">
    <button class="button-primary">На главную</button>
</form>
<%}%>

<form action="login" method="post" class="block">
    <h1>Вход в систему</h1>

    <% if (request.getSession().getAttribute("errorMessage") != null) { %>
    <div class="error_message"> ${errorMessage} </div>
    <%}%>

    <p>Введите логин</p>
    <input class="input" style="width:95%;" type="text" name="login" placeholder="login" required>
    <p>Введите пароль</p>
    <input class="input" style="width:95%;" type="password" name="password" placeholder="password" required>
    <p>
        <button class="button-primary" style="width:40%;" type="submit">Вход</button>
        <input form="reg" class="button-primary" style="width:50%; float:right;" type="submit" value="Регистрация"/></p>
</form>

<form id="reg" action="register.jsp" class="block"></form>
</body>
</html>
