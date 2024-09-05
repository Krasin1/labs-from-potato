<%@ page import="sample.text.l2_.model.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="sample.text.l2_.model.ComplexInfluence" %>
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
    <button class="btn-допрос" style="left: auto; float:left">< На главную</button>
</form>
<form action="${pageContext.request.contextPath}/edit" style="right: auto; float:right">
    <button class="btn-допрос">< Редактирование базы</button>
</form>
<br>
<%
    ComplexInfluence complexInfluence = (ComplexInfluence) session.getAttribute("complexInfluence");
    if (complexInfluence == null) {
        response.sendRedirect(request.getContextPath()+"/edit");
    }
%>
<form method="post" id="influence-list" action="changeQuestion"></form>
<form method="post" id="question-delete" action="removeQuestion"></form>
<div style="text-align: center; margin-top:40px">
    <h1>Редкатирование факта</h1>
    <table>
        <thead>
        <tr>
            <th style="width:60%">Наименование</th>
            <th style="width:20%">Коэфициент доверия</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th style="width:60%"><input form="influence-list" style="width:100%" type="text" name="change_text_question" value="<%=complexInfluence.getQuestion().getText()%>" required></th>
            <th style="width:20%"><input form="influence-list" style="width:100%" type="number" name="change_trust_coef" step="0.001" min="0.000" max="1.000" value="<%=complexInfluence.getQuestion().getTrust_coef()%>" required> </th>
        </tr>
        </tbody>
    </table>
</div>
<table style="margin-top:170px;">
    <thead>
    <tr>
        <th style="width:10%">ID</th>
        <th>Ответ</th>
        <th style="width:20%">Коефициент влияния</th>
    </tr>
    </thead>
    <tbody>
    <%
        ArrayList<Answer> answers = complexInfluence.getAnswers();
        ArrayList<Influence> influences = complexInfluence.getInfluences();
        for( Answer answer : answers ) {
            out.println("<tr>");
            out.println("<th style=\"width:10%\">" + answer.getId() + "</th>");
            out.println("<th>" + answer.getText() + "</th>");
            for( Influence influence : influences ) {
                if( answer.getId() == influence.getAnswer_id() && influence.getQuestion_id() == complexInfluence.getQuestion().getId() ) {
                    out.println("<th style=\"width:20%\">" +
                            "<input form=\"influence-list\" style=\"width:100%\" type=\"number\" name=\"change_influ_coef" + influence.getId() + "\" step=\"0.001\" min=\"0.000\" max=\"1.000\" value=" +
                            influence.getInfluence_coef() +
                            " required></th>");
                }
            }
            out.println("</tr>");
        }
    %>
    </tbody>
</table>
<table style="margin-top:3%">
    <thead>
    <tr>
        <th><button class="btn-допрос" form="influence-list">Применить изменения</button></th>
        <th><button class="btn-допрос" style="background:orangered" form="question-delete">Удалить вопрос</button></th>
    </tr>
    </thead>
</table>

</body>
</html>
