<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Contact Us – Manifest Yatra</title>
  <meta name="description"
    content="Get in touch with Manifest Yatra. Book a free consultation, visit us at Sundarmarga Ufo Galli-8, Pokhara, or reach us on Instagram." />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .map-placeholder {
      width: 100%;
      height: 320px;
      background: linear-gradient(135deg, rgba(42, 77, 143, 0.2), rgba(10, 15, 30, 0.9));
      border: 1px solid rgba(201, 169, 110, 0.15);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 1rem;
      position: relative;
      overflow: hidden;
    }

    .map-placeholder::before {
      content: '';
      position: absolute;
      inset: 0;
      background: repeating-linear-gradient(0deg, transparent, transparent 40px, rgba(201, 169, 110, 0.03) 40px, rgba(201, 169, 110, 0.03) 41px),
        repeating-linear-gradient(90deg, transparent, transparent 40px, rgba(201, 169, 110, 0.03) 40px, rgba(201, 169, 110, 0.03) 41px);
    }

    .map-pin {
      font-size: 3rem;
      z-index: 1;
      animation: float 3s ease-in-out infinite;
    }

    @keyframes float {

      0%,
      100% {
        transform: translateY(0);
      }

      50% {
        transform: translateY(-8px);
      }
    }

    .map-label {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.1rem;
      color: var(--gold);
      z-index: 1;
      text-align: center;
    }

    .map-sublabel {
      font-size: 0.8rem;
      color: var(--muted);
      z-index: 1;
    }

    .map-cta {
      z-index: 1;
      background: rgba(201, 169, 110, 0.12);
      border: 1px solid rgba(201, 169, 110, 0.3);
      color: var(--gold);
      padding: 0.5rem 1.2rem;
      text-decoration: none;
      font-size: 0.78rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      transition: background 0.2s;
    }

    .map-cta:hover {
      background: rgba(201, 169, 110, 0.2);
    }

    .info-box {
      background: rgba(255, 255, 255, 0.03);
      border: 1px solid rgba(201, 169, 110, 0.12);
      padding: 2rem;
    }

    .info-box h3 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.3rem;
      font-weight: 600;
      color: var(--cream);
      margin-bottom: 1.5rem;
      padding-bottom: 0.8rem;
      border-bottom: 1px solid rgba(201, 169, 110, 0.1);
    }

    .info-row {
      display: flex;
      gap: 1rem;
      align-items: flex-start;
      padding: 0.8rem 0;
      border-bottom: 1px solid rgba(255, 255, 255, 0.04);
    }

    .info-row:last-child {
      border-bottom: none;
    }

    .info-icon {
      font-size: 1.1rem;
      min-width: 1.8rem;
      margin-top: 0.1rem;
    }

    .info-row h5 {
      font-size: 0.68rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 0.25rem;
    }

    .info-row p,
    .info-row a {
      font-size: 0.92rem;
      color: rgba(245, 240, 232, 0.85);
      text-decoration: none;
      line-height: 1.6;
    }

    .info-row a:hover {
      color: var(--gold);
    }

    .ig-btn {
      display: flex;
      align-items: center;
      gap: 0.8rem;
      background: linear-gradient(135deg, #833ab4, #fd1d1d, #fcb045);
      color: white;
      text-decoration: none;
      padding: 0.9rem 1.6rem;
      font-size: 0.85rem;
      letter-spacing: 0.06em;
      transition: opacity 0.2s;
      margin-top: 0.5rem;
    }

    .ig-btn:hover {
      opacity: 0.9;
    }
  </style>
</head>

<body>

  <!-- ═══════════════════════ NAVIGATION ═══════════════════════ -->
   <nav id="mainNav">
  <a href="${pageContext.request.contextPath}/pages/index.jsp" class="nav-logo">
    <img src="${pageContext.request.contextPath}/pages/IMG.PNG" class="nav-logo-emblem">
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
      <a href="#" onclick="return false;">
        <% if (session.getAttribute("userName") != null) { %>
          👤 <%= session.getAttribute("userName") %>
        <% } else { %>
          Account
        <% } %>
        <span class="nav-dropdown-icon">▾</span>
      </a>
      <div class="dropdown-menu">
        <% if (session.getAttribute("userName") != null) { %>
          <a href="${pageContext.request.contextPath}/pages/book.jsp">
            <span class="dm-icon">📅</span> My Booking
          </a>
          <a href="${pageContext.request.contextPath}/logout" style="color:#e07070;">
            <span class="dm-icon">🚪</span> Logout
          </a>
        <% } else { %>
          <a href="${pageContext.request.contextPath}/register"><span class="dm-icon"></span>Sign Up</a>
          <a href="${pageContext.request.contextPath}/login"><span class="dm-icon"></span>Login</a>
          <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="admin-link"><span class="dm-icon"></span>Admin Login</a>
        <% } %>
      </div>
    </li>
  </ul>

  <div class="nav-cta-wrap">
    <% if (session.getAttribute("userName") != null) { %>
      <a href="${pageContext.request.contextPath}/pages/book.jsp" class="nav-cta">My Booking</a>
    <% } else { %>
      <a href="${pageContext.request.contextPath}/login" class="nav-cta">Free Consultation</a>
    <% } %>
  </div>

  <button class="nav-hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<div class="nav-drawer" id="navDrawer">
  <a href="${pageContext.request.contextPath}/pages/index.jsp">Home</a>
  <a href="${pageContext.request.contextPath}/pages/services.jsp">Services</a>
  <a href="${pageContext.request.contextPath}/pages/destination.jsp">Destinations</a>
  <a href="${pageContext.request.contextPath}/pages/about.jsp">About</a>
  <a href="${pageContext.request.contextPath}/pages/process.jsp">Process</a>
  <a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a>

  <div class="drawer-dropdown">
    <button class="drawer-dropdown-trigger">
      <% if (session.getAttribute("userName") != null) { %>
        👤 <%= session.getAttribute("userName") %>
      <% } else { %>
        Account
      <% } %>
      <span class="drawer-arrow" style="font-size:0.7rem;transition:transform 0.2s;display:inline-block;">&#9662;</span>
    </button>
    <div class="drawer-sub">
      <% if (session.getAttribute("userName") != null) { %>
        <a href="${pageContext.request.contextPath}/pages/book.jsp">📅 My Booking</a>
        <a href="${pageContext.request.contextPath}/logout" style="color:#e07070;">🚪 Logout</a>
      <% } else { %>
        <a href="${pageContext.request.contextPath}/register">Sign Up</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/pages/admin.jsp">Login as Administrator</a>
      <% } %>
    </div>
  </div>

  <% if (session.getAttribute("userName") != null) { %>
    <a href="${pageContext.request.contextPath}/pages/book.jsp" class="drawer-cta">My Booking &#8594;</a>
  <% } else { %>
    <a href="${pageContext.request.contextPath}/login" class="drawer-cta">Free Consultation &#8594;</a>
  <% } %>
</div>
  <!-- ═══════════════════════ PAGE HERO ═════════════════════════ -->
  <div class="page-hero">
    <div class="page-hero-bg"></div>
    <div class="page-hero-deco"></div>
    <div class="page-hero-content anim-hero">
      <p class="hero-tag">Get In Touch</p>
      <h1>Begin Your<br><em>Yatra Today</em></h1>
      <p>Ready to take the first step? Book a free consultation, drop by our Pokhara office, or reach out on Instagram.
        We'd love to hear from you.</p>
    </div>
  </div>

  <!-- ═══════════════════════ CONTACT MAIN ══════════════════════ -->
  <section class="alt">
    <div class="contact-grid">
      <!-- Left: info -->
      <div>
        <p class="section-tag reveal">Our Details</p>
        <h2 class="reveal">Find <em>Us</em></h2>
        <p class="section-intro reveal" style="margin-bottom:2rem;">We're based in the heart of Pokhara. Walk in, call
          us, or connect on Instagram — our counsellors are ready to help.</p>

        <div class="info-box reveal">
          <h3>📍 Office Information</h3>
          <div class="info-row">
            <div class="info-icon">📍</div>
            <div>
              <h5>Address</h5>
              <p>Sundarmarga, Ufo Galli – 8<br>Pokhara, Gandaki Province, Nepal</p>
            </div>
          </div>
          <div class="info-row">
            <div class="info-icon">🕐</div>
            <div>
              <h5>Office Hours</h5>
              <p>Sunday – Friday: 9:00 AM – 6:00 PM<br>Saturday: 10:00 AM – 3:00 PM</p>
            </div>
          </div>
          <div class="info-row">
            <div class="info-icon">📸</div>
            <div>
              <h5>Instagram</h5>
              <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank">@manifest_yatra_int_edu_</a>
            </div>
          </div>
          <div class="info-row">
            <div class="info-icon">💬</div>
            <div>
              <h5>Best Way to Reach Us</h5>
              <p>Send us a DM on Instagram for the fastest response. We typically reply within a few hours during office
                hours.</p>
            </div>
          </div>
        </div>

        <div style="margin-top:1.5rem;" class="reveal">
          <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank" class="ig-btn">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
              <path
                d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z" />
            </svg>
            Message us on Instagram →
          </a>
        </div>

        <!-- Map placeholder -->
        <div style="margin-top:1.5rem;" class="reveal">
          <div class="map-placeholder">
            <div class="map-pin">📍</div>
            <div class="map-label">Manifest Yatra</div>
            <div class="map-sublabel">Sundarmarga, Ufo Galli–8, Pokhara</div>
            <a href="https://maps.google.com/?q=Pokhara,Nepal" target="_blank" class="map-cta">Open in Google Maps →</a>
          </div>
        </div>
      </div>

      <!-- Right: form -->
      <div>
        <p class="section-tag reveal">Book a Consultation</p>
        <h2 class="reveal">Send Us<br><em>A Message</em></h2>
        <p class="section-intro reveal" style="margin-bottom:2rem;">Fill in the form below and we'll get back to you as
          soon as possible — usually within one business day.</p>

        <div class="contact-form reveal">
          <div class="form-row">
            <div class="form-group">
              <label>Full Name *</label>
              <input type="text" id="fname" placeholder="Your full name" required />
            </div>
            <div class="form-group">
              <label>Phone Number</label>
              <input type="tel" id="fphone" placeholder="+977 98XXXXXXXX" />
            </div>
          </div>
          <div class="form-group">
            <label>Email Address *</label>
            <input type="email" id="femail" placeholder="your@email.com" required />
          </div>
          <div class="form-row">
            <div class="form-group">
              <label>Destination Country</label>
              <select id="fdest">
                <option value="" disabled selected>Select destination</option>
                <option>Australia</option>
                <option>United Kingdom</option>
                <option>Canada</option>
                <option>USA</option>
                <option>Japan</option>
                <option>Germany</option>
                <option>New Zealand</option>
                <option>South Korea</option>
                <option>France</option>
                <option>Ireland</option>
                <option>Netherlands</option>
                <option>Malaysia</option>
                <option>Not decided yet</option>
              </select>
            </div>
            <div class="form-group">
              <label>Level of Study</label>
              <select id="flevel">
                <option value="" disabled selected>Select level</option>
                <option>Foundation / Pathway</option>
                <option>Undergraduate (Bachelor's)</option>
                <option>Postgraduate (Master's)</option>
                <option>PhD / Research</option>
                <option>Diploma / Certificate</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label>Field of Study</label>
            <input type="text" id="ffield" placeholder="e.g. Computer Science, Business, Nursing…" />
          </div>
          <div class="form-group">
            <label>Do you have IELTS / TOEFL / PTE?</label>
            <select id="ftest">
              <option value="" disabled selected>Select</option>
              <option>Yes – IELTS</option>
              <option>Yes – TOEFL</option>
              <option>Yes – PTE</option>
              <option>No, not yet</option>
              <option>Currently preparing</option>
            </select>
          </div>
          <div class="form-group">
            <label>Your Message</label>
            <textarea id="fmsg"
              placeholder="Tell us about your background, goals, and any specific questions you have…"></textarea>
          </div>

          <div style="margin-top:0.5rem;">
            <a id="submitBtn" href="#" class="btn-primary" style="width:100%;text-align:center;display:block;"
              onclick="buildAndSend(event)">
              Send via Instagram →
            </a>
          </div>
          <p style="font-size:0.75rem;color:var(--muted);margin-top:0.8rem;text-align:center;line-height:1.6;">
            Clicking "Send" will open Instagram with your details pre-filled as a message to us. Alternatively, DM us
            directly at
            <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank"
              style="color:var(--gold);">@manifest_yatra_int_edu_</a>
          </p>
        </div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ QUICK LINKS ══════════════════════ -->
  <section style="padding:4rem;text-align:center;">
    <p class="section-tag reveal" style="justify-content:center;">Not Sure Where to Start?</p>
    <h2 class="reveal">Explore More<br><em>About Us</em></h2>
    <div style="display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;margin-top:2.5rem;" class="reveal">
      <a href="services.jsp" class="btn-outline">Our Services</a>
      <a href="destination.jsp" class="btn-outline">Study Destinations</a>
      <a href="process.jsp" class="btn-outline">How It Works</a>
      <a href="about.jsp" class="btn-outline">About Us</a>
    </div>
  </section>

  <!-- ═══════════════════════ FOOTER ════════════════════════════ -->
  <footer>
    <div>
      <div class="footer-logo">Manifest <span>Yatra</span></div>
      <span class="footer-sub">International Education Pvt. Ltd.</span>
      <p style="color:var(--muted);font-size:0.8rem;margin-top:0.5rem;">Sundarmarga, Ufo Galli–8, Pokhara, Nepal</p>
    </div>
    <nav class="footer-links">
      <a href="index.jsp">Home</a>
      <a href="services.jsp">Services</a>
      <a href="destination.jsp">Destinations</a>
      <a href="about.jsp">About</a>
      <a href="process.jsp">Process</a>
      <a href="contact.jsp">Contact</a>
      <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank">Instagram</a>
    </nav>
    <p class="footer-copy">© 2025 Manifest Yatra International Education Pvt. Ltd.</p>
  </footer>

  <script src="main.js"></script>
  <script>
    function buildAndSend(e) {
      e.preventDefault();
      const name = document.getElementById('fname').value || '(not provided)';
      const email = document.getElementById('femail').value || '(not provided)';
      const phone = document.getElementById('fphone').value || '(not provided)';
      const dest = document.getElementById('fdest').value || 'Not decided';
      const level = document.getElementById('flevel').value || 'Not specified';
      const field = document.getElementById('ffield').value || 'Not specified';
      const test = document.getElementById('ftest').value || 'Not answered';
      const msg = document.getElementById('fmsg').value || '';

      const text = encodeURIComponent(
        `Hello Manifest Yatra! I'm enquiring about studying abroad.\n\n` +
        `Name: ${name}\nEmail: ${email}\nPhone: ${phone}\n` +
        `Destination: ${dest}\nLevel: ${level}\nField: ${field}\n` +
        `Language Test: ${test}\n\nMessage: ${msg}`
      );

      window.open(`https://www.instagram.com/manifest_yatra_int_edu_/`, '_blank');
      navigator.clipboard.writeText(decodeURIComponent(text)).catch(() => { });
      alert('Your details have been copied to clipboard! Paste them into the Instagram DM window that just opened.');
    }
  </script>
</body>

</html>