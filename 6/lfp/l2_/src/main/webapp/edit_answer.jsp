<%@ page import="sample.text.l2_.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sample.text.l2_.model.Answer" %>
<%@ page import="sample.text.l2_.model.Influence" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="styles2.css">
</head>
<body>
<form action="${pageContext.request.contextPath}/" style="left: auto; float:left">
    <button  class="btn-допрос" style="left: auto; float:left">< На главную</button>
</form>
<form action="${pageContext.request.contextPath}/showAnswers" style="right: auto; float:right">
    <button class="btn-допрос">< Редактирование ответов</button>
</form>
<br>
<form method="post" id="answer-form" action="changeAnswer"></form>
<form method="post" id="answer-delete" action="removeAnswer"></form>
<div style="text-align: center; margin-top:40px">
    <h1>Редкатирование факта</h1>
    <table>
        <thead>
        <tr>
            <th style="width: 10%">ID</th>
            <th style="width: 60%">Наименование</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th style="width:10%">
                <%
                    Answer ans = (Answer)request.getSession().getAttribute("editing_answer");
                    out.println(ans.getId());
                %>
            </th>
            <th style="width:60%"><input form="answer-form" style="width:100%" type="text" name="change_answer" value="<% out.println(ans.getText()); %>" required></th>
        </tr>
        </tbody>
    </table>
    <table>
        <thead>
        <tr>
            <th><button class="btn-допрос" form="answer-form">Применить изменения</button></th>
            <th><button class="btn-допрос"style="background:orangered" form="answer-delete">Удалить ответ</button></th>
        </tr>
        </thead>
    </table>
</div>
<br>

</body>
</html>
