package com.example.reeltix.dao;

import com.example.reeltix.model.Payment;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    public Payment findById(int maThanhToan) {
        String sql = "SELECT * FROM ThanhToan WHERE MaThanhToan = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maThanhToan);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPayment(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Payment findByBooking(String maDon) {
        String sql = "SELECT * FROM ThanhToan WHERE MaDon = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maDon);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPayment(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Payment> findAll() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM ThanhToan ORDER BY NgayThanhToan DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public boolean insert(Payment payment) {
        String sql = "INSERT INTO ThanhToan (MaDon, PhuongThuc, SoTien, TrangThai) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, payment.getMaDon());
            ps.setString(2, payment.getPhuongThuc());
            ps.setDouble(3, payment.getSoTien());
            ps.setString(4, payment.getTrangThai());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        payment.setMaThanhToan(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStatus(int maThanhToan, String trangThai) {
        String sql = "UPDATE ThanhToan SET TrangThai = ? WHERE MaThanhToan = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setInt(2, maThanhToan);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int maThanhToan) {
        String sql = "DELETE FROM ThanhToan WHERE MaThanhToan = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maThanhToan);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setMaThanhToan(rs.getInt("MaThanhToan"));
        payment.setMaDon(rs.getString("MaDon"));
        payment.setPhuongThuc(rs.getString("PhuongThuc"));
        payment.setSoTien(rs.getDouble("SoTien"));
        payment.setTrangThai(rs.getString("TrangThai"));
        payment.setNgayThanhToan(rs.getTimestamp("NgayThanhToan"));
        return payment;
    }
}
