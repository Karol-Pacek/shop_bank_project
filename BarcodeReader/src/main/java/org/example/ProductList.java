package org.example;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ProductList {
    Map<String, Product> products = new HashMap<>();

    public ProductList() {}

    public void addProduct(String barcode, String name, double price) {
        if (barcode.length() == 13) {
            products.put(barcode, new Product(name,price));
        }
    }
}
