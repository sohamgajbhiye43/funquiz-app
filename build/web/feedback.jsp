<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback</title>

    <style>
        body {
            font-family: Arial;
            text-align: center;
            background: linear-gradient(to right, #ff9a9e, #fad0c4);
        }

        .container {
            background: white;
            width: 90%;
            max-width: 500px;
            margin: auto;
            padding: 20px;
            margin-top: 40px;
            border-radius: 10px;
        }

        h2 {
            margin-bottom: 20px;
        }

        .question {
            margin: 15px 0;
        }

        .stars {
            display: flex;
            justify-content: center;
            flex-direction: row-reverse;
        }

        .stars input {
            display: none;
        }

        .stars label {
            font-size: 25px;
            color: gray;
            cursor: pointer;
        }

        .stars input:checked ~ label {
            color: gold;
        }

        button {
            margin-top: 20px;
            padding: 10px;
            width: 100%;
            background: #ff6f61;
            color: white;
            border: none;
            border-radius: 5px;
        }
    </style>

</head>
<body>

<div class="container">

<h2>Rate Your Quiz Experience</h2>

<form action="submitFeedback" method="post">

<!-- QUESTION 1 -->
<div class="question">
    <p>1. Quiz Difficulty</p>
    <div class="stars">
        <input type="radio" name="q1" value="5" id="q1-5"><label for="q1-5">★</label>
        <input type="radio" name="q1" value="4" id="q1-4"><label for="q1-4">★</label>
        <input type="radio" name="q1" value="3" id="q1-3"><label for="q1-3">★</label>
        <input type="radio" name="q1" value="2" id="q1-2"><label for="q1-2">★</label>
        <input type="radio" name="q1" value="1" id="q1-1"><label for="q1-1">★</label>
    </div>
</div>

<!-- QUESTION 2 -->
<div class="question">
    <p>2. Quiz Engagement</p>
    <div class="stars">
        <input type="radio" name="q2" value="5" id="q2-5"><label for="q2-5">★</label>
        <input type="radio" name="q2" value="4" id="q2-4"><label for="q2-4">★</label>
        <input type="radio" name="q2" value="3" id="q2-3"><label for="q2-3">★</label>
        <input type="radio" name="q2" value="2" id="q2-2"><label for="q2-2">★</label>
        <input type="radio" name="q2" value="1" id="q2-1"><label for="q2-1">★</label>
    </div>
</div>

<!-- QUESTION 3 -->
<div class="question">
    <p>3. UI Experience</p>
    <div class="stars">
        <input type="radio" name="q3" value="5" id="q3-5"><label for="q3-5">★</label>
        <input type="radio" name="q3" value="4" id="q3-4"><label for="q3-4">★</label>
        <input type="radio" name="q3" value="3" id="q3-3"><label for="q3-3">★</label>
        <input type="radio" name="q3" value="2" id="q3-2"><label for="q3-2">★</label>
        <input type="radio" name="q3" value="1" id="q3-1"><label for="q3-1">★</label>
    </div>
</div>

<!-- QUESTION 4 -->
<div class="question">
    <p>4. Question Quality</p>
    <div class="stars">
        <input type="radio" name="q4" value="5" id="q4-5"><label for="q4-5">★</label>
        <input type="radio" name="q4" value="4" id="q4-4"><label for="q4-4">★</label>
        <input type="radio" name="q4" value="3" id="q4-3"><label for="q4-3">★</label>
        <input type="radio" name="q4" value="2" id="q4-2"><label for="q4-2">★</label>
        <input type="radio" name="q4" value="1" id="q4-1"><label for="q4-1">★</label>
    </div>
</div>

<!-- QUESTION 5 -->
<div class="question">
    <p>5. Overall Experience</p>
    <div class="stars">
        <input type="radio" name="q5" value="5" id="q5-5"><label for="q5-5">★</label>
        <input type="radio" name="q5" value="4" id="q5-4"><label for="q5-4">★</label>
        <input type="radio" name="q5" value="3" id="q5-3"><label for="q5-3">★</label>
        <input type="radio" name="q5" value="2" id="q5-2"><label for="q5-2">★</label>
        <input type="radio" name="q5" value="1" id="q5-1"><label for="q5-1">★</label>
    </div>
</div>

<button type="submit">Submit Feedback</button>

</form>

</div>

</body>
</html>