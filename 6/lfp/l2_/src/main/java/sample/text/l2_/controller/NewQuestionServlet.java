package sample.text.l2_.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Question;

@WebServlet(name = "newQuestion", value = "/newQuestion")
public class NewQuestionServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        String new_question = request.getParameter("new_question");
        String new_trust = request.getParameter("new_trust_coef");
        Float new_trust_coef = null;
        if(new_trust != null) {
            new_trust_coef = Float.parseFloat(new_trust);
        } else {
            //TODO: add error
        }

        try {
			Question.pushToDB(new_question, new_trust_coef);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

        ArrayList<Question> questions = Question.getQuestionsFromDB();
        session.setAttribute("questions", questions);
        response.sendRedirect(getServletContext().getContextPath() +"/edit");
    }
}
