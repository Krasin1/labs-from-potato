<%@ page import="lab.course.model.ListProducts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Данные покупателя</title>
    <style>
        * {margin: 5px; padding: 5px;}
        table {
            border-spacing: 10px;
            border-collapse: separate;
            border: 1px solid red;
        }
        td {
            border: 1px solid red;
            text-align: center;
        }
        #left {float: left; width: 35%;}
        #right {float: right; width: 60%;}
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"/>
    <div style="width: 100%; align-content: center">${err}</div>
<div id="left">
<table>
    <td>
        <h4> Аккаунт покупателя для привязки покупки </h4>

        <form action="purchase" method="post">
            <p><label>Введите логин</label>
                <input type="text" name="buyer_login" placeholder="some_login" required/> </p>
            <div style="text-align:left;">
                <h4> Способ оплаты :</h4>
                <p><input type="radio" name="payment" value="card">Банковской картой </p>
                <p><input type="radio" name="payment" value="money" checked>Наличкой </p>
                <p><input type="radio" name="payment" value="agreement">Договор для юр. лиц </p>
            </div>
            <button type="submit">Оплатить</button>
        </form>
    </td>
</table>
</div>

<div id="right">
<table style="width: 90%">
    <tr>
        <td>№</td>
        <td>Продукт</td>
        <td>Цена</td>
        <td>Кол-во</td>
    </tr>
    <% var list = (ListProducts)request.getSession().getAttribute("list");
        if (list != null) {
            int i = 1; int sum = 0;
            for (var a : list.getListProducts()) {
                out.print("<tr><td>" + i++ + "</td>");
                out.print("<td>" + a.getProduct_name() + "</td>");
                out.print("<td>" + a.getPrice() + "</td>");
                out.print("<td style=\"width:70px;\">" + a.getCount() + "</td></tr>");
                sum += a.getPrice() * a.getCount();
            }
            out.print("<tr><td colspan=\"4\">Общая цена : " + sum + "</td></tr");
        } %>
</table>
</div>
</body>
</html>
