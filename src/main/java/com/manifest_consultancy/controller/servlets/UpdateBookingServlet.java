package com.manifest_consultancy.controller.servlets;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateBookingServlet")
public class UpdateBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // 1. Retrieve Parameters
        String idStr = request.getParameter("id");
        String status = request.getParameter("status");

        if (idStr == null || status == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp?error=invalid_params");
            return;
        }

        // 2. Session & Security Check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            return;
        }

        // Retrieve Admin ID (with fallback to ID 1 if not in session)
        Object sAdminId = session.getAttribute("adminId");
        Integer adminId = 1; 
        if (sAdminId != null) {
            adminId = (sAdminId instanceof Integer) ? (Integer) sAdminId : Integer.parseInt(sAdminId.toString());
        }

        try {
            int bookingId = Integer.parseInt(idStr);
            AdminDAO dao = new AdminDAO();
            
            // 3. Update Database
            boolean success = dao.updateBookingStatus(bookingId, status, adminId);

            if (success) {
                System.out.println("✅ Booking #" + bookingId + " updated to " + status);
                response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp?success=updated");
            } else {
                System.out.println("❌ Database Update Failed for ID: " + bookingId);
                response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp?error=db_fail");
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp?error=format");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}