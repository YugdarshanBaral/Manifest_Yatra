package com.manifest_consultancy.utilities;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtil {

    /**
     * Adds a cookie.
     * maxAgeSeconds = -1  → session cookie (deleted when browser closes)
     * maxAgeSeconds =  0  → deletes the cookie
     * maxAgeSeconds > 0   → persists for that many seconds
     */
    public static void addCookie(HttpServletResponse response,
                                  String name, String value, int maxAgeSeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeSeconds);
        cookie.setPath("/");        // visible to the whole app
        cookie.setHttpOnly(true);   // JS cannot read it — protects against XSS
        // cookie.setSecure(true); // uncomment when deploying on HTTPS
        response.addCookie(cookie);
    }

    /** Returns the cookie value by name, or null if not found. */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (name.equals(c.getName())) {
                    return c.getValue();
                }
            }
        }
        return null;
    }

    /** Deletes a cookie by zeroing its max age. */
    public static void deleteCookie(HttpServletResponse response, String name) {
        addCookie(response, name, "", 0);
    }

    /** Returns true if the named cookie exists. */
    public static boolean hasCookie(HttpServletRequest request, String name) {
        return getCookieValue(request, name) != null;
    }
}