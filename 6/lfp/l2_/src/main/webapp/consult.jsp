<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Консультация</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="styles.css">
    <script>
        var question_id = -1;
        $(document).ready(function() {
            window.onload = function() {
                refreshQuestions();
            }
            window.onunload = function() {
                refreshQuestions();
            }
            getNextQuestion();
            $('#reset-button').click(function() {
                $('yes').prop('disabled', false);
                $('no').prop('disabled', false);
                refreshQuestions();
            });

            if (!($('#yes').prop('disabled'))) {
                $('#yes').click(function() {
                    $.ajax({
                        url: 'saveFact',
                        type: 'POST',
                        async: false,
                        data: {
                            id: question_id,
                        },
                        success: function(data) {
                            getNextQuestion();
                        }
                    });
                });
            }

            $('#no').click(function() {
                getNextQuestion();
            });
        });
        function refreshQuestions() {
            $.ajax({
                url: 'getQuestion',
                type: 'POST',
                data: {
                    refresh: 'yes',
                },
                success: function(data) {
                    getNextQuestion();
                }
            })
        }

        function getNextQuestion() {
            $.ajax({
                url: 'getQuestion',
                type: 'GET',
                async: false,
                dataType: 'json',
                success: function(data) {
                    if(data.id == -1) {
                        $('#question').html('<a href="${pageContext.request.contextPath}/results">Посмотреть результаты</a>');
                        $('yes').prop('disabled', true);
                        $('no').prop('disabled', true);
                    } else {
                        $('#question').text(data.question);
                        $('yes').prop('disabled', false);
                        $('no').prop('disabled', false);
                    }
                    question_id = data.id;
                }
            });
        }
    </script>
</head>

<body>
<form action="${pageContext.request.contextPath}/" style="left: auto; float:left">
    <button class="btn-допрос" style="left: auto; float:left">< На главную</button>
</form>
<form action="${pageContext.request.contextPath}/edit" style="right:auto; float:right">
    <button class="btn-допрос"style="right:auto; float:right">Редактура фактов</button>
</form>
<br>
<div><h1 style="text-align:center;margin-top:14%">Отвечай:</h1></div>
<div class="question-block" >
    <div id="question" style="text-align:center"></div>
    <a href="${pageContext.request.contextPath}/results" ></a><br>
    <button class="btn-допрос"id="yes" style="left: auto; float:left">Да</button>
    <button class="btn-допрос"id="no" style="right:auto; float:right">Нет</button>
    <br>
    <br>
    <button class="btn-допрос" id="reset-button" style="position: absolute; left: 50%; transform: translateX(-50%)">Заново</button>
</div>
</body>
</html>
