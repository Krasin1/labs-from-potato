<%@ page import="lab.course.model.ListProducts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@ericblade/quagga2/dist/quagga.js"></script>
    <script src="barcode.js"></script>
    <title>Сканер</title>

    <style>
        .scanner {
            position: relative;
        }

        /* In order to place the tracking correctly */
        canvas.drawing, canvas.drawingBuffer {
            padding-left: 0;
            position: absolute;
            left: 0;
            top: 0;
        }

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

        .left {
            width: 40%;
            flex-grow: 3;
        }

        .right {
            flex-grow: 7;
        }

        #scanner-container > video {
            width: 100%;
            height: 100%;
            padding-left: 0;
        }

        #scanner-container > canvas {
            width: 100%;
            height: 100%;
        }

        .flex-container {
            width: 100%;
            height: 300px;
            display: flex;
            flex-flow: row nowrap;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>
<% if (request.getSession().getAttribute("errorCheck") != null) { %>
<script>alert("${errorCheck}")</script>
<%} %>
<div class="flex-container">
    <div class="left">
        <table>
            <tr>
                <td>
                    <form action="checkBarcode" method="post">
                        <h3>Отсканируйте товар</h3>
                        <div>
                            ${errorRead}
                        </div>
                        <p>
                            <input class="input" type="text" name="barcode" id="barcode" placeholder="Штрих код" required>
                            <button class="button-primary" id="barcode-submit" type="submit">Ввод</button>
                        </p>
                    </form>
                </td>
            </tr>
            <tr>
                <td>
                    <label style="cursor:pointer" onclick="Quagga.stop()">Выключить</label><label style="cursor:pointer"
                                                                                                  onclick="startScanner();">Включить</label>
                    <div id="scanner-container" class="scanner" style="padding-left: 0"></div>
                </td>
            </tr>
        </table>
    </div>

    <div class="right">
        <div style="display: flex; align-items: center; justify-content: center">
            <form action="buy" method="post" id="basket_post"> <button class="button-primary" type="submit">Перейти к оплате</button> </form>
        </div>
        <table style="width: 100%; align-content: center;">
            <tr>
                <td>№</td>
                <td>На складе</td>
                <td>Продукт</td>
                <td>Цена</td>
                <td>Кол-во</td>
                <td>Флажок</td>
            </tr>
            <%
                var list = (ListProducts) request.getSession().getAttribute("list");
                if (list != null) {
                    int i = 1;
                    for (var a : list.getListProducts()) {
                        if (i % 2 == 0) {
                            out.print("<tr><td>" + i++ + "</td>");
                        } else {
                            out.print("<tr style=\"background: silver\"><td>" + i++ + "</td>");
                        }
                        out.print("<td style=\"width:50px;\">" + a.getCount_in_stok() + "</td>");
                        out.print("<td>" + a.getProduct_name() + "</td>");
                        out.print("<td>" + a.getPrice() + "</td>");
                        out.print("<td style=\"width:50px;\"><input class=\"input\" type=number form=\"basket_post\" required value=" + a.getCount() + " name=\"basket" + a.getId() + "\" min=\"1\" max=\"1000\" " +
                                "onkeyup=\"if(this.value>999){this.value='999';}else if(this.value<1){this.value='1';}\"></td>");
                        out.print("<td style=\"width:50px;\"><input class=\"input\" type=\"checkbox\" form=\"check_del\" name=\"delete\" value=\"" + a.getId() + "\"></td></tr>");
                    }
                }
            %>
        </table>
        <table style="width: 100%; align-content: center">
            <form action="remove" id="check_del" method="post">
                <td>
                    <button class="button-primary" type="submit">Убрать выбранные товары</button>
                </td>
            </form>
        </table>
    </div>
</div>

<script>
    startScanner();
</script>

</body>
</html>
