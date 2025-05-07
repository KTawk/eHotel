<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<html>
<head>
    <title>Employee Operations - e-Hotels</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h2, h3 {
            color: #333;
        }
        .button-bar {
            margin-bottom: 20px;
        }
        .button-bar button {
            background-color: #5cb85c;
            color: #fff;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .button-bar button:hover {
            background-color: #4cae4c;
        }
        .section {
            display: none; /* Hidden by default; toggled via JavaScript */
            margin-bottom: 30px;
            padding: 15px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        label {
            margin-right: 10px;
            display: inline-block;
            width: 150px;
        }
        input[type="text"], input[type="date"], select {
            padding: 5px;
            border-radius: 3px;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            background-color: #5cb85c;
            color: #fff;
            cursor: pointer;
            border: none;
            padding: 6px 12px;
            border-radius: 3px;
        }
        input[type="submit"]:hover {
            background-color: #4cae4c;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .actions button {
            background-color: #5cb85c;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 3px;
            cursor: pointer;
        }
        .actions button:hover {
            background-color: #4cae4c;
        }
        .form-container {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
    </style>
    <script>
        function showSection(sectionId) {
            // Hide both sections
            document.getElementById("allBookingsSection").style.display = "none";
            document.getElementById("walkInSection").style.display = "none";
            // Show the requested section
            document.getElementById(sectionId).style.display = "block";
        }
    </script>
</head>
<body>
<div style="margin-bottom: 10px;">
    <a href="index.jsp" style="color: #5cb85c; text-decoration: none;">Go to Main Page</a>
</div>

<h2>Employee Operations</h2>

<!-- Button bar with two buttons -->
<div class="button-bar">
    <button onclick="showSection('allBookingsSection')">Show All Bookings</button>
    <button onclick="showSection('walkInSection')">Walk-In Customer</button>
</div>

<!-- SECTION 1: TABLE OF ALL BOOKINGS -->
<div id="allBookingsSection" class="section">
    <h3>All Bookings for All Customers</h3>
    <%
        Connection db = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            Class.forName("org.postgresql.Driver");
            db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");
            st = db.createStatement();

            String sql =
                    "SELECT b.booking_id, b.creation_date, b.start_date, b.end_date, b.room_id, " +
                            "       c.sin, c.firstname, c.lastname " +
                            "FROM booking b " +
                            "JOIN customer c ON b.c_sin = c.sin " +
                            "ORDER BY b.booking_id";

            rs = st.executeQuery(sql);

                out.println("<table>");
                out.println("<tr>");
                out.println("<th>Booking ID</th>");
                out.println("<th>Customer SIN</th>");
                out.println("<th>Customer Name</th>");
                out.println("<th>Creation Date</th>");
                out.println("<th>Start Date</th>");
                out.println("<th>End Date</th>");
                out.println("<th>Room ID</th>");
                out.println("<th>Action</th>");
                out.println("</tr>");

                while (rs.next()) {
                    String bookingId = rs.getString("booking_id");
                    String sin = rs.getString("sin");
                    String fname = rs.getString("firstname");
                    String lname = rs.getString("lastname");
                    String creationDate = rs.getString("creation_date");
                    String startDate = rs.getString("start_date");
                    String endDate = rs.getString("end_date");
                    String roomId = rs.getString("room_id");

                    out.println("<tr>");
                    out.println("<td>" + bookingId + "</td>");
                    out.println("<td>" + sin + "</td>");
                    out.println("<td>" + fname + " " + lname + "</td>");
                    out.println("<td>" + creationDate + "</td>");
                    out.println("<td>" + startDate + "</td>");
                    out.println("<td>" + endDate + "</td>");
                    out.println("<td>" + roomId + "</td>");
                    out.println("<td class='actions'>");
                    out.println("<form method='post' action='convertBookingRenting.jsp' style='display:inline;'>");
                    out.println("<input type='hidden' name='bookingId' value='" + bookingId + "'/>");
                    out.println("<input type='hidden' name='customerSIN' value='" + sin + "'/>");
                    out.println("<input type='hidden' name='startDate' value='" + startDate + "'/>");
                    out.println("<input type='hidden' name='endDate' value='" + endDate + "'/>");
                    out.println("<input type='hidden' name='roomId' value='" + roomId + "'/>");
                    out.println("<button type='submit'>Convert to Renting</button>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                }
                out.println("</table>");

        } catch (Exception e) {
            out.println("<p><strong>Error retrieving bookings:</strong> " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (st != null) try { st.close(); } catch (SQLException ignored) {}
            if (db != null) try { db.close(); } catch (SQLException ignored) {}
        }
    %>
</div>

<!-- SECTION 2: WALK-IN CUSTOMER (DIRECT RENTING) & RECORD PAYMENT -->
<div id="walkInSection" class="section">
    <h3>Walk-In Customer</h3>
    <!-- Direct Renting Form -->
    <div class="form-container">
        <h4>Direct Renting (Register Renting)</h4>
        <form method="post" action="directRenting.jsp">
            <label for="customerId">Customer SIN:</label>
            <input type="text" name="customerId" id="customerId" required>
            <br>

            <label for="roomId">Room ID:</label>
            <input type="text" name="roomId" id="roomId" required>
            <br>

            <label for="startDate">Start Date:</label>
            <input type="date" name="startDate" id="startDate" required>
            <br>

            <label for="endDate">End Date:</label>
            <input type="date" name="endDate" id="endDate" required>
            <br>

            <input type="submit" value="Register Direct Renting">
        </form>
    </div>
    <!-- Record Payment Form -->
    <div class="form-container">
        <h4>Record Customer Payment for Renting</h4>
        <form method="post" action="payment.jsp">
            <label for="rentingId">Renting ID:</label>
            <input type="text" name="rentingId" id="rentingId" required>
            <br>

            <label for="paymentAmount">Payment Amount:</label>
            <input type="text" name="paymentAmount" id="paymentAmount" required>
            <br>

            <input type="submit" value="Record Payment">
        </form>
    </div>
</div>

<script>
    // Optionally, show one section by default on page load.
    showSection('allBookingsSection');
</script>
</body>
</html>
