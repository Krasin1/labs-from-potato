<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Вход</title>
</head>
<body>
<a href="/">На главную</a>
<form action="login" method="post">
    <h1>Вход в систему</h1>

    <div>
        ${errorMessage}
    </div>

    <p>Введите логин</p>
    <input type="text" name="login" placeholder="login" required>
    <p>Введите пароль</p>
    <input type="password" name="password" placeholder="password" required>
    <p><button type="submit">Вход</button></p>
</form>

<form action="register.jsp">
    <input type="submit" value="Регистрация"/>
</form>

</body>
</html>
