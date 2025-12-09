package com.example.reeltix.dao;

import com.example.reeltix.model.Booking;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public Booking findById(String maDon) {
        String sql = "SELECT * FROM DatVe WHERE MaDon = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maDon);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Booking> findAll() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM DatVe ORDER BY NgayDat DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bookings.add(mapResultSetToBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> findByCustomer(int maKhachHang) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM DatVe WHERE MaKhachHang = ? ORDER BY NgayDat DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maKhachHang);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public boolean insert(Booking booking) {
        String sql = "INSERT INTO DatVe (MaDon, MaKhachHang, MaSuatChieu, SoLuongVe, TongTien) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, booking.getMaDon());
            ps.setInt(2, booking.getMaKhachHang());
            ps.setInt(3, booking.getMaSuatChieu());
            ps.setInt(4, booking.getSoLuongVe());
            ps.setDouble(5, booking.getTongTien());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(String maDon) {
        String sql = "DELETE FROM DatVe WHERE MaDon = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maDon);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String generateBookingId() {
        String prefix = "DV";
        String datePart = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String sql = "SELECT COUNT(*) + 1 AS next_num FROM DatVe WHERE MaDon LIKE ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, prefix + datePart + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int nextNum = rs.getInt("next_num");
                    return prefix + datePart + String.format("%03d", nextNum);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return prefix + datePart + "001";
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM DatVe";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(TongTien), 0) FROM DatVe";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Booking> getRecentBookings(int limit) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT dv.*, nd.HoTen as TenKhachHang, p.TenPhim " +
                     "FROM DatVe dv " +
                     "JOIN NguoiDung nd ON dv.MaKhachHang = nd.MaNguoiDung " +
                     "JOIN SuatChieu sc ON dv.MaSuatChieu = sc.MaSuatChieu " +
                     "JOIN Phim p ON sc.MaPhim = p.MaPhim " +
                     "ORDER BY dv.NgayDat DESC LIMIT ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking booking = mapResultSetToBooking(rs);
                    // Thêm thông tin bổ sung nếu cần
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setMaDon(rs.getString("MaDon"));
        booking.setMaKhachHang(rs.getInt("MaKhachHang"));
        booking.setMaSuatChieu(rs.getInt("MaSuatChieu"));
        booking.setSoLuongVe(rs.getInt("SoLuongVe"));
        booking.setTongTien(rs.getDouble("TongTien"));
        booking.setNgayDat(rs.getTimestamp("NgayDat"));
        booking.setNgayTao(rs.getTimestamp("NgayTao"));

        // Ánh xạ thông tin từ JOIN nếu có
        try {
            booking.setTenKhachHang(rs.getString("TenKhachHang"));
        } catch (SQLException e) {
            // Nếu không có trường TenKhachHang trong ResultSet, bỏ qua
        }

        try {
            booking.setTenPhim(rs.getString("TenPhim"));
        } catch (SQLException e) {
            // Nếu không có trường TenPhim trong ResultSet, bỏ qua
        }

        return booking;
    }
}
