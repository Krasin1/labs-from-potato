package sample.text.l2_.controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Answer;

@WebServlet(name = "showAnswers", value = "/showAnswers")
public class ShowAnswersServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        ArrayList<Answer> answers;
        answers = (ArrayList<Answer>) session.getAttribute("answers");
        if (answers == null) {
            answers = Answer.getAnswersFromDB();
            session.setAttribute("answers", answers);
        }
        request.getRequestDispatcher("edit_answers.jsp").forward(request, response);
    }

}
