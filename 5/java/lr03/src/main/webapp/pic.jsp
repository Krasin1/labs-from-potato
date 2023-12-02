<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pictures</title>
</head>
<body>
<a href="index.jsp">На главную</a>
    <script>
        function cars() {
            for(var i = 1; i <= 2; i++) {
                document.write('<li><a href="images/car' + 
                i + '.jpg"><img src="images/car' + i + '.jpg" ></a></li>');
            }
        }
        function kurgans() {
            for(var i = 1; i <= 4; i++) {
                document.write('<li><a href="images/kurgan' + 
                i + '.jpg"><img src="images/kurgan' + i + '.jpg" ></a></li>');
            }
        }
        function natures() {
            for(var i = 1; i <= 3; i++) {
                document.write('<li><a href="images/nature' + 
                i + '.jpg"><img src="images/nature' + i + '.jpg" ></a></li>');
            }
        }
        function sams() {
            for(var i = 1; i <= 4; i++) {
                document.write('<li><a href="images/sam' + 
                i + '.jpg"><img src="images/sam' + i + '.jpg" ></a></li>');
            }
        }
        function choose() {
            const myUrl = new URL(window.location.toLocaleString());
            const urlParams = myUrl.searchParams;
            switch(urlParams.get('genre')) {
                case "Машины":
                    cars();
                    break;
                case "Курганы":
                    kurgans();
                    break;
                case "Природа":
                    natures();
                    break;
                case "Сэм Лейк":
                    sams();
                    break;
                default:
                    cars();
                    kurgans();
                    natures();
                    sams();
                    break;
            }
        }
        choose();
    </script>
</body>
</html>
