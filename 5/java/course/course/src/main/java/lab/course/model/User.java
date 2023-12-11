package lab.course.model;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

    // проверяем на уникальность логин
    public static boolean checkLogin(String login) {
        String SQL = "select * from Users where login = ?";
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

    public static String getHashedPassword(final String text) {
        if (text == null) return null;
        if (text.isEmpty()) return "";

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
     public static boolean checkPhone(String str) {
        if (str == null) return false;
        String patterns = "^((8|\\+7)[\\- ]?)?(\\(?\\d{3}\\)?[\\- ]?)?[\\d\\- ]{7,10}$";
        Pattern pattern = Pattern.compile(patterns);
        Matcher matcher =  pattern.matcher(str);
        return matcher.matches();
    }


    public static User getUserByLogin(String login) {
        if (login == null) return null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "select * from Users where login = ?";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            // connection.setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
            // connection.setAutoCommit(false);
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
    
    public static boolean updateUserParam(int id, String param, String value) {
        if (param == null || value == null || id <= 0) return false;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "UPDATE `Users` SET `"+param+"` = ? where `Users`.`id` = " + String.valueOf(id);
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, value);
            int res = preparedStatement.executeUpdate();

            if (res == 0) return false;
            connection.close();
        } catch (Exception e) {
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
