package dao;

import com.manifest_consultancy.utilities.DbConfig;
import java.sql.*;
import java.util.*;

public class AdminDAO {

    // ─────────────────────────────────────────────
    // 1. LOGIN
    // ─────────────────────────────────────────────
    public Map<String, Object> getAdminForLogin(String email) {
        String sql = "SELECT id, full_name, email, password FROM admin_users WHERE TRIM(email) = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, Object> admin = new HashMap<>();
                    admin.put("id",        rs.getInt("id"));
                    admin.put("full_name", rs.getString("full_name"));
                    admin.put("email",     rs.getString("email"));
                    admin.put("password",  rs.getString("password"));
                    return admin;
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ─────────────────────────────────────────────
    // 2. DASHBOARD STATS
    // ─────────────────────────────────────────────
    public int getTotalBookings()     { return getCount("SELECT COUNT(*) FROM enquiries"); }
    public int getPendingBookings()   { return getCount("SELECT COUNT(*) FROM enquiries WHERE status = 'Pending'"); }
    public int getConfirmedBookings() { return getCount("SELECT COUNT(*) FROM enquiries WHERE status IN ('Accepted','Confirmed')"); }
    public int getTotalStudents()     { return getCount("SELECT COUNT(*) FROM students"); }

    private int getCount(String sql) {
        try (Connection conn = DbConfig.getConnection();
             Statement stmt  = conn.createStatement();
             ResultSet rs    = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ─────────────────────────────────────────────
    // 3. RECENT BOOKINGS (dashboard)
    // ─────────────────────────────────────────────
    public List<Map<String, String>> getRecentBookings(int limit) {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT id, name, destination, booking_type, status, submitted_at " +
                     "FROM enquiries ORDER BY id DESC LIMIT ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("id",           rs.getString("id"));
                    map.put("student_name", rs.getString("name"));
                    map.put("destination",  rs.getString("destination") != null ? rs.getString("destination") : "-");
                    map.put("status",       rs.getString("status"));
                    map.put("booking_date", rs.getString("submitted_at"));
                    list.add(map);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ─────────────────────────────────────────────
    // 4. ALL BOOKINGS (bookings.jsp)
    // ─────────────────────────────────────────────
    public List<Map<String, String>> getAllBookings() {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT id, name, destination, booking_type, status, submitted_at " +
                     "FROM enquiries ORDER BY id DESC";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id",           rs.getString("id"));
                map.put("student_name", rs.getString("name"));
                map.put("destination",  rs.getString("destination") != null ? rs.getString("destination") : "-");
                map.put("service_type", rs.getString("booking_type") != null ? rs.getString("booking_type") : "Consultation");
                map.put("status",       rs.getString("status"));
                map.put("booking_date", rs.getString("submitted_at"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ─────────────────────────────────────────────
    // 5. ALL STUDENTS (students.jsp)
    // ─────────────────────────────────────────────
    public List<Map<String, String>> getAllStudents() {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT id, full_name, email, phone, destination, status, registered_at " +
                     "FROM students ORDER BY id DESC";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id",          rs.getString("id"));
                map.put("name",        rs.getString("full_name"));
                map.put("email",       rs.getString("email"));
                map.put("phone",       rs.getString("phone") != null ? rs.getString("phone") : "-");
                map.put("destination", rs.getString("destination") != null ? rs.getString("destination") : "-");
                map.put("status",      rs.getString("status") != null ? rs.getString("status") : "New");
                map.put("created_at",  rs.getString("registered_at"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ─────────────────────────────────────────────
    // 6. ALL ENQUIRIES (enquiries.jsp)
    // ─────────────────────────────────────────────
    public List<Map<String, String>> getAllEnquiries() {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT id, name, email, phone, message, booking_type, submitted_at " +
                     "FROM enquiries ORDER BY id DESC";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id",           rs.getString("id"));
                map.put("name",         rs.getString("name"));
                map.put("email",        rs.getString("email"));
                map.put("phone",        rs.getString("phone") != null ? rs.getString("phone") : "-");
                map.put("message",      rs.getString("message") != null ? rs.getString("message") : "-");
                map.put("service_type", rs.getString("booking_type") != null ? rs.getString("booking_type") : "General");
                map.put("submitted_at", rs.getString("submitted_at"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ─────────────────────────────────────────────
    // 7. USER BOOKING HISTORY (book.jsp)
    // ─────────────────────────────────────────────
    public List<Map<String, String>> getUserBookingHistory(Integer userId, String userEmail) {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT id, destination, study_level, field_of_study, submitted_at, status " +
                     "FROM enquiries WHERE (user_account_id = ? OR email = ?) ORDER BY id DESC";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (userId != null) ps.setInt(1, userId); else ps.setNull(1, Types.INTEGER);
            ps.setString(2, userEmail);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> map = new HashMap<>();
                    map.put("id",           rs.getString("id"));
                    map.put("destination",  rs.getString("destination") != null ? rs.getString("destination") : "-");
                    map.put("study_level",  rs.getString("study_level") != null ? rs.getString("study_level") : "-");
                    map.put("field",        rs.getString("field_of_study") != null ? rs.getString("field_of_study") : "-");
                    map.put("submitted_at", rs.getString("submitted_at"));
                    map.put("status",       rs.getString("status"));
                    list.add(map);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ─────────────────────────────────────────────
    // 8. UPDATE BOOKING STATUS
    // ─────────────────────────────────────────────
    public boolean updateBookingStatus(int id, String status, Integer adminId) {
        Connection conn = null;
        try {
            conn = DbConfig.getConnection();
            conn.setAutoCommit(false);

            String updateSql;
            if ("Accepted".equalsIgnoreCase(status)) {
                updateSql = "UPDATE enquiries SET status = ?, assigned_admin_id = ? WHERE id = ?";
            } else {
                updateSql = "UPDATE enquiries SET status = ? WHERE id = ?";
            }

            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                ps.setString(1, status);
                if ("Accepted".equalsIgnoreCase(status)) {
                    if (adminId != null) ps.setInt(2, adminId); else ps.setNull(2, Types.INTEGER);
                    ps.setInt(3, id);
                } else {
                    ps.setInt(2, id);
                }
                ps.executeUpdate();
            }

            if ("Accepted".equalsIgnoreCase(status)) {
                String fetchSql =
                    "SELECT name, email, phone, destination, study_level, user_account_id " +
                    "FROM enquiries WHERE id = ?";

                try (PreparedStatement ps = conn.prepareStatement(fetchSql)) {
                    ps.setInt(1, id);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            String  name        = rs.getString("name");
                            String  email       = rs.getString("email");
                            String  phone       = rs.getString("phone");
                            String  destination = rs.getString("destination");
                            String  studyLevel  = rs.getString("study_level");
                            int     userAccId   = rs.getInt("user_account_id");
                            boolean hasUserId   = !rs.wasNull();

                            String checkSql = "SELECT COUNT(*) FROM students WHERE email = ?";
                            try (PreparedStatement chk = conn.prepareStatement(checkSql)) {
                                chk.setString(1, email);
                                try (ResultSet cr = chk.executeQuery()) {
                                    cr.next();
                                    if (cr.getInt(1) == 0) {
                                        String insertSql =
                                            "INSERT INTO students " +
                                            "(full_name, email, phone, destination, study_level, " +
                                            " user_id, managed_by_admin_id, " +
                                            " source_enquiry_id, enquiry_id, " +
                                            " status, accepted_by, accepted_at, " +
                                            " registered_at, created_at) " +
                                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'In Progress', ?, NOW(), NOW(), NOW())";
                                        try (PreparedStatement ins = conn.prepareStatement(insertSql)) {
                                            ins.setString(1, name);
                                            ins.setString(2, email);
                                            ins.setString(3, phone);
                                            ins.setString(4, destination);
                                            ins.setString(5, studyLevel);
                                            if (hasUserId) ins.setInt(6, userAccId);
                                            else           ins.setNull(6, Types.INTEGER);
                                            if (adminId != null) ins.setInt(7, adminId);
                                            else                 ins.setNull(7, Types.INTEGER);
                                            ins.setInt(8,  id);
                                            ins.setInt(9,  id);
                                            if (adminId != null) ins.setInt(10, adminId);
                                            else                 ins.setNull(10, Types.INTEGER);
                                            ins.executeUpdate();
                                        }
                                    } else {
                                        String updateStudentSql =
                                            "UPDATE students SET " +
                                            "  study_level        = COALESCE(study_level, ?), " +
                                            "  managed_by_admin_id = COALESCE(managed_by_admin_id, ?), " +
                                            "  user_id            = COALESCE(user_id, ?), " +
                                            "  accepted_by        = COALESCE(accepted_by, ?), " +
                                            "  accepted_at        = COALESCE(accepted_at, NOW()) " +
                                            "WHERE email = ?";
                                        try (PreparedStatement upd = conn.prepareStatement(updateStudentSql)) {
                                            upd.setString(1, studyLevel);
                                            if (adminId != null) upd.setInt(2, adminId);
                                            else                 upd.setNull(2, Types.INTEGER);
                                            if (hasUserId) upd.setInt(3, userAccId);
                                            else           upd.setNull(3, Types.INTEGER);
                                            if (adminId != null) upd.setInt(4, adminId);
                                            else                 upd.setNull(4, Types.INTEGER);
                                            upd.setString(5, email);
                                            upd.executeUpdate();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) { try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); } }
            return false;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }

    // ─────────────────────────────────────────────
    // 9. DELETE BOOKING (enquiry row)
    // ─────────────────────────────────────────────
    public boolean deleteBooking(int id) {
        String sql = "DELETE FROM enquiries WHERE id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ─────────────────────────────────────────────
    // 10. DELETE STUDENT
    // ─────────────────────────────────────────────
    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM students WHERE id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

 // ─────────────────────────────────────────────
 // 11. UPDATE STUDENT + sync back to enquiries
 // ─────────────────────────────────────────────
 public boolean updateStudent(int id, String fullName, String email, String phone,
                               String destination, String status) {
     Connection conn = null;
     try {
         conn = DbConfig.getConnection();
         conn.setAutoCommit(false);

         // Step 1: update the student row
         String updateStudentSql =
             "UPDATE students SET full_name = ?, email = ?, phone = ?, " +
             "destination = ?, status = ? WHERE id = ?";
         try (PreparedStatement ps = conn.prepareStatement(updateStudentSql)) {
             ps.setString(1, fullName);
             ps.setString(2, email);
             ps.setString(3, phone);
             ps.setString(4, destination);
             ps.setString(5, status);
             ps.setInt(6, id);
             ps.executeUpdate();
         }

         // Step 2: find the linked enquiry id
         int enquiryId = -1;
         String fetchSql = "SELECT source_enquiry_id FROM students WHERE id = ?";
         try (PreparedStatement ps = conn.prepareStatement(fetchSql)) {
             ps.setInt(1, id);
             try (ResultSet rs = ps.executeQuery()) {
                 if (rs.next()) {
                     enquiryId = rs.getInt("source_enquiry_id");
                     if (rs.wasNull()) enquiryId = -1;
                 }
             }
         }

         // Step 3: sync changes back to enquiries if a link exists
         if (enquiryId > 0) {
             // Map student status back to enquiry status
             String enquiryStatus;
             switch (status) {
                 case "Completed":   enquiryStatus = "Completed";  break;
                 case "Rejected":    enquiryStatus = "Rejected";   break;
                 case "On Hold":     enquiryStatus = "Pending";    break;
                 default:            enquiryStatus = "Accepted";   break; // "In Progress" etc.
             }

             String syncSql =
                 "UPDATE enquiries SET " +
                 "  name        = ?, " +
                 "  phone       = ?, " +
                 "  destination = ?, " +
                 "  status      = ? " +
                 "WHERE id = ?";
             try (PreparedStatement ps = conn.prepareStatement(syncSql)) {
                 ps.setString(1, fullName);
                 ps.setString(2, phone);
                 ps.setString(3, destination);
                 ps.setString(4, enquiryStatus);
                 ps.setInt(5, enquiryId);
                 ps.executeUpdate();
             }
         }

         conn.commit();
         return true;

     } catch (Exception e) {
         e.printStackTrace();
         if (conn != null) {
             try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
         }
         return false;
     } finally {
         if (conn != null) {
             try { conn.setAutoCommit(true); conn.close(); } catch (Exception e) { e.printStackTrace(); }
         }
     }
 }

    // ─────────────────────────────────────────────
    // 12. DELETE ENQUIRY
    // ─────────────────────────────────────────────
    public boolean deleteEnquiry(int id) {
        // Reuses the same enquiries table; alias kept separate for clarity
        return deleteBooking(id);
    }
}