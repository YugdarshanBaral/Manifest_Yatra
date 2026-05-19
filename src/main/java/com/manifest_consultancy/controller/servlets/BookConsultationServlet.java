package com.manifest_consultancy.controller.servlets;

import com.manifest_consultancy.utilities.DbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/BookConsultationServlet")
public class BookConsultationServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        // CRITICAL: Get the logged-in user's ID
        Integer userId = (Integer) session.getAttribute("userId");
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String destination = request.getParameter("destination");
        String level = request.getParameter("level");
        String field = request.getParameter("field");
        String message = request.getParameter("message");

        // Use 'booking_type' and 'user_account_id' to match your DB schema
        String sql = "INSERT INTO enquiries (user_account_id, name, email, phone, destination, study_level, field_of_study, message, booking_type, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Consultation', 'Pending')";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (userId != null) {
                ps.setInt(1, userId);
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, destination);
            ps.setString(6, level);
            ps.setString(7, field);
            ps.setString(8, message);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.getWriter().write("Success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}