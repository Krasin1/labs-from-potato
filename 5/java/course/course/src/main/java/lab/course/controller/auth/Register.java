package lab.course.controller.auth;

import java.nio.charset.StandardCharsets;
import java.security.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "Register", urlPatterns = "/register")
public class Register extends HttpServlet {
    private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static String USERNAME = "user";
    private static String PASSWORD = "qwer";


    // хэшируем пароль
    String getHashedPassword(final String text) {
        if (text == null) return null;

        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
            md.update(text.getBytes("UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (md != null)
            return new String(md.digest(), StandardCharsets.UTF_8);
        else return null;
    }
    // номер телефона проверяется по регулярному выражению 
    boolean checkPhone(String str) {
        if (str == null) return false;
        String patterns = "^((8|\\+7)[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{7,10}$";
        Pattern pattern = Pattern.compile(patterns);
        Matcher matcher =  pattern.matcher(str);
        return matcher.matches();
    }

    // почта проверяется по регулярному выражению 
    boolean checkEmail(String str) {
        if (str == null) return false;
        String patterns =
                    "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
                    "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
        Pattern pattern = Pattern.compile(patterns);
        Matcher matcher =  pattern.matcher(str);
        return matcher.matches();
    }

    // проверяем на уникальность логин
    boolean checkLogin(Connection connection, String login) {
        String SQL = "select * from Users where login = ?";
        PreparedStatement preparedStatement = null;
        try { 
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, login);
            ResultSet resultSet = preparedStatement.executeQuery();
            connection.close();

            if (!resultSet.next()) {
                connection.close();
                return true;
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // получаем параметры из формы
        String login = request.getParameter("login");
        // хэшируем пароль
        String password = getHashedPassword(request.getParameter("password").trim());
        String passwordSecond = getHashedPassword(request.getParameter("passwordSecond").trim());
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        // новые пользователи получают роль user
        String role = "user";

        // подготавливаем запрос
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "INSERT INTO `Users`(`login`, `password`, `email`, `name`, `surname`, `phone`, `role`) VALUES (?,?,?,?,?,?,?)";
        int resultExecute = 0;

        if (!passwordSecond.equals(password)) {
            request.getSession().setAttribute("errorInput", "Пароли не совпадают");
            response.sendRedirect("register");
            return;
        } else if (!checkEmail(email)) {
            request.getSession().setAttribute("errorInput", "Неправильно введена почта");
            response.sendRedirect("register");
            return;
        } else if (!checkPhone(phone)) {
            request.getSession().setAttribute("errorInput", "Неправильно введен номер");
            response.sendRedirect("register");
            return;
        } else if (!checkLogin(connection, login)) {
            request.getSession().setAttribute("errorInput", "Логин занят");
            response.sendRedirect("register");
            return;
        }


        // подключаем базу данных 
        // если прошли проверки, то заносим пользователя в бд
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, login);
            preparedStatement.setString(2, password);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, name);
            preparedStatement.setString(5, surname);
            preparedStatement.setString(6, phone);
            preparedStatement.setString(7, role);
            resultExecute = preparedStatement.executeUpdate();
            // preparedStatement.execute();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // если insert прошел успешно, то выводим уведомление
        request.getSession().invalidate();
        if (resultExecute != 0) {
            request.getSession().setAttribute("success", "Пользователь зарегестрированн");
        } else {
            request.getSession().setAttribute("errorInput", "Что то пошло не так");
        }
        response.sendRedirect("register");

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
