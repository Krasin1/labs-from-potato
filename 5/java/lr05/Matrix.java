import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

class Matrix extends JFrame {
    // запускаем окно
    public static void main(String[] args) {
        Matrix form = new Matrix();
        form.setVisible(true);
    }

    // метод для обращения к серверу за результатом
    private int getInverseMatrix(Double[] matr, Double[] inverse) {
        BufferedReader in;
        BufferedWriter out;
        try {
            // создаем сокет и откываем потоки чтения и записи
            Socket clientSocket = new Socket("127.0.0.1", 4004);
            in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            out = new BufferedWriter(new OutputStreamWriter(clientSocket.getOutputStream()));

            // отправляем матрицу серверу
            for(int i = 0; i < 9; i++) {
                out.write(matr[i].toString() + '\n');
                out.flush();
            }

            // первой строкой получаем либо ошибку либо обратную матрицу
            String messeage = in.readLine();
            try {
                inverse[0] = Double.valueOf(messeage);
                inverse[0] = Double.parseDouble(String.format("%.6f", inverse[0]));
            } catch (IllegalArgumentException e) {
                // выводим окно с ошибкой
                JOptionPane.showMessageDialog(new JFrame(), messeage, "Dialog", JOptionPane.ERROR_MESSAGE);
                // закрываем что открывали
                clientSocket.close();
                in.close();
                out.close();
                return -1;
            }

            // получаем оставшуюся обратную матрицу
            for(int i = 1; i < 9; i++) {
                inverse[i] = Double.valueOf(in.readLine());
                inverse[i] = Double.parseDouble(String.format("%.6f", inverse[i]));
            }

            // закрываем что открывали
            clientSocket.close();
            in.close();
            out.close();
        } catch (Exception e) {
            System.out.println(e);
            // выводим в отдельном окошке ошибку
            JOptionPane.showMessageDialog(new JFrame(), e, "Dialog", JOptionPane.ERROR_MESSAGE);
            return -1;
        }
        return 0;
    }

    public Matrix() {
        // задаем размеры окна
        super("Test");
        super.setBounds(200, 100, 860, 300);
        super.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // задаем структуру онка
        GridBagLayout gridBagLayout = new GridBagLayout();
        setLayout(gridBagLayout);

        // надписи
        JLabel intro = new JLabel("Лабораторная работа №4");
        JLabel name = new JLabel("Дунаев В.Е. ИКПИ-11");
        JLabel task = new JLabel("Нахождение обратной матрицы");
        JLabel inverse = new JLabel("Обратная матрица:");

        // задаем расположение надписей
        GridBagConstraints title = new GridBagConstraints();
        title.weightx = 0;
        title.weighty = 0;
        title.gridx = 0;
        title.gridy = 0;
        title.gridheight = 1;
        title.gridwidth = 3;
        add(intro, title);

        // смещаемся на одну клетку по y и выводим имя
        title.gridy = 1;
        add(name, title);

        // смещаемся на одну клетку по y и выводим задание
        title.gridy = 2;
        add(task, title);

        // cмещаемся на 5 клеток по x и выводим надпись над обратной матрицей
        title.gridx = 5;
        add(inverse, title);

        // инициализируем 2 массива с полями для ввода вывода матриц
        JTextField[] outputCells = new JTextField[9];
        JTextField[] inputCells= new JTextField[9];
        for(int i = 0; i < 9; ++i) {
            outputCells[i] = new JTextField(String.valueOf(i));
        }
        // рисуем обратную матрицу с заглушками в виде чисел от 0 до 8
        drawInverseMatrix(outputCells);


        // создаем кнопку и задаем ее располажение на сетке
        JButton button = new JButton("Вычислить");
        // отступы справа и слева по 10px
        title.insets = new Insets(0, 10, 0, 10);
        title.gridx = 4;
        title.gridy = 3;
        title.gridheight = 0;
        title.gridwidth = 1;
        add(button, title);

        // действие при нажании на кнопку
        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Double[] matr = new Double[9];
                Double[] inverse = new Double[9];
                for (int i = 0; i < 9; i++) {
                    // считываем нашу матрицу
                    try {
                        matr[i] = Double.valueOf(inputCells[i].getText());
                    } catch (NumberFormatException ex) {
                        String messeage = "Матрица заполнена неправильно";
                        JOptionPane.showMessageDialog(new JFrame(), messeage, "Dialog", JOptionPane.ERROR_MESSAGE);
                        return;
                    }
                }
                // вызываем метод который обращается к серверу за ответом
                // если он вернул 0, значит все хорошо и можно вывести обратную матрицу
                // иначе метод сам выведет окно с ошибкой
                if (getInverseMatrix(matr, inverse) == 0) 
                    editMatrix(outputCells, inverse);
            }
        });

        // рисуем поля для ввода нашей матрицы
        for (int i = 0; i < 9; i++) {
            // задаем размеры одного элемента матрицы
            GridBagConstraints temp = new GridBagConstraints();
            temp.insets = new Insets(10,10,10,10);
            temp.weightx = 0;
            temp.weighty = 0;
            // вычисляем координаты на сетке
            temp.gridx = i % 3;
            temp.gridy = i / 3 + 3;
            temp.gridheight = 1;
            temp.gridwidth = 1;
            temp.ipadx = 70;
            temp.ipady = 25;

            inputCells[i] = new JTextField(String.valueOf(i));
            inputCells[i].setBackground(Color.WHITE);
            inputCells[i].setHorizontalAlignment(JTextField.CENTER);

            // ограничиваем кол-во символов
            // использую final потому что нельзя напрямую обратится к inputCells[i]
            final JTextField inner = inputCells[i];
            inputCells[i].addKeyListener(new KeyAdapter() {
                public void keyPressed(KeyEvent ke) {
                    String value = inner.getText();
                    int l = value.length();
                    // если длинна строки меньше 10 или нажата клавиша backspace
                    if (ke.getKeyChar() == 8 || l < 10) {
                        inner.setEditable(true);
                    } else {
                        inner.setEditable(false);
                    } 

                }
            });
            // рисуем ячейку
            add(inputCells[i], temp);
        }


    }

    // меняем текст в ячейках матрицы
    void editMatrix(JTextField[] cells, Double[] matr) {
        for(int i = 0; i < 9; i++) {
            cells[i].setText(matr[i].toString());
        }
    }

    // рисуем ячейки обратной матрицы 
    void drawInverseMatrix(JTextField[] cells) {
        for (int i = 0; i < 9; i++) {
            // задаем размеры одного элемента матрицы
            GridBagConstraints temp = new GridBagConstraints();
            temp.insets = new Insets(10,10,10,10);
            temp.weightx = 0;
            temp.weighty = 0;
            temp.gridx = i % 3 + 5;
            temp.gridy = i / 3 + 3;
            temp.gridheight = 1;
            temp.gridwidth = 1;
            temp.ipadx = 70;
            temp.ipady = 25;

            cells[i].setBackground(Color.WHITE);
            cells[i].setHorizontalAlignment(JTextField.CENTER);
            cells[i].setEditable(false);
            // рисуем ячейку
            add(cells[i], temp);
        }
    }

}
