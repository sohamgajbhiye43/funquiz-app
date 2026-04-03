<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <script>
        function showDifficulty(id) {
            let div = document.getElementById(id);
            div.style.display = div.style.display === "block" ? "none" : "block";
        }

        function startQuiz(category, difficulty) {
           window.location.href = "quiz?category=" + category + "&difficulty=" + difficulty;
        }
    </script>
</head>

<body>

<div class="container">
    <h2>Welcome to Quiz Dashboard</h2>

    <div class="category-box">

        <!-- CATEGORY CARD -->
        <div class="card" onclick="showDifficulty('pop')">
            Pop Culture
            <br>
            <div id="pop" class="difficulty">
                <button onclick="startQuiz('Pop Culture','easy')">Easy</button>
                <button onclick="startQuiz('Pop Culture','hard')">Hard</button>
                <button onclick="startQuiz('Pop Culture','advanced')">Advanced</button>
            </div>
        </div>
<br>
        <div class="card" onclick="showDifficulty('sports')">
            Sports 
            <br>
            <div id="sports" class="difficulty">
                <button onclick="startQuiz('Sports','easy')">Easy</button>
                <button onclick="startQuiz('Sports','hard')">Hard</button>
                <button onclick="startQuiz('Sports','advanced')">Advanced</button>
            </div>
        </div>
<br>
        <div class="card" onclick="showDifficulty('ent')">
            Entertainment 
            <br>        
            <div id="ent" class="difficulty">
                <button onclick="startQuiz('Entertainment','easy')">Easy</button>
                <button onclick="startQuiz('Entertainment','hard')">Hard</button>
                <button onclick="startQuiz('Entertainment','advanced')">Advanced</button>
            </div>
        </div>
<br>
        <div class="card" onclick="showDifficulty('geo')">
            Geography 
            <br> 
            
            <div id="geo" class="difficulty">
                <button onclick="startQuiz('Geography','easy')">Easy</button>
                <button onclick="startQuiz('Geography','hard')">Hard</button>
                <button onclick="startQuiz('Geography','advanced')">Advanced</button>
            </div>
        </div>

    </div>
</div>
    
    <br><br>
        
    <div 
    onmouseover="this.style.transform='translateY(-10px) scale(1.05)'"
    onmouseout="this.style.transform='none'"
    >

        <a href="history.jsp" style="color:white; font-size:20px; text-decoration:none; font-weight:bold;">
             View Previous Attempts
        </a>
    </div>
   
<br>
<br>
    <div 
    onmouseover="this.style.transform='translateY(-10px) scale(1.05)'"
    onmouseout="this.style.transform='none'"
    >

        <a href="logout" style="color:white; font-size:20px; text-decoration:none; font-weight:bold;">
             Logout
        </a>
    </div>

</body>
</html>