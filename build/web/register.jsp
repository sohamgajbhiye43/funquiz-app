<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
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
            background: linear-gradient(to right, #4facfe, #00f2fe);
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
    
<h2>Register</h2>

<br>
<br>
<br>
<br>

<form action="register" method="post" style="text-align:center;">
    Name: <input type="text" name="name"><br>
    Email: <input type="text" name="email"><br>
    Password: <input type="password" name="password"><br>
    <button type="submit">Register</button>
</form>


    
</body>
</html>