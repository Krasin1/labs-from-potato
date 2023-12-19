<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Добавить товар</title>
    <link type="text/css" href="/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@ericblade/quagga2/dist/quagga.js"></script>
    <script src="barcode.js"></script>
    <style>
        .block {
            margin-left: auto;
            margin-right: auto;
            width: 30em;
        }
        input {
            width: 30em;
        }
        .scanner {
            position: relative;
        }
        /* In order to place the tracking correctly */
        canvas.drawing, canvas.drawingBuffer {
            position: absolute;
            padding-left: 0;
            left: 0;
            top: 0;
        }


        #scanner-container > video {
            padding-left: 0;
            width: 85%;
        }
        #scanner-container > canvas {
            width: 85%;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>



<form action="/addProduct" method="post" class="block" >
    <h1>Новый товар</h1>

    <div> ${errorAddProduct} </div>
    <div> ${successAddProduct}</div>

    <p>Введите название</p>
    <input class="input" type="text" name="productName" placeholder="Алебра 10-11 класс" required>
    <p>Введите кол-во</p>
    <input class="input" type="number" name="count" placeholder="123" required>
    <p>Введите цену</p>
    <input class="input" type="number" name="price" placeholder="123" required>
    <p>Введите штрих-код</p>
    <input class="input" type="text" id="barcode" name="barcode" placeholder="" required>

    <br>
    <label style="cursor:pointer" onclick="Quagga.stop()">Выключить</label><label style="cursor:pointer" onclick="startScanner();">Включить</label>
    <div id="scanner-container" class="scanner" style="padding-left: 0;margin-left: 0;"></div>

    <button class="button-primary" type="submit" style="width: 14em;">Добавить</button>
    <button class="button-primary" type="reset" style="width: 14em;">Сброс</button>
</form>

<script>
    startScanner();
</script>



</body>
</html>
