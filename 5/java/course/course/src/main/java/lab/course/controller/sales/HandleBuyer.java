package lab.course.controller.sales;

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
import lab.course.model.ListProducts;

@WebServlet(name = "HandleBuyer", urlPatterns = "/buy")
public class HandleBuyer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // получаем корзину, если не получили выводим ошибку
        ListProducts listProducts = (ListProducts) request.getSession().getAttribute("list");
        if(listProducts == null || listProducts.getListProducts().isEmpty()) {
            request.getSession().setAttribute("errorCheck", "Не выбран ни один товар");
            response.sendRedirect("/checkBarcode");
            return;
        }
        // считываем кол-во товаров в корзине из формы
        for (var a :listProducts.getListProducts()){
            String basket = request.getParameter("basket" + a.getId());
            a.setCount(Integer.parseInt(basket));
        }

        // проверяем, хватает ли товара на складе
        if (!listProducts.checkCountInStok()) {
            request.getSession().setAttribute("errorCheck", "Товара не хватает на складе ");
            response.sendRedirect("/checkBarcode");
            return;
        }



        request.getSession().setAttribute("errorCheck",null);
        response.sendRedirect("/buy");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("errorCheck") != null) {
            request.getRequestDispatcher("/checkBarcode").forward(request, response);
        } else {
            request.getRequestDispatcher("salesman/handleBuyer.jsp").forward(request, response);
        }
    }
}
