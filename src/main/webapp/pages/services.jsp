<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Our Services – Manifest Yatra</title>
  <meta name="description"
    content="Explore the full range of study abroad services at Manifest Yatra — from university counselling and applications to visa support and pre-departure briefings." />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
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
      <p class="hero-tag">What We Offer</p>
      <h1>Our <em>Services</em></h1>
      <p>Comprehensive, personalised support at every stage of your study abroad journey — from your first enquiry to
        your first day on campus.</p>
    </div>
  </div>

  <!-- ═══════════════════════ CORE SERVICES ═════════════════════ -->
  <section class="alt">
    <p class="section-tag reveal">Core Services</p>
    <h2 class="reveal">Everything You Need<br><em>In One Place</em></h2>
    <p class="section-intro reveal">We've built our service portfolio around the real challenges Nepali students face
      when pursuing education abroad.</p>

    <div class="cards-grid reveal" style="margin-top:3.5rem;">
      <div class="card">
        <div class="card-icon">🎓</div>
        <h3>University Counselling</h3>
        <p>Our counsellors evaluate your academic profile, career aspirations, and financial situation to identify the
          ideal universities and programs. We maintain an up-to-date database of 100+ partner institutions across 20+
          countries.</p>
      </div>
      <div class="card">
        <div class="card-icon">📋</div>
        <h3>Application Assistance</h3>
        <p>We manage your entire application — crafting compelling Statements of Purpose (SOPs), guiding Letter of
          Recommendation (LOR) requests, building an impressive resume, and ensuring all documents meet each
          university's exact requirements.</p>
      </div>
      <div class="card">
        <div class="card-icon">🛂</div>
        <h3>Visa Processing</h3>
        <p>Our visa specialists have an industry-leading 98% success rate. We guide you through student visa
          applications for the UK, USA, Australia, Canada, Japan, Germany, and beyond — preparing every document
          correctly, the first time.</p>
      </div>
      <div class="card">
        <div class="card-icon">🗣️</div>
        <h3>Test Preparation Guidance</h3>
        <p>We advise on IELTS, TOEFL, PTE, SAT, GRE, and GMAT requirements and connect you with trusted coaching
          partners in Pokhara to help you achieve competitive scores.</p>
      </div>
      <div class="card">
        <div class="card-icon">💰</div>
        <h3>Scholarship &amp; Financial Aid</h3>
        <p>Studying abroad doesn't have to break the bank. We identify scholarship opportunities, government grants, and
          university financial aid programs, and help you build a strong scholarship application.</p>
      </div>
      <div class="card">
        <div class="card-icon">✈️</div>
        <h3>Pre-Departure Briefing</h3>
        <p>Before you leave Nepal, we hold a comprehensive orientation covering accommodation, banking, health
          insurance, cultural adaptation, student rights, and what to expect in your first weeks abroad.</p>
      </div>
      <div class="card">
        <div class="card-icon">🏠</div>
        <h3>Accommodation Support</h3>
        <p>We help you find safe, affordable student housing — whether on-campus dormitories or vetted off-campus
          accommodation — so you arrive knowing exactly where home will be.</p>
      </div>
      <div class="card">
        <div class="card-icon">📝</div>
        <h3>Document Verification</h3>
        <p>We review and prepare every document — transcripts, certificates, financial statements — ensuring they meet
          embassy and university standards to prevent rejections.</p>
      </div>
      <div class="card">
        <div class="card-icon">🔄</div>
        <h3>Post-Arrival Support</h3>
        <p>Our care doesn't end when you board the plane. We stay in touch during your transition, connecting you with
          alumni networks and helping resolve any early challenges.</p>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ SPECIALISMS ═══════════════════════ -->
  <section>
    <p class="section-tag reveal">Our Specialisms</p>
    <h2 class="reveal">Fields We<br><em>Excel In</em></h2>
    <p class="section-intro reveal">We have placed students in a wide range of disciplines at world-leading
      institutions.</p>

    <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:1rem;margin-top:3rem;"
      class="reveal">
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">💻</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Computer Science &amp; IT</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">💼</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Business &amp; MBA</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">⚕️</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Healthcare &amp; Medicine</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">⚙️</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Engineering</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">🎨</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Arts &amp; Design</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">⚖️</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Law</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">🌿</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Agriculture &amp; Environment</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">🔬</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Science &amp; Research</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">🏨</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Hospitality &amp; Tourism</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">📐</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Architecture</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">📡</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Media &amp; Communications</div>
      </div>
      <div style="border:1px solid rgba(201,162,39,0.12);padding:1.5rem;text-align:center;transition:all 0.25s;"
        onmouseover="this.style.borderColor='var(--gold)'" onmouseout="this.style.borderColor='rgba(201,162,39,0.12)'">
        <div style="font-size:1.8rem;margin-bottom:0.6rem;">🧠</div>
        <div style="font-size:0.9rem;color:var(--cream);font-weight:500;">Psychology &amp; Social Work</div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ CTA ════════════════════════════════ -->
  <section class="dark" style="text-align:center;">
    <p class="section-tag reveal" style="justify-content:center;">Get Started</p>
    <h2 class="reveal">Ready to Explore<br><em>Your Options?</em></h2>
    <p style="color:var(--muted);font-size:1rem;max-width:460px;margin:0 auto 2.5rem;line-height:1.8;" class="reveal">
      Book a free, no-obligation consultation with one of our expert counsellors today.</p>
    <div class="reveal">
      <a href="contact.jsp" class="btn-primary">Book Free Consultation</a>
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
</body>

</html>