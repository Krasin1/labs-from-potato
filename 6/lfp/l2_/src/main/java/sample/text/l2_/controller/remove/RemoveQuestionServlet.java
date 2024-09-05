package sample.text.l2_.controller.remove;

import jakarta.servlet.http.HttpServlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Answer;
import sample.text.l2_.model.Influence;
import sample.text.l2_.model.Question;

@WebServlet(name = "removeQuestion", value = "/removeQuestion")
public class RemoveQuestionServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        Question question = (Question) session.getAttribute("editing_question");

        try {
            question.removeFromDB();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        ArrayList<Answer> answers = Answer.getAnswersFromDB();
        session.setAttribute("answers", answers );

        ArrayList<Question> questions = Question.getQuestionsFromDB();
        session.setAttribute("questions", questions );

        ArrayList<Influence> influences = Influence.getInfluencesFromDB();
        session.setAttribute("influences", influences );

        response.sendRedirect(getServletContext().getContextPath() + "/edit");
    }
}
