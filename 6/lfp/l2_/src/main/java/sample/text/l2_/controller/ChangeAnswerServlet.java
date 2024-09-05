package sample.text.l2_.controller;

import jakarta.servlet.http.HttpServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Answer;

@WebServlet(name = "changeAnswer", value = "/changeAnswer")
public class ChangeAnswerServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String new_answer_text = request.getParameter("change_answer");

        HttpSession session = request.getSession();
        Answer answer = (Answer)session.getAttribute("editing_answer");

        try {
            answer.updateToDB(new_answer_text);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("answers", Answer.getAnswersFromDB());

        response.sendRedirect(getServletContext().getContextPath() + "/showAnswers");
    }
}
