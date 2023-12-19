<%@ page import="java.util.ArrayList" %>
<%@ page import="lab.course.model.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Заказ</title>
    <style>
        body {
            background: bisque;
        }

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

    <% @SuppressWarnings("unchecked")
        ArrayList<Order> orderInfo = (ArrayList<Order>) request.getSession().getAttribute("orderInfo");
        if (orderInfo != null && !orderInfo.isEmpty()) { %>
    <label>Список товаров:</label>
    <table style="width: 100%; align-content: center;">
        <tr>
            <td>Название</td>
            <td>Кол-во</td>
            <td>Цена</td>
        </tr>
        <%
            for (var a : orderInfo) {
                out.print("<tr>");
                out.print("<td>"+a.getName()+"</td>");
                out.print("<td>"+a.getCount()+"</td>");
                out.print("<td>"+a.getPrice()+"</td>");
                out.print("</tr>");
            }
            out.print("</table>");
            out.print("<label>Сумма заказа: " + orderInfo.get(0).getTotal_price()+ "</label>");
        } else { %>
            <label>${errorOrder}</label><br>
            <label>Нет данных по заказу</label>
        <%} %>
</body>
</html>
