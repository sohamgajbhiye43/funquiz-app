<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    int score = (int) session.getAttribute("score");
    List<Map<String, String>> questions = (List<Map<String, String>>) session.getAttribute("questions");
    List<String> answers = (List<String>) session.getAttribute("answers");

    int total = questions.size();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Result</title> 
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { font-family: Arial; padding: 20px; }
        .correct { background: blue; padding: 10px; }
        .wrong { background: #f8d7da; padding: 10px; }
    </style>
</head>
<body>

<h2>Your Score: <%= score %> / <%= total %></h2>

<hr>

<%
for (int i = 0; i < questions.size(); i++) {
    Map<String, String> q = questions.get(i);
    String correct = q.get("correct");
    String userAns = "Not Answered";
    if (answers != null && i < answers.size()) {
        userAns = answers.get(i);
    }

    boolean isCorrect = correct.equals(userAns);
%>


    <div style="padding:10px; 
    background-color:<%= isCorrect ? "#d4edda" : "#f8d7da" %>;
    ">
        <div 
    onmouseover="this.style.transform='translateY(-10px) scale(1.05)'"
    onmouseout="this.style.transform='none'"
    >
    <p><b>Q:</b> <%= q.get("question") %></p>
    <p><b>Your Answer:</b> <%= userAns %></p>
    <p><b>Correct Answer:</b> <%= correct %></p>
        </div>
    
    </div>
<br>

<% } %>

<div 
    onmouseover="this.style.transform='translateY(-10px) scale(1.05)'"
    onmouseout="this.style.transform='none'"
    >

        <a href="dashboard.jsp" style="color:white; font-size:20px; text-decoration:none; font-weight:bold;">
             Back to Dashboard
        </a>
    </div>
   
<br>
<br>
    <div 
    onmouseover="this.style.transform='translateY(-10px) scale(1.05)'"
    onmouseout="this.style.transform='none'"
    >

        <a href="saveScore" style="color:white; font-size:20px; text-decoration:none; font-weight:bold;">
             Continue to Feedback
        </a>
    </div>


</body>
</html>