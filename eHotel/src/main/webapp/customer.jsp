<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<html>
<head>
    <title>Hotel Rooms</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #333;
        }
        form {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 filters per row */
            gap: 20px;
            align-items: flex-end;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }
        select, input[type="text"],
        input[type="date"] {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            min-width: 150px;
        }

        input[type="submit"] {
            background-color: #5cb85c;
            color: white;
            font-weight: bold;
            padding: 8px 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #4cae4c;
        }



        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<p>
    <a href="index.jsp" style="text-decoration: none; color: #5cb85c;">Go to Main Page</a>
</p>
<h2>Hotel Rooms</h2>

<form method="get" action="">
    <div>
        <label for="areaFilter">Filter by area:</label>
        <select name="areaFilter" id="areaFilter">
            <option value="">Select</option>
            <option value="Downtown">Downtown</option>
            <option value="Uptown">Uptown</option>
            <option value="Suburb">Suburb</option>
        </select>
    </div>

<div>
    <label for="categoryFilter">Category:</label>
    <select name="categoryFilter" id="categoryFilter">
        <option value="">Select</option>
        <option value="ExtremeBudget">ExtremeBudget</option>
        <option value="Budget">Budget</option>
        <option value="Budget+">Budget+</option>
        <option value="ComfortBudget">ComfortBudget</option>
        <option value="Comfort">Comfort</option>
        <option value="ComfortLuxury">Comfort Luxury</option>
        <option value="MidLuxury">MidLuxury</option>
        <option value="Luxury">Luxury</option>
        <option value="Luxury+">Luxury+</option>
        <option value="Luxury++">Luxury++</option>
        <option value="BusinessBudget">BusinessBudget</option>
        <option value="Business">Business</option>
        <option value="BusinessLuxury">BusinessLuxury</option>
        <option value="Eco">Eco</option>
        <option value="Eco+">Eco+</option>
        <option value="SuperEco">SuperEco</option>
    </select>
</div>

<div>
    <label for="capacityFilter">Capacity:</label>
    <select name="capacityFilter" id="capacityFilter">
        <option value="">Select</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
    </select>
</div>

<div>
    <label for="chainFilter">Chain:</label>
    <select name="chainFilter" id="chainFilter">
        <option value="">Select</option>
        <option value="LuxuryStay">LuxuryStay</option>
        <option value="BudgetInn">BudgetInn</option>
        <option value="ComfortHotels">ComfortHotels</option>
        <option value="EcoLodge">EcoLodge</option>
        <option value="BusinessSuites">BusinessSuites</option>
    </select>
</div>

<div>
    <label for="countFilter">Room Count:</label>
    <select name="countFilter" id="countFilter">
        <option value="">Select</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
    </select>
</div>

<div>
    <label for="priceFilter">Max Price:</label>
    <input type="text" id="priceFilter" name="priceFilter" size = 8>
</div>

<div>
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate">
</div>

<div>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate">
</div>

<div>
    <input type="submit" value="Filter">
</div>
</form>

<p>Only click book after setting a date range in the filters.</p>

<p>
    <%
        String areaFilter = request.getParameter("areaFilter");
        String categoryFilter = request.getParameter("categoryFilter");
        String capacityFilter = request.getParameter("capacityFilter");
        String priceFilter = request.getParameter("priceFilter");
        String chainFilter = request.getParameter("chainFilter");
        String countFilter = request.getParameter("countFilter");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");



        String query = "SELECT * FROM rooms r natural join hotels h natural join (select hotel_id, count(*) count from rooms group by hotel_id)";

        String view1 = "select * from available_rooms_by_area";
        String view2 = "select * from rooms_available_h1";


        List<String> conditions = new ArrayList<>();

        if (areaFilter != null && !areaFilter.isEmpty()) {
            conditions.add("area = '" + areaFilter + "'");
        }

        if (categoryFilter != null && !categoryFilter.isEmpty()) {
            conditions.add("category = '" + categoryFilter + "'");
        }

        if (capacityFilter != null && !capacityFilter.isEmpty()) {
            conditions.add("r.capacity = " + capacityFilter.toString());
        }
        if (priceFilter != null && !priceFilter.isEmpty()) {
            conditions.add("r.price <= " + priceFilter.toString());
        }

        if (chainFilter != null && !chainFilter.isEmpty()) {
            conditions.add("chain_name = '" + chainFilter + "'");
        }
        if (countFilter != null && !countFilter.isEmpty()) {
            conditions.add("count = " + countFilter.toString());
        }

        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            conditions.add("room_id NOT IN (SELECT room_id FROM booking WHERE (start_date <= '" + endDate + "' AND end_date >= '" + startDate +  "') ) AND room_id NOT IN (SELECT room_id FROM renting WHERE (start_date <= '" + endDate + "' AND end_date >= '" + startDate +  "') )");
        }

        if (!conditions.isEmpty()) {
            query += " WHERE " + String.join(" AND ", conditions);
            //view1 += " WHERE " + String.join(" AND ", conditions);

        }



        try {
            Class.forName("org.postgresql.Driver");
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");
            Statement st = db.createStatement();
            Statement st2 = db.createStatement();
            Statement st3 = db.createStatement();
            ResultSet rs = st.executeQuery(query);
            ResultSet rs2 = st2.executeQuery(view1);
            ResultSet rs3 = st3.executeQuery(view2);

            out.write("<table><tr><th>Area</th><th>Rooms available</th></tr>");
            while (rs2.next()) {
                out.write("<tr><td>" + rs2.getString(1) + "</td><td>" + rs2.getString(2) + "</td></tr>");
            }
            out.write("</table>");
            rs3.next();
            out.write("<table><tr><th>Total Capacity of a Specific Hotel: </th><th>" + rs3.getString(1) +"</th></tr>");
            out.write("</table>");

            out.write("<table><tr><th>Book Now!</th><th>Hotel ID</th><th>Room Number</th><th>Capacity</th><th>View</th><th>Price</th><th>Chain</th><th>Address</th><th>Stars</th><th>Area</th><th>Category</th></tr>");
            while (rs.next()) {
                out.write("<tr><td>"
                        + "<form action='book.jsp' method='POST' onsubmit='return confirm(\"Are you sure you want to book this room? \")'>"
                        + "<input type='hidden' name='c_sin' value='111111111'>"
                        + "<input type='hidden' name='room_id' value='" + rs.getString(2) + "'>"
                        + "<input type='hidden' name='start_date' value='" + startDate + "'>"
                        + "<input type='hidden' name='end_date' value='" + endDate + "'>"
                        + "<button type='submit'>Book</button>"
                        + "</form>"
                        + "</td><td>"
                        + rs.getString(1) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td><td>" + rs.getString(11) + "</td><td>$" + rs.getString(13) + "</td><td>" + rs.getString(15) + "</td><td>" + rs.getString(16) + "</td><td>" + rs.getString(17) + "</td><td>" + rs.getString(18) + "</td><td>" + rs.getString(19) + "</td></tr>");

            }
            out.write("</table>");





            rs.close();
            st.close();
            // db.close();
        } catch (SQLException exception) {
            out.write("<strong>An exception was thrown: " + exception.getMessage() + "</strong>");
        }
    %>
</p>

</body>
</html>
