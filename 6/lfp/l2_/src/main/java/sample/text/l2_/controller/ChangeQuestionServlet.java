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
import sample.text.l2_.model.ComplexInfluence;
import sample.text.l2_.model.Influence;
import sample.text.l2_.model.Question;

@WebServlet(name = "changeQuestion", value = "/changeQuestion")
public class ChangeQuestionServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String new_question_text = request.getParameter("change_text_question");
        String new_trust_coef = request.getParameter("change_trust_coef");
        Float new_trust = Float.valueOf(new_trust_coef);

        HttpSession session = request.getSession();
        ComplexInfluence ci = (ComplexInfluence)session.getAttribute("complexInfluence");

        ArrayList<Influence> new_influences = new ArrayList<Influence>();
        for(Influence i : ci.getInfluences()){
            String new_influence_coef = request.getParameter("change_influ_coef" + i.getId());
            if (new_influence_coef == null) {
                System.out.println("--->null");
            }
            Float new_inf_coef = Float.valueOf(new_influence_coef);
            i.setInfluence_coef(new_inf_coef);
            new_influences.add(i);
        }

        ci.getQuestion().setText(new_question_text);
        ci.getQuestion().setTrust_coef(new_trust);
        ci.setInfluences(new_influences);

        try {
            ci.updateToDB();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("complexInfluence", ci);
        session.setAttribute("answers", Answer.getAnswersFromDB());
        session.setAttribute("influences", new_influences);
        session.setAttribute("questions", Question.getQuestionsFromDB());

        response.sendRedirect(getServletContext().getContextPath() + "/edit");
    }
}
