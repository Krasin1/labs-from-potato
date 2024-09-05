package sample.text.l2_.controller.edit;

import jakarta.servlet.http.HttpServlet;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Answer;

@WebServlet(name = "editAnswer", value = "/editAnswer")
public class EditAnswerServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        String new_answer = request.getParameter("answer_id");
        if (new_answer == null) {
            //TODO: handle error
        }
        Integer answer_id = Integer.parseInt(new_answer);

        ArrayList<Answer> answers = (ArrayList<Answer>) session.getAttribute("answers");
        if (answers == null) {
            answers = Answer.getAnswersFromDB();
            session.setAttribute("answers", answers );
        }

        for (Answer answer : answers) {
            if (answer.getId() == answer_id) {
                session.setAttribute("editing_answer", answer);
            }
        }
        response.sendRedirect("edit_answer.jsp");
    }
}
