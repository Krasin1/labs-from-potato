<%@ page import="lab.course.model.ListProducts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Данные покупателя</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <style>
        * {
            margin: 5px;
            padding: 5px;
        }

        table {
            border-spacing: 10px;
            border-collapse: separate;
            border: 1px solid red;
        }

        td {
            border: 1px solid red;
            text-align: center;
        }

        .flex-container {
            width: 100%;
            height: 300px;
            display: flex;
            flex-flow: row nowrap;
        }

        .left {
            width: 30%;
            flex-grow: 3;
        }

        .right {
            flex-grow: 7;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>
<% if (request.getSession().getAttribute("err") != null) { %>
<script>alert("${err}")</script>
<%} %>
<div class="flex-container">
    <div class="left">
        <table>
            <td>
                <h4>По желанию введите телефон покупателя для привязки покупки </h4>

                <form action="purchase" method="post">
                    <p><label>Телефон</label>
                        <script src="https://cdn.jsdelivr.net/npm/jquery@3.2.1/dist/jquery.min.js"
                                type="text/javascript"></script>
                        <script src="https://cdn.jsdelivr.net/npm/jquery.maskedinput@1.4.1/src/jquery.maskedinput.js"
                                type="text/javascript"></script>
                        <script src="js/jquery.maskedinput.min.js"></script>
                        <input type="text" placeholder="Телефон" name="buyer_phone" class="phone_mask input">
                        <script> $(".phone_mask").mask("+7(999)999-99-99"); </script>
                    </p>
                    <div style="text-align:left;">
                        <h4> Способ оплаты :</h4>
                        <p><input type="radio" name="payment" value="card" id="card"><label for="card">Банковской
                            картой </label></p>
                        <p><input type="radio" name="payment" value="money" checked id="money"><label for="money">Наличкой </label>
                        </p>
                        <p><input type="radio" name="payment" value="agreement" id="agreement"><label for="agreement">Договор
                            для юр. лиц </label></p>
                    </div>
                    <button class="button-primary" type="submit">Оплатить</button>
                </form>
            </td>
        </table>
    </div>

    <div class="right">
        <table style="width: 100%;align-content: center;">
            <tr>
                <td>№</td>
                <td>Продукт</td>
                <td>Цена</td>
                <td>Кол-во</td>
            </tr>
            <% var list = (ListProducts) request.getSession().getAttribute("list");
                if (list != null) {
                    int i = 1;
                    int sum = 0;
                    for (var a : list.getListProducts()) {
                        if (i % 2 == 0) {
                            out.print("<tr><td>" + i++ + "</td>");
                        } else {
                            out.print("<tr style=\"background: silver\"><td>" + i++ + "</td>");
                        }
                        out.print("<td>" + a.getProduct_name() + "</td>");
                        out.print("<td>" + a.getPrice() + "</td>");
                        out.print("<td style=\"width:70px;\">" + a.getCount() + "</td></tr>");
                        sum += a.getPrice() * a.getCount();
                    }
                    out.print("<tr><td colspan=\"4\">Общая цена : " + sum + "</td></tr");
                } %>
        </table>
    </div>
</div>
</body>
</html>
