<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login – eHotel</title>
    <link rel="stylesheet" href="css/style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background: #f4f4f4;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 30px;
            color: #333;
        }

        .login-container input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .login-container button {
            width: 100%;
            padding: 12px;
            background-color: #222;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        .login-container button:hover {
            background-color: #444;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login to eHotel</h2>
    <form action="LoginServlet" method="post">
        <input type="text" name="emailOrUsername" placeholder="Email or Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
    </form>
    <p style="margin-top: 20px; font-size: 0.95rem;">
        Don’t have an account?
        <a href="signup.jsp" style="color: #222; text-decoration: underline;">Sign up here</a>
    </p>

</div>

</body>
</html>
