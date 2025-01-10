package org.example;
import java.sql.*;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        /*ProductList productList = new ProductList();
        ScannerLogic scannerLogic = new ScannerLogic(productList);

        productList.addProduct("1234567890000", "kremówka", 21.37);
        productList.addProduct("1234567890123", "humunkulus", 59.99);
        productList.addProduct("1234567891234", "schwepsik", 8.59);
        productList.addProduct("1234567892345", "John Produkt", 999999.99);
        productList.addProduct("1234567893456", "powietrze 0.5l", 4.23);
        productList.addProduct("5449000000996", "cocla", 999.12);
        productList.addProduct("5449000234636", "nigger", 69.4202137);

                    //JDBC database connection

        String url = "jdbc:mysql://localhost:3306/shop";
        String username = "root";
        String password = "";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection connection = DriverManager.getConnection(url, username, password);
            Statement statement = connection.createStatement();

            ResultSet resultSet = statement.executeQuery("select * from products");

            while (resultSet.next()) {
                System.out.println(resultSet.getLong("barcode"));
            }


        }
        catch (Exception e) {
            System.out.println(e);
        }*/




        ProductList productList = ProductList.createListFromDbData(DbUtils.getData());
        ScannerLogic scannerLogic = new ScannerLogic(productList);

        scannerLogic.start();





    }
}