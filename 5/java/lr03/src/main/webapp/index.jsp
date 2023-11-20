<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Lab3 servlet</title>
</head>
<body>
<div>
  <h1><%= "Лабораторая работа №3" %></h1>

  <h2><%= "Выберите тематику картинок" %></h2>
  <form action="picture-servlet">
      <input type="submit" name="genre" value="Машины">
      <input type="submit" name="genre" value="Курганы">
      <input type="submit" name="genre" value="Природа">
      <input type="submit" name="genre" value="Сэм Лейк">
  </form>

  <form action="hello-servlet">
    <p>
      <input type="submit" value="Hello world!">
    </p>
  </form>

</div>
</body>
</html>
