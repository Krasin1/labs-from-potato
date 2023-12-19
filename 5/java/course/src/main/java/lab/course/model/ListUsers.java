package lab.course.model;

import java.sql.*;
import java.util.ArrayList;


import java.sql.*;
import java.util.ArrayList;

public class ListUsers{
    private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static String USERNAME = "user";
    private static String PASSWORD = "qwer";

    private ArrayList<User> list;

    public ListUsers() {
        this.list = new ArrayList<User>();
    }

    public void insertUser(User a) {
        list.add(a);
    }

    public void deleteUser(User a) {
        list.remove(a);
    }

    public ArrayList<User> getListUsers() {
        return list;
    }


    public static ArrayList<User> getUsers() {
        ArrayList<User> users = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "select * from Users";
        ResultSet result = null;

        // подключаем базу данных
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            result = preparedStatement.executeQuery();

            User temp = null;
            while(result.next()) {
                temp = new User(result.getInt("id"),
                        result.getString("login"),
                        result.getString("email"),
                        result.getString("name"),
                        result.getString("surname"),
                        result.getString("phone"),
                        result.getString("role"));
                users.add(temp);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return users;
    }

}
