package lab.lr4;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Set;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(value = "/write")
public class WriteDBServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Set<String> paramNames = request.getParameterMap().keySet();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        for(String name : paramNames) {
            String value = request.getParameter(name);
            // out.println(value + " " + value.length() + "<br>");
            if (value.equals("null")) { value = null;}
            String index = name.replace("mark", "");
            index = index.substring(index.indexOf("_") + 1 ,index.length());
            Integer temp = Integer.parseInt(index) - 3;
            index = temp.toString();
            String id = name.replace("mark", "");
            id = id.substring(0,id.indexOf("_"));

            String sql;
            if(index.length() == 1) {
                sql = "update" + " math " + "set math.`0" + index + ".02.2024` = ? where math.id=" + id;
            } else {
                sql = "update" + " math " + "set math.`" + index + ".02.2024` = ? where math.id=" + id;
            }
            
            try (Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/students", "user", "qwer");            PreparedStatement prep = con.prepareStatement(sql)){
                prep.setString(1, value);
                prep.executeUpdate();
                prep.close();

            } catch (SQLException se) {
                out.println(se.getMessage());
                se.printStackTrace();
            } catch (Exception e) {
                out.println(e.getMessage());
                e.printStackTrace();
            }
        }
        out.println("<html><body>");
        out.println("<a href=\"/index.jsp\">На главную</a>");
        out.println("<p>Готого</p>");
        out.println("</body></html>");
        request.getRequestDispatcher("/login?user=teacher").forward(request, response);
    }
}

