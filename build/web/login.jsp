<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <style>
        /* Full page styling */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;

            /* Centering using Flexbox */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;

            /* Background color */
            background: linear-gradient(to right, #4fa, #00f2fe);
        }

        /* Login box */
        .login-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            width: 300px;
            text-align: center;

            /* Shadow for modern look */
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        /* Input fields */
        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;

            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* Button styling */
        button {
            width: 100%;
            padding: 10px;
            background: #4facfe;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background: #00c6ff;
        }

        /* Register link */
        a {
            display: block;
            margin-top: 15px;
            text-decoration: none;
            color: #4facfe;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>

</head>

<body>

<div class="login-container">
    <h2>Login</h2>

    <form action="login" method="post">
        <input type="text" name="email" placeholder="Enter Email" required>
        <input type="password" name="password" placeholder="Enter Password" required>

        <button type="submit">Login</button>
    </form>

    <a href="register.jsp">Register</a>
</div>

</body>
</html>