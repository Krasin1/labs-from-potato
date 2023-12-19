package lab.lr4;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;


@WebServlet(value = "/login")
public class login extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String role = request.getParameter("user");
        switch (role) {
            case "student" :
                request.getRequestDispatcher("/list").forward(request,response);
                break;
            case "teacher" :
                request.getRequestDispatcher("/teacher").forward(request,response);
                break;
        }
    }
}
