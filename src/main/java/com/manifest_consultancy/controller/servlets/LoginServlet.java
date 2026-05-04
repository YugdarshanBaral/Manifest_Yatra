package com.manifest_consultancy.controller.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.manifest_consultancy.utilities.CookieUtil;
import com.manifest_consultancy.utilities.DbConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // 30 days in seconds for "Remember Me"
    private static final int REMEMBER_ME_MAX_AGE = 30 * 24 * 60 * 60;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        boolean rememberMe = "on".equals(request.getParameter("remember"));

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // ---- Build the session ----
                HttpSession session = request.getSession(true);
                session.setAttribute("userId",    rs.getInt("id"));
                session.setAttribute("userName",  rs.getString("first_name"));
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("role",      rs.getString("role"));

                // ---- Handle Remember Me ----
                if (rememberMe) {
                    CookieUtil.addCookie(response, "rememberEmail", email, REMEMBER_ME_MAX_AGE);
                } else {
                    CookieUtil.deleteCookie(response, "rememberEmail");
                }

                // ---- Redirect to book.jsp ----
                response.sendRedirect(request.getContextPath() + "/pages/book.jsp");

            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Login failed. Please try again.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}