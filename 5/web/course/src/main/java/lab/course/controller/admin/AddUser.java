package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@WebServlet(name = "AddUser", urlPatterns = "/addUser")
public class AddUser extends HttpServlet {
    private static final String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static final String USERNAME = "user";
    private static final String PASSWORD = "qwer";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // получаем параметры из формы
        String login = request.getParameter("login");
        // хэшируем пароль
        String password = User.getHashedPassword(request.getParameter("password").trim());
        String passwordSecond = User.getHashedPassword(request.getParameter("passwordSecond").trim());
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("roleInput");

        // подготавливаем запрос
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "INSERT INTO `Users`(`login`, `password`, `email`, `name`, `surname`, `phone`, `role`) VALUES (?,?,?,?,?,?,?)";
        int resultExecute = 0;

        if (!passwordSecond.equals(password)) {
            request.getSession().setAttribute("errorAddUser", "Пароли не совпадают");
            response.sendRedirect("addUser");
            return;
        } else if (!User.checkEmail(email)) {
            request.getSession().setAttribute("errorAddUser", "Неправильно введена почта");
            response.sendRedirect("addUser");
            return;
        } else if (!User.checkUniqueField("phone",phone)) {
            request.getSession().setAttribute("errorAddUser", "Аккаунт с этим номером уже существует");
            response.sendRedirect("addUser");
            return;
        } else if (!User.checkUniqueField("login", login)) {
            request.getSession().setAttribute("errorAddUser", "Логин занят");
            response.sendRedirect("addUser");
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
        if (resultExecute != 0) {
            request.getSession().removeAttribute("errorAddUser");
            request.getSession().setAttribute("successAddUser", "Пользователь зарегестрированн");
        } else {
            request.getSession().setAttribute("errorAddUser", "Что то пошло не так");
        }
        response.sendRedirect("addUser");

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin/addUser.jsp").forward(request, response);
    }
}
