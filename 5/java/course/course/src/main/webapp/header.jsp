<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    * {margin: 5px; padding: 5px;}
</style>
<header style="width: 100%; position:sticky; top: 0; overflow: hidden">
    <nav>
        <%  var role = request.getSession().getAttribute("role").toString();
            var name = request.getSession().getAttribute("name").toString();
            if (role.equals("admin")) { out.print("<label>Админ : " + name + "</label>"); }
            else if (role.equals("salesman")) { out.print("<label>Продавец : " + name + "</label>"); }
            else if (role.equals("user")) { out.print("<label>Пользователь : " + name + "</label>"); } %>

        <form style="right: auto; float: right" action="logout" ><button>Logout</button></form>
        <form  style="right: auto; float: right" action="/data" method="post"><button>Аккаунт</button></form>
        <form style="right: auto; float: right" action="/" method="post"><button>На главную</button></form>
    </nav>
</header>