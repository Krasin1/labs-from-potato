<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Документ, состоящий из HTML-текста и PHP-кода</title>
</head>
<body>
    <?php
        echo "А вот и PHP!<br>";
    ?>
    Всё очень просто!<br><br>


    <!-- if else -->

    <?php
        $i = 6; // целое
        $v = 7;
        $d = 4.89; // дробное
        $str = "РНР для всех!"; // строка
        echo ($i + $d);
        echo "<br>Привет, мир!".$str;
        if($i == $v) {
            echo $i + $v;
        } else {
            echo $i.$v;
        }
    ?>

    <br><br>

    <?php
        $b = $a = 5;
        echo "<br>переменная a=$a, b=$b";
        $c = $a++;
        echo "<br>переменная a=$a, c=$c";
        $e = $d = ++$b;
        echo "<br>переменная e=$e, d=$d, b=$b";
        $g = 10;
        $h = $g += 10;
        echo "<br>переменная g=$g, h=$h";
    ?>

    <br><br>
</body>
</html>
