package org.example;

import java.util.ArrayList;
import java.util.Objects;
import java.util.Scanner;

public class ScannerLogic {
    ProductList productList;

    public ScannerLogic(ProductList productList) {
        this.productList = productList;
    }

    public void start() {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Podaj kod produktu: ");
        String code = String.valueOf(scanner.nextLong());
        Product result = readInput(code);
        if(result != null) {
            System.out.println("Zeskanowano " + "\u001B[32m" + result.name + "\u001B[0m" + " o cenie " + "\u001B[33m" + result.price + "\u001B[0m");
        }
        start();
    }

    public Product readInput(String code) {
        if(code.length() == 13) {
            if(productList.products.containsKey(code)) {
                return productList.products.get(code);
            }else{
                System.out.println("\u001B[31m" + "Produkt o danym kodzie nie istnieje." + "\u001B[0m");
                return null;
            }
        }else{
            System.out.println("\u001B[31m" + "Podana wartość nie jest kodem." + "\u001B[0m");
            return null;
        }
    }


}
