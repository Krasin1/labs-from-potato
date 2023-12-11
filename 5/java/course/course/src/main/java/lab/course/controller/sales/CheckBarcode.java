package lab.course.controller.sales;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.ListProducts;

@WebServlet(name = "CheckBarcode", urlPatterns = "/checkBarcode")
public class CheckBarcode extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // получаем штрих код 
        String barcode = request.getParameter("barcode");

        // создаем/получаем корзину
        ListProducts listProducts = (ListProducts) request.getSession().getAttribute("list");
        if(listProducts == null) listProducts = new ListProducts();

        // добавляем товар по штрих коду + возврааем корзину или выводим ошибку
        if (listProducts.addByBarcode(barcode)) {
            request.getSession().setAttribute("errorCheck", null); 
            request.getSession().setAttribute("list", listProducts);
        } else {
            request.getSession().setAttribute("errorCheck", "Такого товара нет в базе данных");
        }

        // редирект на себя, для очередного товара
        response.sendRedirect("/checkBarcode");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("salesman/").forward(request, response);
    }
}
