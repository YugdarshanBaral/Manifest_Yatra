package com.manifest_consultancy.controller.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// Handle GET request (redirect to login page)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
    }

    // Handle POST request (actual login)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = com.manifest_consultancy.utilities.DbConfig.getConnection()) {
            
            String sql = "SELECT * FROM admin_users WHERE email = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminEmail", email);
                session.setAttribute("adminName", rs.getString("full_name"));
                
                response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp");
            } else {
                request.setAttribute("error", "Invalid email or password!");
                request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database connection error!");
            request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
        }
    }
}