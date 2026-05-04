package com.manifest_consultancy.Filters;

import com.manifest_consultancy.utilities.SessionUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * AuthFilter — runs before any request to the protected URLs below.
 *
 * If the user is NOT logged in  → redirect to /register (sign-up page)
 * If the user IS logged in      → let the request pass through normally
 *
 * To protect more pages later, just add them to urlPatterns.
 */
@WebFilter(urlPatterns = {
    "/pages/book.jsp"
    // Add more protected pages here when needed, e.g.:
    // "/pages/profile.jsp",
    // "/pages/dashboard.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // nothing to initialise
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  httpReq  = (HttpServletRequest)  request;
        HttpServletResponse httpResp = (HttpServletResponse) response;

        if (SessionUtil.isLoggedIn(httpReq)) {
            // ✅ Logged in — allow the request to continue to book.jsp
            chain.doFilter(request, response);
        } else {
            // ❌ Not logged in — send them to the register page
            httpResp.sendRedirect(httpReq.getContextPath() + "/register");
        }
    }

    @Override
    public void destroy() {
        // nothing to clean up
    }
}