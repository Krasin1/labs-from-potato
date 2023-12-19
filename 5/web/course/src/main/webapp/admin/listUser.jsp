<%@ page import="lab.course.model.ListUsers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Список пользователей</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <style>
        table {
            border: 1px solid red;
        }

        td {
            border: 1px solid red;
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>
<h1>Список пользователей</h1>
<table style="width: 100%; align-content: center;">
    <tr>
        <td>Id</td>
        <td>Логин</td>
        <td>Почта</td>
        <td>Имя</td>
        <td>Фамилия</td>
        <td>Телефон</td>
        <td>Роль</td>
    </tr>
        <% if (ListUsers.getUsers() != null) {
                for (var a : ListUsers.getUsers()) {
                    out.print("<tr >");
                    out.print("<td>" + a.getId() + "</td>");
                    out.print("<td>" + a.getLogin() + "</td>");
                    out.print("<td>" + a.getEmail() + "</td>");
                    out.print("<td>" + a.getName() + "</td>");
                    out.print("<td>" + a.getSurname() + "</td>");
                    out.print("<td>" + a.getPhone() + "</td>");
                    out.print("<td>" + a.getRole() + "</td>");
                    out.print("</tr>");
                }
            } else {
                out.print("Пользователи не найдены");
            }
    %>
</body>
</html>
