package org.example;

public class Product {
    String barcode;
    String name;
    double price;
    int quantity = 1;

    public Product(String barcode, String name, double price) {
        this.barcode = barcode;
        this.name = name;
        this.price = price;
    }

    @Override
    public String toString() {
        return name + " - " + price + " PLN";
    }
}
