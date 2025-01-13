package org.example;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Objects;
import java.util.Scanner;

public class ScannerLogic {
    DbUtils db = new DbUtils();
    public ScannerLogic() { }

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
        Product result = db.getProductByBarcode(code);
        if(result != null) {
            return result;
        }else{
            System.out.println("\u001B[31m" + "Podana wartość nie jest kodem." + "\u001B[0m");
            return null;
        }
    }


}
