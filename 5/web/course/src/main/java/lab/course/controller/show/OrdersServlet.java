package lab.course.controller.show;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.Orders;

import java.io.IOException;

@WebServlet(name = "OrdersServlet", urlPatterns = "/orders")
public class OrdersServlet extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Orders orders = new Orders((Integer) request.getSession().getAttribute("user_id"));
        request.getSession().setAttribute("orders", orders);
        request.getRequestDispatcher("user/orders.jsp").forward(request, response);
    }
}
