package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.User;

import java.io.IOException;

@WebServlet(name = "RedirectToEditUser ", urlPatterns = "/redirectToEditUser")
public class RedirectToEditUser extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().setAttribute("errorEdit", null);
        request.getSession().setAttribute("sucEdit", null);
        String login = (String) request.getSession().getAttribute("user_login");
        User user = User.getUserByLogin(login);
        if (user != null) {
            request.getSession().setAttribute("user_email", user.getEmail());
            request.getSession().setAttribute("user_name", user.getName());
            request.getSession().setAttribute("user_surname", user.getSurname());
            request.getSession().setAttribute("user_phone", user.getPhone());
            request.getSession().setAttribute("user_role", user.getRole());
        } else {
            request.getSession().setAttribute("noUser", true);
            request.getRequestDispatcher("/login").forward(request, response);
        }
        request.getRequestDispatcher("/editUser").forward(request, response);
    }
}
