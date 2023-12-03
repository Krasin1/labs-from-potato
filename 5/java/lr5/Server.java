import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.ServerSocket;
import java.net.Socket;

class ClientThread extends Thread {
    private Socket clientSocket;
    private BufferedReader in;
    private BufferedWriter out;

    ClientThread(Socket inSocket) {
        clientSocket = inSocket;
    }

    // переворачиваем матрицу 
    // везде ожидается что матрица размером 3 * 3 
    public void transponseMatrix(Double[] matr) {
        Double temp = matr[1];
        matr[1] = matr[3];
        matr[3] = temp;

        temp = matr[2];
        matr[2] = matr[6];
        matr[6] = temp;

        temp = matr[5];
        matr[5] = matr[7];
        matr[7] = temp;
    }

    // вычисляем обратную матрицу
    public int inverseMatrix(Double[] matr, Double[] adj) {
        // определитель матрицы 3 * 3
        Double det = matr[0] * (matr[4]*matr[8] - matr[5]*matr[7]) -
                     matr[1] * (matr[3]*matr[8] - matr[5]*matr[6]) +
                     matr[2] * (matr[3]*matr[7] - matr[4]*matr[6]);
        // если равен нулю возвращаем ошибку
        if (Double.compare(det,0) == 0) return -1;

        // транспонируем матрицу
        transponseMatrix(matr);

        // матрица дополнений
        Double a = null, b = null, c = null, d = null;
        for(int i = 0; i < 9; i++) {
            for(int j = 0; j < 9; j++) {
                if ((j % 3 == i % 3) || (j / 3 == i / 3)) continue;
                if (a == null) { a = matr[j]; continue; }
                if (b == null) { b = matr[j]; continue; }
                if (c == null) { c = matr[j]; continue; }
                if (d == null) { d = matr[j]; continue; }
            }
            // тернартым оператором изменяем знак
            adj[i] = (a * d - b * c) * ((i % 2 == 0) ? 1 : -1) ;
            // делим каждый элемент матрицы на определитель
            adj[i] /= det;
            // обнуляем переменные для следующего минора
            a = null; b = null; c = null; d = null;
        }
        return 0;
    }

    // метод который запускается в отдельном потоке
    // унаследован от Thread
    public void run() {
        try {
            try {
                // открываем потоки чтения и записи
                in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                out = new BufferedWriter(new OutputStreamWriter(clientSocket.getOutputStream()));

                // считываем матрицу от клиента
                Double[] matr = new Double[9];
                for(int i = 0; i < 9; i++) {
                    matr[i] = Double.valueOf(in.readLine());
                }

                // вычисляем обратуню матрицу 
                // и обрабатываем случай с нулевым определителем
                Double[] inverse = new Double[9];
                if (inverseMatrix(matr, inverse) == -1) {
                    out.write("Определитель равен нулю\n");
                    out.flush();
                    return;
                }

                // отправляем обратную матрицу клиенту
                for(int i = 0; i < 9; i++) {
                    out.write(inverse[i].toString() + '\n');
                    out.flush();
                }
            } finally {
                System.out.println("Клиент отключился\n");
                clientSocket.close();
                in.close();
                out.close();
            }
        } catch (IOException e) {
            System.out.println(e);
        }

    }

}

public class Server {
    private static ServerSocket server;
    private static Socket clientSocket;

    public static void main(String[] args) throws IOException {
        try {
            try {
                // запускаем сервер
                server = new ServerSocket(4004);
                System.out.println("Сервер запущен");
                // ждем подключения клиентов
                while (true) {
                    clientSocket = server.accept();
                    System.out.println("Новый клиент подключен");
                    ClientThread a = new ClientThread(clientSocket);
                    a.start();
                }

            } finally {
                System.out.println("Сервер закрыт");
                server.close();
            }
        } catch (IOException e) {
            System.out.println(e);
        }
    }
        
}
