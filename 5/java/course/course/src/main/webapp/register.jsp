<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <a href="index.jsp">На главную</a>
    <form action="register" method="post">
        <h1>Регистрация</h1>

        <div> ${errorInput} </div>
        <div> ${success}</div>

        <p>Введите логин</p>
        <input type="text" name="login" placeholder="login" required>
        <p>
            <table>
                <tr>
                    <td>Введите пароль</td>
                    <td>Повторите пароль</td>
                </tr>
                <tr>
                    <td><input type="password" name="password" placeholder="password" required></td>
                    <td><input type="password" name="passwordSecond" placeholder="password" required></td>
                </tr>
            </table>
        </p>
        <p>Введите имя</p>
        <input type="text" name="name" placeholder="Name" required>
        <p>Введите фамилию</p>
        <input type="text" name="surname" placeholder="Surname" required>
        <p>Введите почту</p>
        <input type="email" name="email" placeholder="you_mail@gmail.com" required>
        <p>Введите номер телефона</p>
        <input type="text" name="phone" placeholder="79008880033" required>
        <p><button type="submit">Регистрация</button>
            <button type="reset">Сброс</button> </p>
    </form>
</body>
</html>
