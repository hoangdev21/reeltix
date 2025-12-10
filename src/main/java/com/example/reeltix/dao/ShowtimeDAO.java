package com.example.reeltix.dao;

import com.example.reeltix.model.Showtime;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ShowtimeDAO {

    // Tìm suất chiếu theo mã suất chiếu
    public Showtime findById(int maSuatChieu) {
        String sql = "SELECT sc.*, p.TenPhim, ph.TenPhong FROM SuatChieu sc " +
                     "LEFT JOIN Phim p ON sc.MaPhim = p.MaPhim " +
                     "LEFT JOIN PhongChieu ph ON sc.MaPhong = ph.MaPhong " +
                     "WHERE sc.MaSuatChieu = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maSuatChieu);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToShowtime(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy tất cả suất chiếu, sắp xếp theo ngày chiếu giảm dần và giờ chiếu
    public List<Showtime> findAll() {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT sc.*, p.TenPhim, ph.TenPhong FROM SuatChieu sc " +
                     "LEFT JOIN Phim p ON sc.MaPhim = p.MaPhim " +
                     "LEFT JOIN PhongChieu ph ON sc.MaPhong = ph.MaPhong " +
                     "ORDER BY sc.NgayChieu DESC, sc.GioChieu";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                showtimes.add(mapResultSetToShowtime(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    // Tìm suất chiếu theo mã phim đang mở cửa
    public List<Showtime> findByMovie(int maPhim) {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT sc.*, p.TenPhim, ph.TenPhong FROM SuatChieu sc " +
                     "LEFT JOIN Phim p ON sc.MaPhim = p.MaPhim " +
                     "LEFT JOIN PhongChieu ph ON sc.MaPhong = ph.MaPhong " +
                     "WHERE sc.MaPhim = ? AND sc.TrangThai = 'MoCua' ORDER BY sc.NgayChieu, sc.GioChieu";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhim);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    showtimes.add(mapResultSetToShowtime(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    // Tìm suất chiếu theo mã phim và ngày chiếu đang mở cửa
    public List<Showtime> findByMovieAndDate(int maPhim, LocalDate ngayChieu) {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT sc.*, p.TenPhim, ph.TenPhong FROM SuatChieu sc " +
                     "LEFT JOIN Phim p ON sc.MaPhim = p.MaPhim " +
                     "LEFT JOIN PhongChieu ph ON sc.MaPhong = ph.MaPhong " +
                     "WHERE sc.MaPhim = ? AND sc.NgayChieu = ? AND sc.TrangThai = 'MoCua' ORDER BY sc.GioChieu";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhim);
            ps.setDate(2, Date.valueOf(ngayChieu));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    showtimes.add(mapResultSetToShowtime(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    // Thêm suất chiếu mới
    public boolean insert(Showtime showtime) {
        String sql = "INSERT INTO SuatChieu (MaPhim, MaPhong, NgayChieu, GioChieu, GiaVe, TrangThai) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, showtime.getMaPhim());
            ps.setInt(2, showtime.getMaPhong());
            ps.setDate(3, Date.valueOf(showtime.getNgayChieu()));
            ps.setTime(4, Time.valueOf(showtime.getGioChieu()));
            ps.setDouble(5, showtime.getGiaVe());
            ps.setString(6, showtime.getTrangThai());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        showtime.setMaSuatChieu(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin suất chiếu
    public boolean update(Showtime showtime) {
        String sql = "UPDATE SuatChieu SET MaPhim = ?, MaPhong = ?, NgayChieu = ?, GioChieu = ?, GiaVe = ?, TrangThai = ? WHERE MaSuatChieu = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showtime.getMaPhim());
            ps.setInt(2, showtime.getMaPhong());
            ps.setDate(3, Date.valueOf(showtime.getNgayChieu()));
            ps.setTime(4, Time.valueOf(showtime.getGioChieu()));
            ps.setDouble(5, showtime.getGiaVe());
            ps.setString(6, showtime.getTrangThai());
            ps.setInt(7, showtime.getMaSuatChieu());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa suất chiếu theo mã suất chiếu
    public boolean delete(int maSuatChieu) {
        String sql = "DELETE FROM SuatChieu WHERE MaSuatChieu = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maSuatChieu);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Chuyển đổi ResultSet thành đối tượng Showtime
    private Showtime mapResultSetToShowtime(ResultSet rs) throws SQLException {
        Showtime showtime = new Showtime();
        showtime.setMaSuatChieu(rs.getInt("MaSuatChieu"));
        showtime.setMaPhim(rs.getInt("MaPhim"));
        showtime.setMaPhong(rs.getInt("MaPhong"));
        showtime.setNgayChieu(rs.getDate("NgayChieu").toLocalDate());
        showtime.setGioChieu(rs.getTime("GioChieu").toLocalTime());
        showtime.setGiaVe(rs.getDouble("GiaVe"));
        showtime.setTrangThai(rs.getString("TrangThai"));
        showtime.setNgayTao(rs.getTimestamp("NgayTao"));

        // Set tên phim và tên phòng từ JOIN
        try {
            showtime.setTenPhim(rs.getString("TenPhim"));
            showtime.setTenPhong(rs.getString("TenPhong"));
        } catch (SQLException e) {
            // Nếu không có JOIN result, để giá trị mặc định null
        }

        return showtime;
    }
}

