<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Administrator Login – Manifest Yatra</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  
  <style>
    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      color: var(--muted);
      text-decoration: none;
      font-size: 0.78rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      margin-bottom: 2rem;
      transition: color 0.2s;
    }
    .back-link:hover { color: var(--gold); }
    .admin-badge {
      display: inline-block;
      padding: 6px 14px;
      background: rgba(201,162,39,0.1);
      border: 1px solid rgba(201,162,39,0.3);
      border-radius: 20px;
      color: var(--gold);
      font-size: 0.85rem;
      font-weight: 500;
    }
  </style>
</head>

<body>
  <nav id="mainNav">
    <a href="${pageContext.request.contextPath}/pages/index.jsp" class="nav-logo">
      <img src="${pageContext.request.contextPath}/pages/IMG.PNG" class="nav-logo-emblem">
      <span class="nav-logo-text">
        <span class="nav-logo-name">Manifest <em>Yatra</em></span>
        <span class="nav-logo-sub">Intl. Education Pvt. Ltd.</span>
      </span>
    </a>
  </nav>

  <div class="auth-page" style="min-height:100vh;display:flex;align-items:center;justify-content:center;padding:2rem;">
    <div style="width:100%;max-width:420px;">
      <a href="${pageContext.request.contextPath}/pages/index.jsp" class="back-link">← Back to Home</a>

      <div class="auth-card">
        <div class="auth-logo">
          <div class="logo-text">Manifest <em>Yatra</em></div>
          <span class="logo-sub">International Education Pvt. Ltd.</span>
        </div>

        <div style="text-align:center;margin:1.5rem 0;">
          <span class="admin-badge">🛡️ Administrator Access</span>
        </div>

        <p style="font-family:'Cormorant Garamond',serif;font-size:1.55rem;font-weight:300;text-align:center;margin-bottom:1.5rem;">
          Secure <em>Admin</em> Portal
        </p>

        <%-- Error Message Handling --%>
        <% if (request.getAttribute("error") != null) { %>
          <div style="color:#e07070; text-align:center; padding:12px; background:rgba(224,112,112,0.15); border:1px solid rgba(224,112,112,0.2); border-radius:6px; margin-bottom:1.5rem; font-size:0.9rem;">
            <%= request.getAttribute("error") %>
          </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post" 
              style="display:flex;flex-direction:column;gap:1.2rem;">

          <div class="form-group">
            <label>Administrator Email</label>
            <input type="email" name="email" 
                   value="<%= request.getParameter("email") != null ? request.getParameter("email").trim() : "" %>" 
                   placeholder="admin@manifestyatra.com" required />
          </div>

          <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="••••••••" required />
          </div>

          <button type="submit" class="btn-primary" style="width:100%;padding:1rem;margin-top:0.5rem;">
            🛡️ Access Dashboard →
          </button>
        </form>
      </div>
    </div>
  </div>
</body>
</html>