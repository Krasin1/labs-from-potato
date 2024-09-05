<%@ page import="java.util.ArrayList" %>
<%@ page import="sample.text.l2_.model.Answer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit</title>
    <link rel="stylesheet" href="styles2.css">
</head>
<body>
<form action="${pageContext.request.contextPath}/" style="left: auto; float:left">
    <button  class="btn-допрос"style="left: auto; float:left">< На главную</button>
</form>
<form action="${pageContext.request.contextPath}/edit" style="right: auto; float:right">
    <button class="btn-допрос">< Редактирование базы</button>
</form>
<br>
<div style="text-align: center; margin-top:40px"><h1>Редкатирование ответов</h1></div>
<table style="margin-top:170px;">
    <thead>
    <tr>
        <th style="width: 10%">ID</th>
        <th>Текст ответа</th>
    </tr>
    </thead>
    <tbody>
    <%
        ArrayList<Answer> answers = (ArrayList<Answer>)session.getAttribute("answers");
        if (answers != null && !answers.isEmpty()) {
            for (Answer a: answers) {
                out.println("<tr onclick=\"location.href='" + request.getContextPath() + "/editAnswer?answer_id=" + a.getId() + "'\">");
                out.println("<td style=\"width:10%\">" + a.getId() + "</td>");
                out.println("<td>" + a.getText() + "</td>");
                out.println("</tr>");
            }
        }
    %>
    </tbody>
</table>
<br>
<div style="text-align: center; margin-top:10px"><h1>Добавить ответ</h1></div>

<div style="text-align: center;">
    <form action="${pageContext.request.contextPath}/newAnswer" method="post">
        <input class="input" style="width:50%;" type="text" name="new_answer" placeholder="Ответ" required>
        <button class="btn-допрос" type="submit" >Добавить</button>
    </form>
</div>

</body>
</html>
