package sample.text.l2_.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sample.text.l2_.model.Fact;
import sample.text.l2_.model.Question;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "getQuestion", value = "/getQuestion")
public class GetQuestionServlet extends HttpServlet {
    static private int counter = 0;
    private ArrayList<Question> questions;

    private Question getNextQuestionFromDB() {
        while(counter < questions.size()) {
            Question question = questions.get(counter);
            counter++;
            return question;
        }
        return null;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        questions = (ArrayList<Question>) session.getAttribute("questions");
        if (questions == null) {
            questions = Question.getQuestionsFromDB();
            session.setAttribute("questions", questions);
        }

        if(session.getAttribute("facts") == null) {
            session.setAttribute("facts", new ArrayList<Fact>());
        }

        Question next = getNextQuestionFromDB();

        response.setContentType("application/json");
        if (next == null) {
            // response.getWriter().write("{\"question\":\"" + "<div style=\"color:red\">Все вопросы прошли</div>" + "\", \"id\":-1}");
            response.getWriter().write("{\"question\":\"" + "что-то пошло совершенно не так" + "\", \"id\": -1 }");
        } else {
            response.getWriter().write("{\"question\":\"" + next.getText() + "\", \"id\":"+ next.getId() + "}");
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String refresh = request.getParameter("refresh");
        if (refresh != null && refresh.equals("yes")) {
            counter = 0;
            request.getSession().removeAttribute("facts");
        }
    }
}
