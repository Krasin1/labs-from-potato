<%@ page import="lab.course.model.ListProducts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Список товаров</title>
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

<h1>Список Товаров</h1>
<table style="width: 100%; align-content: center;">
    <tr>
        <td>Id</td>
        <td>Наименование</td>
        <td>Штрих-код</td>
        <td>Кол-во в наличии</td>
        <td>Цена</td>
    </tr>
        <% if (ListProducts.getProducts() != null) {
                for (var a : ListProducts.getProducts()) {
                    out.print("<tr >");
                    out.print("<td>" + a.getId() + "</td>");
                    out.print("<td>" + a.getProduct_name() + "</td>");
                    out.print("<td>" + a.getBarcode() + "</td>");
                    out.print("<td>" + a.getCount_in_stok() + "</td>");
                    out.print("<td>" + a.getPrice() + "</td>");
                    out.print("</tr>");
                }
            } else {
                out.print("Товары не найдены");
            }
    %>
</body>
</html>
</body>
</html>
