package com.manifest_consultancy.controller.servlets;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditStudentServlet")
public class EditStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            return;
        }

        String redirectUrl = request.getContextPath() + "/pages/AdminDash.jsp?tab=students";

        try {
            int    id          = Integer.parseInt(request.getParameter("id").trim());
            String fullName    = request.getParameter("full_name");
            String email       = request.getParameter("email");
            String phone       = request.getParameter("phone");
            String destination = request.getParameter("destination");
            String status      = request.getParameter("status");

            AdminDAO dao = new AdminDAO();
            boolean success = dao.updateStudent(
                id,
                fullName    != null ? fullName    : "",
                email       != null ? email       : "",
                phone       != null ? phone       : "",
                destination != null ? destination : "",
                status      != null ? status      : "In Progress"
            );

            if (success) {
                session.setAttribute("flashMessage", "Student and booking updated successfully.");
            } else {
                session.setAttribute("flashMessage", "Update failed. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("flashMessage", "Error: " + e.getMessage());
        }

        response.sendRedirect(redirectUrl);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp?tab=students");
    }
}