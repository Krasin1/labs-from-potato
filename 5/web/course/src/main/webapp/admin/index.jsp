<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Меню</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
</head>

<body>

<% if (request.getSession().getAttribute("noUser") != null && (boolean)request.getSession().getAttribute("noUser")) { %>
    <script>alert("Пользователь не найден")</script>
<% } %>

<% if (request.getSession().getAttribute("noProduct") != null && (boolean)request.getSession().getAttribute("noProduct")) { %>
<script>alert("Товар не найден")</script>
<% } %>

<jsp:include page="/header.jsp"/>
<h1>Администрирование:</h1>

<div style="display: flex; justify-content: center">

<div style="border: 3px solid black; display: flex; flex-direction: column; align-items: center;">
    <div><form action="func" method="post">
        <button class="button-primary" name="choose" value="addUser"><h2>Добавить пользователя</h2></button>
    </form></div>
    <div><form action="func" method="post">
        <button  class="button-primary" name="choose" value="addProduct"><h2>Добавить новый товар</h2></button>
    </form></div>
</div>

<div style="border: 3px solid black; display: flex; flex-direction: column; align-items: center; ">
    <div><form action="func" method="post" style="margin-left:0; padding-left: 0; display: flex; border-bottom: 3px solid black;">
        <div style=""><button  class="button-primary" name="choose" value="editUser"><h2>Изменить данные пользователя</h2></button></div>
        <div>Введите логин пользователя:<br><input class="input" type="text" name="login" placeholder="login" required></div>
    </form></div>
    <div><form action="func" method="post" style="margin-left:0; padding-left: 0; display: flex">
        <div style=""><button  class="button-primary" name="choose" value="editProduct"><h2>Изменить товар</h2></button></div>
        <div>Введите id товара:<br><input class="input" type="text" name="product" placeholder=" 0" required></div>
    </form></div>
</div>

<div style="border: 3px solid black; display: flex; flex-direction: column; align-items: center;">
    <div><form action="func" method="post">
        <button  class="button-primary" name="choose" value="listUser"><h2>Список пользователей</h2></button>
    </form></div>
    <div><form action="func" method="post">
        <button  class="button-primary" name="choose" value="listProduct"><h2>Список товаров</h2></button>
    </form></div>
</div>

</div>



</body>
</html>
