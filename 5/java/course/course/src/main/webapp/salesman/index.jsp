<%@ page import="lab.course.model.ListProducts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Сканер</title>

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
    <div id="left">
        <table >
            <td>
                <form action="checkBarcode" method="post">
                    <h3>Отсканируйте товар</h3>
                    <div>
                        ${errorCheck}
                    </div>
                    <p>
                        <input type="text" name="barcode" placeholder="Штрих код" required>
                        <button type="submit">Отсканировать</button>
                    </p>
                </form>
            </td>
        </table>
        <form action="buy" method="post" id="basket_post">
            <button type="submit">Перейти к оплате</button>
        </form>
    </div>

    <div id="right">
    <table style="width: 95%; align-content: center;">
        <tr>
            <td>№</td>
            <td>На складе</td>
            <td>Продукт</td>
            <td>Цена</td>
            <td>Кол-во</td>
            <td>Флажок</td>
        </tr>
        <%
            var list = (ListProducts)request.getSession().getAttribute("list");
            if (list != null) {
                int i = 1;
                for (var a : list.getListProducts()) {
                    out.print("<tr><td>" + i++ + "</td>");
                    out.print("<td style=\"width:50px;\">"+ a.getCount_in_stok()+"</td>");
                    out.print("<td>" + a.getProduct_name() + "</td>");
                    out.print("<td>" + a.getPrice() + "</td>");
                    out.print("<td style=\"width:50px;\"><input type=number form=\"basket_post\" required value=" + a.getCount() + " name=\"basket"+ a.getId() +"\" min=\"1\" max=\"1000\" " +
                            "onkeyup=\"if(this.value>999){this.value='999';}else if(this.value<1){this.value='1';}\"></td>");
                    out.print("<td style=\"width:50px;\"><input type=\"checkbox\" form=\"check_del\" name=\"delete\" value=\""+ a.getId() +"\"></td></tr>");
                }
            }
        %>
    </table>
    <table style="width: 95%; align-content: center">
        <form action="remove" id="check_del" method="post">
            <td><button type="submit">Убрать выбранные товары</button></td>
        </form>
    </table>
    </div>
</body>
</html>
