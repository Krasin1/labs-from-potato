package lab.course.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Orders {
    private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static String USERNAME = "user";
    private static String PASSWORD = "qwer";

    private Integer user_id;

	public Orders(Integer id) {
        this.user_id = id;
    }

    public ArrayList<Order> getOrders() {
        ArrayList<Order> orders = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "select * from purchases where buyer_id = ?";
        ResultSet result = null;

        // подключаем базу данных
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setInt(1, user_id);
            result = preparedStatement.executeQuery();
            
            Order temp = null;
            while(result.next()) {
                temp = new Order(result.getInt("purchase_id"),
                        user_id,
                        result.getDate("date"),
                        result.getInt("total_price"));
                orders.add(temp);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return orders;
    }
}
