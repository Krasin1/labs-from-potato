package sample.text.l2_.controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Question;

@WebServlet(name = "edit", value = "/edit")
public class EditServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        ArrayList<Question> questions;
        questions = (ArrayList<Question>) session.getAttribute("questions");
        if (questions == null) {
            questions = Question.getQuestionsFromDB();
            session.setAttribute("questions", questions);
        }
        request.getRequestDispatcher("edit.jsp").forward(request, response);
    }
    
}
