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

@WebServlet(value = "/teacher")
public class TeacherServlet extends HttpServlet {

    public void createTable(PrintWriter out, String table) {
        String sql = "select * from person cross join " + table + " on person.id="+table+".id";
        try (Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/studetns", "user", "qwer");            PreparedStatement prep = con.prepareStatement(sql)){
            ResultSet res = prep.executeQuery();
            while(res.next()){
                out.println("<tr>");
                out.println("<td>" + res.getString(2) + " " + res.getString(3) + "</td>");
                for(int i = 4; i <=13; ++i) {
                    createCell(out, res.getString(i), res.getString(1)+"_"+i);
                }
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
    public void createCell(PrintWriter out, String param, String unique) {
        out.println("<td><select name=\"mark" + unique + "\">");

        out.println("<option value=\"null\" ");
        if(param == null) {out.println("selected>");} else {out.println(">");}
        out.println("</option>");

        out.println("<option value=\"2\" ");
        if(param != null && param.equals("2")) {out.println("selected>");} else {out.println(">");}
        out.println("2</option>");

        out.println("<option value=\"3\" ");
        if(param != null && param.equals("3")) {out.println("selected>");} else {out.println(">");}
        out.println("3</option>");

        out.println("<option value=\"4\" ");
        if(param != null && param.equals("4")) {out.println("selected>");} else {out.println(">");}
        out.println("4</option>");

        out.println("<option value=\"5\" ");
        if(param != null && param.equals("5")) {out.println("selected>");} else {out.println(">");}
        out.println("5</option>");

        out.println("<option value=\"н\" ");
        if(param != null && param.equals("н")) {out.println("selected>");} else {out.println(">");}
        out.println("н</option>");
        // out.println("<option value=\"null\" " + param == null ? "selected>" : ">" + "</option>");
        // out.println("<option value=\"2\" " + param == "2" ? "selected>" : ">" + "2</option>");
        // out.println("<option value=\"3\" " + param == "3" ? "selected>" : ">" + "3</option>");
        // out.println("<option value=\"4\" " + param == "4" ? "selected>" : ">" + "4</option>");
        // out.println("<option value=\"5\" " + param == "5" ? "selected>" : ">" + "5</option>");
        // out.println("<option value=\"н\" " + param == "н" ? "selected>" : ">" + "н</option>");
        out.println("</select></td>");
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
        out.println("<style>table,td,tr {border:1px solid black;text-align:center;}</style>");
        out.println("<h1>Преподаватель математики</h1>");
            out.println("<form action=\"write\"><table><tr><td></td>");
            for(int i = 1; i <=10; ++i) {
                out.println("<td>" + i + ".02.2024</td>");
            }
            out.println("</tr>");
        createTable(out, "math");
        out.println("<p><button type=\"submit\">Сохранить</button></p>");
        out.println("</table>");
        out.println("</form>");
        out.println("</body></html>");
    }
}

