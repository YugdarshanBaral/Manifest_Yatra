package dao;

import com.manifest_consultancy.utilities.DbConfig;
import java.sql.*;
import java.util.*;

public class AdminDAO {

    // Dashboard Statistics
    public int getTotalBookings() {
        return getCount("SELECT COUNT(*) FROM bookings");
    }

    public int getPendingBookings() {
        return getCount("SELECT COUNT(*) FROM bookings WHERE status = 'Pending'");
    }

    public int getConfirmedBookings() {
        return getCount("SELECT COUNT(*) FROM bookings WHERE status = 'Confirmed'");
    }

    public int getTotalStudents() {
        return getCount("SELECT COUNT(*) FROM students");
    }

    private int getCount(String sql) {
        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            System.err.println("Error in getCount: " + e.getMessage());
        }
        return 0;
    }

    // Recent Bookings
    public List<Map<String, String>> getRecentBookings(int limit) {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT id, student_name, destination, service_type, booking_date, status " +
                     "FROM bookings ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> map = new HashMap<>();
                map.put("id", String.valueOf(rs.getInt("id")));
                map.put("student_name", rs.getString("student_name"));
                map.put("destination", rs.getString("destination"));
                map.put("service_type", rs.getString("service_type"));
                map.put("booking_date", rs.getString("booking_date"));
                map.put("status", rs.getString("status"));
                list.add(map);
            }
        } catch (Exception e) {
            System.err.println("Error in getRecentBookings: " + e.getMessage());
        }
        return list;
    }
}