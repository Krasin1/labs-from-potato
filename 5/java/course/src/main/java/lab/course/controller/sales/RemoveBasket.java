package lab.course.controller.sales;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.ListProducts;
import lab.course.model.Product;

@WebServlet(name = "RemoveBasket", urlPatterns = "/remove")
public class RemoveBasket extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // получаем список товаров, которые удаляем из корзины
        String[] checkboxes = request.getParameterValues("delete");

        // получаем корзину, если не получили выводим ошибку
        ListProducts listProducts = (ListProducts) request.getSession().getAttribute("list");
        if(listProducts == null || listProducts.getListProducts().isEmpty() || checkboxes == null) {
            request.getSession().setAttribute("errorCheck", "Нечего удалять");
            response.sendRedirect("/checkBarcode");
            return;
        }

        // находим все товары, которые будем удаялть из корзины
        ArrayList<Product> temp = new ArrayList<>();
        for (var check : checkboxes) {
            for (var a : listProducts.getListProducts()) {
                if (check.equals(a.getId().toString())) {
                    temp.add(a);
                    // listProducts.deleteProduct(a);
                }
            }
        }
        // удаяем все найденные
        for (var a : temp) {
            listProducts.deleteProduct(a);
        }

        // возвращаемся назад
        request.getSession().removeAttribute("errorCheck");
        response.sendRedirect("/checkBarcode");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/checkBarcode").forward(request, response);
    }
}
