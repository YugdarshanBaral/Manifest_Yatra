<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.AdminDAO" %>
<%@ page import="java.util.*" %>

<%
    // Redirect if not logged in
    if (session.getAttribute("userName") == null) {
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        return;
    }

    Integer userId = (Integer) session.getAttribute("userId");
    String userEmail = (String) session.getAttribute("userEmail");

    AdminDAO dao = new AdminDAO();
    // This fetches the latest list every time the page loads or refreshes
    List<Map<String, String>> bookings = dao.getUserBookingHistory(userId, userEmail);

    String bookingStatus = "No Booking";
    String statusColor = "#888888";

    if (bookings != null && !bookings.isEmpty()) {
        Map<String, String> latestBooking = bookings.get(0);
        bookingStatus = latestBooking.get("status");
    }

    if ("Pending".equalsIgnoreCase(bookingStatus)) {
        statusColor = "#f5a623";
    } else if ("Accepted".equalsIgnoreCase(bookingStatus) || "Confirmed".equalsIgnoreCase(bookingStatus)) {
        statusColor = "#6bbf8a";
    } else if ("Rejected".equalsIgnoreCase(bookingStatus)) {
        statusColor = "#e07070";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Bookings – Manifest Yatra</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

<style>
:root {
    --bg-dark: #16181c;
    --bg: #1e2028;
    --gold: #c9a227;
    --muted: #8a8d96;
    --text: #e8e9ec;
}

body {
    background: var(--bg-dark);
    color: var(--text);
    font-family: 'DM Sans', sans-serif;
    margin: 0;
    padding: 0;
}

.page-section {
    padding: 8rem 4rem 3rem;
}

.book-card {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(201,162,39,0.15);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    padding: 3rem;
    max-width: 900px;
    margin: 40px auto;
    border-radius: 24px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.35);
}

.booking-item {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(201,162,39,0.12);
    padding: 1.8rem;
    border-radius: 18px;
    margin-bottom: 1.5rem;
    transition: all 0.35s ease;
}

.booking-item:hover {
    transform: translateY(-3px);
    border-color: rgba(201,162,39,0.25);
    box-shadow: 0 10px 30px rgba(0,0,0,0.25);
}

.booking-item h3 {
    margin-top: 0;
    margin-bottom: 1rem;
    color: var(--gold);
    font-weight: 500;
}

.booking-item p {
    margin: 0.45rem 0;
    color: var(--text);
    line-height: 1.6;
}

.form-row {
    display: flex;
    gap: 1.5rem;
    margin-bottom: 1.2rem;
}

.form-group {
    flex: 1;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: var(--muted);
    font-size: 0.92rem;
}

input, select, textarea {
    width: 100%;
    padding: 14px 16px;
    background: #2a2d35;
    border: 1px solid rgba(201,162,39,0.2);
    color: white;
    border-radius: 10px;
    box-sizing: border-box;
    font-family: inherit;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: rgba(201,162,39,0.55);
    box-shadow: 0 0 0 3px rgba(201,162,39,0.08);
}

.btn-primary {
    background: var(--gold);
    color: #16181c;
    padding: 14px 2rem;
    border: none;
    border-radius: 10px;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    width: 100%;
    margin-top: 1rem;
    transition: all 0.3s ease;
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(201,162,39,0.25);
    opacity: 0.95;
}

.status {
    font-weight: 700;
}

#newBookingForm {
    display: none;
}

.success-overlay {
    display: none;
    text-align: center;
    padding-top: 1rem;
}

.success-overlay.visible {
    display: block;
}
</style>
</head>
<body>

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
            <a href="#" onclick="return false;">
                👤 <%= session.getAttribute("userName") %>
                <span class="nav-dropdown-icon">▾</span>
            </a>
            <div class="dropdown-menu">
                <a href="${pageContext.request.contextPath}/pages/book.jsp">
                    <span class="dm-icon">📅</span> My Booking
                    <span style="color:<%= statusColor %>; font-size:0.85rem;">(<%= bookingStatus %>)</span>
                </a>
                <a href="${pageContext.request.contextPath}/logout" style="color:#e07070;">
                    <span class="dm-icon">🚪</span> Logout
                </a>
            </div>
        </li>
    </ul>
</nav>

<section class="page-section">

    <div class="book-card" id="historyView">
        <h2 style="text-align:center; color:var(--gold); margin-bottom:2rem;">My Booking History</h2>

        <% if (bookings != null && !bookings.isEmpty()) { %>
            <% for (Map<String, String> booking : bookings) {
                String status = booking.get("status");
                String color = "#888888";
                if ("Pending".equalsIgnoreCase(status)) color = "#f5a623";
                else if ("Accepted".equalsIgnoreCase(status) || "Confirmed".equalsIgnoreCase(status)) color = "#6bbf8a";
                else if ("Rejected".equalsIgnoreCase(status)) color = "#e07070";
            %>
            <div class="booking-item">
                <h3><%= booking.get("destination") %></h3>
                <p><strong>Study Level:</strong> <%= booking.get("study_level") %></p>
                <p><strong>Field of Study:</strong> <%= booking.get("field") %></p>
                <p><strong>Submitted At:</strong> <%= booking.get("submitted_at") %></p>
                <p><strong>Status:</strong> <span class="status" style="color:<%= color %>;"><%= status %></span></p>
            </div>
            <% } %>
        <% } else { %>
            <p style="text-align:center; color:var(--muted);">You have not submitted any bookings yet.</p>
        <% } %>

        <button class="btn-primary" onclick="document.getElementById('newBookingForm').style.display='block'; document.getElementById('historyView').style.display='none';">
            + Book Another Consultation
        </button>
    </div>

    <div class="book-card" id="newBookingForm">
        <h2 style="text-align:center; color:var(--gold); margin-bottom:2rem;">Book Another Consultation</h2>
        <div id="formCard">
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" id="bname" value="<%= session.getAttribute("userName") %>" required>
                </div>
                <div class="form-group">
                    <label>Phone *</label>
                    <input type="tel" id="bphone" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" id="bemail" value="<%= userEmail %>" required>
                </div>
                <div class="form-group">
                    <label>Destination Country *</label>
                    <select id="bdest" required>
                        <option value="">Select Country</option>
                        <option>Australia</option><option>UK</option><option>Canada</option><option>USA</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label>Study Level *</label>
                    <select id="blevel" required>
                        <option value="">Select Level</option>
                        <option>Bachelor's</option><option>Master's</option><option>PhD</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Field of Study *</label>
                    <input type="text" id="bfield" placeholder="e.g. Computer Science" required>
                </div>
            </div>
            <div class="form-group">
                <label>Message</label>
                <textarea id="bmsg" rows="5" placeholder="Tell us about your goals..."></textarea>
            </div>
            <button type="button" onclick="submitBooking(event)" class="btn-primary">Submit Booking Request</button>
        </div>

        <div class="success-overlay" id="successCard">
            <h2 style="color:var(--gold); margin-bottom:1rem;">✅ Booking Submitted Successfully!</h2>
            <p style="color:var(--muted); margin-bottom:1.5rem;">Refreshing your history...</p>
        </div>
    </div>
</section>

<script src="${pageContext.request.contextPath}/pages/main.js"></script>

<script>
function submitBooking(e) {
    if (e) e.preventDefault();

    const formData = new URLSearchParams();
    formData.append('name', document.getElementById('bname').value);
    formData.append('phone', document.getElementById('bphone').value);
    formData.append('email', document.getElementById('bemail').value);
    formData.append('destination', document.getElementById('bdest').value);
    formData.append('level', document.getElementById('blevel').value);
    formData.append('field', document.getElementById('bfield').value);
    formData.append('message', document.getElementById('bmsg').value);

    fetch('${pageContext.request.contextPath}/BookConsultationServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData.toString()
    })
    .then(response => {
        if (response.ok) {
            document.getElementById('formCard').style.display = 'none';
            document.getElementById('successCard').classList.add('visible');
            
            // ✅ CRITICAL FIX: Reload the page after 2 seconds to show new history
            setTimeout(() => {
                window.location.reload();
            }, 2000);
        } else {
            alert('Error submitting request.');
        }
    })
    .catch(error => alert('Connection error.'));
}
</script>

</body>
</html>