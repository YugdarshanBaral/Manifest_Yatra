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
    .switch-link a:hover { color: var(--gold); }

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
    .back-link:hover { color: var(--sky); }

    .forgot-link {
      color: var(--sky);
      text-decoration: none;
      font-size: 0.76rem;
      transition: color 0.2s ease;
    }
    .forgot-link:hover {
      color: var(--gold);
    }

    /* Forgot Password Modal */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0, 0, 0, 0.75);
      align-items: center;
      justify-content: center;
      z-index: 1000;
    }
    .modal-content {
      background: #0f1626;
      border: 1px solid rgba(201, 169, 110, 0.2);
      border-radius: 12px;
      width: 90%;
      max-width: 420px;
      padding: 2rem;
    }
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5rem;
    }
    .close-modal {
      font-size: 1.8rem;
      color: var(--muted);
      cursor: pointer;
      line-height: 1;
    }
    .close-modal:hover { color: var(--gold); }
  </style>
</head>

<body>

  <!-- NAVIGATION -->
  <nav id="mainNav">
    <!-- ... your existing navigation code (unchanged) ... -->
    <a href="${pageContext.request.contextPath}/pages/index.jsp" class="nav-logo">
      <img src="${pageContext.request.contextPath}/Image/IMG.PNG" class="nav-logo-emblem">
      <span class="nav-logo-text">
        <span class="nav-logo-name">Manifest <em>Yatra</em></span>
        <span class="nav-logo-sub">Intl. Education Pvt. Ltd.</span>
      </span>
    </a>

    <ul class="nav-center">
      <li><a href="${pageContext.request.contextPath}/pages/index.jsp">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/services.jsp">Services</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/destination.jsp">Destinations</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/about.jsp">About</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/process.jsp">Process</a></li>
      <li><a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a></li>

      <li class="nav-dropdown">
        <a href="#" onclick="return false;">Account <span class="nav-dropdown-icon">▾</span></a>
        <div class="dropdown-menu">
          <a href="${pageContext.request.contextPath}/register"><span class="dm-icon"></span>Sign Up</a>
          <a href="${pageContext.request.contextPath}/pages/login.jsp"><span class="dm-icon"></span>Login</a>
          <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="admin-link">
            <span class="dm-icon"></span>Admin Login
          </a>
        </div>
      </li>
    </ul>

    <div class="nav-cta-wrap">
      <a href="${pageContext.request.contextPath}/pages/contact.jsp" class="nav-cta">Free Consultation</a>
    </div>

    <button class="nav-hamburger" id="hamburger" aria-label="Menu">
      <span></span><span></span><span></span>
    </button>
  </nav>

  <!-- LOGIN FORM -->
  <div class="auth-page">
    <div style="width:100%;max-width:440px;">
      <a href="${pageContext.request.contextPath}/pages/index.jsp" class="back-link">← Back to Home</a>

      <div class="auth-card">
        <div class="auth-logo">
          <div class="logo-text">Manifest <em>Yatra</em></div>
          <span class="logo-sub">International Education Pvt. Ltd.</span>
        </div>

        <p style="font-family:'Cormorant Garamond',serif;font-size:1.6rem;font-weight:300;color:var(--white);margin-bottom:0.4rem;">
          Welcome back
        </p>

        <p style="font-size:0.82rem;color:var(--muted-light);margin-bottom:1.8rem;">
          Sign in to your student account.
        </p>

        <% if (request.getParameter("registered") != null) { %>
          <p style="color:lightgreen;font-size:0.82rem;margin-bottom:1rem;">
            Registration successful. Please login.
          </p>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
          <p style="color:#ff6b6b;font-size:0.82rem;margin-bottom:1rem;">
            <%= request.getAttribute("error") %>
          </p>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post"
              style="display:flex;flex-direction:column;gap:1.1rem;">

          <div class="form-group">
            <label>Email Address</label>
            <input type="email" placeholder="your@email.com" name="email" required />
          </div>

          <div class="form-group">
            <label style="display:flex;justify-content:space-between;align-items:center;">
              Password
              <a href="#" onclick="openForgotModal()" class="forgot-link">Forgot password?</a>
            </label>
            <input type="password" placeholder="Your password" name="password" required />
          </div>

          <div style="display:flex;align-items:center;gap:0.7rem;">
            <input type="checkbox" id="remember" name="remember" style="accent-color:var(--sky);width:15px;height:15px;" />
            <label for="remember" style="font-size:0.78rem;color:var(--muted-light);cursor:pointer;">
              Remember me for 30 days
            </label>
          </div>

          <button type="submit" class="btn-primary"
            style="width:100%;font-size:0.85rem;padding:1rem;margin-top:0.4rem;">
            Sign In →
          </button>
        </form>

        <!-- Rest of your content -->
        <div style="margin-top:1.5rem;padding-top:1.5rem;border-top:1px solid rgba(74,158,221,0.12);">
          <p style="font-size:0.75rem;color:var(--muted);text-align:center;margin-bottom:1rem;letter-spacing:0.08em;text-transform:uppercase;">
            Are you an administrator?
          </p>
          <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="btn-outline"
            style="width:100%;text-align:center;display:block;padding:0.8rem;font-size:0.78rem;">
            🛡️ &nbsp;Administrator Login
          </a>
        </div>

        <p class="switch-link" style="margin-top:1.5rem;">
          Don't have an account?
          <a href="${pageContext.request.contextPath}/register">Sign up free →</a>
        </p>
      </div>
    </div>
  </div>

  <!-- Forgot Password Modal -->
  <div id="forgotModal" class="modal">
    <div class="modal-content">
      <div class="modal-header">
        <h3 style="margin:0;color:var(--gold);">Reset Password</h3>
        <span class="close-modal" onclick="closeForgotModal()">×</span>
      </div>
      
      <p style="color:var(--muted-light);margin-bottom:1.5rem;">
        Enter your registered email address and we'll send you a password reset link.
      </p>

      <div class="form-group">
        <label>Email Address</label>
        <input type="email" id="resetEmail" placeholder="your@email.com" style="width:100%;" />
      </div>

      <button onclick="sendResetLink()" class="btn-primary" 
              style="width:100%;margin-top:1rem;">
        Send Reset Link →
      </button>

      <p style="text-align:center;font-size:0.78rem;color:var(--muted);margin-top:1.2rem;">
        Check your spam folder if you don't receive the email.
      </p>
    </div>
  </div>

  <footer>
    <div>
      <div class="footer-logo">Manifest <span>Yatra</span></div>
      <span class="footer-sub">International Education Pvt. Ltd.</span>
    </div>
    <nav class="footer-links">
      <a href="${pageContext.request.contextPath}/pages/index.jsp">Home</a>
      <a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a>
    </nav>
    <p class="footer-copy">© 2025 Manifest Yatra International Education Pvt. Ltd.</p>
  </footer>

  <script src="${pageContext.request.contextPath}/pages/main.js"></script>

  <script>
    // Forgot Password Modal Functions
    function openForgotModal() {
      document.getElementById('forgotModal').style.display = 'flex';
      document.getElementById('resetEmail').focus();
    }

    function closeForgotModal() {
      document.getElementById('forgotModal').style.display = 'none';
    }

    function sendResetLink() {
      const email = document.getElementById('resetEmail').value.trim();
      
      if (!email) {
        alert("Please enter your email address.");
        return;
      }

      // Here you can later connect to backend
      alert("✅ Password reset link has been sent to " + email + " (Demo Mode)");
      closeForgotModal();
      document.getElementById('resetEmail').value = '';
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
      const modal = document.getElementById('forgotModal');
      if (event.target === modal) {
        closeForgotModal();
      }
    }
  </script>

</body>
</html>