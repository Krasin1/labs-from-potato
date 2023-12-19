package lab.course.model;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class User {
    private Integer id;
    private String login;
    private String password;
    private String email;
    private String name;
    private String surname;
    private String phone;
    private String role;
    private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static String USERNAME = "user";
    private static String PASSWORD = "qwer";

    public User(Integer id, String login, String password, String email,
                String name, String surname, String phone, String role) {
        this.id = id;
        this.login = login;
        this.password = password;
        this.email = email;
        this.name = name;
        this.surname = surname;
        this.phone = phone;
        this.role = role;
    }

    public User(Integer id, String login, String email,
                String name, String surname, String phone, String role) {
        this.id = id;
        this.login = login;
        this.email = email;
        this.name = name;
        this.surname = surname;
        this.phone = phone;
        this.role = role;
    }

    // проверяем на уникальность логин
    public static boolean checkUniqueField(String field, String login) {
        String SQL = "select * from Users where " + field + " = ?";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try { 
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, login);
            ResultSet resultSet = preparedStatement.executeQuery();
            connection.close();

            if (!resultSet.next()) {
                connection.close();
                return true;
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static String getHashedPassword(String text) {
        if (text == null) return null;
        if (text.isEmpty()) return "";
        text = text.trim();

        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-256");
            md.update(text.trim().getBytes("UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (md != null)
            return new String(md.digest(), StandardCharsets.UTF_8);
        else return null;
    }
    public static User getUserByPhone(String phone) {
        if (phone == null) return null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "select * from Users where phone = ?";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, phone);
            ResultSet resultSet = preparedStatement.executeQuery();

            User temp = null;
            if (resultSet.next()) {
                temp = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("login"),
                        resultSet.getString("password"),
                        resultSet.getString("email"),
                        resultSet.getString("name"),
                        resultSet.getString("surname"),
                        resultSet.getString("phone"),
                        resultSet.getString("role"));
            }
            connection.close();
            return temp;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static User getUserByLogin(String login) {
        if (login == null) return null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "select * from Users where login = ?";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, login);
            ResultSet resultSet = preparedStatement.executeQuery();

            User temp = null;
            if (resultSet.next()) {
                temp = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("login"),
                        resultSet.getString("password"),
                        resultSet.getString("email"),
                        resultSet.getString("name"),
                        resultSet.getString("surname"),
                        resultSet.getString("phone"),
                        resultSet.getString("role"));
            }
            connection.close();
            return temp;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public static boolean updateUserParam(int id, HashMap<String, String> map) {
        if (map == null || map.isEmpty() || id < 0) return false;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            connection.setAutoCommit(false);
            for(Map.Entry<String, String> entry : map.entrySet()) {
                SQL =  "UPDATE `Users` SET `"+ entry.getKey() +"` = ? where `Users`.`id` = "
                        + String.valueOf(id);
                preparedStatement = connection.prepareStatement(SQL);
                preparedStatement.setString(1, entry.getValue());
                int res = preparedStatement.executeUpdate();
                if (res == 0) {
                    connection.rollback();
                    connection.close();
                    return false;
                }
            }
            connection.commit();
            connection.close();
        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            }
            e.printStackTrace();
        }
        return true;

    }

    // почта проверяется по регулярному выражению
    public static boolean checkEmail(String str) {
        if (str == null) return false;
        String patterns =
                "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
                        "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
        Pattern pattern = Pattern.compile(patterns);
        Matcher matcher =  pattern.matcher(str);
        return matcher.matches();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
