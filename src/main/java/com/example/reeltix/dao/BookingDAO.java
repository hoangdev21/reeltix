package com.example.reeltix.dao;

import com.example.reeltix.model.Booking;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Tìm đơn đặt vé theo mã đơn
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

    // Lấy tất cả đơn đặt vé với thông tin bổ sung từ các bảng liên quan
    public List<Booking> findAll() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT dv.*, " +
                     "nd.HoTen as TenKhachHang, nd.SoDienThoai, " +
                     "p.TenPhim, " +
                     "sc.NgayChieu, sc.GioChieu, " +
                     "ph.TenPhong " +
                     "FROM DatVe dv " +
                     "LEFT JOIN NguoiDung nd ON dv.MaKhachHang = nd.MaNguoiDung " +
                     "LEFT JOIN SuatChieu sc ON dv.MaSuatChieu = sc.MaSuatChieu " +
                     "LEFT JOIN Phim p ON sc.MaPhim = p.MaPhim " +
                     "LEFT JOIN PhongChieu ph ON sc.MaPhong = ph.MaPhong " +
                     "ORDER BY dv.NgayDat DESC";
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

    // Tìm đơn đặt vé theo mã khách hàng
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

    // Thêm đơn đặt vé mới
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

    // Xóa đơn đặt vé theo mã đơn
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

    // Tạo mã đơn đặt vé mới
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

    // Thống kê tổng số đơn đặt vé
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

    // Thống kê tổng doanh thu từ đơn đặt vé
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

    // Lấy danh sách đơn đặt vé gần đây với giới hạn
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

    // Phương thức ánh xạ ResultSet thành đối tượng Booking
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
            booking.setSoDienThoai(rs.getString("SoDienThoai"));
        } catch (SQLException e) {
            // Nếu không có trường SoDienThoai trong ResultSet, bỏ qua
        }

        try {
            booking.setTenPhim(rs.getString("TenPhim"));
        } catch (SQLException e) {
            // Nếu không có trường TenPhim trong ResultSet, bỏ qua
        }

        try {
            String ngayChieu = rs.getString("NgayChieu");
            if (ngayChieu != null) {
                booking.setNgayChieu(ngayChieu);
            }
        } catch (SQLException e) {
            // Nếu không có trường NgayChieu trong ResultSet, bỏ qua
        }

        try {
            String gioChieu = rs.getString("GioChieu");
            if (gioChieu != null) {
                booking.setGioChieu(gioChieu);
            }
        } catch (SQLException e) {
            // Nếu không có trường GioChieu trong ResultSet, bỏ qua
        }

        try {
            booking.setTenPhong(rs.getString("TenPhong"));
        } catch (SQLException e) {
            // Nếu không có trường TenPhong trong ResultSet, bỏ qua
        }

        return booking;
    }
}
