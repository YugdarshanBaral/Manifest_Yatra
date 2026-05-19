<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

<%
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        return;
    }
    AdminDAO dao = new AdminDAO();
    List<Map<String, String>> allBookings = dao.getAllBookings();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Bookings – Manifest Yatra</title>
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

/* ── Sidebar ── */
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

/* ── Main ── */
.main { margin-left: 260px; flex: 1; display: flex; flex-direction: column; }
.topbar { padding: 1.2rem 2rem; background: var(--bg-dark); border-bottom: 1px solid rgba(201,162,39,0.15); display: flex; justify-content: space-between; align-items: center; }
.topbar h1 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2.3rem; }
.topbar h1 em { color: var(--gold); font-style: italic; }
.content { padding: 2rem; }
.section-title { font-family: 'Cormorant Garamond', serif; font-weight: 400; font-size: 2rem; margin-bottom: 1rem; }

/* ── Table ── */
.table-card { background: var(--bg-card); border-radius: 12px; overflow: hidden; border: 1px solid rgba(201,162,39,0.08); }
table { width: 100%; border-collapse: collapse; }
th, td { padding: 14px 12px; text-align: left; font-size: 0.92rem; }
th { background: rgba(201,162,39,0.12); color: var(--gold); font-weight: 500; }
tbody tr { border-top: 1px solid rgba(255,255,255,0.04); }
tbody tr:hover { background: rgba(255,255,255,0.03); }

/* ── Pills & buttons ── */
.pill { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 0.78rem; font-weight: 500; }
.btn { padding: 6px 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 0.82rem; font-family: 'DM Sans', sans-serif; margin-right: 6px; font-weight: 500; transition: opacity 0.2s; }
.btn:hover { opacity: 0.85; }
.btn-accept { background: var(--success); color: white; }
.btn-reject { background: var(--danger); color: white; }
.btn-delete { background: rgba(224,112,112,0.15); color: var(--danger); border: 1px solid rgba(224,112,112,0.3); }

/* ── Delete confirmation modal ── */
.modal-backdrop {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.65);
    z-index: 200;
    align-items: center;
    justify-content: center;
}
.modal-backdrop.show { display: flex; }
.modal-box {
    background: var(--bg-card);
    border: 1px solid var(--gold-border);
    border-radius: 14px;
    padding: 2rem 2.2rem;
    max-width: 400px;
    width: 92%;
    text-align: center;
}
.modal-box h3 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 1.75rem;
    margin-bottom: 0.6rem;
}
.modal-box p {
    color: var(--muted);
    font-size: 0.9rem;
    line-height: 1.6;
    margin-bottom: 1.6rem;
}
.modal-actions { display: flex; gap: 0.8rem; justify-content: center; }
.btn-cancel-modal {
    padding: 8px 20px; border-radius: 8px; cursor: pointer;
    background: rgba(255,255,255,0.07); color: var(--text);
    border: 1px solid rgba(255,255,255,0.12); font-family: 'DM Sans', sans-serif;
    font-size: 0.88rem;
}
.btn-confirm-delete {
    padding: 8px 20px; border-radius: 8px; cursor: pointer;
    background: var(--danger); color: white; border: none;
    font-family: 'DM Sans', sans-serif; font-size: 0.88rem; font-weight: 600;
}
.btn-cancel-modal:hover { background: rgba(255,255,255,0.12); }
.btn-confirm-delete:hover { opacity: 0.88; }
</style>
</head>
<body>

<!-- ══ SIDEBAR ══════════════════════════════════════════════════ -->
<aside class="sidebar">
    <div class="brand">
        <h2>Manifest <em>Yatra</em></h2>
        <p>Admin Panel</p>
    </div>
    <div class="nav-links">
        <a href="AdminDash.jsp">📊 Dashboard</a>
        <a href="bookings.jsp" class="active">📅 Manage Bookings</a>
        <a href="students.jsp">👥 Students</a>
        <a href="enquiries.jsp">💬 Enquiries</a>
        <a href="reports.jsp">📈 Reports</a>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="logout-btn">🚪 Logout</a>
    </div>
</aside>

<!-- ══ MAIN ══════════════════════════════════════════════════════ -->
<main class="main">
    <div class="topbar">
        <h1>Manage <em>Bookings</em></h1>
    </div>

    <div class="content">
        <h2 class="section-title">All Dynamic Requests</h2>
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
                <% if (allBookings != null && !allBookings.isEmpty()) {
                       for (Map<String, String> b : allBookings) {
                           String status = b.get("status");
                           String bgColor   = "rgba(107,191,138,0.15)";
                           String textColor = "var(--success)";
                           if ("Pending".equalsIgnoreCase(status)) {
                               bgColor   = "rgba(245,166,35,0.15)";
                               textColor = "var(--warning)";
                           } else if ("Rejected".equalsIgnoreCase(status)) {
                               bgColor   = "rgba(224,112,112,0.15)";
                               textColor = "var(--danger)";
                           }
                           // Safe JS string: escape single quotes for onclick attributes
                           String safeName = b.get("student_name") != null
                               ? b.get("student_name").replace("'", "\\'") : "";
                %>
                    <tr>
                        <td>#<%= b.get("id") %></td>
                        <td><%= b.get("student_name") %></td>
                        <td><%= b.get("destination") != null ? b.get("destination") : "-" %></td>
                        <td><%= b.get("service_type") != null ? b.get("service_type") : "Consultation" %></td>
                        <td><%= b.get("booking_date") %></td>
                        <td>
                            <span class="pill" style="background:<%= bgColor %>; color:<%= textColor %>;">
                                <%= status %>
                            </span>
                        </td>
                        <td>
                            <% if ("Pending".equalsIgnoreCase(status)) { %>
                                <button class="btn btn-accept"
                                    onclick="updateStatus(<%= b.get("id") %>, 'Accepted')">Accept</button>
                                <button class="btn btn-reject"
                                    onclick="updateStatus(<%= b.get("id") %>, 'Rejected')">Reject</button>
                            <% } else { %>
                                <span style="color: var(--muted); font-size: 0.85rem; margin-right:8px;">Processed</span>
                            <% } %>
                            <button class="btn btn-delete"
                                onclick="openDeleteModal(<%= b.get("id") %>, '<%= safeName %>')">
                                🗑 Delete
                            </button>
                        </td>
                    </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="7" style="text-align:center; color: var(--muted); padding: 2rem;">
                            No entries found.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ══ DELETE CONFIRMATION MODAL ════════════════════════════════ -->
<div class="modal-backdrop" id="deleteModal">
    <div class="modal-box">
        <h3>Delete Booking?</h3>
        <p id="deleteModalText">
            This will permanently remove the booking record. This action cannot be undone.
        </p>
        <div class="modal-actions">
            <button class="btn-cancel-modal" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn-confirm-delete" onclick="confirmDelete()">Yes, Delete</button>
        </div>
    </div>
</div>

<script>
    var _pendingDeleteId = null;

    function openDeleteModal(id, name) {
        _pendingDeleteId = id;
        document.getElementById('deleteModalText').textContent =
            'Permanently delete booking #' + id + ' for "' + name + '"? This cannot be undone.';
        document.getElementById('deleteModal').classList.add('show');
    }

    function closeDeleteModal() {
        _pendingDeleteId = null;
        document.getElementById('deleteModal').classList.remove('show');
    }

    function confirmDelete() {
        if (_pendingDeleteId !== null) {
            window.location.href =
                '${pageContext.request.contextPath}/DeleteBookingServlet?id=' + _pendingDeleteId + '&from=bookings';
        }
    }

    function updateStatus(id, status) {
        if (confirm('Mark booking #' + id + ' as ' + status + '?')) {
            window.location.href =
                '${pageContext.request.contextPath}/UpdateBookingServlet?id=' + id + '&status=' + status;
        }
    }

    // Close modal when clicking the dark backdrop
    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if (e.target === this) closeDeleteModal();
    });
</script>
</body>
</html>
