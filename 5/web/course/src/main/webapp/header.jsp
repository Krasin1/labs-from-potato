<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link type="text/css" href="style.css" rel="stylesheet">
<style> * {margin: 5px; padding: 5px;} </style>
<header style="width: 100%; position:sticky; top: 10px; overflow: hidden; background-color: azure">
    <nav style="display:flex; justify-content: space-between">
        <div>
            <%  var role = request.getSession().getAttribute("role").toString();
                var name = request.getSession().getAttribute("name").toString();
                if (role.equals("admin")) { out.print("<h2>Администратор : " + name + "</h2>"); }
                else if (role.equals("salesman")) { out.print("<h2>Продавец : " + name + "</h2>"); }
                else if (role.equals("user")) { out.print("<h2>Пользователь : " + name + "</h2>"); }%>
        </div>
        <div>
            <form style="right: auto; float: right" action="logout" ><button class="button-primary" >Выйти</button></form>
            <form style="right: auto; float: right" action="/data" method="post"><button class="button-primary" >Настройки</button></form>
            <form style="right: auto; float: right" action="/login" method="get"><button class="button-primary" >Меню</button></form>
            <form style="right: auto; float: right" action="/" method="post"><button class="button-primary">На главную</button></form>
        </div>


    </nav>
</header>
<br>