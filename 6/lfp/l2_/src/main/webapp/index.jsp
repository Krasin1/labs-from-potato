<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Консультация</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>

<div class="question-block" style="top:40%">
    <form action="${pageContext.request.contextPath}/consult.jsp" style="left: auto; float:left">
        <button class="btn-допрос" style="left: auto; float:left">Допрос</button>
    </form>
    <form action="${pageContext.request.contextPath}/edit" style="right:auto; float:right">
        <button class="btn-допрос" style="right:auto; float:right">Редактура фактов</button>
    </form>
</div>
<div style="text-align:center">
    <h3>Работу выполнил студент СПбГУТ 3 курса группы ИКПИ-11 Дунаев В.Е.</h3><br>
</div>
</body>
</html>
