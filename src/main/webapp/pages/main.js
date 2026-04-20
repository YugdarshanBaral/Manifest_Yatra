/* ============================================================
   MANIFEST YATRA — Global JavaScript  v2.0
   ============================================================ */

document.addEventListener('DOMContentLoaded', () => {

  /* ── Scroll reveal ─────────────────────────────────────────── */
  const revealEls = document.querySelectorAll('.reveal');
  if (revealEls.length) {
    const revealObserver = new IntersectionObserver((entries) => {
      entries.forEach((entry, i) => {
        if (entry.isIntersecting) {
          setTimeout(() => entry.target.classList.add('visible'), i * 70);
          revealObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });
    revealEls.forEach(el => revealObserver.observe(el));
  }

  /* ── Nav scroll effect ─────────────────────────────────────── */
  const mainNav = document.getElementById('mainNav');
  if (mainNav) {
    const onScroll = () => mainNav.classList.toggle('scrolled', window.scrollY > 40);
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  /* ── Active nav link ───────────────────────────────────────── */
  const currentPage = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-center a, .nav-drawer a').forEach(a => {
    const href = a.getAttribute('href');
    if (href === currentPage || (currentPage === '' && href === 'index.html')) {
      a.classList.add('active');
    }
  });

  /* ── Hamburger / mobile drawer ─────────────────────────────── */
  const hamburger = document.getElementById('hamburger');
  const navDrawer  = document.getElementById('navDrawer');
  if (hamburger && navDrawer) {
    hamburger.addEventListener('click', () => {
      hamburger.classList.toggle('open');
      navDrawer.classList.toggle('open');
    });
    navDrawer.querySelectorAll('a:not(.drawer-dropdown-trigger)').forEach(a => {
      a.addEventListener('click', () => {
        hamburger.classList.remove('open');
        navDrawer.classList.remove('open');
      });
    });
  }

  /* ── Mobile drawer sub-menu (sign-up) ──────────────────────── */
  const drawerTrigger = document.querySelector('.drawer-dropdown-trigger');
  if (drawerTrigger) {
    drawerTrigger.addEventListener('click', (e) => {
      e.preventDefault();
      const sub = drawerTrigger.closest('.drawer-dropdown')
                    ?.querySelector('.drawer-sub');
      if (sub) {
        sub.classList.toggle('open');
        const arrow = drawerTrigger.querySelector('.drawer-arrow');
        if (arrow) arrow.style.transform = sub.classList.contains('open') ? 'rotate(180deg)' : 'rotate(0)';
      }
    });
  }

  /* ── Animated counter (stats) ──────────────────────────────── */
  const counters = document.querySelectorAll('[data-count]');
  if (counters.length) {
    const countObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        const el     = entry.target;
        const target = parseInt(el.dataset.count, 10);
        const suffix = el.dataset.suffix || '';
        const dur    = 1400;
        const step   = 16;
        const inc    = target / (dur / step);
        let current  = 0;
        const timer  = setInterval(() => {
          current += inc;
          if (current >= target) { current = target; clearInterval(timer); }
          el.textContent = Math.floor(current) + suffix;
        }, step);
        countObserver.unobserve(el);
      });
    }, { threshold: 0.5 });
    counters.forEach(c => countObserver.observe(c));
  }

});
