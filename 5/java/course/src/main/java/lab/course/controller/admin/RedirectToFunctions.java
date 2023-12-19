package lab.course.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


@WebServlet(name = "RedirectToFunctions", urlPatterns = "/func")
public class RedirectToFunctions extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String choose =  request.getParameter("choose");
        request.getSession().setAttribute("choose", choose);
        if (choose.equals("editUser")) {
            request.getSession().setAttribute("user_login", request.getParameter("login"));
        }
        if (choose.equals("editProduct")) {
            request.getSession().setAttribute("selected_product", request.getParameter("product"));
        }

        response.sendRedirect("/func");
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        boolean check = (session.getAttribute("role") != null);
        String choose = (String) session.getAttribute("choose");

        if (check) {
            if (choose.equals("addUser")) {
                request.getRequestDispatcher("admin/addUser.jsp").forward(request, response);
            } else if (choose.equals("editUser")) {
                request.getRequestDispatcher("/redirectToEditUser").forward(request, response);
            } else if (choose.equals("listUser")) {
                request.getRequestDispatcher("/listUser").forward(request, response);
            } else if (choose.equals("deleteUser")){
                request.getRequestDispatcher("admin/deleteUser.jsp").forward(request, response);
            } else if (choose.equals("addProduct")) {
                request.getRequestDispatcher("admin/addProduct.jsp").forward(request, response);
            } else if (choose.equals("editProduct")) {
                request.getRequestDispatcher("/redirectToEditProduct").forward(request, response);
            } else if (choose.equals("listProduct")) {
                request.getRequestDispatcher("/listProduct").forward(request, response);
            } else if (choose.equals("deleteProduct")){
                request.getRequestDispatcher("admin/deleteProduct.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
