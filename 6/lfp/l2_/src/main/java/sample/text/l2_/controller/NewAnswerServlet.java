package sample.text.l2_.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Answer;

@WebServlet(name = "newAnswer", value = "/newAnswer")
public class NewAnswerServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        String new_question = request.getParameter("new_answer");

        try {
            Answer.pushToDB(new_question);
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        ArrayList<Answer> answers = Answer.getAnswersFromDB();
        session.setAttribute("answers", answers);
        response.sendRedirect(getServletContext().getContextPath() +"/showAnswers");
    }
}
