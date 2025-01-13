package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbUtils {
    public DbUtils() {}

    public Product getProductByBarcode(String barcode) {
        String url = "jdbc:mysql://localhost:3306/shop";
        String username = "root";
        String password = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();

            ResultSet resultSet = statement.executeQuery("select * from products where barcode = '" + barcode + "' limit 1");
            Product product = null;

            while (resultSet.next()) {
                product = new Product(
                        Long.toString(resultSet.getLong("barcode")),
                        resultSet.getString("product_name"),
                        resultSet.getDouble("price"));
            }
            return product;
        }
        catch (Exception e) {
            System.out.println(e);
        }

        return null;
    }
}
