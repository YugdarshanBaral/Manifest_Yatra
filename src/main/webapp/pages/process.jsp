<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>How It Works – Manifest Yatra</title>
  <meta name="description"
    content="Discover the step-by-step process at Manifest Yatra — from your first free consultation to your pre-departure briefing and beyond." />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    /* Big step cards */
    .big-step {
      display: grid;
      grid-template-columns: 140px 1fr;
      gap: 3rem;
      padding: 3.5rem 0;
      border-bottom: 1px solid rgba(201, 169, 110, 0.1);
      align-items: start;
    }

    .big-step:last-child {
      border-bottom: none;
    }

    .big-step-left {
      text-align: right;
      padding-top: 0.3rem;
    }

    .big-step-num {
      font-family: 'Cormorant Garamond', serif;
      font-size: 5.5rem;
      font-weight: 600;
      color: rgba(201, 169, 110, 0.18);
      line-height: 1;
      display: block;
    }

    .big-step-icon {
      font-size: 2.2rem;
      display: block;
      margin-top: 0.5rem;
    }

    .big-step-right h3 {
      font-family: 'Cormorant Garamond', serif;
      font-size: 2rem;
      font-weight: 600;
      color: var(--cream);
      margin-bottom: 0.8rem;
      line-height: 1.1;
    }

    .big-step-right h3 em {
      font-style: italic;
      color: var(--gold);
    }

    .big-step-right p {
      font-size: 0.95rem;
      color: var(--muted);
      line-height: 1.8;
      max-width: 560px;
      margin-bottom: 1.5rem;
    }

    .step-detail-list {
      display: flex;
      flex-direction: column;
      gap: 0.6rem;
    }

    .step-detail {
      display: flex;
      align-items: center;
      gap: 0.8rem;
      font-size: 0.88rem;
      color: rgba(245, 240, 232, 0.8);
    }

    .step-detail::before {
      content: '✓';
      color: var(--gold);
      font-size: 0.75rem;
      min-width: 1rem;
      font-weight: 600;
    }

    .step-connector {
      display: flex;
      align-items: center;
      justify-content: flex-start;
      padding: 0 0 0 140px;
      gap: 0.5rem;
      color: var(--gold);
      font-size: 0.72rem;
      letter-spacing: 0.15em;
      text-transform: uppercase;
    }

    .step-connector::before {
      content: '↓';
      font-size: 1.2rem;
    }

    /* Timeline visual */
    .timeline-visual {
      display: flex;
      gap: 0;
      margin: 3.5rem 0;
      overflow-x: auto;
      padding-bottom: 1rem;
    }

    .tl-step {
      flex: 1;
      min-width: 150px;
      display: flex;
      flex-direction: column;
      align-items: center;
      position: relative;
    }

    .tl-step:not(:last-child)::after {
      content: '';
      position: absolute;
      top: 20px;
      left: 50%;
      width: 100%;
      height: 1px;
      background: linear-gradient(90deg, var(--gold), rgba(201, 169, 110, 0.2));
      z-index: 0;
    }

    .tl-dot {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      border: 2px solid var(--gold);
      background: var(--deep);
      z-index: 1;
      display: grid;
      place-items: center;
      font-size: 0.8rem;
      font-family: 'Cormorant Garamond', serif;
      font-weight: 600;
      color: var(--gold);
    }

    .tl-label {
      font-size: 0.72rem;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: var(--muted);
      margin-top: 0.8rem;
      text-align: center;
      line-height: 1.4;
    }

    /* FAQ */
    .faq-item {
      border-bottom: 1px solid rgba(201, 169, 110, 0.1);
    }

    .faq-question {
      width: 100%;
      background: none;
      border: none;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1.4rem 0;
      cursor: pointer;
      font-family: 'DM Sans', sans-serif;
      font-size: 1rem;
      font-weight: 400;
      color: var(--cream);
      text-align: left;
      gap: 1rem;
    }

    .faq-question:hover {
      color: var(--gold);
    }

    .faq-icon {
      font-size: 1.2rem;
      color: var(--gold);
      transition: transform 0.3s;
      flex-shrink: 0;
    }

    .faq-item.open .faq-icon {
      transform: rotate(45deg);
    }

    .faq-answer {
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.4s ease, padding 0.3s;
    }

    .faq-item.open .faq-answer {
      max-height: 300px;
      padding-bottom: 1.4rem;
    }

    .faq-answer p {
      font-size: 0.9rem;
      color: var(--muted);
      line-height: 1.8;
    }

    @media (max-width: 600px) {
      .big-step {
        grid-template-columns: 1fr;
        gap: 1rem;
      }

      .big-step-left {
        text-align: left;
      }

      .step-connector {
        padding: 0;
      }
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
      <p class="hero-tag">How It Works</p>
      <h1>Your Path to<br><em>Studying Abroad</em></h1>
      <p>A clear, structured, and supportive process — from your very first conversation with us to the day you
        confidently step onto your international campus.</p>
    </div>
  </div>

  <!-- ═══════════════════════ TIMELINE OVERVIEW ════════════════ -->
  <section class="alt">
    <p class="section-tag reveal">At a Glance</p>
    <h2 class="reveal">Your Journey<br><em>In 7 Steps</em></h2>

    <div class="timeline-visual reveal">
      <div class="tl-step">
        <div class="tl-dot">01</div>
        <div class="tl-label">Free<br>Consultation</div>
      </div>
      <div class="tl-step">
        <div class="tl-dot">02</div>
        <div class="tl-label">Profile<br>Assessment</div>
      </div>
      <div class="tl-step">
        <div class="tl-dot">03</div>
        <div class="tl-label">University<br>Shortlisting</div>
      </div>
      <div class="tl-step">
        <div class="tl-dot">04</div>
        <div class="tl-label">Application<br>&amp; Offer</div>
      </div>
      <div class="tl-step">
        <div class="tl-dot">05</div>
        <div class="tl-label">Scholarship<br>&amp; Finance</div>
      </div>
      <div class="tl-step">
        <div class="tl-dot">06</div>
        <div class="tl-label">Visa<br>Processing</div>
      </div>
      <div class="tl-step">
        <div class="tl-dot">07</div>
        <div class="tl-label">Pre-Departure<br>&amp; Fly ✈</div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ DETAILED STEPS ═══════════════════ -->
  <section>
    <p class="section-tag reveal">Detailed Breakdown</p>
    <h2 class="reveal">Every Step<br><em>Explained</em></h2>

    <div style="margin-top:3.5rem;">

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">01</span>
          <span class="big-step-icon">💬</span>
        </div>
        <div class="big-step-right">
          <h3>Free <em>Consultation</em></h3>
          <p>Your journey starts with a no-cost, no-obligation conversation with one of our expert counsellors. We
            listen — really listen — to understand your academic background, career dreams, family situation, and
            financial considerations.</p>
          <div class="step-detail-list">
            <div class="step-detail">Walk-in, phone, or online appointment available</div>
            <div class="step-detail">No fees charged at this stage</div>
            <div class="step-detail">Discuss preferred countries and fields of study</div>
            <div class="step-detail">Initial assessment of eligibility and realistic options</div>
          </div>
        </div>
      </div>

      <div class="step-connector reveal">Then we move to</div>

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">02</span>
          <span class="big-step-icon">📊</span>
        </div>
        <div class="big-step-right">
          <h3>Profile <em>Assessment</em></h3>
          <p>We conduct a thorough evaluation of your academic transcripts, English proficiency scores, financial
            capacity, and career goals. This forms the foundation of your personalised study-abroad strategy.</p>
          <div class="step-detail-list">
            <div class="step-detail">Academic transcript and GPA review</div>
            <div class="step-detail">IELTS / TOEFL / PTE score assessment</div>
            <div class="step-detail">Extracurricular and work experience review</div>
            <div class="step-detail">Financial capacity and scholarship need evaluation</div>
          </div>
        </div>
      </div>

      <div class="step-connector reveal">Then we move to</div>

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">03</span>
          <span class="big-step-icon">🔍</span>
        </div>
        <div class="big-step-right">
          <h3>University <em>Shortlisting</em></h3>
          <p>Based on your profile, we create a balanced list of 5–8 universities — ambitious reaches, well-matched
            targets, and safe options — across your chosen countries, ensuring you have realistic and exciting choices.
          </p>
          <div class="step-detail-list">
            <div class="step-detail">Personalised list of 5–8 universities</div>
            <div class="step-detail">Mix of reach, target, and safe schools</div>
            <div class="step-detail">Detailed comparison of tuition, scholarships, and rankings</div>
            <div class="step-detail">Program-specific advice for your chosen field</div>
          </div>
        </div>
      </div>

      <div class="step-connector reveal">Then we move to</div>

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">04</span>
          <span class="big-step-icon">📝</span>
        </div>
        <div class="big-step-right">
          <h3>Application &amp;<br><em>Offer Letter</em></h3>
          <p>Our team takes charge of the entire application process — crafting a compelling Statement of Purpose (SOP),
            guiding your Letter of Recommendation writers, polishing your resume/CV, and submitting everything on time.
          </p>
          <div class="step-detail-list">
            <div class="step-detail">Statement of Purpose (SOP) writing and editing</div>
            <div class="step-detail">Resume / CV building and optimisation</div>
            <div class="step-detail">Letter of Recommendation (LOR) guidance</div>
            <div class="step-detail">Document notarisation and verification assistance</div>
            <div class="step-detail">Application submission and tracking</div>
            <div class="step-detail">Offer letter review and negotiation support</div>
          </div>
        </div>
      </div>

      <div class="step-connector reveal">Then we move to</div>

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">05</span>
          <span class="big-step-icon">💰</span>
        </div>
        <div class="big-step-right">
          <h3>Scholarship &amp;<br><em>Financial Planning</em></h3>
          <p>Once offer letters arrive, we help you compare them, identify scholarship opportunities, and plan your
            finances — including bank statements, loan guidance, and sponsorship documentation.</p>
          <div class="step-detail-list">
            <div class="step-detail">Scholarship identification and application</div>
            <div class="step-detail">University financial aid negotiation</div>
            <div class="step-detail">Bank balance and financial documentation guidance</div>
            <div class="step-detail">Education loan referrals (if needed)</div>
          </div>
        </div>
      </div>

      <div class="step-connector reveal">Then we move to</div>

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">06</span>
          <span class="big-step-icon">🛂</span>
        </div>
        <div class="big-step-right">
          <h3>Visa <em>Processing</em></h3>
          <p>Our visa specialists guide you through every form, every document, and every step of the student visa
            application — the most critical phase of your journey. Our 98% success rate speaks for itself.</p>
          <div class="step-detail-list">
            <div class="step-detail">Complete visa documentation checklist</div>
            <div class="step-detail">Visa application form preparation</div>
            <div class="step-detail">Mock visa interview preparation (UK, USA, Canada)</div>
            <div class="step-detail">Biometric appointment scheduling support</div>
            <div class="step-detail">Tracking and follow-up until decision</div>
          </div>
        </div>
      </div>

      <div class="step-connector reveal">Then we move to</div>

      <div class="big-step reveal">
        <div class="big-step-left">
          <span class="big-step-num">07</span>
          <span class="big-step-icon">✈️</span>
        </div>
        <div class="big-step-right">
          <h3>Pre-Departure<br><em>&amp; Beyond</em></h3>
          <p>Before you fly, we hold a comprehensive orientation covering everything you need to land confidently and
            settle in quickly. And our support doesn't end when your flight takes off.</p>
          <div class="step-detail-list">
            <div class="step-detail">Pre-departure orientation session</div>
            <div class="step-detail">Accommodation and bank account guidance</div>
            <div class="step-detail">Health insurance and cultural briefing</div>
            <div class="step-detail">Introduction to alumni network at your destination</div>
            <div class="step-detail">Post-arrival check-in and ongoing support</div>
          </div>
        </div>
      </div>

    </div>
  </section>

  <!-- ═══════════════════════ FAQ ═══════════════════════════════ -->
  <section class="alt">
    <p class="section-tag reveal">Common Questions</p>
    <h2 class="reveal">Frequently Asked<br><em>Questions</em></h2>
    <div style="max-width:760px;margin-top:3rem;">
      <div class="faq-item reveal">
        <button class="faq-question">How long does the entire process take? <span class="faq-icon">+</span></button>
        <div class="faq-answer">
          <p>The timeline varies by destination. On average, from your first consultation to receiving a visa takes 3–6
            months. Some countries like Germany may take longer due to university admission timelines, while others like
            Australia can be faster with rolling intake.</p>
        </div>
      </div>
      <div class="faq-item reveal">
        <button class="faq-question">Is the initial consultation really free? <span class="faq-icon">+</span></button>
        <div class="faq-answer">
          <p>Yes, completely free and with no obligation. We believe every student deserves access to honest advice.
            Only if you choose to proceed with our services will any fees apply, and we'll outline everything clearly
            upfront.</p>
        </div>
      </div>
      <div class="faq-item reveal">
        <button class="faq-question">What if my visa application is rejected? <span class="faq-icon">+</span></button>
        <div class="faq-answer">
          <p>While our visa success rate is 98%, if a visa is refused we thoroughly analyse the reason and guide you
            through the re-application process. We stand by our students through every challenge.</p>
        </div>
      </div>
      <div class="faq-item reveal">
        <button class="faq-question">Do I need IELTS before coming to you? <span class="faq-icon">+</span></button>
        <div class="faq-answer">
          <p>No — you can come to us at any stage. Many students begin their consultation before taking their language
            tests. We'll advise you on the score you need and connect you with coaching centres to help you get there.
          </p>
        </div>
      </div>
      <div class="faq-item reveal">
        <button class="faq-question">Can you help with scholarship applications? <span
            class="faq-icon">+</span></button>
        <div class="faq-answer">
          <p>Absolutely. Scholarship identification and application support is a core part of our service. We stay
            updated on Chevening, Commonwealth, MEXT, GKS, Eiffel, and many university-specific scholarships available
            to Nepali students.</p>
        </div>
      </div>
      <div class="faq-item reveal">
        <button class="faq-question">I'm in a remote part of Nepal. Can you still help me? <span
            class="faq-icon">+</span></button>
        <div class="faq-answer">
          <p>Yes! We offer online consultations via video call and can guide you through the entire process remotely.
            Many of our students come from outside Pokhara, including Kathmandu, Butwal, Chitwan, and beyond.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ═══════════════════════ CTA ════════════════════════════════ -->
  <section
    style="text-align:center;padding:5rem 4rem;background:linear-gradient(135deg,rgba(60,60,60,0.35),rgba(249,168,38,0.07));">
    <p class="section-tag reveal" style="justify-content:center;">Start Today</p>
    <h2 class="reveal">Step One is<br><em>Completely Free</em></h2>
    <p style="color:var(--muted);font-size:1rem;max-width:460px;margin:0 auto 2.5rem;line-height:1.8;" class="reveal">
      Book your free consultation now. No fees, no pressure — just expert, honest guidance to help you plan your next
      step.</p>
    <div class="reveal">
      <a href="book.jsp" class="btn-primary" style="font-size:0.9rem;padding:1rem 2.5rem;">Book Free Consultation</a>
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
    // FAQ accordion
    document.querySelectorAll('.faq-question').forEach(btn => {
      btn.addEventListener('click', () => {
        const item = btn.closest('.faq-item');
        const isOpen = item.classList.contains('open');
        document.querySelectorAll('.faq-item').forEach(i => i.classList.remove('open'));
        if (!isOpen) item.classList.add('open');
      });
    });
  </script>
</body>

</html>