<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Study Destinations – Manifest Yatra</title>
  <meta name="description"
    content="Explore top study abroad destinations for Nepali students — Australia, UK, Canada, USA, Japan, Germany, and more. Manifest Yatra, Pokhara." />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .dest-card {
      background: rgba(255, 255, 255, 0.03);
      border: 1px solid rgba(201, 169, 110, 0.12);
      overflow: hidden;
      transition: border-color 0.3s, transform 0.3s;
    }

    .dest-card:hover {
      border-color: var(--gold);
      transform: translateY(-4px);
    }

    .dest-card-header {
      padding: 2rem 2rem 1rem;
      display: flex;
      align-items: center;
      gap: 1rem;
      border-bottom: 1px solid rgba(201, 169, 110, 0.08);
    }

    .dest-flag {
      font-size: 3rem;
      line-height: 1;
    }

    .dest-card-header h3 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.6rem;
      font-weight: 600;
      color: var(--cream);
    }

    .dest-card-header .dest-tag {
      font-size: 0.65rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
      color: var(--gold);
      margin-top: 0.2rem;
    }

    .dest-card-body {
      padding: 1.5rem 2rem 2rem;
    }

    .dest-card-body p {
      font-size: 0.9rem;
      color: var(--muted);
      line-height: 1.7;
      margin-bottom: 1.2rem;
    }

    .dest-highlights {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    .dest-highlight {
      display: flex;
      align-items: center;
      gap: 0.6rem;
      font-size: 0.82rem;
      color: rgba(245, 240, 232, 0.75);
    }

    .dest-highlight::before {
      content: '→';
      color: var(--gold);
      font-size: 0.7rem;
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
      <p class="hero-tag">Study Destinations</p>
      <h1>Your World<br><em>Awaits</em></h1>
      <p>From the vibrant cities of Australia to the historic universities of the UK — we open doors to world-class
        education in 20+ countries across the globe.</p>
    </div>
  </div>

  <!-- ═══════════════════════ STATS ══════════════════════════════ -->
  <div class="stats-bar">
    <div class="stat">
      <div class="stat-num" data-count="10" data-suffix="+">10+</div>
      <div class="stat-label">Countries</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="50" data-suffix="+">50+</div>
      <div class="stat-label">Partner Universities</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="50" data-suffix="+">50+</div>
      <div class="stat-label">Students Placed</div>
    </div>
    <div class="stat">
      <div class="stat-num" data-count="98" data-suffix="%">98%</div>
      <div class="stat-label">Visa Success Rate</div>
    </div>
  </div>

  <!-- ═══════════════════════ TOP DESTINATIONS ══════════════════ -->
  <section class="alt">
    <p class="section-tag reveal">Popular Destinations</p>
    <h2 class="reveal">Top Study<br><em>Destinations</em></h2>
    <p class="section-intro reveal">Our most popular destinations, chosen by Nepali students for quality of education,
      work opportunities, and post-study pathways.</p>

    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(320px,1fr));gap:1.5rem;margin-top:3.5rem;">
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇦🇺</div>
          <div>
            <h3>Australia</h3>
            <div class="dest-tag">Most Popular</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Australia remains the top destination for Nepali students, offering world-class universities, multicultural
            cities, and strong post-study work rights of 2–4 years.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Post-Study Work Visa: 2–4 years</div>
            <div class="dest-highlight">Top universities: Melbourne, ANU, Sydney, UNSW</div>
            <div class="dest-highlight">High scholarship availability</div>
            <div class="dest-highlight">Strong Nepali community</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇬🇧</div>
          <div>
            <h3>United Kingdom</h3>
            <div class="dest-tag">Prestigious</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Home to Oxford, Cambridge, and a prestigious network of Russell Group universities. The UK Graduate Route
            Visa allows 2 years of post-study work (3 for PhDs).</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Graduate Route Visa: 2–3 years</div>
            <div class="dest-highlight">Top universities: Oxford, Cambridge, Imperial, UCL</div>
            <div class="dest-highlight">1-year Master's programs save time &amp; money</div>
            <div class="dest-highlight">Chevening &amp; Commonwealth Scholarships</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇨🇦</div>
          <div>
            <h3>Canada</h3>
            <div class="dest-tag">Immigration Pathway</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Canada is a top choice for students seeking not just education but a future immigration pathway. The
            Post-Graduate Work Permit and Express Entry make PR accessible.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">PGWP: up to 3 years</div>
            <div class="dest-highlight">Top universities: UofT, UBC, McGill, Waterloo</div>
            <div class="dest-highlight">Clear pathway to Permanent Residency</div>
            <div class="dest-highlight">Bilingual (English &amp; French) environment</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇺🇸</div>
          <div>
            <h3>USA</h3>
            <div class="dest-tag">World #1 Universities</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>The United States hosts the most top-ranked universities in the world. OPT and STEM OPT extensions offer
            excellent work opportunities post-graduation.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">OPT: 1–3 years work authorization</div>
            <div class="dest-highlight">Top universities: MIT, Harvard, Stanford, Yale</div>
            <div class="dest-highlight">Enormous scholarship &amp; assistantship funding</div>
            <div class="dest-highlight">Strongest research &amp; STEM ecosystem</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇯🇵</div>
          <div>
            <h3>Japan</h3>
            <div class="dest-tag">Tech &amp; Culture</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Japan offers cutting-edge education in technology and research, generous MEXT scholarships, and a unique
            cultural experience. Nepal-Japan ties are strong.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">MEXT Government Scholarships available</div>
            <div class="dest-highlight">Top universities: Tokyo, Kyoto, Osaka</div>
            <div class="dest-highlight">Part-time work: 28 hrs/week during studies</div>
            <div class="dest-highlight">Low tuition at national universities</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇩🇪</div>
          <div>
            <h3>Germany</h3>
            <div class="dest-tag">Tuition-Free</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Germany is famous for tuition-free public universities for international students, world-class engineering
            programs, and a booming job market post-graduation.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Free tuition at public universities</div>
            <div class="dest-highlight">Top universities: TU Munich, Heidelberg, LMU</div>
            <div class="dest-highlight">18-month job-seeker visa after graduation</div>
            <div class="dest-highlight">Strong STEM &amp; engineering programs</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇳🇿</div>
          <div>
            <h3>New Zealand</h3>
            <div class="dest-tag">Quality of Life</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>New Zealand offers an outstanding quality of life, safe campuses, and generous post-study work rights — a
            growing favourite among Nepali students.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Post-Study Work Visa: up to 3 years</div>
            <div class="dest-highlight">Top universities: Auckland, Victoria, Canterbury</div>
            <div class="dest-highlight">Safe, peaceful study environment</div>
            <div class="dest-highlight">Part-time work: 20 hrs/week during studies</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇰🇷</div>
          <div>
            <h3>South Korea</h3>
            <div class="dest-tag">Emerging Hub</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>South Korea is rapidly emerging as a leading education destination, offering GKS scholarships, high-tech
            campuses, and strong ties with global corporations.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">GKS (KGSP) Full Scholarships available</div>
            <div class="dest-highlight">Top universities: Seoul National, KAIST, Yonsei</div>
            <div class="dest-highlight">Growing K-culture &amp; language programs</div>
            <div class="dest-highlight">Strong tech industry partnerships</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇫🇷</div>
          <div>
            <h3>France</h3>
            <div class="dest-tag">Arts &amp; Business</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>France is a hub for arts, fashion, culinary studies, and business — with affordable tuition at public
            universities and world-renowned Grandes Écoles.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Low tuition at public universities</div>
            <div class="dest-highlight">Eiffel Excellence Scholarships</div>
            <div class="dest-highlight">Top schools: Sciences Po, HEC, INSEAD</div>
            <div class="dest-highlight">Vibrant cultural &amp; intellectual environment</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇮🇪</div>
          <div>
            <h3>Ireland</h3>
            <div class="dest-tag">EU Access</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Ireland is an English-speaking EU nation with a booming tech economy, home to European HQs of Google, Meta,
            and Apple — making it ideal for tech and business graduates.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Stay-Back Visa: 1–2 years</div>
            <div class="dest-highlight">Top universities: Trinity Dublin, UCD, NUI Galway</div>
            <div class="dest-highlight">Tech sector hub (EU Silicon Valley)</div>
            <div class="dest-highlight">English-medium instruction throughout</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇳🇱</div>
          <div>
            <h3>Netherlands</h3>
            <div class="dest-tag">Innovation</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>The Netherlands offers hundreds of English-taught programs, a multicultural environment, and a thriving
            startup ecosystem, all at competitive tuition rates.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Orientation Year Visa post-graduation</div>
            <div class="dest-highlight">Top universities: TU Delft, Leiden, Amsterdam</div>
            <div class="dest-highlight">Hundreds of English-taught programs</div>
            <div class="dest-highlight">Holland Scholarship for non-EEA students</div>
          </div>
        </div>
      </div>
      <div class="dest-card reveal">
        <div class="dest-card-header">
          <div class="dest-flag">🇲🇾</div>
          <div>
            <h3>Malaysia</h3>
            <div class="dest-tag">Affordable</div>
          </div>
        </div>
        <div class="dest-card-body">
          <p>Malaysia offers internationally recognised degrees at a fraction of Western tuition costs, with a warm
            climate, diverse culture, and proximity to Nepal.</p>
          <div class="dest-highlights">
            <div class="dest-highlight">Low cost of living &amp; tuition</div>
            <div class="dest-highlight">Top universities: UM, UPM, UTM, Monash Malaysia</div>
            <div class="dest-highlight">English-medium instruction</div>
            <div class="dest-highlight">Gateway to ASEAN job market</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ CTA ════════════════════════════════ -->
  <section
    style="text-align:center;padding:5rem 4rem;background:linear-gradient(135deg,rgba(60,60,60,0.35),rgba(249,168,38,0.07));">
    <p class="section-tag reveal" style="justify-content:center;">Not Sure Where to Go?</p>
    <h2 class="reveal">We'll Help You<br><em>Choose the Right Destination</em></h2>
    <p style="color:var(--muted);font-size:1rem;max-width:480px;margin:0 auto 2.5rem;line-height:1.8;" class="reveal">
      Every student is different. Our counsellors will help you find the country and university that best fits your
      goals, budget, and career aspirations.</p>
    <div class="reveal" style="display:flex;gap:1rem;justify-content:center;flex-wrap:wrap;">
      <a href="contact.jsp" class="btn-primary">Book Free Consultation</a>
      <a href="services.jsp" class="btn-outline">View Our Services</a>
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