import java.util.*;
import java.io.*;

class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int N = 0;
        System.out.println("\nВариант №7");
        while(true) {
            System.out.println("\nВведите номер задания 1 - 5 (0 - для выхода) : ");
            try {
                N = in.nextInt();
            } catch (InputMismatchException some) {
                System.out.println("Некорректный ввод");
                in.nextLine();
                continue;
            }
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
                    zad5();
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
        double m = 0, y = 0;

        try {
            m = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        System.out.print("y = ");

        try {
            y = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        double N = ((m * m + 2.8 * m + 0.355) / (Math.cos(2 * y) + 3.6));
        System.out.printf("\nОтвет N = %.3f\n", N);
    }

    public static void zad2(Scanner in) {
        System.out.println("\nЗадание №2\n");
        System.out.println("    Найти косинус угла между векторами a,b");
        System.out.print("a = (a1, a2)\na1 = ");
        double a1 = 0, a2 = 0, b1 = 0, b2 = 0;
        try {
            a1 = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        System.out.print("a2 = ");
        try {
            a2 = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        System.out.print("\nb = (b1, b2)\nb1 = ");
        try {
            b1 = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        System.out.print("b2 = ");
        try {
            b2 = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        double denominator = Math.sqrt(a1 * a1 + a2 * a2) * Math.sqrt(b1 * b1 + b2 * b2);
        if (denominator == 0) {
            System.out.println("Деление на ноль");
            return;
        }
        double ans = (a1 * b1 + a2 * b2) / denominator; 
        System.out.printf("\ncos x = %.3f\n", ans);
    }

    public static void zad3(Scanner in) {
        int N = 0;
        System.out.println("\nЗадание №3\n");
        System.out.print(
                "  Записать логическое выражение, которое является истинным, когда\nчисло N четноe делится на 7, но не делится на 11 и 13 без остатка.\nN = ");
        try {
            N = in.nextInt();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        boolean ans = ((N % 2) == 0) & ((N % 7) == 0) & !((N % 11) == 0) & !((N % 13) == 0);
        System.out.printf("\nОтвет = %b\n", ans);
    }

    public static void zad4(Scanner in) {
        double x = 0, y = 0, R = 0;
        System.out.println("\nЗадание №4\n");
        System.out.println(
                "    Ввести с клавиатуры координаты точки А(x,y) и определить лежит ли\nданная точка внутри окружности радиуса R. Центром окружности является\nначало координат. Ответ выветси в виде сообщения.");
        System.out.print("x = ");
        try {
            x = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        System.out.print("y = ");
        try {
            y = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }
        System.out.print("R = ");
        try {
            R = in.nextDouble();
        } catch (InputMismatchException some) {
            System.out.println("Некорректный ввод");
            in.nextLine();
            return;
        }

        boolean ans = (R * R - (x * x + y * y)) > 0.000001; // туть теорема пифагора
        System.out.printf("\nОтвет = %b\n", ans);
    }

    public static void zad5() {
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
