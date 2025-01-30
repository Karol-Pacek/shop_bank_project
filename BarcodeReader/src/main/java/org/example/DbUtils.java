package org.example;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
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

    public void paymentRequest(String card_number, short pin, byte cvc, double sum, int receiver_id, String description) {
        try {
            URL url = new URL("http://localhost:8080/transaction");

            String jsonData = "{\"card_number\": \""+ card_number +"\", \"pin\": \""+ pin +"\", \"cvc\": \""+cvc+"\", \"sum\": \""+sum+"\", " +
                    "\"receiver_account_id\": \""+ receiver_id +"\", \"description\": \""+ description +"\"}";

            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("PUT");
            con.setDoOutput(true);
            DataOutputStream out = new DataOutputStream(con.getOutputStream());
            out.writeBytes(jsonData);
            out.flush();
            out.close();

        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
