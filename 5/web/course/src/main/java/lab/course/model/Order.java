package lab.course.model;

import java.sql.*;
import java.util.ArrayList;

public class Order {
	private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
	private static String USERNAME = "user";
	private static String PASSWORD = "qwer";

	private int purchase_id;
    private int buyer_id;
    private Date date;
    private int total_price;

	private String name;
	private int price;
	private int count;

	public Order(int purchase, int buyer_id, Date date, int price) {
        this.purchase_id = purchase;
        this.buyer_id = buyer_id;
        this.date = date;
        this.total_price = price;
    }

	public Order(int purchase, int buyer_id, Date date, int t_price, String name, int price, int count) {
		this.purchase_id = purchase;
		this.buyer_id = buyer_id;
		this.date = date;
		this.total_price = t_price;
		this.name = name;
		this.price = price;
		this.count = count;
	}

	public static ArrayList<Order> getOrderInfo(Integer order_id, Integer user_id) {
		ArrayList<Order> orders = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String SQL = "select p.purchase_id, p.date, p.total_price, pi.product_count, pr.name, pr.price " +
				"from purchases as p cross join purchases_items as pi " +
				"on p.purchase_id = pi.purchase_id cross join products as pr " +
				"on pr.id = pi.product_id where p.purchase_id = ? and p.buyer_id = ?";
		ResultSet result = null;

		// подключаем базу данных
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, order_id);
			preparedStatement.setInt(2, user_id);
			result = preparedStatement.executeQuery();

			Order temp = null;
			while(result.next()) {
				temp = new Order(result.getInt("purchase_id"),
						user_id,
						result.getDate("date"),
						result.getInt("total_price"),
						result.getString("name"),
						result.getInt("price"),
                        result.getInt("product_count"));
				orders.add(temp);
			}

			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return orders;
	}
	public Integer getPurchase_id() {
		return purchase_id;
	}

	public void setPurchase_id(Integer purchase_id) {
		this.purchase_id = purchase_id;
	}

	public Integer getBuyer_id() {
		return buyer_id;
	}

	public void setBuyer_id(Integer buyer_id) {
		this.buyer_id = buyer_id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Integer getTotal_price() {
		return total_price;
	}

	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

    public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}
