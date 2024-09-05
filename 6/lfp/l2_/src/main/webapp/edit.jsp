<%@ page import="sample.text.l2_.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit</title>
    <link rel="stylesheet" href="styles2.css">
</head>
<body>
<form action="${pageContext.request.contextPath}/" style="left: auto; float:left">
    <button class="btn-допрос" style="left: auto; float:left">< На главную</button>
</form>
<form action="${pageContext.request.contextPath}/showAnswers" style="right: auto; float:right">
    <button class="btn-допрос" >Редактировать ответы</button>
</form>
<br>
<div style="text-align: center; margin-top:40px"><h1>Редкатирование базы знаний</h1></div>
<table style="margin-top:170px;">
    <thead>
    <tr>
        <th>Вопросы</th>
        <th>Коефициент доверия</th>
    </tr>
    </thead>
    <tbody>
    <%
        ArrayList<Question> questions = (ArrayList<Question>)session.getAttribute("questions");
        if (questions != null && !questions.isEmpty()) {
            for (Question q: questions) {
                out.println("<tr onclick=\"location.href='" + request.getContextPath() + "/editQuestion?question_id=" + q.getId() + "'\">");
                out.println("<td>" + q.getText() + "</td>");
                out.println("<td>" + q.getTrust_coef() + "</td>");
                out.println("</tr>");
            }
        }
    %>
    </tbody>
</table>
<br>
<div style="text-align: center; margin-top:10px"><h1>Добавить вопрос</h1></div>

<div style="text-align: center;">
    <form action="${pageContext.request.contextPath}/newQuestion" method="post">
        <input class="input" style="width:40%;" type="text" name="new_question" placeholder="Вопрос?" required>
        <input class="input" style="width:6%;" type="number" min="0.000" max="1.000" step="0.001" name="new_trust_coef" placeholder="Коэфициент" required>
        <button class="btn-допрос"type="submit" >Добавить</button>
    </form>
</div>

</body>
</html>
