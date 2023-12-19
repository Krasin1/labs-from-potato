package lab.course.controller.show;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lab.course.model.Order;
import lab.course.model.Orders;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "OrderServlet", urlPatterns = "/order")
public class OrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String purchase_id = request.getParameter("order_id");
        Integer user_id = (Integer) request.getSession().getAttribute("user_id");
            try {
                if (purchase_id == null ) throw new NumberFormatException();
                Integer p_id = Integer.valueOf(purchase_id);
                ArrayList<Order> info = Order.getOrderInfo(p_id, user_id);
                if (info == null) throw new NumberFormatException();

                request.getSession().removeAttribute("errorOrder");
                request.getSession().setAttribute("orderInfo", info);
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorOrder", "Неправильный номер заказа");
            }

        request.getRequestDispatcher("user/order.jsp").forward(request, response);
    }
}
