package com.example.reeltix.dao;

import com.example.reeltix.model.Movie;
import com.example.reeltix.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    public Movie findById(int maPhim) {
        String sql = "SELECT * FROM Phim WHERE MaPhim = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhim);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMovie(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Movie> findAll() {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Phim ORDER BY NgayTao DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                movies.add(mapResultSetToMovie(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public List<Movie> findByStatus(String trangThai) {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Phim WHERE TrangThai = ? ORDER BY NgayKhoiChieu DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    movies.add(mapResultSetToMovie(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public List<Movie> findNowShowing() {
        return findByStatus("DangChieu");
    }

    public List<Movie> findComingSoon() {
        return findByStatus("SapChieu");
    }

    public boolean insert(Movie movie) {
        String sql = "INSERT INTO Phim (TenPhim, MoTa, AnhPoster, ThoiLuong, DaoDien, DienVien, TheLoai, TrangThai, NgayKhoiChieu) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, movie.getTenPhim());
            ps.setString(2, movie.getMoTa());
            ps.setString(3, movie.getAnhPoster());
            ps.setInt(4, movie.getThoiLuong());
            ps.setString(5, movie.getDaoDien());
            ps.setString(6, movie.getDienVien());
            ps.setString(7, movie.getTheLoai());
            ps.setString(8, movie.getTrangThai());
            ps.setTimestamp(9, movie.getNgayKhoiChieu());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        movie.setMaPhim(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Movie movie) {
        String sql = "UPDATE Phim SET TenPhim = ?, MoTa = ?, AnhPoster = ?, ThoiLuong = ?, DaoDien = ?, DienVien = ?, TheLoai = ?, TrangThai = ?, NgayKhoiChieu = ? WHERE MaPhim = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, movie.getTenPhim());
            ps.setString(2, movie.getMoTa());
            ps.setString(3, movie.getAnhPoster());
            ps.setInt(4, movie.getThoiLuong());
            ps.setString(5, movie.getDaoDien());
            ps.setString(6, movie.getDienVien());
            ps.setString(7, movie.getTheLoai());
            ps.setString(8, movie.getTrangThai());
            ps.setTimestamp(9, movie.getNgayKhoiChieu());
            ps.setInt(10, movie.getMaPhim());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int maPhim) {
        String sql = "DELETE FROM Phim WHERE MaPhim = ?";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhim);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Movie> search(String keyword) {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Phim WHERE TenPhim LIKE ? OR DaoDien LIKE ? OR DienVien LIKE ? OR TheLoai LIKE ? ORDER BY NgayTao DESC";
        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    movies.add(mapResultSetToMovie(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM Phim";
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

    public List<Movie> findByStatusAndSearch(String status, String search) {
        List<Movie> movies = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Phim WHERE 1=1");

        if (status != null && !status.isEmpty()) {
            sql.append(" AND TrangThai = ?");
        }
        if (search != null && !search.isEmpty()) {
            sql.append(" AND TenPhim LIKE ?");
        }
        sql.append(" ORDER BY NgayTao DESC");

        try (Connection conn = DBConnection.getNewConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            if (search != null && !search.isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    movies.add(mapResultSetToMovie(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    private Movie mapResultSetToMovie(ResultSet rs) throws SQLException {
        Movie movie = new Movie();
        movie.setMaPhim(rs.getInt("MaPhim"));
        movie.setTenPhim(rs.getString("TenPhim"));
        movie.setMoTa(rs.getString("MoTa"));
        movie.setAnhPoster(rs.getString("AnhPoster"));
        movie.setThoiLuong(rs.getInt("ThoiLuong"));
        movie.setDaoDien(rs.getString("DaoDien"));
        movie.setDienVien(rs.getString("DienVien"));
        movie.setTheLoai(rs.getString("TheLoai"));
        movie.setTrangThai(rs.getString("TrangThai"));
        movie.setNgayKhoiChieu(rs.getTimestamp("NgayKhoiChieu"));
        movie.setNgayTao(rs.getTimestamp("NgayTao"));
        return movie;
    }
}
