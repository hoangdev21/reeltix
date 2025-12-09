package com.example.reeltix.dao;

import com.example.reeltix.model.User;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User findByUsername(String tenDangNhap) {
        String sql = "SELECT * FROM NguoiDung WHERE TenDangNhap = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenDangNhap);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findById(int maNguoiDung) {
        String sql = "SELECT * FROM NguoiDung WHERE MaNguoiDung = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maNguoiDung);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM NguoiDung ORDER BY NgayTao DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean insert(User user) {
        String sql = "INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro, SoDienThoai, TrangThai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getTenDangNhap());
            ps.setString(2, user.getMatKhau());
            ps.setString(3, user.getHoTen());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getVaiTro());
            ps.setString(6, user.getSoDienThoai());
            ps.setString(7, user.getTrangThai());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setMaNguoiDung(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(User user) {
        String sql = "UPDATE NguoiDung SET TenDangNhap = ?, MatKhau = ?, HoTen = ?, Email = ?, VaiTro = ?, SoDienThoai = ?, TrangThai = ? WHERE MaNguoiDung = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getTenDangNhap());
            ps.setString(2, user.getMatKhau());
            ps.setString(3, user.getHoTen());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getVaiTro());
            ps.setString(6, user.getSoDienThoai());
            ps.setString(7, user.getTrangThai());
            ps.setInt(8, user.getMaNguoiDung());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int maNguoiDung) {
        String sql = "DELETE FROM NguoiDung WHERE MaNguoiDung = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maNguoiDung);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User authenticate(String tenDangNhap, String matKhau) {
        String sql = "SELECT * FROM NguoiDung WHERE TenDangNhap = ? AND MatKhau = ? AND TrangThai = 'HoatDong'";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenDangNhap);
            ps.setString(2, matKhau);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM NguoiDung";
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

    public List<User> findByRoleAndStatus(String role, String status, String search) {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM NguoiDung WHERE 1=1");

        if (role != null && !role.isEmpty()) {
            sql.append(" AND VaiTro = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND TrangThai = ?");
        }
        if (search != null && !search.isEmpty()) {
            sql.append(" AND (HoTen LIKE ? OR Email LIKE ? OR SoDienThoai LIKE ?)");
        }
        sql.append(" ORDER BY NgayTao DESC");

        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (role != null && !role.isEmpty()) {
                ps.setString(paramIndex++, role);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            if (search != null && !search.isEmpty()) {
                String searchPattern = "%" + search + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean updateStatus(int maNguoiDung, String trangThai) {
        String sql = "UPDATE NguoiDung SET TrangThai = ? WHERE MaNguoiDung = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setInt(2, maNguoiDung);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setMaNguoiDung(rs.getInt("MaNguoiDung"));
        user.setTenDangNhap(rs.getString("TenDangNhap"));
        user.setMatKhau(rs.getString("MatKhau"));
        user.setHoTen(rs.getString("HoTen"));
        user.setEmail(rs.getString("Email"));
        user.setVaiTro(rs.getString("VaiTro"));
        user.setSoDienThoai(rs.getString("SoDienThoai"));
        user.setTrangThai(rs.getString("TrangThai"));
        user.setNgayTao(rs.getTimestamp("NgayTao"));
        return user;
    }
}
