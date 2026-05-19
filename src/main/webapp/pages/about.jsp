<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>About Us – Manifest Yatra</title>
  <meta name="description"
    content="Learn why Manifest Yatra is Pokhara's trusted international education consultancy — our story, values, team, and commitment to every student." />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .value-card {
      padding: 2.5rem;
      border: 1px solid rgba(201, 169, 110, 0.12);
      background: rgba(255, 255, 255, 0.02);
      position: relative;
      overflow: hidden;
      transition: border-color 0.3s, background 0.3s;
    }

    .value-card:hover {
      border-color: rgba(201, 169, 110, 0.35);
      background: rgba(201, 169, 110, 0.04);
    }

    .value-card-num {
      font-family: 'Cormorant Garamond', serif;
      font-size: 5rem;
      font-weight: 600;
      color: rgba(201, 169, 110, 0.08);
      line-height: 1;
      position: absolute;
      top: 1rem;
      right: 1.5rem;
    }

    .value-card-icon {
      font-size: 2rem;
      margin-bottom: 1rem;
    }

    .value-card h3 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.4rem;
      font-weight: 600;
      color: var(--cream);
      margin-bottom: 0.7rem;
    }

    .value-card p {
      font-size: 0.9rem;
      color: var(--muted);
      line-height: 1.7;
    }

    .team-card {
      text-align: center;
      padding: 2rem 1.5rem;
      border: 1px solid rgba(201, 169, 110, 0.1);
      background: rgba(255, 255, 255, 0.02);
      transition: all 0.3s;
    }

    .team-card:hover {
      border-color: var(--gold);
      background: rgba(201, 169, 110, 0.04);
    }

    .team-avatar {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      border: 2px solid var(--gold);
      background: linear-gradient(135deg, rgba(42, 77, 143, 0.5), rgba(201, 169, 110, 0.2));
      display: grid;
      place-items: center;
      font-size: 2rem;
      margin: 0 auto 1.2rem;
    }

    .team-card h4 {
      font-size: 1rem;
      font-weight: 500;
      color: var(--cream);
      margin-bottom: 0.3rem;
    }

    .team-card .role {
      font-size: 0.78rem;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: var(--gold);
    }

    .team-card p {
      font-size: 0.85rem;
      color: var(--muted);
      line-height: 1.65;
      margin-top: 0.8rem;
    }

    .timeline {
      display: flex;
      flex-direction: column;
      gap: 0;
      margin-top: 3rem;
    }

    .timeline-item {
      display: flex;
      gap: 2rem;
      padding: 2rem 0;
      border-bottom: 1px solid rgba(201, 169, 110, 0.08);
    }

    .timeline-year {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.8rem;
      font-weight: 600;
      color: var(--gold);
      min-width: 5rem;
      line-height: 1.1;
    }

    .timeline-item h4 {
      font-size: 1rem;
      font-weight: 500;
      color: var(--cream);
      margin-bottom: 0.4rem;
    }

    .timeline-item p {
      font-size: 0.88rem;
      color: var(--muted);
      line-height: 1.65;
    }
  </style>
</head>

<body>

  <!-- ═══════════════════════ NAVIGATION ═══════════════════════ -->
    <nav id="mainNav">
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
      <p class="hero-tag">Why Choose Us</p>
      <h1>About<br><em>Manifest Yatra</em></h1>
      <p>We're a team of passionate education consultants based in Pokhara, dedicated to making every Nepali student's
        dream of studying abroad a reality — with integrity, expertise, and genuine care.</p>
    </div>
  </div>

  <!-- ═══════════════════════ STATS ══════════════════════════════ -->
  <div class="stats-bar">
    <div class="stat">
      <div class="stat-num" data-count="10" data-suffix="+">10+</div>
      <div class="stat-label">Students Placed</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="10" data-suffix="+">10+</div>
      <div class="stat-label">Countries</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="98" data-suffix="%">98%</div>
      <div class="stat-label">Visa Success Rate</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="50" data-suffix="+">50+</div>
      <div class="stat-label">Partner Universities</div>
    </div>
  </div>

  <!-- ═══════════════════════ OUR STORY ════════════════════════ -->
  <section>
    <div class="two-col">
      <div>
        <p class="section-tag reveal">Our Story</p>
        <h2 class="reveal">Born from a<br><em>Student's Struggle</em></h2>
        <p style="color:var(--muted);font-size:1rem;line-height:1.85;margin-bottom:1.5rem;" class="reveal">
          Manifest Yatra was founded with a deeply personal mission: to give every Nepali student the guidance that the
          founders wished they had when they were navigating the complex world of international education.
        </p>
        <p style="color:var(--muted);font-size:1rem;line-height:1.85;margin-bottom:1.5rem;" class="reveal">
          Nestled in the beautiful city of Pokhara — the gateway to the Himalayas — our office on Sundarmarga has become
          a place where thousands of students' dreams have taken their first concrete steps.
        </p>
        <p style="color:var(--muted);font-size:1rem;line-height:1.85;" class="reveal">
          We believe that geography shouldn't limit ambition. A student from Pokhara deserves the same access to
          world-class education as anyone else — and with the right guidance, they can achieve it.
        </p>
      </div>
      <div class="visual-box reveal">
        <div class="visual-box-icon">🏔</div>
        <div style="margin-bottom:0.5rem;">
          <span style="font-size:0.65rem;letter-spacing:0.2em;text-transform:uppercase;color:var(--gold);">Our
            Home</span>
        </div>
        <div class="visual-quote">"From the foothills of the Himalayas to the halls of the world's greatest
          universities."</div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ MISSION & VISION ══════════════════ -->
  <section class="alt">
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:3rem;" class="reveal">
      <div style="padding:3rem;border:1px solid rgba(249,168,38,0.12);background:rgba(60,60,60,0.18);">
        <div style="font-size:2.5rem;margin-bottom:1.2rem;">🎯</div>
        <h3
          style="font-family:'Cormorant Garamond',serif;font-size:1.8rem;font-weight:600;color:var(--cream);margin-bottom:1rem;">
          Our Mission</h3>
        <p style="color:var(--muted);font-size:0.95rem;line-height:1.8;">To empower Nepali students with honest, expert
          guidance and comprehensive support — making quality international education accessible to every ambitious
          young person in Nepal, regardless of their background.</p>
      </div>
      <div style="padding:3rem;border:1px solid rgba(249,168,38,0.12);background:rgba(201,169,110,0.05);">
        <div style="font-size:2.5rem;margin-bottom:1.2rem;">🌟</div>
        <h3
          style="font-family:'Cormorant Garamond',serif;font-size:1.8rem;font-weight:600;color:var(--cream);margin-bottom:1rem;">
          Our Vision</h3>
        <p style="color:var(--muted);font-size:0.95rem;line-height:1.8;">To be Nepal's most trusted international
          education consultancy — known not just for our results, but for the integrity, warmth, and genuine care we
          bring to every student relationship.</p>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ OUR VALUES ═══════════════════════ -->
  <section>
    <p class="section-tag reveal">Our Values</p>
    <h2 class="reveal">What We<br><em>Stand For</em></h2>
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:1.5rem;margin-top:3.5rem;">
      <div class="value-card reveal">
        <div class="value-card-num">01</div>
        <div class="value-card-icon">🤝</div>
        <h3>Integrity First</h3>
        <p>We never recommend a university that isn't genuinely right for the student. Our advice is always honest, even
          when it's not what someone wants to hear.</p>
      </div>
      <div class="value-card reveal">
        <div class="value-card-num">02</div>
        <div class="value-card-icon">💎</div>
        <h3>Excellence</h3>
        <p>We hold ourselves to the highest standards — in the accuracy of our guidance, the quality of our
          documentation, and the outcomes we achieve for students.</p>
      </div>
      <div class="value-card reveal">
        <div class="value-card-num">03</div>
        <div class="value-card-icon">❤️</div>
        <h3>Genuine Care</h3>
        <p>To us, every application isn't just a file — it's a person's future. We treat every student with the same
          attention and care we'd give a family member.</p>
      </div>
      <div class="value-card reveal">
        <div class="value-card-num">04</div>
        <div class="value-card-icon">🌍</div>
        <h3>Accessibility</h3>
        <p>We believe great guidance should be accessible. Our fees are transparent and fair, and we work hard to
          identify scholarships that make international education affordable.</p>
      </div>
      <div class="value-card reveal">
        <div class="value-card-num">05</div>
        <div class="value-card-icon">📈</div>
        <h3>Continuous Learning</h3>
        <p>Visa policies, university rankings, and scholarship opportunities change constantly. Our team actively
          updates its knowledge to give you the most current guidance possible.</p>
      </div>
      <div class="value-card reveal">
        <div class="value-card-num">06</div>
        <div class="value-card-icon">🏘️</div>
        <h3>Community</h3>
        <p>We're proud to be a Pokhara-based institution. We reinvest in local talent and work to strengthen the global
          network of Nepali students abroad.</p>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ WHY CHOOSE US ════════════════════ -->
  <section class="dark">
    <p class="section-tag reveal">Why Choose Us</p>
    <h2 class="reveal">What Sets Us<br><em>Apart</em></h2>
    <div class="why-list reveal" style="max-width:700px;">
      <div class="why-item">
        <div class="why-num">01</div>
        <div>
          <h4>Local Roots, Global Reach</h4>
          <p>Based in Pokhara, we deeply understand the Nepali student journey — the family pressures, the financial
            planning, the cultural adjustment — while maintaining partnerships with universities worldwide.</p>
        </div>
      </div>
      <div class="why-item">
        <div class="why-num">02</div>
        <div>
          <h4>Personalised, Not Templated</h4>
          <p>Every student receives a dedicated counsellor and a tailored roadmap. We never use a copy-paste approach —
            your profile is unique, and your strategy should be too.</p>
        </div>
      </div>
      <div class="why-item">
        <div class="why-num">03</div>
        <div>
          <h4>98% Visa Success Rate</h4>
          <p>Our meticulous attention to documentation and deep knowledge of embassy requirements has resulted in an
            industry-leading 98% student visa success rate.</p>
        </div>
      </div>
      <div class="why-item">
        <div class="why-num">04</div>
        <div>
          <h4>End-to-End Support</h4>
          <p>From the first consultation to the day you land at your destination — and even after — we're with you. We
            don't disappear after collecting our fee.</p>
        </div>
      </div>
      <div class="why-item">
        <div class="why-num">05</div>
        <div>
          <h4>Transparent Fees</h4>
          <p>No hidden costs, no surprise charges. We clearly outline what's included in our service before you commit
            to anything.</p>
        </div>
      </div>
      <div class="why-item">
        <div class="why-num">06</div>
        <div>
          <h4>Strong Alumni Network</h4>
          <p>With 500+ students placed worldwide, we've built a network of Manifest Yatra alumni who share experiences,
            housing tips, and career opportunities with incoming students.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ CTA ════════════════════════════════ -->
  <section
    style="text-align:center;padding:5rem 4rem;background:linear-gradient(135deg,rgba(60,60,60,0.3),rgba(249,168,38,0.06));">
    <p class="section-tag reveal" style="justify-content:center;">Join Our Family</p>
    <h2 class="reveal">Become Part of the<br><em>Manifest Yatra Story</em></h2>
    <p style="color:var(--muted);font-size:1rem;max-width:460px;margin:0 auto 2.5rem;line-height:1.8;" class="reveal">
      Hundreds of students from Pokhara and across Nepal have trusted us with their futures. We'd be honoured to guide
      yours too.</p>
    <div class="reveal" style="display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;">
      <a href="contact.jsp" class="btn-primary">Book Free Consultation</a>
      <a href="process.jsp" class="btn-outline">See How It Works</a>
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