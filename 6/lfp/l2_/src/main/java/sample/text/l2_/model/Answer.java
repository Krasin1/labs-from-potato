package sample.text.l2_.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Answer {
    private String text;
    private int id;

    private static String URL = "jdbc:mariadb://localhost:3306/lfp_l3";
    private static String USERNAME = "mysql";
    private static String PASSWORD = "qwer";

    public Answer(String text, int id) {
        this.text = text;
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Integer updateToDB(String text) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result_execute = 0;

        String SQL = "update answers set text = ? where id = ?";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, text);
            preparedStatement.setInt(2, this.id);
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

        String SQL = "delete from answers where id = " + String.valueOf(this.id);

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

    static public Integer pushToDB(String text) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        int result_execute = 0;

        String SQL = "insert into answers (text) values (?) ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, text);
            result_execute = preparedStatement.executeUpdate();

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ResultSet rs = preparedStatement.getGeneratedKeys();
        if (rs.next()) {
            Influence.addNewAnswer(rs.getInt(1));
        }
        return result_execute;
    }

    public static ArrayList<Answer> getAnswersFromDB() {
        ArrayList<Answer> answers = new ArrayList<Answer>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet result = null;

        String SQL = "SELECT * FROM answers";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            result = preparedStatement.executeQuery();

            if(result.wasNull()) return null;
            while (result.next()) {
                answers.add(new Answer(result.getString("text"), result.getInt("id")));
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return answers;
    }
}
