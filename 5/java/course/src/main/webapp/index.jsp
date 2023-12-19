<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Главная страница</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
</head>
<body>
    <% String id = (String) request.getSession().getAttribute("role");
        if (id != null) { %>
            <jsp:include page="header.jsp"/>
        <%}%>
    <center>
        <h1>Главная страница</h1>

        <h2>Информационная система для управления<br>
            клиентской базой данных и автоматизаци процесса продаж</h2>
        <h3>Разработал студент группы ИКПИ-11 Дунаев В.Е.</h3>

        <form action="/login">
            <button class="button-primary" >Войти</button>
        </form>
    </center>
</body>
</html>
