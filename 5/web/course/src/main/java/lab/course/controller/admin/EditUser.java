package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.Objects;

import static lab.course.model.User.*;

@WebServlet(name = "EditUser", urlPatterns = "/editUser")
public class EditUser extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getSession().setAttribute("errorEdit", null);
        request.getSession().setAttribute("sucEdit", null);

        // получаем параметры
        String user_login = (String) request.getSession().getAttribute("user_login");
        String login = request.getParameter("login");
        String passwordNew = getHashedPassword(request.getParameter("passwordNew"));
        String passwordSecond = getHashedPassword(request.getParameter("passwordNewSecond"));
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("roleInput");


        // инициализируем ассощиативный массив для последующей отправки его в бд
        HashMap<String,String> map = new HashMap<>();

        // правильность пароля
        if ( passwordNew != null && !passwordNew.isEmpty() || passwordSecond != null && !passwordSecond.isEmpty()) {
            if (!passwordNew.equals(passwordSecond)) {
                request.getSession().setAttribute("errorEdit", "Ошибка: Проверьте пароль");
                response.sendRedirect("/editUser");
                return;
            } else {
                map.put("password", passwordNew);
            }
        }
        // проверка на правилный email
        if (email != null && !email.isEmpty()) {
            if (!checkEmail(email)) {
                request.getSession().setAttribute("errorEdit", "Некорректный адрес почты");
                response.sendRedirect("/editUser");
                return;
            } else {
                map.put("email", email);
                request.getSession().setAttribute("user_email", email);
            }
        }

        // проверка на логин
        if (login != null && !login.isEmpty()) {
            if (!User.checkUniqueField("login", login)) {
                request.getSession().setAttribute("errorEdit", "Ошибка, логин уже занят");
                response.sendRedirect("/editUser");
                return;
            } else {
                map.put("login", login);
                request.getSession().setAttribute("user_login", login);
            }
        }

        // проверка на имя
        if (name != null && !name.isEmpty()) {
            map.put("name", name);
            request.getSession().setAttribute("user_name",name);
        }

        // проверка на фамилию
        if (surname != null && !surname.isEmpty()) {
            map.put("surname", surname);
            request.getSession().setAttribute("user_surname", surname);
        }

        // проверка на телефон
        if (phone != null && !phone.isEmpty()) {
            if (!User.checkUniqueField("phone",phone)) {
                request.getSession().setAttribute("errorEdit", "Ошибка, телефон уже используется");
                response.sendRedirect("/editUser");
                return;
            } else {
                map.put("phone", phone);
                request.getSession().setAttribute("user_phone", phone);
            }
        }

        // проверка на роль
        if (role != null && !role.isEmpty()) {
            map.put("role", role);
            request.getSession().setAttribute("user_role", role);
        }

        // получаем id пользователя по логину для загрузки в бд
        int id = Objects.requireNonNull(getUserByLogin(user_login)).getId();

        // загружаем изменения в бд + обработка ошибки
        boolean check = updateUserParam(id, map);
        if (!check) {
            request.getSession().setAttribute("errorEdit", "Произошла ошибка во время обновления данных");
            response.sendRedirect("/editUser");
            return;
        }

        // если все хорошо, то говорим что все хорошо
        request.getSession().setAttribute("sucEdit", "Данные обновлены");
        response.sendRedirect("/editUser");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/editUser.jsp").forward(request, response);
    }
}
