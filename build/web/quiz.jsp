<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    List<Map<String, String>> questions = (List<Map<String, String>>) session.getAttribute("questions");
    Integer index = (Integer) session.getAttribute("index");

    if (questions == null || index == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    if (index >= questions.size()) {
        response.sendRedirect("result.jsp");
        return;
    }

    Map<String, String> q = questions.get(index);
    int total = questions.size();
    int progress = (int)(((double) index / total) * 100);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <script>
        let time = 60;
        function startTimer() {
            let t = setInterval(function () {
                document.getElementById("timer").innerHTML = time;
                time--;
                if (time < 0) {
                    clearInterval(t);
                    document.getElementById("quizForm").submit();
                }
            }, 1000);
        }
    </script>
</head>

<body onload="startTimer()">

<div class="container">

    <div class="progress-bar">
        <div class="progress" style="width:<%= progress %>%"></div>
    </div>

    <h3>Time Left: <span id="timer">60</span> sec</h3>

    <h2><%= q.get("question") %></h2>

    <form action="nextQuestion" method="post" id="quizForm">

        <input type="hidden" name="correct" value="<%= q.get("correct") %>">

        <label class="option">
            <input type="radio" name="answer" value="<%= q.get("option1") %>">
            <%= q.get("option1") %>
        </label>

        <label class="option">
            <input type="radio" name="answer" value="<%= q.get("option2") %>">
            <%= q.get("option2") %>
        </label>

        <label class="option">
            <input type="radio" name="answer" value="<%= q.get("option3") %>">
            <%= q.get("option3") %>
        </label>

        <label class="option">
            <input type="radio" name="answer" value="<%= q.get("option4") %>">
            <%= q.get("option4") %>
        </label>

        <br>
        <button type="submit">Next</button>
    </form>

</div>

</body>
</html>