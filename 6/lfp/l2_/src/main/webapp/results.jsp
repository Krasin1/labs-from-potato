<%@ page import="sample.text.l2_.model.Fact" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Map" %>
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
<div style="text-align:center">
    <br>
    <h1>Ваш приговор:</h1>
<%
    TreeMap<Float, String> sorted_cfg = (TreeMap<Float,String>)session.getAttribute("sorted_cfg");
    if (sorted_cfg != null || !sorted_cfg.isEmpty()) {
        out.println("<p>---> <u>"+ sorted_cfg.lastEntry().getValue() + "</u> <---</p>");
    }
%>
</div>
<table style="margin-top:2%">
    <thead>
    <tr>
        <th>Другие возможные приговоры</th>
        <th>Точность</th>
    </tr>
    </thead>
    <tbody>
<%
    if (sorted_cfg != null || !sorted_cfg.isEmpty()) {
        for (Map.Entry<Float, String> entry : sorted_cfg.descendingMap().entrySet()) {
            if (entry.getKey() > 0.000){
                out.println("<tr>");
                out.println("<td>" + entry.getValue() + "</td>");
                out.println("<td>" + entry.getKey() * 100 + " %</td>");
                out.println("</tr>");
            }
        }
    }
%>
    </tbody>
</table>

<br>

<table>
    <thead>
    <tr>
        <th>Ваши показания</th>
    </tr>
    </thead>
    <tbody>
<%
    ArrayList<Fact> facts = (ArrayList<Fact>)session.getAttribute("facts");
    if (facts != null && !facts.isEmpty()) {
        for (Fact fact : facts) {
            out.println("<tr>");
            out.println("<td>" + fact.getText() + "</td>");
            out.println("</tr>");
        }
    }
%>
    </tbody>
</table>

</body>
</html>
