package com.manifest_consultancy.controller.servlets;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {

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
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                AdminDAO dao = new AdminDAO();
                dao.deleteStudent(id);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp?tab=students"); // ← flat path
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}