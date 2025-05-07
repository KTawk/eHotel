<%@ page import="java.sql.*" %>
<%
    String bookingId = request.getParameter("bookingId");
    String cSin = request.getParameter("customerSIN");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String roomId = request.getParameter("roomId");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password");

        String sql = "INSERT INTO renting(c_sin, e_sin, room_id, creation_date, start_date, end_date) VALUES (?, 123456789, ?::int, CURRENT_DATE, ?::date, ?::date); DELETE FROM booking WHERE booking_id = ?::int";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, cSin);
        pstmt.setString(2, roomId);
        pstmt.setString(3, startDate);
        pstmt.setString(4, endDate);
        pstmt.setString(5, bookingId);

        pstmt.executeUpdate();

        out.println("converting successful for Room ID: " + roomId);
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage() + "\n");
    } finally {
        // Close resources
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
