package com.example.reeltix.dao;

import com.example.reeltix.model.Room;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // Tìm phòng chiếu theo mã phòng
    public Room findById(int maPhong) {
        String sql = "SELECT * FROM PhongChieu WHERE MaPhong = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRoom(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy tất cả phòng chiếu, sắp xếp theo tên phòng
    public List<Room> findAll() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM PhongChieu ORDER BY TenPhong";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rooms.add(mapResultSetToRoom(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    // Lấy tất cả phòng chiếu đang hoạt động
    public List<Room> findActive() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM PhongChieu WHERE TrangThai = 'HoatDong' ORDER BY TenPhong";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                rooms.add(mapResultSetToRoom(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    // Thêm phòng chiếu mới
    public boolean insert(Room room) {
        String sql = "INSERT INTO PhongChieu (TenPhong, SoLuongGhe, TrangThai) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, room.getTenPhong());
            ps.setInt(2, room.getSoLuongGhe());
            ps.setString(3, room.getTrangThai());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        room.setMaPhong(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin phòng chiếu
    public boolean update(Room room) {
        String sql = "UPDATE PhongChieu SET TenPhong = ?, SoLuongGhe = ?, TrangThai = ? WHERE MaPhong = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getTenPhong());
            ps.setInt(2, room.getSoLuongGhe());
            ps.setString(3, room.getTrangThai());
            ps.setInt(4, room.getMaPhong());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa phòng chiếu theo mã phòng
    public boolean delete(int maPhong) {
        String sql = "DELETE FROM PhongChieu WHERE MaPhong = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhong);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Chuyển đổi ResultSet thành đối tượng Room
    private Room mapResultSetToRoom(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setMaPhong(rs.getInt("MaPhong"));
        room.setTenPhong(rs.getString("TenPhong"));
        room.setSoLuongGhe(rs.getInt("SoLuongGhe"));
        room.setTrangThai(rs.getString("TrangThai"));
        int[] hangCot = getSoHangSoCot(rs.getInt("MaPhong"));
        room.setSoHang(hangCot[0]);
        room.setSoCot(hangCot[1]);
        return room;
    }

    // Tính số hàng và số cột từ bảng GheNgoi
    private int[] getSoHangSoCot(int maPhong) {
        String sql = "SELECT " +
                     "MAX(ASCII(SUBSTRING(TenGhe, 1, 1))) AS maxRow, " +
                     "MAX(CAST(SUBSTRING(TenGhe, 2) AS UNSIGNED)) AS maxCol " +
                     "FROM GheNgoi WHERE MaPhong = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int maxRow = rs.getInt("maxRow");
                    int maxCol = rs.getInt("maxCol");
                    int soHang = (maxRow > 0) ? (maxRow - 'A' + 1) : 0;
                    int soCot = maxCol;
                    return new int[]{soHang, soCot};
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new int[]{0, 0};
    }
}
