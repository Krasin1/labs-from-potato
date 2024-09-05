package sample.text.l2_.controller.edit;

import jakarta.servlet.http.HttpServlet;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.ComplexInfluence;

@WebServlet(name = "editQuestion", value = "/editQuestion")
public class EditQuestionServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        String new_question = request.getParameter("question_id");
        if (new_question == null) {
            //TODO: handle error
        }
        Integer question_id = Integer.parseInt(new_question);

        ComplexInfluence complexInfluence = new ComplexInfluence(question_id);
        session.setAttribute("editing_question", complexInfluence.getQuestion());

        session.setAttribute("complexInfluence", complexInfluence);

        response.sendRedirect("edit_question.jsp");
    }
}
