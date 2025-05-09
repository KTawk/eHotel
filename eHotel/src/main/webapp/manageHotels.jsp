<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage Hotels</title>
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
        function openEditModal(id, name, chain, address, stars, area, category, manager) {
            document.getElementById("editId").value = id;
            document.getElementById("editName").value = name;
            document.getElementById("editChain").value = chain;
            document.getElementById("editAddress").value = address;
            document.getElementById("editStars").value = stars;
            document.getElementById("editArea").value = area;
            document.getElementById("editCategory").value = category;
            document.getElementById("editManager").value = manager;
            document.getElementById("editModal").style.display = "flex";
        }
        function closeModal() {
            document.getElementById("editModal").style.display = "none";
        }
    </script>
</head>
<body>
<%@ include file="admin-navbar.html" %>

<h2>Manage Hotels</h2>

<!-- INSERT HOTEL -->
<div class="card">
    <h3>Insert Hotel</h3>
    <form method="post">
        <label>Hotel Name:</label><input type="text" name="insert_name" required><br>
        <label>Chain Name:</label><input type="text" name="insert_chain" required><br>
        <label>Address:</label><input type="text" name="insert_address" required><br>
        <label>Stars:</label><input type="text" name="insert_stars"><br>
        <label>Area:</label><input type="text" name="insert_area" required><br>
        <label>Category:</label><input type="text" name="insert_category"><br>
        <label>Manager SIN:</label><input type="text" name="insert_manager"><br>
        <input type="submit" name="action" value="Insert">
    </form>
</div>

<!-- Display All Hotels -->
<table>
    <tr>
        <th>ID</th><th>Name</th><th>Chain</th><th>Address</th><th>Stars</th><th>Area</th><th>Category</th><th>Manager</th><th>Actions</th>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM hotels");
            while (rs.next()) {
                String id = rs.getString("hotel_id");
                String name = rs.getString("hotel_name");
                String chain = rs.getString("chain_name");
                String address = rs.getString("hotel_address");
                String stars = rs.getString("stars");
                String area = rs.getString("area");
                String category = rs.getString("category");
                String manager = rs.getString("manager_sin");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= name %></td>
        <td><%= chain %></td>
        <td><%= address %></td>
        <td><%= stars %></td>
        <td><%= area %></td>
        <td><%= category %></td>
        <td><%= manager %></td>
        <td>
            <button type="button" onclick="openEditModal('<%= id %>', '<%= name %>', '<%= chain %>', '<%= address %>', '<%= stars %>', '<%= area %>', '<%= category %>', '<%= manager %>')">Edit</button>
            <form method="post" style="display:inline;"
                  onsubmit='return confirm("Are you sure you want to delete hotel <%= name %> (ID: <%= id %>)?");'>
                <input type="hidden" name="delete_id" value="<%= id %>"/>
                <input type="submit" name="action" value="Delete">
            </form>


        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='9'>Error loading hotels: " + e.getMessage() + "</td></tr>");
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
        <h3>Edit Hotel</h3>
        <form method="post">
            <input type="hidden" id="editId" name="update_id">
            <label>Name:</label><input type="text" id="editName" name="update_name"><br>
            <label>Chain:</label><input type="text" id="editChain" name="update_chain"><br>
            <label>Address:</label><input type="text" id="editAddress" name="update_address"><br>
            <label>Stars:</label><input type="text" id="editStars" name="update_stars"><br>
            <label>Area:</label><input type="text" id="editArea" name="update_area"><br>
            <label>Category:</label><input type="text" id="editCategory" name="update_category"><br>
            <label>Manager SIN:</label><input type="text" id="editManager" name="update_manager"><br>
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
                String sql = "INSERT INTO hotels (hotel_name, chain_name, hotel_address, stars, area, category, manager_sin) VALUES (?, ?, ?, ?::numeric, ?, ?, ?)";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("insert_name"));
                ps.setString(2, request.getParameter("insert_chain"));
                ps.setString(3, request.getParameter("insert_address"));
                ps.setString(4, request.getParameter("insert_stars"));
                ps.setString(5, request.getParameter("insert_area"));
                ps.setString(6, request.getParameter("insert_category"));
                ps.setString(7, request.getParameter("insert_manager"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Hotel inserted successfully.</p>");
            } else if (action.equals("Update")) {
                String sql = "UPDATE hotels SET hotel_name=?, chain_name=?, hotel_address=?, stars=?::numeric, area=?, category=?, manager_sin=? WHERE hotel_id=?::int";

                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("update_name"));
                ps.setString(2, request.getParameter("update_chain"));
                ps.setString(3, request.getParameter("update_address"));
                ps.setString(4, request.getParameter("update_stars"));
                ps.setString(5, request.getParameter("update_area"));
                ps.setString(6, request.getParameter("update_category"));
                ps.setString(7, request.getParameter("update_manager"));
                ps.setString(8, request.getParameter("update_id"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Hotel updated successfully.</p>");
            } else if (action.equals("Delete")) {
                String sql = "DELETE FROM hotels WHERE hotel_id=?::int";
                ps = db.prepareStatement(sql);
                ps.setString(1, request.getParameter("delete_id"));
                ps.executeUpdate();
                out.println("<p style='color:green;'>Hotel deleted successfully.</p>");
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
