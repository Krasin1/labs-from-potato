<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Оплата</title>

    <style>
        body {
            background: bisque;
        }
    </style>
</head>
<body>
<p>
    <% if (request.getSession().getAttribute("payment") != null) {
        var pay = request.getSession().getAttribute("payment").toString();
        if (pay.equals("card")) {
            out.print("<label>Оплата по карте прошла</label>");
        } else if (pay.equals("money")) {
            out.print("<label>Покупка оплачена наличкой</label>");
        } else if (pay.equals("agreement")) {
            out.print("<label>Договор на покупку оформлен, и будет рассмотрен в скором времени</label>");
        } else {
            out.print("как-то оплатил");
        }
    } %>
</p>
<p><a href="checkBarcode">Вернуться к сканеру</a></p>
</body>
</html>
