<%@ page import="java.sql.*" %>
<%
    String cSin = request.getParameter("c_sin");
    String roomId = request.getParameter("room_id");
    //String creationDate = request.getParameter("creation_date");
    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_systemc", "postgres", "password");

        String sql = "INSERT INTO booking(c_sin, room_id, creation_date, start_date, end_date) VALUES (?, ?::int, CURRENT_DATE, ?::date, ?::date)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, cSin);
        pstmt.setString(2, roomId);
        pstmt.setString(3, startDate);
        pstmt.setString(4, endDate);
        pstmt.executeUpdate();

        out.println("Booking successful for Room ID: " + roomId);
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage() + "\n");
    } finally {
        // Close resources
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
