package com.manifest_consultancy.controller.servlets;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        String from    = request.getParameter("from");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                AdminDAO dao = new AdminDAO();
                dao.deleteBooking(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        String contextPath = request.getContextPath();
        if ("enquiries".equals(from)) {
            response.sendRedirect(contextPath + "/pages/AdminDash.jsp?tab=enquiries"); // ← flat path
        } else {
            response.sendRedirect(contextPath + "/pages/bookings.jsp"); // ← flat path
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}