<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>FunQuiz - Home</title>

    <!-- Mobile Responsive -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CDN -->

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: #333;
        }

        .hero {
            padding: 80px 20px;
            text-align: center;
            color: white;
        }

        .hero h1 {
            font-size: 40px;
            font-weight: bold;
        }

        .hero p {
            font-size: 18px;
            margin-top: 10px;
        }

        .btn-custom {
            margin: 10px;
            padding: 12px 25px;
            font-size: 18px;
            border-radius: 25px;
        }

        .features {
            background: white;
            padding: 50px 20px;
        }

        .feature-box {
            text-align: center;
            padding: 20px;
        }

        .footer {
            background: #222;
            color: white;
            text-align: center;
            padding: 15px;
        }
    </style>
</head>

<body>

<!-- HERO SECTION -->
<div class="hero">
    <h1>Welcome to FunQuiz 🎯</h1>
    <p>Test your knowledge, challenge your mind, and improve your skills!</p>

    <a href="login.jsp" class="btn btn-light btn-custom">Login</a>
    <a href="register.jsp" class="btn btn-dark btn-custom">Register</a>
</div>

<!-- FEATURES -->
<div class="features container">
    <div class="row">

        <div class="col-md-4 feature-box">
            <h3>🧠 Smart Questions</h3>
            <p>Practice with well-designed questions across multiple topics.</p>
        </div>

        <div class="col-md-4 feature-box">
            <h3>⚡ Instant Results</h3>
            <p>Get immediate feedback and track your performance.</p>
        </div>

        <div class="col-md-4 feature-box">
            <h3>📈 Improve Skills</h3>
            <p>Enhance your logical thinking and speed with regular practice.</p>
        </div>

    </div>
</div>

<!-- ABOUT SECTION -->
<div class="container text-center mt-5">
    <h2>About FunQuiz</h2>
    <p>
        FunQuiz is an interactive quiz platform designed to help users test their knowledge 
        and improve their problem-solving skills. Whether you're preparing for exams or just 
        want to challenge yourself, FunQuiz is your perfect learning companion.
    </p>
</div>

<!-- FOOTER -->
<div class="footer mt-5">
    <p>© 2026 FunQuiz | Created by students from final year.</p>
</div>

</body>
</html>