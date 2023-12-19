package lab.lr4;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(value = "/list")
public class StudentShow extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<a href=\"/index.jsp\">На главную</a>");
        out.println("<h1>Список студентов </h1>");

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String sql = "select * from person";
        try(Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/studetns", "user", "qwer");
                PreparedStatement prep = con.prepareStatement(sql)) {
            ResultSet res = prep.executeQuery();
            out.println("<form action=\"student\">");
            while(res.next()) {
                String str = res.getString("first_name").replaceAll("(\\r|\\n)", "");
                Integer num = res.getInt("id");
                out.print("<p><button type=\"submit\" name=\"st\" value=\"");
                out.print(num);
                out.print("\">");
                out.print(str);
                out.println("</button><br></p>");
            }
            out.println("</form>");
            out.println("</body></html>");
        } catch (SQLException se) {
            out.println(se.getMessage());
            se.printStackTrace();
        } catch (Exception e) {
            out.println(e.getMessage());
            e.printStackTrace();
        }
    }
}

