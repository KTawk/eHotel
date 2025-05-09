package com.ehotel.servlets;


import java.io.IOException;
import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String emailOrUsername = request.getParameter("emailOrUsername");

        String password = request.getParameter("password");
        String hashedPassword = hashPassword(password);

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/e_hotel_system", "postgres", "password"
            );

            String query = "SELECT username, role FROM users WHERE (email = ? OR username = ?) AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, emailOrUsername);
            ps.setString(2, emailOrUsername);
            ps.setString(3, hashedPassword);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userRole", role);

                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("manageCustomers.jsp");
                } else if ("employee".equalsIgnoreCase(role)) {
                    response.sendRedirect("employee.jsp");
                } else {
                    response.sendRedirect("rooms.jsp");
                }
            } else {
                response.getWriter().println("Invalid email or password.");
            }


            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}
