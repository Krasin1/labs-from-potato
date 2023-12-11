<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Смена данных</title>
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
    <h2>Логин : ${login}</h2>
    <h2>Почта : ${email}</h2>
    <h2>Имя : ${name}</h2>
    <h2>Фамилия : ${surname}</h2>
    <h2>Номер телефона : ${phone}</h2>

    <form action="/account" method="post">
        <h1>Форма</h1>

        <div> ${error} </div>
        <div> ${suc}</div>

        <table>
            <tr>
                <td>Введите старый пароль</td>
                <td>Введите новый пароль</td>
                <td>Повторите пароль</td>
            </tr>
            <tr>
                <td><input type="password" name="passwordOld" placeholder="password" ></td>
                <td><input type="password" name="passwordNew" placeholder="password" ></td>
                <td><input type="password" name="passwordNewSecond" placeholder="password" ></td>
            </tr>
        </table>

        <p>Изменить логин :   <input type="text" name="login" placeholder="login" ></p>
        <p>Изменить имя :     <input type="text" name="name" placeholder="Name" ></p>
        <p>Изменить фамилию : <input type="text" name="surname" placeholder="Surname" ></p>
        <p>Изменить почту :   <input type="email" name="email" placeholder="you_mail@gmail.com" ></p>
        <p>Изменить телефон : <input type="text" name="phone" placeholder="79008880033" ></p>
        <p><button type="submit">Обновить данные</button>
            <button type="reset">Сброс</button> </p>
    </form>
</body>
</html>
