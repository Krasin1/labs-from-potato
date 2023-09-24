import java.util.Scanner;
import java.io.*;

class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        System.out.println("\nВариант №7");
        while (true) {
            System.out.println("\nВведите номер задания 1 - 5 (0 - для выхода) : ");
            int N = in.nextInt();
            switch (N) {
                case (0):
                    in.close();
                    return;
                case (1):
                    zad1(in);
                    break;
                case (2):
                    zad2(in);
                    break;
                case (3):
                    zad3(in);
                    break;
                case (4):
                    zad4(in);
                    break;
                case (5):
                    zad5(in);
                    break;
                default:
                    System.out.println("Нет такого задания");
                    break;
            }
        }
    }

    public static void zad1(Scanner in) {
        System.out.println("\nЗадание №1\n");
        System.out.println("    m^2 + 2,8m + 0,355");
        System.out.println("N = ------------------");
        System.out.println("       cos2y + 3,6");
        System.out.print("\nm = ");
        double m = in.nextDouble();
        System.out.print("y = ");
        double y = in.nextDouble();
        double N = ((m * m + 2.8 * m + 0.355) / (Math.cos(2 * y) + 3.6));
        System.out.printf("\nОтвет N = %.3f\n", N);
    }

    public static void zad2(Scanner in) {
        System.out.println("\nЗадание №2\n");
        System.out.println("    Найти косинус угла между векторами a,b");
        System.out.print("a = (a1, a2)\na1 = ");
        double a1 = in.nextDouble();
        System.out.print("a2 = ");
        double a2 = in.nextDouble();
        System.out.print("\nb = (b1, b2)\nb1 = ");
        double b1 = in.nextDouble();
        System.out.print("b2 = ");
        double b2 = in.nextDouble();
        double ans = (a1 * b1 + a2 * b2) / (Math.sqrt(a1 * a1 + a2 * a2) * Math.sqrt(b1 * b1 + b2 * b2));
        System.out.printf("\ncos x = %.3f\n", ans);
    }

    public static void zad3(Scanner in) {
        System.out.println("\nЗадание №3\n");
        System.out.print(
                "  Записать логическое выражение, которое является истинным, когда\nчисло N четноe делится на 7, но не делится на 11 и 13 без остатка.\nN = ");
        int N = in.nextInt();
        boolean ans = ((N % 2) == 0) & ((N % 7) == 0) & !((N % 11) == 0) & !((N % 13) == 0);
        System.out.printf("\nОтвет = %b\n", ans);
    }

    public static void zad4(Scanner in) {
        System.out.println("\nЗадание №4\n");
        System.out.println(
                "    Ввести с клавиатуры координаты точки А(x,y) и определить лежит ли\nданная точка внутри окружности радиуса R. Центром окружности является\nначало координат. Ответ выветси в виде сообщения.");
        System.out.print("x = ");
        double x = in.nextDouble();
        System.out.print("y = ");
        double y = in.nextDouble();
        System.out.print("R = ");
        double R = in.nextDouble();

        boolean ans = (R * R - (x * x + y * y)) > 0.00001; // туть теорема пифагора
        System.out.printf("\nОтвет = %b\n", ans);
    }

    public static void zad5(Scanner in) {
        System.out.println("\nЗадание №4\n");
        System.out.println(
                "Дан файл f, компоненты которого являются действитетльными числами.\nНайти разность первой и последней компонент файла.");
        double[] array = null;
        try (BufferedReader file = new BufferedReader(new FileReader("f.txt"))) {
            array = file.lines().mapToDouble(Double::parseDouble).toArray();
        } catch (IOException some) {
            System.out.println(some.getMessage());
        }
        if (array.length > 0) {
            double x = array[0] - array[array.length - 1];
            System.out.printf("\n%.3f - %.3f = %.3f\n", array[0], array[array.length - 1], x);
        } else {
            System.out.println("Пустой файл");
        }
    }
}
