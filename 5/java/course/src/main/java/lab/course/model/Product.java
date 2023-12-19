package lab.course.model;

import jakarta.persistence.criteria.CriteriaBuilder;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Product {
    private Integer id;
	private String product_name;
    private String barcode;
    private Integer count_in_stok;
	private Integer price;
    private Integer count;

	private static final String URL = "jdbc:mariadb://localhost:3306/javaCourse";
	private static final String USERNAME = "user";
	private static final String PASSWORD = "qwer";
    public Product(Integer id, String name, String barcode,
            Integer count_in_stok, Integer price, Integer count) {
        this.id = id;
        this.product_name = name;
        this.barcode = barcode;
        this.count_in_stok = count_in_stok;
        this.price = price;
        this.count = count;
    }

	public Product(Integer id, String name, String barcode,
				   Integer count_in_stok, Integer price ) {
		this.id = id;
		this.product_name = name;
		this.barcode = barcode;
		this.count_in_stok = count_in_stok;
		this.price = price;
	}

	public static boolean updateProductParam(int id, HashMap<String, String> map) {
		if (map == null || map.isEmpty() || id < 0) return false;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String SQL = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			connection.setAutoCommit(false);
			for(Map.Entry<String, String> entry : map.entrySet()) {
				SQL =  "UPDATE `products` SET `"+ entry.getKey() +"` = ? where `products`.`id` = "
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

	public static Product getProductById(Integer id) {
		if (id == null || id < 0) return null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String SQL = "select * from products where id = ?";
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setInt(1, id);
			ResultSet resultSet = preparedStatement.executeQuery();

			Product temp = null;
			if (resultSet.next()) {
				temp = new Product(
						id,
						resultSet.getString("name"),
						resultSet.getString("barcode"),
						resultSet.getInt("count_in_stok"),
						resultSet.getInt("price")
				);
			}
			connection.close();
			return temp;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


	public static boolean checkUniqueField(String field, String value) {
		String SQL = "select * from products where " + field + " = ?";
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setString(1, value);
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
	public static boolean newProduct(String name, String barcode, Integer count_in_stok, Integer price) {
		// подготавливаем запрос
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String SQL = "INSERT INTO `products`(`name`, `barcode`, `count_in_stok`, `price`) VALUES (?,?,?,?)";

		// подключаем базу данных
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			preparedStatement = connection.prepareStatement(SQL);
			preparedStatement.setString(1, name);
			preparedStatement.setString(2, barcode);
			preparedStatement.setInt(3, count_in_stok);
			preparedStatement.setInt(4, price);

			// заполняем информацию о покупке
			int insert = preparedStatement.executeUpdate();

			if (insert == 0) {
				return false;
			}

			connection.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}


    public Integer getCount_in_stok() {
		return count_in_stok;
	}
	public void setCount_in_stok(Integer count_in_stok) {
		this.count_in_stok = count_in_stok;
	}
    public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getBarcode() {
		return barcode;
	}
	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
}
