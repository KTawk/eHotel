<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage Customers</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f9f9f9; }
        h2 { color: #333; }
        .nav { background: #eaf7ea; padding: 10px; margin-bottom: 20px; border-radius: 5px; }
        .nav a { margin-right: 15px; color: #4cae4c; font-weight: bold; text-decoration: none; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); margin-bottom: 30px; }
        label { display: inline-block; width: 100px; margin-bottom: 10px; }
        input[type="text"] { width: 250px; padding: 6px; border: 1px solid #ccc; border-radius: 4px; margin-bottom: 10px; }
        input[type="submit"], button { background: #5cb85c; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; }
        input[type="submit"]:hover, button:hover { background: #4cae4c; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 5px; overflow: hidden; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:hover { background-color: #f1f1f1; }
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); justify-content: center; align-items: center; }
        .modal-content { background: white; padding: 20px; border-radius: 5px; width: 400px; }
        .close { float: right; cursor: pointer; color: red; font-weight: bold; }
    </style>
    <script>
        function openEditModal(sin, email, fname, lname, address) {
            document.getElementById("editSin").value = sin;
            document.getElementById("editEmail").value = email;
            document.getElementById("editFname").value = fname;
            document.getElementById("editLname").value = lname;
            document.getElementById("editAddress").value = address;
            document.getElementById("editModal").style.display = "flex";
        }
        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>
</head>
<body>
<div class="nav">
    <a href="index.jsp">Main Page</a>
    <a href="manageCustomers.jsp">Manage Customers</a>
    <a href="manageEmployees.jsp">Manage Employees</a>
    <a href="manageHotels.jsp">Manage Hotels</a>
    <a href="manageRooms.jsp">Manage Rooms</a>
</div>

<h2>Manage Customers</h2>

<!-- INSERT CUSTOMER -->
<div class="card">
    <h3>Insert Customer</h3>
    <form method="post">
        <label>SIN:</label><input type="text" name="insert_sin" required><br>
        <label>Email:</label><input type="text" name="insert_email" required><br>
        <label>First Name:</label><input type="text" name="insert_fname" required><br>
        <label>Last Name:</label><input type="text" name="insert_lname" required><br>
        <label>Address:</label><input type="text" name="insert_address" required><br>
        <input type="submit" name="action" value="Insert">
    </form>
</div>

<!-- Display All Customers -->
<table>
    <tr>
        <th>SIN</th><th>Email</th><th>First Name</th><th>Last Name</th><th>Address</th><th>Actions</th>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM customer");
            while (rs.next()) {
                String sin = rs.getString("sin");
                String email = rs.getString("email");
                String fname = rs.getString("firstname");
                String lname = rs.getString("lastname");
                String address = rs.getString("address");
    %>
    <tr>
        <td><%= sin %></td>
        <td><%= email %></td>
        <td><%= fname %></td>
        <td><%= lname %></td>
        <td><%= address %></td>
        <td>
            <button onclick="openEditModal('<%= sin %>', '<%= email %>', '<%= fname %>', '<%= lname %>', '<%= address %>')">Edit</button>
            <form method="post" style="display:inline;">
                <input type="hidden" name="delete_sin" value="<%= sin %>"/>
                <input type="submit" name="action" value="Delete" onclick="return confirm('Are you sure you want to delete this customer?');"/>
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='6'>Error loading customers: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</table>

<!-- Edit Modal -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3>Edit Customer</h3>
        <form method="post">
            <input type="hidden" id="editSin" name="update_sin">
            <label>Email:</label>
            <input type="text" id="editEmail" name="update_email">
            <label>First Name:</label>
            <input type="text" id="editFname" name="update_fname">
            <label>Last Name:</label>
            <input type="text" id="editLname" name="update_lname">
            <label>Address:</label>
            <input type="text" id="editAddress" name="update_address">
            <input type="submit" name="action" value="Update">
        </form>
    </div>
</div>

<%
    String action = request.getParameter("action");
    Connection db = null;
    PreparedStatement ps = null;

    try {
        if (action != null) {
            Class.forName("org.postgresql.Driver");
            db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");

            if (action.equals("Insert")) {
                String sql = "INSERT INTO customer (sin, email, firstname, lastname, address) VALUES (?, ?, ?, ?, ?)";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("insert_sin"));
                ps.setString(2, request.getParameter("insert_email"));
                ps.setString(3, request.getParameter("insert_fname"));
                ps.setString(4, request.getParameter("insert_lname"));
                ps.setString(5, request.getParameter("insert_address"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Customer inserted successfully.</p>");
            }

            if (action.equals("Update")) {
                String sql = "UPDATE customer SET email=?, firstname=?, lastname=?, address=? WHERE sin=?";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("update_email"));
                ps.setString(2, request.getParameter("update_fname"));
                ps.setString(3, request.getParameter("update_lname"));
                ps.setString(4, request.getParameter("update_address"));
                ps.setString(5, request.getParameter("update_sin"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Customer updated successfully.</p>");
            }

            if (action.equals("Delete")) {
                String sql = "DELETE FROM customer WHERE sin=?";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("delete_sin"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Customer deleted successfully.</p>");
            }
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (ps != null) ps.close();
        if (db != null) db.close();
    }
%>
</body>
</html>
