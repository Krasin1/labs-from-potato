<%@ page import="lab.course.model.Orders" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Заказы</title>

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
        tr:hover {
            background-color: brown; color: white;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>
<h1>Список заказов</h1>
<table style="width: 100%; align-content: center;">
    <tr>
        <td>Дата заказа</td>
        <td>Номер заказа</td>
        <td>Сумма заказа</td>
    </tr>
    <% Orders orders = (Orders) request.getSession().getAttribute("orders");
        if (orders != null) {
            if (orders.getOrders() != null) {
                for (var a : orders.getOrders()) {
                    out.print("<tr style=\"cursor:pointer;\" method=\"post\" data-href=\"/order?order_id="+ a.getPurchase_id() + "\">");
                    out.print("<td>" + a.getDate() + "</td>");
                    out.print("<td>" + a.getPurchase_id() + "</td>");
                    out.print("<td>" + a.getTotal_price() + "</td>");
                    out.print("</tr>");
                }
            } else {
                out.print("Вы пока не делали заказов<br>");
            }
        } else {
        }
    %>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
        $(document).ready(function($) {
            $('*[data-href]').on('click', function() {
                window.location = $(this).data("href");
            });
        });
    </script>
</table>
</body>
</html>
