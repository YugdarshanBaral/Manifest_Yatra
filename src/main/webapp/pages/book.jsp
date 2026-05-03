<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Book a Consultation – Manifest Yatra</title>
  <meta name="description"
    content="Book your free consultation with Manifest Yatra. Tell us about your study abroad goals and our expert counsellors will get back to you." />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
  <style>
    .book-hero {
      min-height: 42vh;
      display: grid;
      place-items: center;
      position: relative;
      overflow: hidden;
      padding: 8rem 4rem 4rem;
      text-align: center;
    }
    .book-hero-bg {
      position: absolute;
      inset: 0;
      background:
        radial-gradient(ellipse 70% 60% at 50% 30%, rgba(201,162,39,0.07) 0%, transparent 65%),
        linear-gradient(160deg, var(--bg-dark) 0%, var(--bg) 60%, var(--bg-dark) 100%);
    }
    .book-hero-deco {
      position: absolute;
      inset: 0;
      background:
        repeating-linear-gradient(0deg, transparent, transparent 60px, rgba(201,162,39,0.02) 60px, rgba(201,162,39,0.02) 61px),
        repeating-linear-gradient(90deg, transparent, transparent 60px, rgba(201,162,39,0.02) 60px, rgba(201,162,39,0.02) 61px);
    }
    .book-hero-content { position: relative; z-index: 2; }
    .book-hero-content .hero-tag {
      font-size: 0.72rem;
      letter-spacing: 0.28em;
      text-transform: uppercase;
      color: var(--gold);
      margin-bottom: 1.2rem;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.8rem;
    }
    .book-hero-content .hero-tag::before,
    .book-hero-content .hero-tag::after {
      content: '';
      display: inline-block;
      width: 2rem;
      height: 1px;
      background: var(--gold);
    }
    .book-hero-content h1 {
      font-size: clamp(2.4rem, 6vw, 4.5rem);
      font-weight: 300;
      line-height: 1.1;
      margin-bottom: 1rem;
    }
    .book-hero-content h1 em { font-style: italic; color: var(--gold); font-weight: 400; }
    .book-hero-content p { color: var(--muted); font-size: 1rem; line-height: 1.8; max-width: 500px; margin: 0 auto; }

    /* Steps indicator */
    .steps-indicator {
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 3.5rem;
      max-width: 480px;
    }
    .step-badge {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 0.4rem;
      flex: 1;
      position: relative;
    }
    .step-badge::after {
      content: '';
      position: absolute;
      top: 16px;
      left: calc(50% + 16px);
      width: calc(100% - 32px);
      height: 1px;
      background: rgba(201,162,39,0.2);
    }
    .step-badge:last-child::after { display: none; }
    .step-circle {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.7rem;
      font-weight: 600;
      letter-spacing: 0.05em;
      position: relative;
      z-index: 1;
    }
    .step-circle.done { background: rgba(201,162,39,0.2); border: 1px solid var(--gold); color: var(--gold); }
    .step-circle.done::after { content: '✓'; }
    .step-circle.active { background: var(--gold); border: 1px solid var(--gold); color: #1a1a1a; }
    .step-circle.pending { background: transparent; border: 1px solid rgba(201,162,39,0.25); color: var(--muted); }
    .step-label { font-size: 0.65rem; letter-spacing: 0.1em; text-transform: uppercase; color: var(--muted); white-space: nowrap; }
    .step-badge.active-step .step-label { color: var(--gold); }

    /* Form card */
    .book-card {
      background: rgba(255,255,255,0.02);
      border: 1px solid rgba(201,162,39,0.12);
      padding: 3rem;
      max-width: 760px;
      margin: 0 auto;
      position: relative;
    }
    .book-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0;
      height: 2px;
      background: linear-gradient(90deg, transparent, var(--gold), transparent);
      opacity: 0.5;
    }
    .book-section-title {
      font-family: 'Cormorant Garamond', serif;
      font-size: 1.05rem;
      font-weight: 600;
      color: var(--gold);
      letter-spacing: 0.12em;
      text-transform: uppercase;
      margin-bottom: 1.5rem;
      padding-bottom: 0.7rem;
      border-bottom: 1px solid rgba(201,162,39,0.1);
      display: flex;
      align-items: center;
      gap: 0.7rem;
    }
    .book-section-title span.icon { font-size: 1rem; }
    .book-section-gap { margin-top: 2.5rem; }

    .char-hint {
      font-size: 0.7rem;
      color: rgba(245,240,232,0.3);
      text-align: right;
      margin-top: 0.25rem;
      transition: color 0.2s;
    }
    .toggle-group { display: flex; gap: 0.6rem; flex-wrap: wrap; margin-top: 0.5rem; }
    .toggle-chip {
      padding: 0.45rem 1rem;
      border: 1px solid rgba(201,162,39,0.25);
      background: transparent;
      color: var(--muted);
      font-size: 0.78rem;
      letter-spacing: 0.06em;
      cursor: pointer;
      transition: all 0.2s;
      font-family: inherit;
      border-radius: 0;
      outline: none;
    }
    .toggle-chip:hover { border-color: rgba(201,162,39,0.5); color: var(--cream); }
    .toggle-chip.selected { background: rgba(201,162,39,0.15); border-color: var(--gold); color: var(--gold); }

    .submit-area { margin-top: 2.5rem; display: flex; flex-direction: column; align-items: center; gap: 1rem; }
    .submit-area .btn-primary { width: 100%; text-align: center; display: block; font-size: 0.88rem; padding: 1rem 2rem; }
    .submit-note { font-size: 0.75rem; color: var(--muted); text-align: center; line-height: 1.7; }
    .submit-note a { color: var(--gold); text-decoration: none; }

    .success-overlay { display: none; flex-direction: column; align-items: center; justify-content: center; gap: 1.2rem; padding: 4rem 2rem; text-align: center; }
    .success-overlay.visible { display: flex; }
    .success-icon { width: 72px; height: 72px; border-radius: 50%; background: rgba(201,162,39,0.12); border: 1px solid var(--gold); display: flex; align-items: center; justify-content: center; font-size: 1.8rem; }
    .success-overlay h3 { font-family: 'Cormorant Garamond', serif; font-size: 2rem; font-weight: 400; color: var(--cream); }
    .success-overlay h3 em { color: var(--gold); font-style: italic; }
    .success-overlay p { color: var(--muted); font-size: 0.92rem; line-height: 1.8; max-width: 380px; }

    .user-banner {
      display: flex;
      align-items: center;
      gap: 1rem;
      background: rgba(201,162,39,0.06);
      border: 1px solid rgba(201,162,39,0.15);
      padding: 0.9rem 1.4rem;
      margin-bottom: 2.5rem;
      max-width: 760px;
      margin-left: auto;
      margin-right: auto;
    }
    .user-banner-icon { width: 36px; height: 36px; border-radius: 50%; background: rgba(201,162,39,0.15); border: 1px solid rgba(201,162,39,0.3); display: flex; align-items: center; justify-content: center; font-size: 1rem; flex-shrink: 0; }
    .user-banner-text { font-size: 0.85rem; color: var(--muted); line-height: 1.5; }
    .user-banner-text strong { color: var(--cream); font-weight: 500; }

    @media (max-width: 600px) {
      .book-card { padding: 2rem 1.4rem; }
      .steps-indicator { max-width: 320px; }
    }
  </style>
</head>
<body>

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
        <a href="#" onclick="return false;">Account <span class="nav-dropdown-icon">▾</span></a>
        <div class="dropdown-menu">
          <a href="${pageContext.request.contextPath}/register"><span class="dm-icon"></span>Sign Up</a>
          <a href="${pageContext.request.contextPath}/login"><span class="dm-icon"></span>Login</a>
          <a href="${pageContext.request.contextPath}/admin.jsp" class="admin-link"><span class="dm-icon"></span>Admin Login</a>
        </div>
      </li>
    </ul>
    <div class="nav-cta-wrap">
      <a href="${pageContext.request.contextPath}/pages/book.jsp" class="nav-cta">Free Consultation</a>
    </div>
    <button class="nav-hamburger" id="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
  </nav>

  <div class="nav-drawer" id="navDrawer">
    <a href="${pageContext.request.contextPath}/pages/index.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/pages/services.jsp">Services</a>
    <a href="${pageContext.request.contextPath}/pages/destination.jsp">Destinations</a>
    <a href="${pageContext.request.contextPath}/pages/about.jsp">About</a>
    <a href="${pageContext.request.contextPath}/pages/process.jsp">Process</a>
    <a href="${pageContext.request.contextPath}/pages/contact.jsp">Contact</a>
    <div class="drawer-dropdown">
      <button class="drawer-dropdown-trigger">Account <span class="drawer-arrow" style="font-size:0.7rem;transition:transform 0.2s;display:inline-block;">&#9662;</span></button>
      <div class="drawer-sub">
        <a href="${pageContext.request.contextPath}/register">Sign Up</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/admin.jsp">Login as Administrator</a>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/pages/book.jsp" class="drawer-cta">Free Consultation &#8594;</a>
  </div>

  <!-- HERO -->
  <div class="book-hero">
    <div class="book-hero-bg"></div>
    <div class="book-hero-deco"></div>
    <div class="book-hero-content anim-hero">
      <p class="hero-tag">You're Logged In &amp; Ready</p>
      <h1>Book Your<br><em>Free Consultation</em></h1>
      <p>Tell us about your study abroad goals and one of our expert counsellors will reach out to you personally.</p>
    </div>
  </div>

  <!-- STEPS -->
  <section style="padding: 3rem 4rem 0;">
    <div class="steps-indicator">
      <div class="step-badge">
        <div class="step-circle done"></div>
        <span class="step-label">Register</span>
      </div>
      <div class="step-badge">
        <div class="step-circle done"></div>
        <span class="step-label">Login</span>
      </div>
      <div class="step-badge active-step">
        <div class="step-circle active">03</div>
        <span class="step-label">Book</span>
      </div>
    </div>

    <div class="user-banner reveal">
      <div class="user-banner-icon">👤</div>
      <div class="user-banner-text">
        Welcome back, <strong>${not empty sessionScope.userName ? sessionScope.userName : 'Student'}</strong>!
        You're booking a free consultation as a registered user. Your details will be saved to your profile.
      </div>
    </div>
  </section>

  <!-- FORM -->
  <section style="padding: 1.5rem 4rem 5rem;">
    <div class="book-card reveal" id="formCard">

      <!-- Personal Details -->
      <div class="book-section-title"><span class="icon">👤</span> Personal Details</div>
      <div class="form-row">
        <div class="form-group">
          <label>Full Name *</label>
          <input type="text" id="bname" placeholder="Your full name" required />
        </div>
        <div class="form-group">
          <label>Phone Number *</label>
          <input type="tel" id="bphone" placeholder="+977 98XXXXXXXX" required />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Email Address *</label>
          <input type="email" id="bemail" placeholder="your@email.com" required />
        </div>
        <div class="form-group">
          <label>Date of Birth</label>
          <input type="date" id="bdob" />
        </div>
      </div>
      <div class="form-group">
        <label>Current City / District</label>
        <input type="text" id="bcity" placeholder="e.g. Pokhara, Kathmandu, Birgunj…" />
      </div>

      <!-- Study Preferences -->
      <div class="book-section-gap">
        <div class="book-section-title"><span class="icon">🎓</span> Study Preferences</div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Destination Country *</label>
          <select id="bdest" required>
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
          <label>Level of Study *</label>
          <select id="blevel" required>
            <option value="" disabled selected>Select level</option>
            <option>Foundation / Pathway</option>
            <option>Undergraduate (Bachelor's)</option>
            <option>Postgraduate (Master's)</option>
            <option>PhD / Research</option>
            <option>Diploma / Certificate</option>
          </select>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Field of Study *</label>
          <input type="text" id="bfield" placeholder="e.g. Computer Science, Business, Nursing…" required />
        </div>
        <div class="form-group">
          <label>Intended Intake</label>
          <select id="bintake">
            <option value="" disabled selected>Select intake</option>
            <option>January / February 2026</option>
            <option>May / June 2026</option>
            <option>September / October 2026</option>
            <option>January / February 2027</option>
            <option>Not sure yet</option>
          </select>
        </div>
      </div>

      <!-- Academic Background -->
      <div class="book-section-gap">
        <div class="book-section-title"><span class="icon">📄</span> Academic Background</div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Highest Qualification</label>
          <select id="bqual">
            <option value="" disabled selected>Select qualification</option>
            <option>SEE / SLC</option>
            <option>+2 / A-Levels / NEB</option>
            <option>Bachelor's Degree</option>
            <option>Master's Degree</option>
            <option>Currently studying</option>
          </select>
        </div>
        <div class="form-group">
          <label>GPA / Percentage</label>
          <input type="text" id="bgpa" placeholder="e.g. 3.5 GPA or 75%" />
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>English Proficiency Test</label>
          <select id="btest">
            <option value="" disabled selected>Select</option>
            <option>Yes – IELTS</option>
            <option>Yes – TOEFL</option>
            <option>Yes – PTE</option>
            <option>No, not yet</option>
            <option>Currently preparing</option>
          </select>
        </div>
        <div class="form-group">
          <label>Test Score (if applicable)</label>
          <input type="text" id="bscore" placeholder="e.g. IELTS 6.5, TOEFL 90…" />
        </div>
      </div>

      <!-- Consultation Preferences -->
      <div class="book-section-gap">
        <div class="book-section-title"><span class="icon">📅</span> Consultation Preferences</div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Preferred Date</label>
          <input type="date" id="bdate" />
        </div>
        <div class="form-group">
          <label>Preferred Time Slot</label>
          <select id="btime">
            <option value="" disabled selected>Select time</option>
            <option>9:00 AM – 11:00 AM</option>
            <option>11:00 AM – 1:00 PM</option>
            <option>1:00 PM – 3:00 PM</option>
            <option>3:00 PM – 5:00 PM</option>
            <option>Any time is fine</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label>Preferred Contact Method</label>
        <div class="toggle-group" id="contactToggle">
          <button class="toggle-chip" onclick="toggleChip(this)">📞 Phone Call</button>
          <button class="toggle-chip" onclick="toggleChip(this)">📸 Instagram DM</button>
          <button class="toggle-chip" onclick="toggleChip(this)">🏢 Walk-in Visit</button>
          <button class="toggle-chip" onclick="toggleChip(this)">📧 Email</button>
        </div>
      </div>

      <!-- Message -->
      <div class="book-section-gap">
        <div class="book-section-title"><span class="icon">💬</span> Your Message</div>
      </div>
      <div class="form-group">
        <label>Tell us about your goals &amp; questions</label>
        <textarea id="bmsg" rows="5"
          placeholder="Share anything relevant — your background, specific universities you're considering, financial situation, concerns, or any questions you'd like answered in the consultation…"
          oninput="updateCharCount(this,'bmsgCount',600)"></textarea>
        <div class="char-hint" id="bmsgCount">0 / 600</div>
      </div>
      <div class="form-group">
        <label>How did you hear about us?</label>
        <select id="bhear">
          <option value="" disabled selected>Select</option>
          <option>Instagram</option>
          <option>Friend / Family referral</option>
          <option>Google Search</option>
          <option>Walk-in / Signboard</option>
          <option>Other</option>
        </select>
      </div>

      <!-- Submit -->
      <div class="submit-area">
        <a href="#" class="btn-primary" onclick="submitBooking(event)">Confirm Booking Request →</a>
        <p class="submit-note">
          By submitting, you agree that our counsellors may contact you at the details provided.<br>
          Prefer to message directly?
          <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank">DM us on Instagram →</a>
        </p>
      </div>
    </div>

    <!-- Success state -->
    <div class="book-card reveal success-overlay" id="successCard">
      <div class="success-icon">✓</div>
      <h3>Booking <em>Confirmed!</em></h3>
      <p>Thank you! Your consultation request has been received. One of our counsellors will reach out to you at the contact details you provided — usually within one business day.</p>
      <div style="display:flex;gap:1rem;flex-wrap:wrap;justify-content:center;margin-top:1rem;">
        <a href="${pageContext.request.contextPath}/pages/index.jsp" class="btn-outline">Back to Home</a>
        <a href="https://www.instagram.com/manifest_yatra_int_edu_/" target="_blank" class="btn-primary">Follow us on Instagram</a>
      </div>
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
  <script>
    function toggleChip(el) { el.classList.toggle('selected'); }

    function updateCharCount(el, countId, max) {
      const len = el.value.length;
      const counter = document.getElementById(countId);
      counter.textContent = len + ' / ' + max;
      counter.style.color = len > max * 0.85 ? 'var(--gold)' : 'rgba(245,240,232,0.3)';
      if (len > max) el.value = el.value.substring(0, max);
    }

    function getSelectedChips() {
      const chips = document.querySelectorAll('#contactToggle .toggle-chip.selected');
      return Array.from(chips).map(c => c.textContent.trim()).join(', ') || 'Not specified';
    }

    function submitBooking(e) {
      e.preventDefault();
      const required = [
        { id: 'bname',  label: 'Full Name' },
        { id: 'bphone', label: 'Phone Number' },
        { id: 'bemail', label: 'Email Address' },
        { id: 'bdest',  label: 'Destination Country' },
        { id: 'blevel', label: 'Level of Study' },
        { id: 'bfield', label: 'Field of Study' },
      ];
      for (const f of required) {
        const el = document.getElementById(f.id);
        if (!el.value.trim()) {
          el.focus();
          el.style.borderColor = 'rgba(220,60,60,0.7)';
          setTimeout(() => el.style.borderColor = '', 2000);
          alert(f.label + ' is required.');
          return;
        }
      }

      const payload = {
        name: document.getElementById('bname').value,
        phone: document.getElementById('bphone').value,
        email: document.getElementById('bemail').value,
        dob: document.getElementById('bdob').value,
        city: document.getElementById('bcity').value,
        destination: document.getElementById('bdest').value,
        level: document.getElementById('blevel').value,
        field: document.getElementById('bfield').value,
        intake: document.getElementById('bintake').value,
        qual: document.getElementById('bqual').value,
        gpa: document.getElementById('bgpa').value,
        test: document.getElementById('btest').value,
        score: document.getElementById('bscore').value,
        prefDate: document.getElementById('bdate').value,
        prefTime: document.getElementById('btime').value,
        contact: getSelectedChips(),
        message: document.getElementById('bmsg').value,
        hearAbout: document.getElementById('bhear').value,
      };

      /*
       * Wire-up point — replace with your servlet call:
       * fetch('/bookConsultation', {
       *   method: 'POST',
       *   headers: { 'Content-Type': 'application/json' },
       *   body: JSON.stringify(payload)
       * }).then(r => r.json()).then(showSuccess).catch(console.error);
       */
      console.log('Booking payload:', payload);
      showSuccess();
    }

    function showSuccess() {
      document.getElementById('formCard').style.display = 'none';
      const s = document.getElementById('successCard');
      s.style.display = 'flex';
      s.classList.add('visible');
      s.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
  </script>
</body>
</html>
