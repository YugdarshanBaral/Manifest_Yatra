<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login – Manifest Yatra</title>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .switch-link {
      text-align: center;
      font-size: 0.82rem;
      color: var(--muted-light);
      margin-top: 1.2rem;
    }

    .switch-link a {
      color: var(--sky);
      text-decoration: none;
      font-weight: 500;
    }

    .switch-link a:hover {
      color: var(--gold);
    }

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
      color: var(--sky);
    }

    .forgot-link {
      font-size: 0.75rem;
      color: var(--sky);
      text-decoration: none;
      transition: color 0.2s;
    }

    .forgot-link:hover {
      color: var(--gold);
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
      <li><a href="services.jsp">Services</a></li>
      <li><a href="destination.jsp">Destinations</a></li>
      <li><a href="about.jsp">About</a></li>
      <li><a href="process.jsp">Process</a></li>
      <li><a href="contact.jsp">Contact</a></li>
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
    <a href="services.jsp">Services</a>
    <a href="destination.jsp">Destinations</a>
    <a href="about.jsp">About</a>
    <a href="process.jsp">Process</a>
    <a href="contact.jsp">Contact</a>
    <div class="drawer-dropdown">
      <a class="drawer-dropdown-trigger">Account &nbsp;<span class="drawer-arrow"
          style="font-size:0.7rem;transition:transform 0.2s;display:inline-block;">▾</span></a>
      <div class="drawer-sub">
        <a href="registration.jsp"> &nbsp;Sign Up</a>
        <a href="login.jsp"> &nbsp;Login</a>
        <a href="admin.jsp"> &nbsp;Admin Login</a>
      </div>
    </div>
    <a href="contact.jsp" class="drawer-cta">Free Consultation →</a>
  </div>

  <!-- ── Login Page ── -->
  <div class="auth-page">
    <div style="width:100%;max-width:440px;">
      <a href="index.jsp" class="back-link">← Back to Home</a>
      <div class="auth-card">
        <div class="auth-logo">
          <div class="logo-text">Manifest <em>Yatra</em></div>
          <span class="logo-sub">International Education Pvt. Ltd.</span>
        </div>

        <p
          style="font-family:'Cormorant Garamond',serif;font-size:1.6rem;font-weight:300;color:var(--white);margin-bottom:0.4rem;">
          Welcome back</p>
        <p style="font-size:0.82rem;color:var(--muted-light);margin-bottom:1.8rem;">Sign in to your student account.</p>

        <div style="display:flex;flex-direction:column;gap:1.1rem;">
          <div class="form-group">
            <label>Email Address</label>
            <input type="email" placeholder="your@email.com" id="login-email" />
          </div>
          <div class="form-group">
            <label style="display:flex;justify-content:space-between;align-items:center;">
              Password
              <a href="#" class="forgot-link">Forgot password?</a>
            </label>
            <input type="password" placeholder="Your password" id="login-pass" />
          </div>

          <div style="display:flex;align-items:center;gap:0.7rem;">
            <input type="checkbox" id="remember" style="accent-color:var(--sky);width:15px;height:15px;" />
            <label for="remember" style="font-size:0.78rem;color:var(--muted-light);cursor:pointer;">Remember me for 30
              days</label>
          </div>

          <button class="btn-primary" style="width:100%;font-size:0.85rem;padding:1rem;margin-top:0.4rem;"
            onclick="handleLogin(event)">
            Sign In →
          </button>
        </div>

        <div style="margin-top:1.5rem;padding-top:1.5rem;border-top:1px solid rgba(74,158,221,0.12);">
          <p
            style="font-size:0.75rem;color:var(--muted);text-align:center;margin-bottom:1rem;letter-spacing:0.08em;text-transform:uppercase;">
            Are you an administrator?</p>
          <a href="admin.jsp" class="btn-outline"
            style="width:100%;text-align:center;display:block;padding:0.8rem;font-size:0.78rem;">
            🛡️ &nbsp;Administrator Login
          </a>
        </div>

        <p class="switch-link" style="margin-top:1.5rem;">
          Don't have an account? <a href="registration.jsp">Sign up free →</a>
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
    function handleLogin(e) {
      e.preventDefault();
      alert('Login functionality coming soon. Please contact us via Instagram for now.');
    }
  </script>
</body>

</html>