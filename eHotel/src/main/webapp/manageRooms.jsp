<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage Rooms</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f9f9f9; }
        h2 { color: #333; }
        .nav { background: #eaf7ea; padding: 10px; margin-bottom: 20px; border-radius: 5px; }
        .nav a { margin-right: 15px; color: #0a0a0a; font-weight: bold; text-decoration: none; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); margin-bottom: 30px; }
        label { display: inline-block; width: 120px; margin-bottom: 10px; }
        input[type="text"] { width: 250px; padding: 6px; border: 1px solid #ccc; border-radius: 4px; margin-bottom: 10px; }
        input[type="submit"], button { background: #0a0a0a; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; }
        input[type="submit"]:hover, button:hover { background: #0a0a0a; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 5px; overflow: hidden; }
        th, td { padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:hover { background-color: #f1f1f1; }
        .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); justify-content: center; align-items: center; }
        .modal-content { background: white; padding: 20px; border-radius: 5px; width: 400px; }
        .close { float: right; cursor: pointer; color: red; font-weight: bold; }
    </style>
    <script>
        function openEditModal(id, hotel, num, capacity, damages, price) {
            document.getElementById("editId").value = id;
            document.getElementById("editHotel").value = hotel;
            document.getElementById("editNum").value = num;
            document.getElementById("editCapacity").value = capacity;
            document.getElementById("editDamages").value = damages;
            document.getElementById("editPrice").value = price;
            document.getElementById("editModal").style.display = "flex";
        }
        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>
</head>
<body>
<%@ include file="admin-navbar.html" %>

<h2>Manage Rooms</h2>

<!-- INSERT ROOM -->
<div class="card">
    <h3>Insert Room</h3>
    <form method="post">
        <label>Hotel ID:</label><input type="text" name="insert_hotel" required><br>
        <label>Room Number:</label><input type="text" name="insert_num" required><br>
        <label>Capacity:</label><input type="text" name="insert_capacity" required><br>
        <label>Damages:</label><input type="text" name="insert_damages"><br>
        <label>Price:</label><input type="text" name="insert_price" required><br>
        <input type="submit" name="action" value="Insert">
    </form>
</div>

<!-- Display All Rooms -->
<table>
    <tr>
        <th>Room ID</th><th>Hotel ID</th><th>Room #</th><th>Capacity</th><th>Damages</th><th>Price</th><th>Actions</th>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM rooms");
            while (rs.next()) {
                String id = rs.getString("room_id");
                String hotel = rs.getString("hotel_id");
                String num = rs.getString("room_num");
                String capacity = rs.getString("capacity");
                String damages = rs.getString("damages");
                String price = rs.getString("price");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= hotel %></td>
        <td><%= num %></td>
        <td><%= capacity %></td>
        <td><%= damages %></td>
        <td><%= price %></td>
        <td>
            <button onclick="openEditModal('<%= id %>', '<%= hotel %>', '<%= num %>', '<%= capacity %>', '<%= damages %>', '<%= price %>')">Edit</button>
            <form method="post" style="display:inline;">
                <input type="hidden" name="delete_id" value="<%= id %>">
                <input type="submit" name="action" value="Delete" onclick="return confirm('Are you sure you want to delete this room?');">
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='7'>Error loading rooms: " + e.getMessage() + "</td></tr>");
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
        <h3>Edit Room</h3>
        <form method="post">
            <input type="hidden" id="editId" name="update_id">
            <label>Hotel ID:</label><input type="text" id="editHotel" name="update_hotel"><br>
            <label>Room Number:</label><input type="text" id="editNum" name="update_num"><br>
            <label>Capacity:</label><input type="text" id="editCapacity" name="update_capacity"><br>
            <label>Damages:</label><input type="text" id="editDamages" name="update_damages"><br>
            <label>Price:</label><input type="text" id="editPrice" name="update_price"><br>
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
                String sql = "INSERT INTO rooms (hotel_id, room_num, capacity, damages, price, extendable, tv, ac, microwave, fridge, kitchen) VALUES (?, ?, ?, ?, ?, false, false, false, false, false, false)";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("insert_hotel"));
                ps.setString(2, request.getParameter("insert_num"));
                ps.setString(3, request.getParameter("insert_capacity"));
                ps.setString(4, request.getParameter("insert_damages"));
                ps.setString(5, request.getParameter("insert_price"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Room inserted successfully.</p>");
            }

            if (action.equals("Update")) {
                String sql = "UPDATE rooms SET hotel_id=?::int, room_num=?::int, capacity=?::int, damages=?, price=?::numeric WHERE room_id=?::int";

                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("update_hotel"));
                ps.setString(2, request.getParameter("update_num"));
                ps.setString(3, request.getParameter("update_capacity"));
                ps.setString(4, request.getParameter("update_damages"));
                ps.setString(5, request.getParameter("update_price"));
                ps.setString(6, request.getParameter("update_id"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Room updated successfully.</p>");
            }

            if (action.equals("Delete")) {
                String sql = "DELETE FROM rooms WHERE room_id=?::int";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("delete_id"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Room deleted successfully.</p>");
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
