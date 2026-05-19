<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>Manifest Yatra – International Education Consultancy, Pokhara</title>
  <meta name="description" content="Manifest Yatra guides Nepali students to world-class universities abroad." />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%
    String bookingStatus = "No Booking";
    String statusColor = "#888888";
    
    if (session.getAttribute("userName") != null) {
        Integer userId = (Integer) session.getAttribute("userId");
        String userEmail = (String) session.getAttribute("userEmail");
        
        AdminDAO dao = new AdminDAO();
        // ✅ FIX: Use the correct method from AdminDAO that fetches the history list
        List<Map<String, String>> history = dao.getUserBookingHistory(userId, userEmail);
        
        // Extract the latest booking status if history records exist
        if (history != null && !history.isEmpty()) {
            Map<String, String> latestBooking = history.get(0); // Index 0 is the newest record due to ORDER BY submitted_at DESC
            bookingStatus = latestBooking.get("status");
        }
        
        if ("Pending".equals(bookingStatus)) {
            statusColor = "#f5a623";
        } else if ("Accepted".equals(bookingStatus) || "Confirmed".equals(bookingStatus)) {
            statusColor = "#6bbf8a";
        } else if ("Rejected".equals(bookingStatus)) {
            statusColor = "#e07070";
        }
    }
%>

  <!-- NAVIGATION -->
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
              <span style="color:<%= statusColor %>; font-size:0.85rem;">(<%= bookingStatus %>)</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout" style="color:#e07070;">
              <span class="dm-icon">🚪</span> Logout
            </a>
          <% } else { %>
            <a href="${pageContext.request.contextPath}/register"><span class="dm-icon"></span>Sign Up</a>
            <a href="${pageContext.request.contextPath}/login"><span class="dm-icon"></span>Login</a>
            <a href="${pageContext.request.contextPath}/pages/admin.jsp" class="admin-link">
              <span class="dm-icon"></span>Admin Login
            </a>
          <% } %>
        </div>
      </li>
    </ul>

    <div class="nav-cta-wrap">
      <% if (session.getAttribute("userName") != null) { %>
        <a href="${pageContext.request.contextPath}/pages/book.jsp" class="nav-cta">
          My Booking <span style="color:<%= statusColor %>;">(<%= bookingStatus %>)</span>
        </a>
      <% } else { %>
        <a href="${pageContext.request.contextPath}/login" class="nav-cta">Free Consultation</a>
      <% } %>
    </div>

    <button class="nav-hamburger" id="hamburger" aria-label="Menu">
      <span></span><span></span><span></span>
    </button>
  </nav>

  <!-- HERO -->
  <section id="hero" style="min-height:100vh;display:grid;place-items:center;position:relative;overflow:hidden;padding:7rem 4rem 4rem;">
    <div style="position:absolute;inset:0;background:radial-gradient(ellipse 80% 60% at 60% 40%,rgba(255,255,255,0.04) 0%,transparent 65%),radial-gradient(ellipse 50% 40% at 20% 80%,rgba(201,162,39,0.10) 0%,transparent 60%),linear-gradient(160deg,var(--bg-dark) 0%,var(--bg) 50%,var(--bg-dark) 100%);"></div>

    <div style="position:relative;z-index:2;max-width:680px;" class="anim-hero">
      <p style="font-size:0.75rem;letter-spacing:0.25em;text-transform:uppercase;color:var(--gold);margin-bottom:1.5rem;">
        International Education Consultancy · Pokhara, Nepal
      </p>

      <h1 style="font-size:clamp(3.2rem,8vw,6.5rem);font-weight:300;line-height:1;">
        Manifest <em style="color:var(--gold);">Your Journey</em>
      </h1>

      <p style="font-size:1rem;color:var(--muted);line-height:1.8;max-width:480px;margin:1.8rem 0 2.8rem;">
        We guide ambitious students from Nepal to world-class universities abroad.
      </p>

      <div style="display:flex;gap:1rem;flex-wrap:wrap;">
        <a href="${pageContext.request.contextPath}/pages/contact.jsp" class="btn-primary">Start Your Journey</a>
        <a href="${pageContext.request.contextPath}/pages/services.jsp" class="btn-outline">Our Services</a>
      </div>
    </div>
  </section>

      <!-- STATS -->
  <div class="stats-bar">
    <div class="stat">
      <div class="stat-num" data-count="50" data-suffix="+">50+</div>
      <div class="stat-label">Students Placed</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="20" data-suffix="+">20+</div>
      <div class="stat-label">Countries</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="98" data-suffix="%">98%</div>
      <div class="stat-label">Visa Success Rate</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="100" data-suffix="+">100+</div>
      <div class="stat-label">Partner Universities</div>
    </div>
  </div>

  <!-- SERVICES PREVIEW -->
  <section class="alt">
    <p class="section-tag reveal">What We Offer</p>
    <h2 class="reveal">Comprehensive <em>Support</em><br>At Every Step</h2>
    <p class="section-intro reveal">From your first dream to your first day on campus — we're with you through it all.</p>

    <div class="cards-grid reveal">
      <div class="card">
        <div class="card-icon">🎓</div>
        <h3>University Counselling</h3>
        <p>Personalised guidance to shortlist universities aligned with your academic profile, career goals, and budget.</p>
      </div>
      <div class="card">
        <div class="card-icon">📋</div>
        <h3>Application Assistance</h3>
        <p>End-to-end support including SOP writing, LOR guidance, resume building, and document verification.</p>
      </div>
      <div class="card">
        <div class="card-icon">🛂</div>
        <h3>Visa Processing</h3>
        <p>Expert visa counselling and documentation support for student visas across the UK, USA, Australia, Canada &amp; more.</p>
      </div>
      <div class="card">
        <div class="card-icon">✈️</div>
        <h3>Pre-Departure Briefing</h3>
        <p>Orientation covering banking, accommodation, culture, and everything you need before you fly.</p>
      </div>
    </div>

    <div style="margin-top:2.5rem;text-align:center;" class="reveal">
      <a href="${pageContext.request.contextPath}/pages/services.jsp" class="btn-outline">View All Services →</a>
    </div>
  </section>

  <!-- DESTINATIONS PREVIEW -->
  <section>
    <p class="section-tag reveal">Study Destinations</p>
    <h2 class="reveal">Your World <em>Awaits</em></h2>
    <p class="section-intro reveal">We connect Nepali students with top institutions across the globe.</p>

    <div class="countries-grid reveal">
      <div class="country-pill"><span class="country-flag">🇦🇺</span><div class="country-name">Australia</div></div>
      <div class="country-pill"><span class="country-flag">🇬🇧</span><div class="country-name">United Kingdom</div></div>
      <div class="country-pill"><span class="country-flag">🇨🇦</span><div class="country-name">Canada</div></div>
      <div class="country-pill"><span class="country-flag">🇺🇸</span><div class="country-name">USA</div></div>
      <div class="country-pill"><span class="country-flag">🇯🇵</span><div class="country-name">Japan</div></div>
      <div class="country-pill"><span class="country-flag">🇩🇪</span><div class="country-name">Germany</div></div>
      <div class="country-pill"><span class="country-flag">🇳🇿</span><div class="country-name">New Zealand</div></div>
      <div class="country-pill"><span class="country-flag">🇰🇷</span><div class="country-name">South Korea</div></div>
    </div>

    <div style="margin-top:2.5rem;text-align:center;" class="reveal">
      <a href="${pageContext.request.contextPath}/pages/destination.jsp" class="btn-outline">Explore All Destinations →</a>
    </div>
  </section>

  <!-- WHY US TEASER -->
  <section class="dark">
    <div class="two-col">
      <div>
        <p class="section-tag reveal">Why Manifest Yatra</p>
        <h2 class="reveal">Built on<br><em>Trust &amp; Results</em></h2>

        <p class="section-intro reveal">
          Founded on a simple belief: every student deserves honest, expert guidance — not just a quick visa stamp.
        </p>

        <div class="why-list reveal">
          <div class="why-item">
            <div class="why-num">01</div>
            <div>
              <h4>Local Roots, Global Reach</h4>
              <p>Based in Pokhara with deep understanding of the Nepali student journey and worldwide university partnerships.</p>
            </div>
          </div>
          <div class="why-item">
            <div class="why-num">02</div>
            <div>
              <h4>Personalised, Not Templated</h4>
              <p>Every student gets a dedicated counsellor and a tailored roadmap — no one-size-fits-all here.</p>
            </div>
          </div>
          <div class="why-item">
            <div class="why-num">03</div>
            <div>
              <h4>Transparent &amp; Ethical</h4>
              <p>We give honest feedback and never recommend a university that isn't right for you.</p>
            </div>
          </div>
        </div>

        <div style="margin-top:2rem;" class="reveal">
          <a href="${pageContext.request.contextPath}/pages/about.jsp" class="btn-outline">Learn More About Us →</a>
        </div>
      </div>

      <div class="visual-box reveal">
        <div class="visual-box-icon">✈</div>
        <div class="visual-quote">"Your journey abroad begins with a single, well-guided step."</div>
      </div>
    </div>
  </section>

  <!-- PROCESS TEASER -->
  <section class="alt">
    <p class="section-tag reveal">How It Works</p>
    <h2 class="reveal">Your Path to<br><em>Studying Abroad</em></h2>

    <div class="process-steps reveal">
      <div class="process-step">
        <div class="step-dot"></div>
        <div class="step-num">01</div>
        <h4>Free Consultation</h4>
        <p>Meet our counsellors to discuss your background, goals, and destination preferences.</p>
      </div>
      <div class="process-step">
        <div class="step-dot"></div>
        <div class="step-num">02</div>
        <h4>Profile Assessment</h4>
        <p>We evaluate your qualifications and shortlist the best-fit universities for you.</p>
      </div>
      <div class="process-step">
        <div class="step-dot"></div>
        <div class="step-num">03</div>
        <h4>Application &amp; Offer</h4>
        <p>We prepare and submit applications and support you through offer letter negotiations.</p>
      </div>
      <div class="process-step">
        <div class="step-dot"></div>
        <div class="step-num">04</div>
        <h4>Visa &amp; Departure</h4>
        <p>Complete visa documentation support followed by a thorough pre-departure orientation.</p>
      </div>
    </div>

    <div style="margin-top:2.5rem;text-align:center;" class="reveal">
      <a href="${pageContext.request.contextPath}/pages/process.jsp" class="btn-outline">See Full Process →</a>
    </div>
  </section>

  <!-- CTA BANNER -->
  <section
    style="text-align:center;padding:5rem 4rem;background:linear-gradient(135deg,rgba(66,70,80,0.35),rgba(201,162,39,0.07));">
    <p class="section-tag reveal" style="justify-content:center;">Ready to Begin?</p>

    <h2 class="reveal" style="max-width:600px;margin:0 auto 1.5rem;">
      Take the First Step<br><em>Towards Your Dream</em>
    </h2>

    <p style="color:var(--muted);font-size:1rem;max-width:480px;margin:0 auto 2.5rem;line-height:1.8;" class="reveal">
      Book a free consultation today and let our expert counsellors chart the best path for your education abroad.
    </p>

    <div class="reveal">
      <% if (session.getAttribute("userName") != null) { %>
        <a href="${pageContext.request.contextPath}/pages/book.jsp" class="btn-primary" style="font-size:0.9rem;padding:1rem 2.5rem;">
          Book Free Consultation
        </a>
      <% } else { %>
        <a href="${pageContext.request.contextPath}/login" class="btn-primary" style="font-size:0.9rem;padding:1rem 2.5rem;">
          Book Free Consultation
        </a>
      <% } %>
    </div>
  </section>

  <!-- FOOTER -->
  <footer>
    <div>
      <div class="footer-logo">Manifest <span>Yatra</span></div>
      <span class="footer-sub">International Education Pvt. Ltd.</span>
      <p style="color:var(--muted);font-size:0.8rem;margin-top:0.5rem;">Sundarmarga, Ufo Galli–8, Pokhara, Nepal</p>
    </div>

    <nav class="footer-links">
      <a href="${pageContext.request.contextPath}/pages/index.jsp">Home</a>
      <a href="${pageContext.request.contextPath}/pages/services.jsp">Services</a>
      <a href="${pageContext.request.contextPath}/pages/destination.jsp">Destinations</a>
      <a href="${pageContext.request.contextPath}/pages/about.jsp">About</a>
      <a href="${pageContext.request.contextPath}/pages/process.jsp">Process</a>
      <a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a>
      <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank">Instagram</a>
    </nav>

    <p class="footer-copy">© 2025 Manifest Yatra International Education Pvt. Ltd.</p>
  </footer>

  <script src="${pageContext.request.contextPath}/pages/main.js"></script>

</body>
</html>
