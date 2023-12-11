package lab.course.controller.auth;

import java.nio.charset.StandardCharsets;
import java.security.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lab.course.model.User;

import static lab.course.model.User.*;

@WebServlet(name = "AccountChange", urlPatterns = "/account")
public class AccountChange extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String login = request.getParameter("login");
        String passwordNew = getHashedPassword(request.getParameter("passwordNew").trim());
        String passwordOld = getHashedPassword(request.getParameter("passwordOld").trim());
        String passwordSecond = getHashedPassword(request.getParameter("passwordNewSecond").trim());
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        int id = (int) request.getSession().getAttribute("user_id");

        // правильность пароля
        System.out.println(request.getParameter("passwordNew"));
        System.out.println(request.getParameter("passwordOld"));
        System.out.println(request.getParameter("passwordNewSecond"));
        if (passwordOld != null && !passwordOld.isEmpty() ||
                passwordNew != null  && !passwordNew.isEmpty()||
                passwordSecond != null && !passwordSecond.isEmpty()) {
            if (!request.getSession().getAttribute("password").equals(passwordOld)
                    || !passwordNew.equals(passwordSecond)) {
                System.out.println("pass");
                request.getSession().setAttribute("error", "Ошибка: Проверьте пароль");
                response.sendRedirect("/account");
                return;
            } else { updateUserParam(id, "password", passwordNew); }
        }
        // проверка на правилный email
        if (email != null && !email.isEmpty() && !checkEmail(email)) {
            System.out.println("mail");
            request.getSession().setAttribute("error", "Некорректный адрес почты");
            response.sendRedirect("/account");
            return;
        } else { updateUserParam(id, "email", email); }


        // проверка на логин
        if (login != null && !login.isEmpty() && User.checkLogin(login)) {
            System.out.println("login");
            request.getSession().setAttribute("error", "Ошибка, логин уже занят");
            response.sendRedirect("/account");
            return;
        } else { updateUserParam(id, "login", login); }

        // проверка на имя 
        if (name != null && !name.isEmpty()) {
            System.out.println("name");
            request.getSession().setAttribute("error", "");
            response.sendRedirect("/account");
            return;
        } else { updateUserParam(id, "name", name); }

        // проверка на фамилию
        if (surname != null && !surname.isEmpty()) {
            System.out.println("surname");
            request.getSession().setAttribute("error", "");
            response.sendRedirect("/account");
            return;
        } else { updateUserParam(id, "surname", surname); }
        ;

        // проверка на телефон
        if (phone != null && !phone.isEmpty() && User.checkPhone(login)) {
            System.out.println("phone");
            request.getSession().setAttribute("error", "Ошибка, логин уже занят");
            response.sendRedirect("/account");
            return;
        } else { updateUserParam(id, "phone", phone); }


            request.getSession().setAttribute("suc", "Данные обновлены");
            response.sendRedirect("/account");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("user_profile.jsp").forward(request, response);
    }
}
