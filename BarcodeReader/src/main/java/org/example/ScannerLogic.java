package org.example;

import java.net.MalformedURLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class ScannerLogic {
    DbUtils db = new DbUtils();
    Map<String, Product> scannedProducts = new HashMap<>();
    double totalSum = 0.0;
    public ScannerLogic() { }
    public void start() {
        Scanner scanner = new Scanner(System.in);


        //adding more products or terminating this procedure
        while (true) {
            System.out.println("Podaj kod produktu: ");
            String input = scanner.nextLine();

            if (input.equalsIgnoreCase("pay")) {
                payment();
                break;
            }

            Product result = readInput(input);
            if (result != null) {
                clearScreen();
                addProduct(result);
                System.out.println("Zeskanowano " + "\u001B[32m" + result.name + "\u001B[0m" + " o cenie " + "\u001B[33m" + result.price + " PLN\u001B[0m");
                printReceipt();
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
        if(scannedProducts.containsKey(product.barcode)) {
            scannedProducts.get(product.barcode).quantity ++;
        }
        else {
            scannedProducts.put(product.barcode, product);
        }
    }
                                    //receipt
    private void printReceipt() {
        totalSum = 0.0;
        System.out.println("\n====== PARAGON ======");
        for (Map.Entry<String, Product> entry : scannedProducts.entrySet()) {
            Product product = entry.getValue();
            double subtotal = product.price * product.quantity;
            totalSum += subtotal;
                                      //receipt view
            System.out.println(product.name + " x" + product.quantity + " - " + subtotal + " PLN");
        }
        System.out.println("=====================");
        System.out.println("SUMA PLN: " + totalSum);
        System.out.println("=====================");
    }

    private void payment() {
        Scanner sc = new Scanner(System.in);

        System.out.println("Podaj numer karty: ");
        String card_num = sc.nextLine();
        System.out.println("Podaj pin: ");
        short pin = sc.nextShort();
        System.out.println("Podaj cvc: ");
        byte cvc = sc.nextByte();
        db.paymentRequest(card_num, pin, cvc, totalSum, 1, "SKLEP Sklepex™ ZAKUPY");
    }

    public static void clearScreen() {
        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

}
