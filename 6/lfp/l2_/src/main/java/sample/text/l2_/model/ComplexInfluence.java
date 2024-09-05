package sample.text.l2_.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class ComplexInfluence {
    private ArrayList<Answer> answers;
    private ArrayList<Influence> influences;
	private Question question;

    private static String URL = "jdbc:mariadb://localhost:3306/lfp_l3";
    private static String USERNAME = "mysql";
    private static String PASSWORD = "qwer";

    public ComplexInfluence(int question_id) {
        influences = Influence.getInfluencesFromDB(question_id);
        answers = Answer.getAnswersFromDB();
        ArrayList<Question> questions = Question.getQuestionsFromDB();
        for(Question q : questions){
            if(q.getId() == question_id){
                question = q;
            }
        }

    }

    public void updateToDB() throws SQLException {
        question.updateToDB();
        for(Influence i : influences){ 
            i.updateToDB();
        }
    }

	public ArrayList<Answer> getAnswers() {
		return answers;
	}

	public ArrayList<Influence> getInfluences() {
		return influences;
	}

    public void setInfluences(ArrayList<Influence> influences) {
		this.influences = influences;
	}

	public Question getQuestion() {
		return question;
	}

}
