<html>
<head>
    <title>e-Hotel System</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; padding: 40px; text-align: center; }
        h1 { color: #333; }
        .user-type {
            display: inline-block;
            width: 280px;          /* Set equal width */
            height: 220px;         /* Set equal height */
            vertical-align: top;
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .user-type a {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            font-size: 16px;
            background-color: #5cb85c;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .user-type a:hover {
            background-color: #4cae4c;
        }

        body {
            font-family: Arial;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }

        h1 {
            color: #333;
            margin-bottom: 120px;
            margin-top: -70px; /* push it upward */
        }


    </style>
</head>
<body>
<h1>Welcome to e-Hotel System</h1>
<div style="display: flex; justify-content: center; gap: 30px; flex-wrap: wrap;">
    <div class="user-type">
        <h2>Customer</h2>
        <p>Search and book rooms.</p>
        <a href="customer.jsp">Enter as Customer</a>
    </div>
    <div class="user-type">
        <h2>Employee</h2>
        <p>Manage walk-ins and rentals.</p>
        <a href="employee.jsp">Enter as Employee</a>
    </div>
    <div class="user-type">
        <h2>Admin</h2>
        <p>Manage customers, employees, hotels, and rooms.</p>
        <a href="adminLogin.jsp">Enter as Admin</a>

    </div>
</div>

</body>
</html>
