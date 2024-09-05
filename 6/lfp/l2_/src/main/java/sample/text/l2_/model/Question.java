package sample.text.l2_.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Question {
    private int id;
    private String text;
    private float trust_coef;
    static int counter = 0;

    private static String URL = "jdbc:mariadb://localhost:3306/lfp_l3";
    private static String USERNAME = "mysql";
    private static String PASSWORD = "qwer";

    public Question(int id, String text, float trust_coef) {
        this.id = id;
        this.text = text;
        this.trust_coef = trust_coef;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public float getTrust_coef() {
        return trust_coef;
    }

    public void setTrust_coef(float trust_coef) {
        this.trust_coef = trust_coef;
    }

    public Integer updateToDB() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result_execute = 0;

        String SQL = "update questions set text = ?, trust_coef = ? where id = ?";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, this.text);
            preparedStatement.setFloat(2, this.trust_coef);
            preparedStatement.setInt(3, this.id);
            result_execute = preparedStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result_execute;
    }

    public Integer removeFromDB() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result_execute = 0;

        String SQL = "delete from questions where id = " + String.valueOf(this.id);

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            result_execute = preparedStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result_execute;
    }

    public static ArrayList<Question> getQuestionsFromDB() {
        ArrayList<Question> questions = new ArrayList<Question>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet result = null;

        String SQL = "SELECT * FROM questions";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            result = preparedStatement.executeQuery();

            if (result.wasNull())
                return null;
            while (result.next()) {
                questions.add(new Question(
                        result.getInt("id"),
                        result.getString("text"),
                        result.getFloat("trust_coef")));
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    // push new question to DB
    public static int pushToDB(String text, float trust_coef) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result_execute = 0;

        String SQL = "insert into questions (text, trust_coef) values (?, ?) ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, text);
            preparedStatement.setFloat(2, trust_coef);
            result_execute = preparedStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ResultSet rs = preparedStatement.getGeneratedKeys();
        if (rs.next()) {
            Influence.createEmptyToDB(rs.getInt(1));
        }
        return result_execute;
    }
}
