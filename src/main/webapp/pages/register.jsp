<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>Sign Up – Manifest Yatra</title>
  <meta name="description" content="Create your Manifest Yatra student account and start your study abroad journey." />

  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

  <style>
    .auth-form {
      display: flex;
      flex-direction: column;
      gap: 1rem;
    }

    .divider {
      display: flex;
      align-items: center;
      gap: 1rem;
      margin: 0.5rem 0;
    }

    .divider span {
      flex: 1;
      height: 1px;
      background: rgba(74, 158, 221, 0.15);
    }

    .divider p {
      font-size: 0.72rem;
      color: var(--muted);
      letter-spacing: 0.1em;
      white-space: nowrap;
    }

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

    .role-select {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 0.6rem;
      margin-bottom: 0.5rem;
    }

    .role-option {
      border: 1px solid rgba(74, 158, 221, 0.2);
      border-radius: var(--radius);
      padding: 0.8rem;
      text-align: center;
      cursor: pointer;
      transition: all 0.2s;
      background: rgba(74, 158, 221, 0.03);
    }

    .role-option:hover {
      border-color: var(--sky);
      background: rgba(74, 158, 221, 0.1);
    }

    .role-option.selected {
      border-color: var(--sky);
      background: rgba(74, 158, 221, 0.15);
    }

    .role-option .role-icon {
      font-size: 1.5rem;
      display: block;
      margin-bottom: 0.3rem;
    }

    .role-option .role-label {
      font-size: 0.75rem;
      color: var(--cream);
      font-weight: 500;
      letter-spacing: 0.06em;
    }

    .password-hint {
      font-size: 0.7rem;
      color: var(--muted);
      margin-top: 0.2rem;
    }

    .strength-bar {
      height: 3px;
      border-radius: 2px;
      background: rgba(255, 255, 255, 0.08);
      margin-top: 0.4rem;
      overflow: hidden;
    }

    .strength-fill {
      height: 100%;
      width: 0%;
      transition: width 0.3s, background 0.3s;
      border-radius: 2px;
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
  </style>
</head>

<body>

  <nav id="mainNav">
    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-logo">
      <img src="${pageContext.request.contextPath}/IMG_9914.PNG" class="nav-logo-emblem">
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
          <a href="${pageContext.request.contextPath}/login"><span class="dm-icon"></span>Login</a>
          <a href="${pageContext.request.contextPath}/admin.jsp" class="admin-link"><span class="dm-icon"></span>Admin Login</a>
        </div>
      </li>
    </ul>

    <div class="nav-cta-wrap">
      <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-cta">Free Consultation</a>
    </div>

    <button class="nav-hamburger" id="hamburger" aria-label="Menu">
      <span></span><span></span><span></span>
    </button>
  </nav>

  <div class="nav-drawer" id="navDrawer">
    <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/services.jsp">Services</a>
    <a href="${pageContext.request.contextPath}/destination.jsp">Destinations</a>
    <a href="${pageContext.request.contextPath}/about.jsp">About</a>
    <a href="${pageContext.request.contextPath}/process.jsp">Process</a>
    <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>

    <div class="drawer-dropdown">
      <a class="drawer-dropdown-trigger">Account &nbsp;<span class="drawer-arrow"
          style="font-size:0.7rem;transition:transform 0.2s;display:inline-block;">▾</span></a>
      <div class="drawer-sub">
        <a href="${pageContext.request.contextPath}/register">✏️ &nbsp;Sign Up</a>
        <a href="${pageContext.request.contextPath}/login">🔑 &nbsp;Login</a>
        <a href="${pageContext.request.contextPath}/admin.jsp">🛡️ &nbsp;Login as Administrator</a>
      </div>
    </div>

    <a href="${pageContext.request.contextPath}/contact.jsp" class="drawer-cta">Free Consultation →</a>
  </div>

  <div class="auth-page">
    <div style="width:100%;max-width:480px;">
      <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">← Back to Home</a>

      <div class="auth-card">
        <div class="auth-logo">
          <div class="logo-text">Manifest <em>Yatra</em></div>
          <span class="logo-sub">International Education Pvt. Ltd.</span>
        </div>

        <p style="font-family:'Cormorant Garamond',serif;font-size:1.6rem;font-weight:300;color:var(--white);margin-bottom:0.4rem;">
          Create your account
        </p>

        <p style="font-size:0.82rem;color:var(--muted-light);margin-bottom:1.8rem;line-height:1.6;">
          Join hundreds of students on their study abroad journey.
        </p>

        <% if (request.getAttribute("error") != null) { %>
          <p style="color:#ff6b6b;font-size:0.82rem;margin-bottom:1rem;">
            <%= request.getAttribute("error") %>
          </p>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">

          <input type="hidden" name="role" id="selectedRole" value="Student">

          <div style="margin-bottom:1.2rem;">
            <label style="font-size:0.68rem;letter-spacing:0.12em;text-transform:uppercase;color:var(--muted-light);display:block;margin-bottom:0.6rem;font-weight:500;">
              I am a
            </label>

            <div class="role-select">
              <div class="role-option selected" onclick="selectRole(this, 'Student')">
                <span class="role-icon">🎓</span>
                <span class="role-label">Student</span>
              </div>

              <div class="role-option" onclick="selectRole(this, 'Parent / Guardian')">
                <span class="role-icon">👨‍👩‍👦</span>
                <span class="role-label">Parent / Guardian</span>
              </div>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>First Name *</label>
              <input type="text" placeholder="First name" name="firstName" required />
            </div>

            <div class="form-group">
              <label>Last Name *</label>
              <input type="text" placeholder="Last name" name="lastName" required />
            </div>
          </div>

          <div class="form-group">
            <label>Email Address *</label>
            <input type="email" placeholder="your@email.com" name="email" required />
          </div>

          <div class="form-group">
            <label>Phone Number</label>
            <input type="tel" placeholder="+977 98XXXXXXXX" name="phone" />
          </div>

          <div class="form-group">
            <label>Password *</label>
            <input type="password" placeholder="Min. 8 characters" name="password"
              id="reg-pass" oninput="checkStrength(this.value)" required />

            <div class="strength-bar">
              <div class="strength-fill" id="strengthFill"></div>
            </div>

            <p class="password-hint" id="strengthLabel">Enter a password</p>
          </div>

          <div class="form-group">
            <label>Confirm Password *</label>
            <input type="password" placeholder="Re-enter password" name="confirmPassword" required />
          </div>

          <div style="display:flex;align-items:flex-start;gap:0.7rem;margin-top:0.3rem;">
            <input type="checkbox" id="terms" name="terms" required
              style="margin-top:3px;accent-color:var(--sky);width:15px;height:15px;flex-shrink:0;" />

            <label for="terms" style="font-size:0.78rem;color:var(--muted-light);line-height:1.55;cursor:pointer;">
              I agree to the <a href="#" style="color:var(--sky);">Terms of Service</a> and
              <a href="#" style="color:var(--sky);">Privacy Policy</a>
            </label>
          </div>

          <button type="submit" class="btn-primary"
            style="width:100%;margin-top:0.6rem;font-size:0.85rem;padding:1rem;">
            Create Account →
          </button>
        </form>

        <div class="divider" style="margin-top:1.5rem;">
          <span></span>
          <p>or</p>
          <span></span>
        </div>

        <p class="switch-link">
          Already have an account?
          <a href="${pageContext.request.contextPath}/login">Sign in →</a>
        </p>
      </div>
    </div>
  </div>

  <footer>
    <div>
      <div class="footer-logo">Manifest <span>Yatra</span></div>
      <span class="footer-sub">International Education Pvt. Ltd.</span>
      <p style="color:var(--muted);font-size:0.8rem;margin-top:0.5rem;">
        Sundarmarga, Ufo Galli–8, Pokhara, Nepal
      </p>
    </div>

    <nav class="footer-links">
      <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
      <a href="${pageContext.request.contextPath}/services.jsp">Services</a>
      <a href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
      <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank">Instagram</a>
    </nav>

    <p class="footer-copy">© 2025 Manifest Yatra International Education Pvt. Ltd.</p>
  </footer>

  <script src="${pageContext.request.contextPath}/main.js"></script>

  <script>
    function selectRole(el, roleValue) {
      document.querySelectorAll('.role-option').forEach(r => r.classList.remove('selected'));
      el.classList.add('selected');
      document.getElementById('selectedRole').value = roleValue;
    }

    function checkStrength(val) {
      const fill = document.getElementById('strengthFill');
      const label = document.getElementById('strengthLabel');

      let score = 0;

      if (val.length >= 8) score++;
      if (/[A-Z]/.test(val)) score++;
      if (/[0-9]/.test(val)) score++;
      if (/[^A-Za-z0-9]/.test(val)) score++;

      const colors = ['#e74c3c', '#e74c3c', '#e07c3a', '#4a9edd', '#2ecc71'];
      const labels = ['Enter a password', 'Weak', 'Fair', 'Good', 'Strong'];
      const pct = [0, 25, 50, 75, 100];

      fill.style.width = pct[score] + '%';
      fill.style.background = colors[score];
      label.textContent = labels[score];
      label.style.color = colors[score];
    }
  </script>

</body>
</html>