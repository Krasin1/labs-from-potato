package lab.course.controller.sales;

import lab.course.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.ListProducts;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "Purchase", urlPatterns = "/purchase")
public class Purchase extends HttpServlet {
    private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static String USERNAME = "user";
    private static String PASSWORD = "qwer";


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ищем пользователя с подходящим логином
        String login = request.getParameter("buyer_login");
        User user = User.getUserByLogin(login);


        // если не нашли логин, выводим ошибку
        if (login == null || user == null) {
            request.getSession().setAttribute("err", "Такого логина не сушествует");
            response.sendRedirect("/purchase");
            return;
        }

        // получаем корзину, если не получили выводим ошибку
        ListProducts listProducts = (ListProducts) request.getSession().getAttribute("list");
        if(listProducts == null || listProducts.getListProducts().isEmpty()) {
            request.getSession().setAttribute("err", "Пустая корзина");
            response.sendRedirect("/purchase");
            return;
        }

        // читаем способ оплаты и передаем его в сессию, для дальнейших действий
        String payment = request.getParameter("payment");
        request.getSession().setAttribute("payment", payment);

        // оформляем покупку в бд
        listProducts.makePurchase(user);

        // отчищаем сессию от совершенной покупки
        request.getSession().removeAttribute("list");
        request.getSession().removeAttribute("err");
        request.getSession().removeAttribute("errorCheck");
        response.sendRedirect("/purchase");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("err") != null) {
            request.getRequestDispatcher("/buy").forward(request, response);
        } else {
            request.getRequestDispatcher("salesman/payment.jsp").forward(request, response);
        }
    }
}
