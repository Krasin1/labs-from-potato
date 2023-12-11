package lab.course.model;

import java.sql.*;
import java.util.ArrayList;

public class ListProducts {
    private static String URL = "jdbc:mariadb://localhost:3306/javaCourse";
    private static String USERNAME = "user";
    private static String PASSWORD = "qwer";

    private ArrayList<Product> list;

    public ListProducts() {
        this.list = new ArrayList<Product>();
    }

    public void insertProduct(Product a) {
        list.add(a);
    }

    public void deleteProduct(Product a) {
        list.remove(a);
    }

	public ArrayList<Product> getListProducts() {
		return list;
	}

    public Integer getAllPrice() {
        Integer sum = 0;
        for (var a : list) {
            sum += a.getPrice();
        }
        return sum;
    }

    public boolean checkCountInStok() {
        for(var a : this.list) {
            if (a.getCount() >  a.getCount_in_stok()){
                return false;
            }
        }
        return true;
    }

    public boolean addByBarcode(String barcode) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "select * from products where barcode = ?";
        ResultSet result = null;

        // подключаем базу данных
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL);
            preparedStatement.setString(1, barcode);
            result = preparedStatement.executeQuery();
            Product temp;

            // если шрих код уже существует в корзине, то кол-во +1 и возвращаем true
            if (addOneToProduct(barcode)) { return true; }

            // если шрих код сущесвтует в бд, то добавляем в корзину
            if (result.next()) {
                temp = new Product( result.getInt("id"),
                        result.getString("name"),
                        barcode,
                        result.getInt("count_in_stok"),
                        result.getInt("price"),
                        1);
            } else {
                connection.close();
                return false;
            }
            insertProduct(temp);
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    // прибавляет 1 продукт в корзину по шрих коду
    public boolean addOneToProduct(String barcode) {
        for(var a: this.list) {
            if (a.getBarcode().equals(barcode)) {
                a.setCount(a.getCount() + 1);
                return true;
            }
        }
        return false;
    }

    public Integer makePurchase(User user) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String SQL = "INSERT INTO `purchases`(`buyer_id`, `date`, `total_price`) VALUES (?,?,?)";

        // подключаем базу данных
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, user.getId());
            preparedStatement.setDate(2, new Date(System.currentTimeMillis()));
            preparedStatement.setInt(3, getAllPrice());
            // заполняем информацию о покупке
            int insert = preparedStatement.executeUpdate();

            if (insert == 0) {
                return -1;
            }

            // получаем id покупки
            Integer purchase_id = 0;
            try(ResultSet key = preparedStatement.getGeneratedKeys()) {
                if(key.next()) {
                    purchase_id = key.getInt(1);
                } else {
                    return -2;
                }
            }

            // заполняем информацию о товарах в покупке
            SQL = "INSERT INTO `purchases_items`(`product_count`, `purchase_id`, `product_id`) VALUES (?,?,?)";
            preparedStatement = connection.prepareStatement(SQL);
            for(var a : this.list) {
                preparedStatement.setInt(1, a.getCount());
                preparedStatement.setInt(2, purchase_id);
                preparedStatement.setInt(3, a.getId());
                if (preparedStatement.executeUpdate() == 0) {
                    return -3;
                }
            }

            // обновляем наличие товара
            SQL = "UPDATE `products` SET `count_in_stok`= ? WHERE `products`.`id` = ?";
            preparedStatement = connection.prepareStatement(SQL);
            for(var a : this.list) {
                int sub = a.getCount_in_stok() - a.getCount();
                preparedStatement.setInt(1, sub);
                preparedStatement.setInt(2, a.getId());
                if (preparedStatement.executeUpdate() == 0) {
                    return -4;
                }
            }

            connection.close();
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

}
