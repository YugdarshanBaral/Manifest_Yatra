<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

<%
    // Session Check - Redirect to login if not logged in as admin
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – Manifest Yatra</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,400&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    
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
            --sidebar-w: 260px;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            background: var(--bg-dark);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: var(--sidebar-w);
            background: var(--bg);
            position: fixed;
            height: 100vh;
            border-right: 1px solid var(--gold-border);
            z-index: 100;
        }

        .main { margin-left: var(--sidebar-w); flex: 1; }
        .topbar {
            padding: 1.2rem 2rem;
            background: var(--bg-dark);
            border-bottom: 1px solid rgba(201,162,39,0.2);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .content { padding: 2rem; }
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.2rem; margin-bottom: 2.5rem; }
        .stat-card {
            background: var(--bg-card);
            padding: 1.6rem;
            border-radius: 12px;
            border: 1px solid rgba(255,255,255,0.06);
        }
        .stat-value {
            font-family: 'Cormorant Garamond', serif;
            font-size: 2.6rem;
            font-weight: 300;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--bg-card);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td { padding: 14px 12px; text-align: left; }
        th { background: rgba(201,162,39,0.15); color: var(--gold); }
        tr:hover { background: rgba(255,255,255,0.05); }

        .btn {
            padding: 6px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
        }
        .btn-accept { background: var(--success); color: white; }
        .btn-reject { background: var(--danger); color: white; }
        .pill {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.78rem;
        }
        .logout-btn {
            background: var(--danger);
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%
    AdminDAO dao = new AdminDAO();
    int totalBookings = dao.getTotalBookings();
    int pendingBookings = dao.getPendingBookings();
    int confirmedBookings = dao.getConfirmedBookings();
    int totalStudents = dao.getTotalStudents();
    List<Map<String, String>> recentBookings = dao.getRecentBookings(8);
%>

<!-- SIDEBAR -->
<aside class="sidebar">
  <div style="padding: 2rem 1.5rem; border-bottom: 1px solid var(--gold-border);">
    <span style="font-size:1.6rem; font-family:'Cormorant Garamond',serif;">Manifest <em>Yatra</em></span>
    <p style="color:var(--muted); margin-top:5px;">Admin Panel</p>
  </div>

  <div style="padding: 1.5rem 1rem;">
    <a href="AdminDash.jsp" style="display:block; padding:12px 15px; color:var(--gold); background:rgba(201,162,39,0.2); border-radius:6px;">📊 Dashboard</a>
    <a href="bookings.jsp" style="display:block; padding:12px 15px; color:#ddd; margin-top:8px;">📅 Manage Bookings</a>
    <a href="students.jsp" style="display:block; padding:12px 15px; color:#ddd; margin-top:8px;">👥 Students</a>
    <a href="enquiries.jsp" style="display:block; padding:12px 15px; color:#ddd; margin-top:8px;">💬 Enquiries</a>
    <a href="reports.jsp" style="display:block; padding:12px 15px; color:#ddd; margin-top:8px;">📊 Reports</a>
  </div>

  <div style="margin-top:auto; padding:1.5rem;">
    <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="logout-btn">🚪 Logout</a>
  </div>
</aside>

<!-- MAIN -->
<main class="main">
  <div class="topbar">
    <h1 style="font-family:'Cormorant Garamond',serif; font-weight:300;">Admin <em>Overview</em></h1>
    <span>Welcome, <strong><%= session.getAttribute("adminName") != null ? session.getAttribute("adminName") : "Admin" %></strong></span>
    <span id="dateDisplay" style="color:var(--muted);"></span>
  </div>

  <div class="content">
    <div class="stats-grid">
      <div class="stat-card">
        <div style="color:var(--muted);">Total Bookings</div>
        <div class="stat-value"><%= totalBookings %></div>
      </div>
      <div class="stat-card">
        <div style="color:var(--muted);">Pending</div>
        <div class="stat-value" style="color:#f5a623;"><%= pendingBookings %></div>
      </div>
      <div class="stat-card">
        <div style="color:var(--muted);">Confirmed</div>
        <div class="stat-value" style="color:var(--success);"><%= confirmedBookings %></div>
      </div>
      <div class="stat-card">
        <div style="color:var(--muted);">Total Students</div>
        <div class="stat-value"><%= totalStudents %></div>
      </div>
    </div>

    <h2>Recent Bookings</h2>
    <table>
      <thead>
        <tr>
          <th>Student Name</th>
          <th>Destination</th>
          <th>Service</th>
          <th>Booking Date</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <% for(Map<String, String> b : recentBookings) { %>
        <tr>
          <td><%= b.get("student_name") %></td>
          <td><%= b.get("destination") %></td>
          <td><%= b.get("service_type") != null ? b.get("service_type") : "-" %></td>
          <td><%= b.get("booking_date") %></td>
          <td>
            <span class="pill" style="background: <%= "Pending".equals(b.get("status")) ? "#f5a62333" : "#6bbf8a33" %>; color: <%= "Pending".equals(b.get("status")) ? "#f5a623" : "var(--success)" %>;">
              <%= b.get("status") %>
            </span>
          </td>
          <td>
            <% if("Pending".equals(b.get("status"))) { %>
              <button class="btn btn-accept" onclick="updateStatus(<%= b.get("id") %>, 'Confirmed')">Accept</button>
              <button class="btn btn-reject" onclick="updateStatus(<%= b.get("id") %>, 'Rejected')">Reject</button>
            <% } else { %>
              <button class="btn" style="background:#555;">View</button>
            <% } %>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</main>

<script>
  document.getElementById('dateDisplay').textContent = new Date().toLocaleDateString('en-GB', {
    weekday: 'short', day: 'numeric', month: 'long', year: 'numeric'
  });

  function updateStatus(id, status) {
    if(confirm("Mark booking #" + id + " as " + status + "?")) {
      window.location.href = "${pageContext.request.contextPath}/UpdateBookingServlet?id=" + id + "&status=" + status;
    }
  }
</script>
</body>
</html>