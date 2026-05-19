<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

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

    List<Map<String, String>> recentBookings = dao.getRecentBookings(8);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard – Manifest Yatra</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,400;1,500&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
<style>
:root {
    --bg-dark: #16181c;
    --bg: #1e2028;
    --bg-card: #23252d;
    --gold: #c9a227;
    --gold-dim: rgba(201,162,39,0.15);
    --gold-border: rgba(201,162,39,0.22);
    --muted: #8a8d96;
    --text: #e8e9ec;
    --danger: #e07070;
    --success: #6bbf8a;
    --warning: #f5a623;
}
* { margin: 0; padding: 0; box-sizing: border-box; }
body { background: var(--bg-dark); color: var(--text); font-family: 'DM Sans', sans-serif; display: flex; min-height: 100vh; }
.sidebar { width: 260px; background: var(--bg); border-right: 1px solid var(--gold-border); position: fixed; left: 0; top: 0; height: 100vh; display: flex; flex-direction: column; }
.brand { padding: 2rem 1.5rem; border-bottom: 1px solid var(--gold-border); }
.brand h2 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2rem; color: var(--text); margin: 0; }
.brand h2 em { color: var(--gold); font-style: italic; }
.brand p { margin-top: 6px; color: var(--muted); font-size: 0.9rem; letter-spacing: 0.03em; }
.nav-links { padding: 1.5rem 1rem; flex: 1; }
.nav-links a { display: block; padding: 12px 15px; margin-bottom: 8px; border-radius: 8px; color: var(--text); text-decoration: none; font-family: 'DM Sans', sans-serif; font-size: 0.95rem; font-weight: 500; letter-spacing: 0.02em; transition: all 0.3s ease; }
.nav-links a:hover { background: rgba(201,162,39,0.10); color: var(--gold); transform: translateX(4px); }
.nav-links a.active { background: rgba(201,162,39,0.18); color: var(--gold); border: 1px solid rgba(201,162,39,0.25); }
.sidebar-footer { padding: 1.5rem; border-top: 1px solid var(--gold-border); }
.logout-btn { display: block; width: 100%; text-align: center; background: var(--danger); color: white; text-decoration: none; padding: 10px 16px; border-radius: 8px; font-family: 'DM Sans', sans-serif; font-weight: 500; transition: opacity 0.3s ease; }
.logout-btn:hover { opacity: 0.9; }
.main { margin-left: 260px; flex: 1; display: flex; flex-direction: column; }
.topbar { padding: 1.2rem 2rem; background: var(--bg-dark); border-bottom: 1px solid rgba(201,162,39,0.15); display: flex; justify-content: space-between; align-items: center; }
.topbar h1 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2.3rem; }
.topbar h1 em { color: var(--gold); font-style: italic; }
.topbar .welcome { color: var(--muted); font-size: 0.95rem; }
.topbar .welcome strong { color: var(--text); }
.content { padding: 2rem; }
.success-msg { color: var(--success); background: rgba(107,191,138,0.10); border: 1px solid rgba(107,191,138,0.20); padding: 12px 16px; border-radius: 8px; margin-bottom: 1.5rem; }
.stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.2rem; margin-bottom: 2.5rem; }
.stat-card { background: var(--bg-card); border: 1px solid rgba(201,162,39,0.08); padding: 1.6rem; border-radius: 12px; }
.stat-card .label { color: var(--muted); font-size: 0.9rem; margin-bottom: 8px; }
.stat-card .value { font-size: 2.6rem; font-weight: 300; line-height: 1; }
.section-title { font-family: 'Cormorant Garamond', serif; font-weight: 400; font-size: 2rem; margin-bottom: 1rem; }
.table-card { background: var(--bg-card); border-radius: 12px; overflow: hidden; border: 1px solid rgba(201,162,39,0.08); }
table { width: 100%; border-collapse: collapse; }
th, td { padding: 14px 12px; text-align: left; font-size: 0.92rem; }
th { background: rgba(201,162,39,0.12); color: var(--gold); font-weight: 500; }
tbody tr { border-top: 1px solid rgba(255,255,255,0.04); }
tbody tr:hover { background: rgba(255,255,255,0.03); }
.pill { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 0.78rem; font-weight: 500; }
.btn { padding: 6px 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 0.82rem; font-family: 'DM Sans', sans-serif; margin-right: 6px; }
.btn-accept { background: var(--success); color: white; }
.btn-reject { background: var(--danger); color: white; }
.btn-view { background: #555; color: white; }
@media (max-width: 1100px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
@media (max-width: 768px) { .sidebar { width: 220px; } .main { margin-left: 220px; } .content { padding: 1.2rem; } .stats-grid { grid-template-columns: 1fr; } .table-card { overflow-x: auto; } }
</style>
</head>
<body>

<aside class="sidebar">
    <div class="brand">
        <h2>Manifest <em>Yatra</em></h2>
        <p>Admin Panel</p>
    </div>
    <div class="nav-links">
        <a href="AdminDash.jsp" class="active">📊 Dashboard</a>
        <a href="bookings.jsp">📅 Manage Bookings</a>
        <a href="students.jsp">👥 Students</a>
        <a href="enquiries.jsp">💬 Enquiries</a>
        <a href="reports.jsp">📈 Reports</a>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="logout-btn">🚪 Logout</a>
    </div>
</aside>

<main class="main">
    <div class="topbar">
        <h1>Admin <em>Overview</em></h1>
        <div class="welcome">Welcome, <strong><%= session.getAttribute("adminName") != null ? session.getAttribute("adminName") : "Admin" %></strong></div>
    </div>

    <div class="content">
        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="success-msg">✅ Booking status updated successfully!</div>
        <% } %>

        <div class="stats-grid">
            <div class="stat-card"><div class="label">Total Bookings</div><div class="value"><%= totalBookings %></div></div>
            <div class="stat-card"><div class="label">Pending</div><div class="value" style="color: var(--warning);"><%= pendingBookings %></div></div>
            <div class="stat-card"><div class="label">Confirmed</div><div class="value" style="color: var(--success);"><%= confirmedBookings %></div></div>
            <div class="stat-card"><div class="label">Total Students</div><div class="value"><%= totalStudents %></div></div>
        </div>

        <h2 class="section-title">Recent Booking Requests</h2>
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Student Name</th>
                        <th>Destination</th>
                        <th>Service</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% if (recentBookings != null && !recentBookings.isEmpty()) { %>
                    <% for (Map<String, String> b : recentBookings) { %>
                    <tr>
                        <td>#<%= b.get("id") %></td>
                        <td><%= b.get("student_name") %></td>
                        <td><%= b.get("destination") != null ? b.get("destination") : "-" %></td>
                        <td><%= b.get("service_type") != null ? b.get("service_type") : "Consultation" %></td>
                        <td><%= b.get("booking_date") %></td>
                        <td>
                            <%
                                String status = b.get("status");
                                String bgColor = "rgba(107,191,138,0.15)";
                                String textColor = "var(--success)";
                                if ("Pending".equalsIgnoreCase(status)) {
                                    bgColor = "rgba(245,166,35,0.15)"; textColor = "var(--warning)";
                                } else if ("Rejected".equalsIgnoreCase(status)) {
                                    bgColor = "rgba(224,112,112,0.15)"; textColor = "var(--danger)";
                                }
                            %>
                            <span class="pill" style="background:<%= bgColor %>; color:<%= textColor %>;"><%= status %></span>
                        </td>
                        <td>
                            <% if ("Pending".equalsIgnoreCase(status)) { %>
                                <button class="btn btn-accept" onclick="updateStatus(<%= b.get("id") %>, 'Accepted')">Accept</button>
                                <button class="btn btn-reject" onclick="updateStatus(<%= b.get("id") %>, 'Rejected')">Reject</button>
                            <% } else { %>
                                <button class="btn btn-view">View</button>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="7" style="text-align:center; color: var(--muted); padding: 2rem;">No booking records found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<script>
function updateStatus(id, status) {
    if (confirm("Mark booking #" + id + " as " + status + "?")) {
        window.location.href = "${pageContext.request.contextPath}/UpdateBookingServlet?id=" + id + "&status=" + status;
    }
}
</script>
</body>
</html>