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
    <%
        if(request.getSession().getAttribute("all")!=null && (boolean)request.getSession().getAttribute("all")){
            request.getSession().setAttribute("all", null);
            out.print("<h1>Вы наврали во всех показаниях следствию:</h1><br> ");
        } else if(request.getSession().getAttribute("no")!=null && (boolean)request.getSession().getAttribute("no")){
            request.getSession().setAttribute("no", null);
            out.print("<h1>Вы отказались сотрудничества со следствием:</h1><br>");
        }
    %>
    <h3>Ваша участь предрешена...</h3>
    <img style="margin-top:5%; width: 300px; height: auto" src="img/gun2.png">
</div>
</body>
</html>
