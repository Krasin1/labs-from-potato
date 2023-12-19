package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.Product;
import lab.course.model.User;

import java.io.IOException;

@WebServlet(name = "RedirectToEditProduct ", urlPatterns = "/redirectToEditProduct")
public class RedirectToEditProduct extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().setAttribute("errorEditProduct", null);
        request.getSession().setAttribute("successEditProduct", null);
        Integer id = Integer.valueOf( (String) request.getSession().getAttribute("selected_product"));
        Product product = Product.getProductById(id);
        if (product != null) {
            System.out.println(id);
            request.getSession().setAttribute("product_name", product.getProduct_name());
            request.getSession().setAttribute("product_barcode", product.getBarcode());
            request.getSession().setAttribute("product_count", product.getCount_in_stok());
            request.getSession().setAttribute("product_price", product.getPrice());
        }
        request.getRequestDispatcher("/editProduct").forward(request, response);
    }
}
