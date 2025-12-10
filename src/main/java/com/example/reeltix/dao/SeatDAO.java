package com.example.reeltix.dao;

import com.example.reeltix.model.Seat;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {

    // Tìm ghế ngồi theo mã ghế
    public Seat findById(int maGhe) {
        String sql = "SELECT * FROM GheNgoi WHERE MaGhe = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maGhe);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSeat(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Tìm tất cả ghế ngồi theo mã phòng
    public List<Seat> findByRoom(int maPhong) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM GheNgoi WHERE MaPhong = ? ORDER BY TenGhe";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    seats.add(mapResultSetToSeat(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }

    // Tìm tất cả ghế ngồi đang hoạt động theo mã phòng
    public List<Seat> findAvailableByRoom(int maPhong) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM GheNgoi WHERE MaPhong = ? AND TrangThai = 'HoatDong' ORDER BY TenGhe";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    seats.add(mapResultSetToSeat(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }

    // Thêm mới ghế ngồi
    public boolean insert(Seat seat) {
        String sql = "INSERT INTO GheNgoi (MaPhong, TenGhe, LoaiGhe, GiaGhe, TrangThai) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, seat.getMaPhong());
            ps.setString(2, seat.getTenGhe());
            ps.setString(3, seat.getLoaiGhe());
            ps.setDouble(4, seat.getGiaGhe());
            ps.setString(5, seat.getTrangThai());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        seat.setMaGhe(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin ghế ngồi
    public boolean update(Seat seat) {
        String sql = "UPDATE GheNgoi SET MaPhong = ?, TenGhe = ?, LoaiGhe = ?, GiaGhe = ?, TrangThai = ? WHERE MaGhe = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seat.getMaPhong());
            ps.setString(2, seat.getTenGhe());
            ps.setString(3, seat.getLoaiGhe());
            ps.setDouble(4, seat.getGiaGhe());
            ps.setString(5, seat.getTrangThai());
            ps.setInt(6, seat.getMaGhe());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa ghế ngồi theo mã ghế
    public boolean delete(int maGhe) {
        String sql = "DELETE FROM GheNgoi WHERE MaGhe = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maGhe);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa ghế ngồi theo mã phòng
    public boolean deleteByRoom(int maPhong) {
        String sql = "DELETE FROM GheNgoi WHERE MaPhong = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhong);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Chuyển đổi ResultSet thành đối tượng Seat
    private Seat mapResultSetToSeat(ResultSet rs) throws SQLException {
        Seat seat = new Seat();
        seat.setMaGhe(rs.getInt("MaGhe"));
        seat.setMaPhong(rs.getInt("MaPhong"));
        seat.setTenGhe(rs.getString("TenGhe"));
        seat.setLoaiGhe(rs.getString("LoaiGhe"));
        seat.setGiaGhe(rs.getDouble("GiaGhe"));
        seat.setTrangThai(rs.getString("TrangThai"));
        return seat;
    }
}
