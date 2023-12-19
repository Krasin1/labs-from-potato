package lab.course.controller.auth;

import java.nio.charset.StandardCharsets;
import java.security.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Login", urlPatterns = "/login")
public class Login extends HttpServlet {
    private static final String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static final String USERNAME = "user";
    private static final String PASSWORD = "qwer";
    

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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().setAttribute("errorMessage", null);
        // считываем логин и хэш пароля
        String login = request.getParameter("login");
        String password = getHashedPassword(request.getParameter("password").trim());

        HttpSession session = request.getSession(true);
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String SQL = "select * from Users where login = ?";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, login);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                session.setAttribute("user_id", resultSet.getInt("id"));
                session.setAttribute("login", resultSet.getString("login"));
                session.setAttribute("password", resultSet.getString("password"));
                session.setAttribute("role", resultSet.getString("role"));
                session.setAttribute("name", resultSet.getString("name"));
                session.setAttribute("surname", resultSet.getString("surname"));
                session.setAttribute("email", resultSet.getString("email"));
                session.setAttribute("phone", resultSet.getString("phone"));
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // проверяем логин и пароль, после перенаправляем на нужную страницу
        if (login.equals(session.getAttribute("login")) &&
                password.equals(session.getAttribute("password")) &&
                "admin".equals(session.getAttribute("role")) ) {
            response.sendRedirect("login");
        } else if (login.equals(session.getAttribute("login")) &&
                password.equals(session.getAttribute("password")) &&
                "salesman".equals(session.getAttribute("role")) ) {
            response.sendRedirect("login");
        } else if (login.equals(session.getAttribute("login")) &&
                password.equals(session.getAttribute("password")) &&
                "user".equals(session.getAttribute("role")) ) {
            response.sendRedirect("login");
        } else {
            request.getSession().invalidate();
            request.getSession().setAttribute("hash", getHashedPassword(password));
            request.getSession().setAttribute("errorMessage", "Логин или пароль введены неправильно");
            response.sendRedirect("login");
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        boolean check = (session.getAttribute("role") != null);
        ServletContext servletContext = getServletContext();
        // ServletRequest servletRequest = request.
        
        if (check && session.getAttribute("role").equals("admin")) {
            request.getRequestDispatcher("admin/").forward(request, response);
            // servletContext.getRequestDispatcher("/admin/").forward(request, response);
        } else if (check && session.getAttribute("role").equals("salesman")) {
            request.getRequestDispatcher("salesman/").forward(request, response);
            // servletContext.getRequestDispatcher("/salesman/").forward(request, response);
        } else if (check && session.getAttribute("role").equals("user")) {
            request.getRequestDispatcher("user/").forward(request, response);
            // servletContext.getRequestDispatcher("/user/").forward(request, response);
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
            // servletContext.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
