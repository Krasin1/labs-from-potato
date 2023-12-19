package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.Product;

import java.io.IOException;

import static lab.course.model.Product.newProduct;


@WebServlet(name = "AddProduct", urlPatterns = "/addProduct")
public class AddProduct extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // получаем параметры из формы
        String name = request.getParameter("productName");
        String barcode = request.getParameter("barcode");
        String count = request.getParameter("count");
        String price = request.getParameter("price");

        if (name == null || name.isEmpty()) {
            request.getSession().setAttribute("errorAddProduct", "Наименоавние не может быть пустым");
            response.sendRedirect("addProduct");
            return;
        } else if (barcode == null || barcode.isEmpty()) {
            request.getSession().setAttribute("errorAddProduct", "Штрих-код не может быть пустым");
            response.sendRedirect("addProduct");
            return;
        } else if (!Product.checkUniqueField("barcode", barcode)) {
            request.getSession().setAttribute("errorAddProduct", "Штрих-код уже занят");
            response.sendRedirect("addProduct");
            return;
        } else if (count == null || count.isEmpty() || Integer.parseInt(count) < 0) {
            request.getSession().setAttribute("errorAddProduct", "Неправильно задано кол-во");
            response.sendRedirect("addProduct");
            return;
        } else if (price == null || price.isEmpty() || Integer.parseInt(price) < 0) {
            request.getSession().setAttribute("errorAddProduct", "Неправильно задана цена");
            response.sendRedirect("addProduct");
            return;
        }


        // если insert прошел успешно, то выводим уведомление
        if (newProduct(name, barcode, Integer.valueOf(count), Integer.valueOf(price))) {
            request.getSession().removeAttribute("errorAddProduct");
            request.getSession().setAttribute("successAddProduct", "Товар зарегестрированн");
        } else {
            request.getSession().setAttribute("errorAddProduct", "Что то пошло не так");
        }
        response.sendRedirect("addProduct");

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("admin/addProduct.jsp").forward(request, response);
    }
}
