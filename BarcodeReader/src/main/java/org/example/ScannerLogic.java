package org.example;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class ScannerLogic {
    DbUtils db = new DbUtils();
    Map<Product, Integer> scannedProducts = new HashMap<>();
    double totalSum = 0.0;
    public ScannerLogic() { }
    public void start() {
        Scanner scanner = new Scanner(System.in);


        //adding more products or terminating this procedure
        while (true) {
            System.out.println("Podaj kod produktu lub wpisz 'wydrukuj paragon' aby zakonczyc: ");
            String input = scanner.nextLine();

            if (input.equalsIgnoreCase("wydrukuj paragon")) {
                printReceipt();
                break;
            }

            Product result = readInput(input);
            if (result != null) {
                addProduct(result);
                System.out.println("Zeskanowano " + "\u001B[32m" + result.name + "\u001B[0m" + " o cenie " + "\u001B[33m" + result.price + " PLN\u001B[0m");
            }
        }
    }

    public Product readInput(String code) {
        Product result = db.getProductByBarcode(code);
        if (result != null) {
            return result;
        } else {
                System.out.println("\u001B[31m" + "Podana wartość nie jest kodem." + "\u001B[0m");

            return null;
        }
    }
    private void addProduct(Product product) {
        scannedProducts.put(product, scannedProducts.getOrDefault(product, 0) + 1);
        totalSum += product.price;
    }
                                    //receipt
    private void printReceipt() {
        System.out.println("\n====== PARAGON ======");
        for (Map.Entry<Product, Integer> entry : scannedProducts.entrySet()) {
            Product product = entry.getKey();
            int quantity = entry.getValue();
            double subtotal = product.price * quantity;

                                      //receipt view
            System.out.println(product.name + " x" + quantity + " - " + subtotal + " PLN");
        }
        System.out.println("=====================");
        System.out.println("SUMA PLN: " + totalSum);
        System.out.println("=====================");
    }
}
