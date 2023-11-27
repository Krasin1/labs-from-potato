<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Lab3 servlet</title>
</head>
<body>

  <h1>
      <%= "Лабораторая работа №4"%> <br>
      <%="Приложение для учета успеваемости студентов" %>
  </h1>

  <form action="login">
      <p>
          <h2><%= "Аккаунт Преподавателя" %></h2>
          <input type="submit" name="user" value="teacher">
      </p>
      <p>
          <h2><%= "Аккаунт Студента" %></h2>
          <input type="submit" name="user" value="student">
      </p>
  </form>

</body>
</html>
