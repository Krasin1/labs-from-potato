package sample.text.l2_.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Answer;
import sample.text.l2_.model.Fact;
import sample.text.l2_.model.Question;

import java.util.ArrayList;

@WebServlet(name = "saveFact", value = "/saveFact")
public class SaveFactsServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        HttpSession session = request.getSession();

        int question_id = -1;
        if (request.getParameter("id") != null) {
            question_id = Integer.parseInt(request.getParameter("id"));
        }
        System.out.println("id:"+question_id);

        if (session.getAttribute("questions") == null) {
            System.out.println("no questions");
        }
        ArrayList<Question> questions = (ArrayList<Question>) session.getAttribute("questions");
        Question question = null;
        for (Question q : questions) {
            if (q.getId() == question_id) {
                question = q;
                System.out.println("question found:"+q.getText());
            }
        }
        if (question == null) {
            System.out.println("question not found");
            //TODO: error
        }
        
        ArrayList<Fact> facts = null;
        if (session.getAttribute("facts") == null) {
            facts = new ArrayList<>();
            session.setAttribute("facts", facts);
            System.out.println("new facts");
        } else {
            facts = (ArrayList<Fact>) session.getAttribute("facts");
        }
        
        facts.add(new Fact(question, true));
        session.setAttribute("facts", facts);
        for (Fact fact : facts) {
            System.out.println(fact.getText());
        }
        System.out.println("----");

        if(session.getAttribute("answers") == null) {
            session.setAttribute("answers", Answer.getAnswersFromDB());
        }
    }
}
