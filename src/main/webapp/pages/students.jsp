<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

<%
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        return;
    }
    AdminDAO dao = new AdminDAO();
    List<Map<String, String>> students = dao.getAllStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Students Directory – Manifest Yatra</title>
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
.topbar .welcome { color: var(--muted); font-size: 0.95rem; }
.topbar .welcome strong { color: var(--text); }
.content { padding: 2rem; }
.section-title { font-family: 'Cormorant Garamond', serif; font-weight: 400; font-size: 2rem; margin-bottom: 1rem; }

/* ── Table ── */
.table-card { background: var(--bg-card); border-radius: 12px; overflow: hidden; border: 1px solid rgba(201,162,39,0.08); }
table { width: 100%; border-collapse: collapse; }
th, td { padding: 14px 12px; text-align: left; font-size: 0.92rem; }
th { background: rgba(201,162,39,0.12); color: var(--gold); font-weight: 500; }
tbody tr { border-top: 1px solid rgba(255,255,255,0.04); }
tbody tr:hover { background: rgba(255,255,255,0.03); }
.pill { display: inline-block; padding: 5px 12px; border-radius: 20px; font-size: 0.78rem; font-weight: 500; background: rgba(107,191,138,0.15); color: var(--success); }

/* ── Action buttons ── */
.btn { padding: 6px 14px; border: none; border-radius: 6px; cursor: pointer; font-size: 0.82rem; font-family: 'DM Sans', sans-serif; margin-right: 5px; font-weight: 500; transition: opacity 0.2s; }
.btn:hover { opacity: 0.85; }
.btn-edit   { background: rgba(201,162,39,0.15); color: var(--gold); border: 1px solid var(--gold-border); }
.btn-delete { background: rgba(224,112,112,0.15); color: var(--danger); border: 1px solid rgba(224,112,112,0.3); }

/* ── Shared modal styles ── */
.modal-backdrop {
    display: none; position: fixed; inset: 0;
    background: rgba(0,0,0,0.65); z-index: 200;
    align-items: center; justify-content: center;
}
.modal-backdrop.show { display: flex; }
.modal-box {
    background: var(--bg-card); border: 1px solid var(--gold-border);
    border-radius: 14px; padding: 2rem 2.2rem;
    max-width: 480px; width: 94%;
}
.modal-box h3 { font-family: 'Cormorant Garamond', serif; font-size: 1.75rem; margin-bottom: 1.2rem; }

/* Edit form fields */
.form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
.form-group { margin-bottom: 1rem; }
.form-group label { display: block; font-size: 0.78rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 5px; }
.form-control {
    width: 100%; padding: 9px 12px; border-radius: 8px;
    background: var(--bg); border: 1px solid var(--gold-border);
    color: var(--text); font-size: 0.9rem;
    font-family: 'DM Sans', sans-serif; outline: none;
}
.form-control:focus { border-color: var(--gold); }
select.form-control option { background: var(--bg); }

/* Modal action buttons */
.modal-actions { display: flex; gap: 0.8rem; justify-content: flex-end; margin-top: 1.4rem; }
.modal-actions.center { justify-content: center; }
.btn-cancel-modal {
    padding: 8px 20px; border-radius: 8px; cursor: pointer;
    background: rgba(255,255,255,0.07); color: var(--text);
    border: 1px solid rgba(255,255,255,0.12); font-family: 'DM Sans', sans-serif; font-size: 0.88rem;
}
.btn-save-modal {
    padding: 8px 22px; border-radius: 8px; cursor: pointer;
    background: var(--gold); color: #16181c; border: none;
    font-family: 'DM Sans', sans-serif; font-size: 0.88rem; font-weight: 700;
}
.btn-confirm-delete {
    padding: 8px 20px; border-radius: 8px; cursor: pointer;
    background: var(--danger); color: white; border: none;
    font-family: 'DM Sans', sans-serif; font-size: 0.88rem; font-weight: 600;
}
.btn-cancel-modal:hover { background: rgba(255,255,255,0.12); }
.btn-save-modal:hover   { opacity: 0.88; }
.btn-confirm-delete:hover { opacity: 0.88; }

/* Delete confirm box is narrower and centred */
.modal-box.confirm { max-width: 390px; text-align: center; }
.modal-box.confirm p { color: var(--muted); font-size: 0.9rem; line-height: 1.6; margin-bottom: 1.5rem; }

@media (max-width: 768px) {
    .sidebar { width: 220px; }
    .main { margin-left: 220px; }
    .content { padding: 1.2rem; }
    .table-card { overflow-x: auto; }
    .form-row { grid-template-columns: 1fr; }
}
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
        <a href="bookings.jsp">📅 Manage Bookings</a>
        <a href="students.jsp" class="active">👥 Students</a>
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
        <h1>Students <em>Directory</em></h1>
        <div class="welcome">
            Welcome,
            <strong><%= session.getAttribute("adminName") != null ? session.getAttribute("adminName") : "Admin" %></strong>
        </div>
    </div>

    <div class="content">
        <h2 class="section-title">Active Student Profiles</h2>
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Destination</th>
                        <th>File Status</th>
                        <th>Joined Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <% if (students != null && !students.isEmpty()) {
                       for (Map<String, String> s : students) {
                           String sName    = s.get("name")        != null ? s.get("name")        : "";
                           String sEmail   = s.get("email")       != null ? s.get("email")       : "";
                           String sPhone   = s.get("phone")       != null ? s.get("phone")       : "-";
                           String sDest    = s.get("destination") != null ? s.get("destination") : "-";
                           String sStatus  = s.get("status")      != null ? s.get("status")      : "In Progress";
                           // Escape single quotes so onclick strings are safe
                           String jsName   = sName.replace("\\", "\\\\").replace("'", "\\'");
                           String jsEmail  = sEmail.replace("'", "\\'");
                           String jsPhone  = sPhone.replace("'", "\\'");
                           String jsDest   = sDest.replace("\\", "\\\\").replace("'", "\\'");
                %>
                    <tr>
                        <td>#<%= s.get("id") %></td>
                        <td><strong><%= sName %></strong></td>
                        <td><%= sEmail %></td>
                        <td><%= sPhone %></td>
                        <td><%= sDest %></td>
                        <td><span class="pill"><%= sStatus %></span></td>
                        <td><%= s.get("created_at") %></td>
                        <td>
                            <button class="btn btn-edit" onclick="openEditModal(
                                '<%= s.get("id") %>',
                                '<%= jsName %>',
                                '<%= jsEmail %>',
                                '<%= jsPhone.equals("-") ? "" : jsPhone %>',
                                '<%= jsDest.equals("-") ? "" : jsDest %>',
                                '<%= sStatus %>'
                            )">✏️ Edit</button>
                            <button class="btn btn-delete" onclick="openDeleteModal(
                                '<%= s.get("id") %>',
                                '<%= jsName %>'
                            )">🗑 Delete</button>
                        </td>
                    </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="8" style="text-align:center; color: var(--muted); padding: 2rem;">
                            No students found. Try accepting pending bookings on the dashboard!
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ══ EDIT STUDENT MODAL ════════════════════════════════════════ -->
<div class="modal-backdrop" id="editModal">
    <div class="modal-box">
        <h3>Edit <em style="color:var(--gold); font-style:italic;">Student</em></h3>
        <%-- Use action attribute pointing to the servlet --%>
        <form id="editForm" method="POST" action="${pageContext.request.contextPath}/EditStudentServlet">
            <input type="hidden" name="id" id="edit_id">
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input class="form-control" type="text" name="full_name" id="edit_name" required>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input class="form-control" type="email" name="email" id="edit_email" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Phone</label>
                    <input class="form-control" type="text" name="phone" id="edit_phone">
                </div>
                <div class="form-group">
                    <label>Destination</label>
                    <input class="form-control" type="text" name="destination" id="edit_destination">
                </div>
            </div>
            <div class="form-group">
                <label>Status</label>
                <select class="form-control" name="status" id="edit_status">
                    <option value="New">New</option>
                    <option value="In Progress">In Progress</option>
                    <option value="Completed">Completed</option>
                    <option value="On Hold">On Hold</option>
                </select>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-cancel-modal" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="btn-save-modal">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<!-- ══ DELETE CONFIRMATION MODAL ════════════════════════════════ -->
<div class="modal-backdrop" id="deleteModal">
    <div class="modal-box confirm">
        <h3>Delete Student?</h3>
        <p id="deleteModalText">This will permanently remove the student record. This action cannot be undone.</p>
        <div class="modal-actions center">
            <button class="btn-cancel-modal" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn-confirm-delete" onclick="confirmDelete()">Yes, Delete</button>
        </div>
    </div>
</div>

<script>
    /* ── Edit modal ───────────────────────────────────────── */
    function openEditModal(id, name, email, phone, destination, status) {
        document.getElementById('edit_id').value          = id;
        document.getElementById('edit_name').value        = name;
        document.getElementById('edit_email').value       = email;
        document.getElementById('edit_phone').value       = phone;
        document.getElementById('edit_destination').value = destination;
        document.getElementById('edit_status').value      = status;
        document.getElementById('editModal').classList.add('show');
    }
    function closeEditModal() {
        document.getElementById('editModal').classList.remove('show');
    }

    /* ── Delete modal ─────────────────────────────────────── */
    var _pendingDeleteId = null;
    function openDeleteModal(id, name) {
        _pendingDeleteId = id;
        document.getElementById('deleteModalText').textContent =
            'Permanently delete student #' + id + ' (' + name + ')? This cannot be undone.';
        document.getElementById('deleteModal').classList.add('show');
    }
    function closeDeleteModal() {
        _pendingDeleteId = null;
        document.getElementById('deleteModal').classList.remove('show');
    }
    function confirmDelete() {
        if (_pendingDeleteId !== null) {
            window.location.href =
                '${pageContext.request.contextPath}/DeleteStudentServlet?id=' + _pendingDeleteId;
        }
    }

    /* Close modals on backdrop click */
    document.getElementById('editModal').addEventListener('click', function(e) {
        if (e.target === this) closeEditModal();
    });
    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if (e.target === this) closeDeleteModal();
    });
</script>
</body>
</html>
