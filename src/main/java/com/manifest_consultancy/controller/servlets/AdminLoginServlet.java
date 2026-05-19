package com.manifest_consultancy.controller.servlets;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email != null) email = email.trim();
        if (password != null) password = password.trim();

        AdminDAO dao = new AdminDAO();
        Map<String, Object> admin = dao.getAdminForLogin(email);

        if (admin != null && ((String)admin.get("password")).equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminId", admin.get("id"));
            session.setAttribute("adminEmail", admin.get("email"));
            session.setAttribute("adminName", admin.get("full_name"));
            response.sendRedirect(request.getContextPath() + "/pages/AdminDash.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/pages/admin.jsp").forward(request, response);
        }
    }
}