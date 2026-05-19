<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>

<%
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        return;
    }
    AdminDAO dao = new AdminDAO();
    int totalBookings = dao.getTotalBookings();
    int pendingBookings = dao.getPendingBookings();
    int confirmedBookings = dao.getConfirmedBookings();
    int totalStudents = dao.getTotalStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reports Overview – Manifest Yatra</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,400;1,500&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
:root {
    --bg-dark: #16181c;
    --bg: #1e2028;
    --bg-card: #23252d;
    --gold: #c9a227;
    --gold-border: rgba(201,162,39,0.22);
    --muted: #8a8d96;
    --text: #e8e9ec;
    --success: #6bbf8a;
}
* { margin: 0; padding: 0; box-sizing: border-box; }
body { background: var(--bg-dark); color: var(--text); font-family: 'DM Sans', sans-serif; display: flex; min-height: 100vh; }
.sidebar { width: 260px; background: var(--bg); border-right: 1px solid var(--gold-border); position: fixed; left: 0; top: 0; height: 100vh; display: flex; flex-direction: column; }
.brand { padding: 2rem 1.5rem; border-bottom: 1px solid var(--gold-border); }
.brand h2 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2rem; }
.brand h2 em { color: var(--gold); font-style: italic; }
.brand p { margin-top: 6px; color: var(--muted); font-size: 0.9rem; }
.nav-links { padding: 1.5rem 1rem; flex: 1; }
.nav-links a { display: block; padding: 12px 15px; margin-bottom: 8px; border-radius: 8px; color: var(--text); text-decoration: none; font-size: 0.95rem; font-weight: 500; }
.nav-links a:hover { background: rgba(201,162,39,0.10); color: var(--gold); transform: translateX(4px); }
.nav-links a.active { background: rgba(201,162,39,0.18); color: var(--gold); border: 1px solid rgba(201,162,39,0.25); }
.sidebar-footer { padding: 1.5rem; border-top: 1px solid var(--gold-border); }
.logout-btn { display: block; width: 100%; text-align: center; background: #e07070; color: white; text-decoration: none; padding: 10px 16px; border-radius: 8px; font-weight: 500; }
.main { margin-left: 260px; flex: 1; display: flex; flex-direction: column; }
.topbar { padding: 1.2rem 2rem; background: var(--bg-dark); border-bottom: 1px solid rgba(201,162,39,0.15); }
.topbar h1 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2.3rem; }
.topbar h1 em { color: var(--gold); font-style: italic; }
.content { padding: 2rem; }
.section-title { font-family: 'Cormorant Garamond', serif; font-weight: 400; font-size: 2rem; margin-bottom: 1rem; }
.report-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 2rem; margin-top: 1rem; }
.report-card { background: var(--bg-card); border-radius: 12px; padding: 2rem; border: 1px solid rgba(201,162,39,0.08); }
.metric { margin-bottom: 1.5rem; }
.metric-label { font-size: 0.9rem; color: var(--muted); margin-bottom: 4px; }
.metric-bar { background: rgba(255,255,255,0.05); height: 8px; border-radius: 4px; overflow: hidden; margin-top: 6px; }
.metric-fill { background: var(--gold); height: 100%; }
</style>
</head>
<body>

<aside class="sidebar">
    <div class="brand"><h2>Manifest <em>Yatra</em></h2><p>Admin Panel</p></div>
    <div class="nav-links">
        <a href="AdminDash.jsp">📊 Dashboard</a>
        <a href="bookings.jsp">📅 Manage Bookings</a>
        <a href="students.jsp">👥 Students</a>
        <a href="enquiries.jsp">💬 Enquiries</a>
        <a href="reports.jsp" class="active">📈 Reports</a>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="logout-btn">🚪 Logout</a>
    </div>
</aside>

<main class="main">
    <div class="topbar"><h1>Analytics <em>Reports</em></h1></div>
    <div class="content">
        <h2 class="section-title">Conversion Rates</h2>
        <div class="report-grid">
            <div class="report-card">
                <h3>Operational Conversion Metrics</h3>
                <br>
                <div class="metric">
                    <div class="metric-label">Confirmed Ratios (<%= confirmedBookings %> / <%= totalBookings %>)</div>
                    <div class="metric-bar">
                        <div class="metric-fill" style="width: <%= totalBookings > 0 ? (confirmedBookings * 100 / totalBookings) : 0 %>%; background: var(--success);"></div>
                    </div>
                </div>
                <div class="metric">
                    <div class="metric-label">Pending Pipeline Reviews (<%= pendingBookings %> / <%= totalBookings %>)</div>
                    <div class="metric-bar">
                        <div class="metric-fill" style="width: <%= totalBookings > 0 ? (pendingBookings * 100 / totalBookings) : 0 %>%;"></div>
                    </div>
                </div>
            </div>
            
            <div class="report-card">
                <h3>Database Growth Volume</h3>
                <br>
                <p style="color:var(--muted)">Assigned Student Profiles: <strong style="color:var(--text); font-size: 1.4rem;"><%= totalStudents %> Members</strong></p>
                <br>
                <p style="color:var(--muted)">Total Global Submissions Handled: <strong style="color:var(--text); font-size: 1.4rem;"><%= totalBookings %> Items</strong></p>
            </div>
        </div>
    </div>
</main>
</body>
</html>