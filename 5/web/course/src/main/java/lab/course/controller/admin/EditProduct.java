package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.Product;

import java.io.IOException;
import java.util.HashMap;

import static lab.course.model.Product.*;



@WebServlet(name = "EditProduct", urlPatterns = "/editProduct")
public class EditProduct extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        // получаем параметры
        int id= Integer.parseInt((String) request.getSession().getAttribute("selected_product"));
        String productName = request.getParameter("productName");
        String barcode = request.getParameter("barcode");
        String count_string = request.getParameter("count");
        String price_string = request.getParameter("price");


        // инициализируем ассощиативный массив для последующей отправки его в бд
        HashMap<String,String> map = new HashMap<>();

        // проверка на штрих-код
        if (barcode != null && !barcode.isEmpty()) {
            if (!Product.checkUniqueField("barcode",barcode)) {
                request.getSession().setAttribute("errorEditProduct", "Ошибка, штрих-код уже занят");
                response.sendRedirect("/editProduct");
                return;
            } else {
                map.put("barcode", barcode);
                request.getSession().setAttribute("product_barcode",barcode);
            }
        }

        // проверка на имя
        if (productName!= null && !productName.isEmpty()) {
            map.put("name", productName);
            request.getSession().setAttribute("product_name",productName);
        }

        // проверка на кол-во
        if (count_string!= null && !count_string.isEmpty()) {
            Integer count = Integer.parseInt(count_string);
            if (count < 0) {
                request.getSession().setAttribute("errorEditProduct", "Ошибка, не может быть отрицательного кол-ва");
                response.sendRedirect("/editProduct");
                return;
            } else {
                map.put("count_in_stok", count_string);
                request.getSession().setAttribute("product_count", count);
            }
        }

        // проверка на цену
        if (price_string!= null && !price_string.isEmpty()) {
            Integer price = Integer.parseInt(price_string);
            if (price< 0) {
                request.getSession().setAttribute("errorEditProduct", "Ошибка, не может быть отрицательной цены");
                response.sendRedirect("/editProduct");
                return;
            } else {
                map.put("price", price_string);
                request.getSession().setAttribute("product_price",price);
            }
        }


        // загружаем изменения в бд + обработка ошибки
        boolean check = updateProductParam(id, map);
        if (!check) {
            request.getSession().setAttribute("errorEditProduct", "Произошла ошибка во время обновления данных");
            response.sendRedirect("/editProduct");
            return;
        }

        // если все хорошо, то говорим что все хорошо
        request.getSession().setAttribute("successEditProduct", "Данные обновлены");
        response.sendRedirect("/editProduct");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
    }
}