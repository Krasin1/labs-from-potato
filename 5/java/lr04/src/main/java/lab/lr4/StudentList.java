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

@WebServlet(value = "/student")
public class StudentList extends HttpServlet {

    public void createTable(PrintWriter out, String id, String table) {
        String sql = "select * from " + table + " where id = " + id;
        try (Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/studetns", "user", "qwer");            PreparedStatement prep = con.prepareStatement(sql)){
            ResultSet res = prep.executeQuery();
            out.println("<tr>");
            out.println("<td>" + table + "</td>");
            res.next();
            for(int i = 1; i <=10; ++i) {
                String temp = res.getString(i);
                temp = temp == null ? "" : temp;
                out.println("<td>" + temp + "</td>");
            }
            out.println("</tr>");
        } catch (SQLException se) {
            out.println(se.getMessage());
            se.printStackTrace();
        } catch (Exception e) {
            out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String param = request.getParameter("st");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        out.println("<html><body>");
        out.println("<a href=\"/index.jsp\">На главную</a>");
        out.println("<a href=\"/login?user=student\">Назад</a>");
        out.println("<style>table,td,tr {border:1px solid black;text-align:center;}</style>");
        out.println("<table><tr><td></td>");
        for(int i = 1; i <=10; ++i) {
            out.println("<td>" + i + ".02.2024</td>");
        }
        out.println("</tr>");
        createTable(out, param, "math");
        createTable(out, param, "history");
        createTable(out, param, "oop");
        createTable(out, param, "programming");
        out.println("</table>");
        out.println("</form>");
        out.println("</body></html>");
    }
}

