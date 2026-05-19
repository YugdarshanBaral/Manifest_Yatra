<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

<%
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        return;
    }
    AdminDAO dao = new AdminDAO();
    List<Map<String, String>> enquiries = dao.getAllEnquiries();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Enquiries Log – Manifest Yatra</title>
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
    --danger: #e07070;
    --success: #6bbf8a;
    --warning: #f5a623;
}
* { margin: 0; padding: 0; box-sizing: border-box; }
body { background: var(--bg-dark); color: var(--text); font-family: 'DM Sans', sans-serif; display: flex; min-height: 100vh; }

/* ── Sidebar ── */
.sidebar { width: 260px; background: var(--bg); border-right: 1px solid var(--gold-border); position: fixed; left: 0; top: 0; height: 100vh; display: flex; flex-direction: column; }
.brand { padding: 2rem 1.5rem; border-bottom: 1px solid var(--gold-border); }
.brand h2 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2rem; color: var(--text); }
.brand h2 em { color: var(--gold); font-style: italic; }
.brand p { margin-top: 6px; color: var(--muted); font-size: 0.9rem; }
.nav-links { padding: 1.5rem 1rem; flex: 1; }
.nav-links a { display: block; padding: 12px 15px; margin-bottom: 8px; border-radius: 8px; color: var(--text); text-decoration: none; font-size: 0.95rem; font-weight: 500; transition: all 0.3s ease; }
.nav-links a:hover { background: rgba(201,162,39,0.10); color: var(--gold); transform: translateX(4px); }
.nav-links a.active { background: rgba(201,162,39,0.18); color: var(--gold); border: 1px solid rgba(201,162,39,0.25); }
.sidebar-footer { padding: 1.5rem; border-top: 1px solid var(--gold-border); }
.logout-btn { display: block; width: 100%; text-align: center; background: #e07070; color: white; text-decoration: none; padding: 10px 16px; border-radius: 8px; font-weight: 500; transition: opacity 0.3s ease; }
.logout-btn:hover { opacity: 0.9; }

/* ── Main ── */
.main { margin-left: 260px; flex: 1; display: flex; flex-direction: column; }
.topbar { padding: 1.2rem 2rem; background: var(--bg-dark); border-bottom: 1px solid rgba(201,162,39,0.15); }
.topbar h1 { font-family: 'Cormorant Garamond', serif; font-weight: 300; font-size: 2.3rem; }
.topbar h1 em { color: var(--gold); font-style: italic; }
.content { padding: 2rem; }
.section-title { font-family: 'Cormorant Garamond', serif; font-weight: 400; font-size: 2rem; margin-bottom: 1rem; }

/* ── Table ── */
.table-card { background: var(--bg-card); border-radius: 12px; overflow: hidden; border: 1px solid rgba(201,162,39,0.08); }
table { width: 100%; border-collapse: collapse; }
th, td { padding: 14px 12px; text-align: left; font-size: 0.92rem; }
th { background: rgba(201,162,39,0.12); color: var(--gold); }
tbody tr { border-top: 1px solid rgba(255,255,255,0.04); }
tbody tr:hover { background: rgba(255,255,255,0.03); }

/* Message cell truncation */
.msg-cell { max-width: 260px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--muted); font-size: 0.88rem; }

/* ── Action buttons ── */
.btn { padding: 6px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 0.82rem; font-family: 'DM Sans', sans-serif; margin-right: 5px; font-weight: 500; transition: opacity 0.2s; }
.btn:hover { opacity: 0.85; }
.btn-view   { background: rgba(201,162,39,0.15); color: var(--gold);   border: 1px solid var(--gold-border); }
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
    max-width: 500px; width: 94%;
}
.modal-box h3 { font-family: 'Cormorant Garamond', serif; font-size: 1.75rem; margin-bottom: 0.4rem; }

/* View-message modal specifics */
.modal-meta { color: var(--muted); font-size: 0.82rem; margin-bottom: 1.1rem; }
.modal-message-body {
    background: var(--bg); border: 1px solid var(--gold-border);
    border-radius: 8px; padding: 1rem 1.2rem;
    font-size: 0.9rem; line-height: 1.7;
    max-height: 260px; overflow-y: auto;
    white-space: pre-wrap; word-break: break-word;
}

/* Delete confirm modal */
.modal-box.confirm { max-width: 390px; text-align: center; }
.modal-box.confirm p { color: var(--muted); font-size: 0.9rem; line-height: 1.6; margin-bottom: 1.5rem; margin-top: 0.5rem; }

.modal-actions { display: flex; gap: 0.8rem; margin-top: 1.4rem; }
.modal-actions.right  { justify-content: flex-end; }
.modal-actions.center { justify-content: center; }
.btn-cancel-modal {
    padding: 8px 20px; border-radius: 8px; cursor: pointer;
    background: rgba(255,255,255,0.07); color: var(--text);
    border: 1px solid rgba(255,255,255,0.12);
    font-family: 'DM Sans', sans-serif; font-size: 0.88rem;
}
.btn-confirm-delete {
    padding: 8px 20px; border-radius: 8px; cursor: pointer;
    background: var(--danger); color: white; border: none;
    font-family: 'DM Sans', sans-serif; font-size: 0.88rem; font-weight: 600;
}
.btn-cancel-modal:hover   { background: rgba(255,255,255,0.12); }
.btn-confirm-delete:hover { opacity: 0.88; }
</style>
</head>
<body>

<!-- ══ SIDEBAR ══════════════════════════════════════════════════ -->
<aside class="sidebar">
    <div class="brand"><h2>Manifest <em>Yatra</em></h2><p>Admin Panel</p></div>
    <div class="nav-links">
        <a href="AdminDash.jsp">📊 Dashboard</a>
        <a href="bookings.jsp">📅 Manage Bookings</a>
        <a href="students.jsp">👥 Students</a>
        <a href="enquiries.jsp" class="active">💬 Enquiries</a>
        <a href="reports.jsp">📈 Reports</a>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" class="logout-btn">🚪 Logout</a>
    </div>
</aside>

<!-- ══ MAIN ══════════════════════════════════════════════════════ -->
<main class="main">
    <div class="topbar"><h1>Support <em>Enquiries</em></h1></div>
    <div class="content">
        <h2 class="section-title">Message Inboxes</h2>
        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Sender</th>
                        <th>Contact</th>
                        <th>Message</th>
                        <th>Category</th>
                        <th>Received</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% if (enquiries != null && !enquiries.isEmpty()) {
                       for (Map<String, String> e : enquiries) {
                           String eName    = e.get("name")         != null ? e.get("name")         : "";
                           String eEmail   = e.get("email")        != null ? e.get("email")        : "";
                           String ePhone   = e.get("phone")        != null ? e.get("phone")        : "";
                           String eMsg     = e.get("message")      != null ? e.get("message")      : "";
                           String eService = e.get("service_type") != null ? e.get("service_type") : "General";
                           String eDate    = e.get("submitted_at") != null ? e.get("submitted_at") : "";

                           // Safe versions for JS onclick (escape backslash first, then single quote, then newlines)
                           String jsName  = eName.replace("\\","\\\\").replace("'","\\'");
                           String jsEmail = eEmail.replace("'","\\'");
                           String jsMsg   = eMsg.replace("\\","\\\\").replace("'","\\'")
                                                .replace("\r","").replace("\n","\\n");
                           String jsDate  = eDate.replace("'","\\'");

                           // Truncate message for table preview
                           String msgPreview = eMsg.length() > 80 ? eMsg.substring(0, 80) + "…" : eMsg;
                %>
                    <tr>
                        <td>#<%= e.get("id") %></td>
                        <td><strong><%= eName %></strong></td>
                        <td>
                            <%= eEmail %>
                            <% if (!ePhone.isEmpty() && !"-".equals(ePhone)) { %>
                                <br><small style="color:var(--muted)"><%= ePhone %></small>
                            <% } %>
                        </td>
                        <td>
                            <div class="msg-cell" title="<%= eMsg.replace("\"","&quot;") %>">
                                <%= msgPreview.isEmpty() ? "<span style='color:var(--muted)'>—</span>" : msgPreview %>
                            </div>
                        </td>
                        <td><%= eService %></td>
                        <td><%= eDate %></td>
                        <td>
                            <button class="btn btn-view"
                                onclick="openViewModal('<%= jsName %>','<%= jsEmail %>','<%= jsMsg %>','<%= jsDate %>')">
                                👁 View
                            </button>
                            <button class="btn btn-delete"
                                onclick="openDeleteModal('<%= e.get("id") %>','<%= jsName %>')">
                                🗑 Delete
                            </button>
                        </td>
                    </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="7" style="text-align:center; color: var(--muted); padding: 2rem;">
                            No enquiries log history located.
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ══ VIEW MESSAGE MODAL ════════════════════════════════════════ -->
<div class="modal-backdrop" id="viewModal">
    <div class="modal-box">
        <h3 id="viewModalTitle">Enquiry</h3>
        <div class="modal-meta" id="viewModalMeta"></div>
        <div class="modal-message-body" id="viewModalBody"></div>
        <div class="modal-actions right">
            <button class="btn-cancel-modal" onclick="closeViewModal()">Close</button>
        </div>
    </div>
</div>

<!-- ══ DELETE CONFIRMATION MODAL ════════════════════════════════ -->
<div class="modal-backdrop" id="deleteModal">
    <div class="modal-box confirm">
        <h3>Delete Enquiry?</h3>
        <p id="deleteModalText">This will permanently remove the enquiry record. This action cannot be undone.</p>
        <div class="modal-actions center">
            <button class="btn-cancel-modal" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn-confirm-delete" onclick="confirmDelete()">Yes, Delete</button>
        </div>
    </div>
</div>

<script>
    /* ── View modal ───────────────────────────────────────── */
    function openViewModal(name, email, msg, date) {
        document.getElementById('viewModalTitle').textContent = name + ' \u2014 Enquiry';
        document.getElementById('viewModalMeta').textContent  = email + (date ? '  \u00B7  ' + date : '');
        document.getElementById('viewModalBody').textContent  = msg || '(no message)';
        document.getElementById('viewModal').classList.add('show');
    }
    function closeViewModal() {
        document.getElementById('viewModal').classList.remove('show');
    }

    /* ── Delete modal ─────────────────────────────────────── */
    var _pendingDeleteId = null;
    function openDeleteModal(id, name) {
        _pendingDeleteId = id;
        document.getElementById('deleteModalText').textContent =
            'Permanently delete enquiry #' + id + ' from "' + name + '"? This cannot be undone.';
        document.getElementById('deleteModal').classList.add('show');
    }
    function closeDeleteModal() {
        _pendingDeleteId = null;
        document.getElementById('deleteModal').classList.remove('show');
    }
    function confirmDelete() {
        if (_pendingDeleteId !== null) {
            window.location.href =
                '${pageContext.request.contextPath}/DeleteBookingServlet?id=' + _pendingDeleteId + '&from=enquiries';
        }
    }

    /* Close modals on backdrop click */
    document.getElementById('viewModal').addEventListener('click', function(e) {
        if (e.target === this) closeViewModal();
    });
    document.getElementById('deleteModal').addEventListener('click', function(e) {
        if (e.target === this) closeDeleteModal();
    });
</script>
</body>
</html>
