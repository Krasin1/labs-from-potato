<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<form action="${pageContext.request.contextPath}/consult.jsp" style="left: auto; float:left">
    <button class="btn-допрос"  style="left: auto; float:left">< Допрос</button>
</form>
<form action="${pageContext.request.contextPath}/edit" style="right: auto; float:right">
    <button class="btn-допрос"  style="right: auto; float:right">Редактура фактов ></button>
</form>
<br>
<div style="text-align:center; margin-top: 5%">
    <h1>Технические шоколадки</h1>
</div>
</body>
</html>
