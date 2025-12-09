package com.example.reeltix.dao;

import com.example.reeltix.model.BookingDetail;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDetailDAO {

    public List<BookingDetail> findByBooking(String maDon) {
        List<BookingDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM ChiTietDatVe WHERE MaDon = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maDon);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    details.add(mapResultSetToBookingDetail(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }

    public boolean insert(BookingDetail detail) {
        String sql = "INSERT INTO ChiTietDatVe (MaDon, MaGhe, GiaGhe) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, detail.getMaDon());
            ps.setInt(2, detail.getMaGhe());
            ps.setDouble(3, detail.getGiaGhe());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        detail.setMaChiTietDatVe(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertBatch(List<BookingDetail> details) {
        String sql = "INSERT INTO ChiTietDatVe (MaDon, MaGhe, GiaGhe) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            conn.setAutoCommit(false);

            for (BookingDetail detail : details) {
                ps.setString(1, detail.getMaDon());
                ps.setInt(2, detail.getMaGhe());
                ps.setDouble(3, detail.getGiaGhe());
                ps.addBatch();
            }

            ps.executeBatch();
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteByBooking(String maDon) {
        String sql = "DELETE FROM ChiTietDatVe WHERE MaDon = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maDon);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Integer> findBookedSeatsByShowtime(int maSuatChieu) {
        List<Integer> seatIds = new ArrayList<>();
        String sql = "SELECT ct.MaGhe FROM ChiTietDatVe ct " +
                     "INNER JOIN DatVe dv ON ct.MaDon = dv.MaDon " +
                     "WHERE dv.MaSuatChieu = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maSuatChieu);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    seatIds.add(rs.getInt("MaGhe"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seatIds;
    }

    public int countByShowtimeId(int maSuatChieu) {
        String sql = "SELECT COUNT(ct.MaChiTietDatVe) as total FROM ChiTietDatVe ct " +
                     "INNER JOIN DatVe dv ON ct.MaDon = dv.MaDon " +
                     "WHERE dv.MaSuatChieu = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maSuatChieu);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private BookingDetail mapResultSetToBookingDetail(ResultSet rs) throws SQLException {
        BookingDetail detail = new BookingDetail();
        detail.setMaChiTietDatVe(rs.getInt("MaChiTietDatVe"));
        detail.setMaDon(rs.getString("MaDon"));
        detail.setMaGhe(rs.getInt("MaGhe"));
        detail.setGiaGhe(rs.getDouble("GiaGhe"));
        return detail;
    }
}
