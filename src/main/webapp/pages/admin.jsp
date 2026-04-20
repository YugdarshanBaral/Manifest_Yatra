<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    .back-link:hover {
      color: var(--gold);
    }

    .admin-badge {
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      background: rgba(212, 168, 67, 0.12);
      border: 1px solid rgba(212, 168, 67, 0.3);
      color: var(--gold);
      padding: 0.35rem 0.9rem;
      font-size: 0.68rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      border-radius: 20px;
      font-weight: 600;
      margin-bottom: 1.5rem;
    }

    .security-notice {
      background: rgba(224, 124, 58, 0.08);
      border: 1px solid rgba(224, 124, 58, 0.2);
      border-radius: var(--radius);
      padding: 0.9rem 1rem;
      font-size: 0.78rem;
      color: rgba(224, 124, 58, 0.9);
      line-height: 1.55;
      margin-bottom: 1.5rem;
      display: flex;
      gap: 0.6rem;
      align-items: flex-start;
    }
  </style>
</head>

<body>

  <!-- ── Nav ── -->
  <nav id="mainNav">
    <a href="index.jsp" class="nav-logo">
      <img src="IMG_9914.PNG" class="nav-logo-emblem"></img>
      <span class="nav-logo-text">
        <span class="nav-logo-name">Manifest <em>Yatra</em></span>
        <span class="nav-logo-sub">Intl. Education Pvt. Ltd.</span>
      </span>
    </a>
    <ul class="nav-center">
      <li><a href="index.jsp">Home</a></li>
      <li class="nav-dropdown">
        <a href="#" onclick="return false;">Account <span class="nav-dropdown-icon">▾</span></a>
        <div class="dropdown-menu">
          <a href="registration.jsp"><span class="dm-icon"></span>Sign Up</a>
          <a href="login.jsp"><span class="dm-icon"></span>Login</a>
          <a href="admin.jsp" class="admin-link"><span class="dm-icon"></span>Admin Login</a>
        </div>
      </li>
    </ul>
    <div class="nav-cta-wrap">
      <a href="contact.jsp" class="nav-cta">Free Consultation</a>
    </div>
    <button class="nav-hamburger" id="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
  </nav>
  <div class="nav-drawer" id="navDrawer">
    <a href="index.jsp">Home</a>
    <a href="contact.jsp">Contact</a>
    <div class="drawer-dropdown">
      <a class="drawer-dropdown-trigger">Account &nbsp;<span class="drawer-arrow"
          style="font-size:0.7rem;transition:transform 0.2s;display:inline-block;">▾</span></a>
      <div class="drawer-sub">
        <a href="registration.jsp">✏️ &nbsp;Sign Up</a>
        <a href="login.jsp">🔑 &nbsp;Login</a>
        <a href="admin.jsp">🛡️ &nbsp;Login as Administrator</a>
      </div>
    </div>
    <a href="contact.jsp" class="drawer-cta">Free Consultation →</a>
  </div>

  <!-- ── Admin Login Page ── -->
  <div class="auth-page">
    <div style="width:100%;max-width:420px;">
      <a href="index.jsp" class="back-link">← Back to Home</a>
      <div class="auth-card">
        <!-- Gold top border already from auth-card::before -->

        <div class="auth-logo">
          <div class="logo-text">Manifest <em>Yatra</em></div>
          <span class="logo-sub">International Education Pvt. Ltd.</span>
        </div>

        <div style="text-align:center;margin-bottom:1rem;">
          <span class="admin-badge">🛡️ &nbsp;Administrator Access</span>
        </div>

        <p
          style="font-family:'Cormorant Garamond',serif;font-size:1.55rem;font-weight:300;color:var(--white);margin-bottom:1.5rem;text-align:center;">
          Secure <em>Admin</em> Portal
        </p>

        <div class="security-notice">
          <span>⚠️</span>
          <span>This area is restricted to authorised Manifest Yatra staff only. Unauthorised access attempts are
            logged.</span>
        </div>

        <div style="display:flex;flex-direction:column;gap:1.1rem;">
          <div class="form-group">
            <label>Administrator Email</label>
            <input type="email" placeholder="admin@manifestyatra.com" id="admin-email" />
          </div>
          <div class="form-group">
            <label>Password</label>
            <input type="password" placeholder="Admin password" id="admin-pass" />
          </div>
          <div class="form-group">
            <label>2-Factor Code <span style="color:var(--muted);font-weight:300;font-size:0.65rem;">(if
                enabled)</span></label>
            <input type="text" placeholder="6-digit code" id="admin-2fa" maxlength="6" />
          </div>

          <button class="btn-primary"
            style="width:100%;font-size:0.85rem;padding:1rem;margin-top:0.4rem;background:var(--grad-gold);"
            onclick="handleAdmin(event)">
            🛡️ &nbsp;Access Dashboard →
          </button>
        </div>

        <p style="text-align:center;font-size:0.72rem;color:var(--muted);margin-top:1.5rem;line-height:1.6;">
          Not an admin? <a href="login.html" style="color:var(--sky);">Student login →</a>
        </p>
      </div>
    </div>
  </div>

  <footer>
    <div>
      <div class="footer-logo">Manifest <span>Yatra</span></div>
      <span class="footer-sub">International Education Pvt. Ltd.</span>
    </div>
    <nav class="footer-links">
      <a href="index.jsp">Home</a>
      <a href="contact.jsp">Contact</a>
    </nav>
    <p class="footer-copy">© 2025 Manifest Yatra International Education Pvt. Ltd.</p>
  </footer>

  <script src="main.js"></script>
  <script>
    function handleAdmin(e) {
      e.preventDefault();
      alert('Administrator portal under construction. Please contact the system administrator.');
    }
  </script>
</body>

</html>