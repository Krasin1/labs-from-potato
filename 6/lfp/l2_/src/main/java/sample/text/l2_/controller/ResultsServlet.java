package sample.text.l2_.controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Fact;
import sample.text.l2_.model.Question;
import sample.text.l2_.model.Answer;
import sample.text.l2_.model.Consult;

@WebServlet(name = "results", value = "/results")
public class ResultsServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        ArrayList<Answer> answers = (ArrayList<Answer>) session.getAttribute("answers");
        ArrayList<Fact> facts = (ArrayList<Fact>) session.getAttribute("facts");
        ArrayList<Question> questions = (ArrayList<Question>) session.getAttribute("questions");
        if (answers == null || facts == null || questions==null || questions.size() == 0 || answers.size() == 0){
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        if (facts.size() == 0) {
            System.out.println("no facts");
            session.setAttribute("no", true);
            request.getRequestDispatcher("reject.jsp").forward(request, response);
        }
        if (questions.size() == facts.size()) {
            System.out.println("all facts choosen");
            session.setAttribute("all", true);
            request.getRequestDispatcher("reject.jsp").forward(request, response);
        }

        Consult consult = new Consult(facts);
        consult.analyze();
        session.setAttribute("sorted_cfg", consult.getSorted_cfg());

        request.getRequestDispatcher("results.jsp").forward(request, response);
    }

}
