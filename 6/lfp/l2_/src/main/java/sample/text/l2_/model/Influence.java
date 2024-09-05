package sample.text.l2_.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Influence {
    private int id;
    private int question_id;
    private int answer_id;
    private float influence_coef;

    private static String URL = "jdbc:mariadb://localhost:3306/lfp_l3";
    private static String USERNAME = "mysql";
    private static String PASSWORD = "qwer";

    public Influence(int id, int question_id, int answer_id, float influence_coef) {
        this.id = id;
        this.question_id = question_id;
        this.answer_id = answer_id;
        this.influence_coef = influence_coef;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }

    public int getAnswer_id() {
        return answer_id;
    }

    public void setAnswer_id(int answer_id) {
        this.answer_id = answer_id;
    }

    public float getInfluence_coef() {
        return influence_coef;
    }

    public void setInfluence_coef(float influence_coef) {
        this.influence_coef = influence_coef;
    }

    public Integer updateToDB() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result_execute = 0;

        String SQL = "update influence set influence_coef = ? where id = ?";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setFloat(1, this.influence_coef);
            preparedStatement.setInt(2, this.id);
            result_execute = preparedStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result_execute;
    }

    static public void addNewAnswer(int answer_id) {
        ArrayList<Question> questions = Question.getQuestionsFromDB();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        Integer result = null;

        String SQL = "insert into influence (question_id, answer_id, influence_coef) values (?," + answer_id +",0.000)";

        for (Question q : questions) {
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setInt(1, q.getId());
                result = preparedStatement.executeUpdate();

                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (result == 0){
                //TODO: add error
            }
        }
    }

    static public void createEmptyToDB(int question_id) {
        ArrayList<Answer> answers = Answer.getAnswersFromDB();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        Integer result = null;

        String SQL = "insert into influence (question_id, answer_id, influence_coef) values (" + question_id + ", ?,0.000)";

        for (Answer a : answers) {
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setInt(1, a.getId());
                result = preparedStatement.executeUpdate();

                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (result == 0){
                //TODO: add error
            }
        }
    }

    public static ArrayList<Influence> getInfluencesFromDB(int question_id) {
        ArrayList<Influence> influences = new ArrayList<Influence>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet result = null;

        String SQL = "SELECT * FROM influence WHERE question_id = " + question_id;
        ;

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            result = preparedStatement.executeQuery();

            if (result.wasNull())
                return null;
            while (result.next()) {
                influences.add(new Influence(
                        result.getInt("id"),
                        result.getInt("question_id"),
                        result.getInt("answer_id"),
                        result.getFloat("influence_coef")));
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return influences;
    }

    public static ArrayList<Influence> getInfluencesFromDB() {
        ArrayList<Influence> influences = new ArrayList<Influence>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet result = null;

        String SQL = "SELECT * FROM influence";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            result = preparedStatement.executeQuery();

            if (result.wasNull())
                return null;
            while (result.next()) {
                influences.add(new Influence(
                        result.getInt("id"),
                        result.getInt("question_id"),
                        result.getInt("answer_id"),
                        result.getFloat("influence_coef")));
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return influences;
    }

}
