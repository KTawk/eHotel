<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Sign Up - eHotel</title>
    <style>
        body {
            font-family: 'Helvetica Neue', sans-serif;
            background-color: #fefef9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .signup-container {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: 600;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 12px;
            background-color: black;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            opacity: 0.8;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <h2>Create an Account</h2>
    <form method="post" action="signup">
        <label for="fullName">Full Name:</label>
        <input type="text" name="fullName" id="fullName" required />

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required />

        <label for="phone">Phone:</label>
        <input type="tel" name="phone" id="phone"
               pattern="\\d{10}"
               title="Enter a 10-digit phone number without spaces or dashes"
               placeholder="e.g. 1234567890" />

        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required />

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required />

        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" name="confirmPassword" id="confirmPassword" required />

        <label for="role">Role:</label>
        <select name="role" id="role" required>
            <option value="Customer">Customer</option>
            <option value="Employee">Employee</option>
            <option value="Admin">Admin</option>
        </select>

        <button type="submit">Sign Up</button>
    </form>
    <a class="back-link" href="index.jsp">Back to Home</a>
</div>
</body>
</html>
