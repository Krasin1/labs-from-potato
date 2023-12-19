package lab.course.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.User;

import java.io.IOException;
import java.util.HashMap;

import static lab.course.model.User.*;

@WebServlet(name = "AccountChange", urlPatterns = "/account")
public class AccountChange extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().setAttribute("error", null);
        request.getSession().setAttribute("suc",null);

        // получаем параметры
        String login = request.getParameter("login");
        String passwordNew = getHashedPassword(request.getParameter("passwordNew"));
        String passwordOld = getHashedPassword(request.getParameter("passwordOld"));
        String passwordSecond = getHashedPassword(request.getParameter("passwordNewSecond").trim());
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int id = (int) request.getSession().getAttribute("user_id");

        // инициализируем ассощиативный массив для последующей отправки его в бд
        HashMap<String,String> map = new HashMap<>();


        // правильность пароля
        if (passwordOld != null && !passwordOld.isEmpty() ||
                passwordNew != null && !passwordNew.isEmpty() ||
                passwordSecond != null && !passwordSecond.isEmpty()) {
            if (!request.getSession().getAttribute("password").equals(passwordOld)
                    || !passwordNew.equals(passwordSecond)) {
                request.getSession().setAttribute("error", "Ошибка: Проверьте пароль");
                response.sendRedirect("/account");
                return;
            } else {
                map.put("password", passwordNew);
                request.getSession().setAttribute("password", passwordNew);
            }
        }
        // проверка на правилный email
        if (email != null && !email.isEmpty()) {
            if (!checkEmail(email)) {
                request.getSession().setAttribute("error", "Некорректный адрес почты");
                response.sendRedirect("/account");
                return;
            } else {
                map.put("email", email);
                request.getSession().setAttribute("email", email);
            }
        }

        // проверка на логин
        if (login != null && !login.isEmpty()) {
            if (!User.checkUniqueField("login", login)) {
                request.getSession().setAttribute("error", "Ошибка, логин уже занят");
                response.sendRedirect("/account");
                return;
            } else {
                map.put("login", login);
                request.getSession().setAttribute("login", login);
            }
        }

        // проверка на имя
        if (name != null && !name.isEmpty()) {
            map.put("name", name);
            request.getSession().setAttribute("name",name);
        }

        // проверка на фамилию
        if (surname != null && !surname.isEmpty()) {
            map.put("surname", surname);
            request.getSession().setAttribute("surname", surname);
        }

        // проверка на телефон
        if (phone != null && !phone.isEmpty()) {
            if (!User.checkUniqueField("phone",phone)) {
                request.getSession().setAttribute("error", "Ошибка, телефон уже используется");
                response.sendRedirect("/account");
                return;
            } else {
                map.put("phone", phone);
                request.getSession().setAttribute("phone", phone);
            }
        }
        boolean check = true;
        // загружаем изменения в бд + обработка ошибки
        if (!map.isEmpty()) check = updateUserParam(id, map);
        if (!map.isEmpty() && !check) {
            request.getSession().setAttribute("error", "Произошла ошибка во время обновления данных");
            response.sendRedirect("/account");
            return;
        }

        // если все хорошо, то говорим что все хорошо
        request.getSession().setAttribute("error", null);
        if (!map.isEmpty()) request.getSession().setAttribute("suc", "Данные обновлены");
        response.sendRedirect("/account");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("user_profile.jsp").forward(request, response);
    }
}
