package com.example.reeltix.model;

import java.sql.Timestamp;

public class Movie {
    private int MaPhim;
    private String TenPhim;
    private String MoTa;
    private String AnhPoster;
    private int ThoiLuong;
    private String DaoDien;
    private String DienVien;
    private String TheLoai;
    private String TrangThai;
    private Timestamp NgayKhoiChieu;
    private Timestamp NgayTao;

    // Constructors, getters, and setters
    public Movie() {
    }

    public Movie(int maPhim, String tenPhim, String moTa, String anhPoster, int thoiLuong, String daoDien,
                 String dienVien, String theLoai, String trangThai, Timestamp ngayKhoiChieu, Timestamp ngayTao) {
        MaPhim = maPhim;
        TenPhim = tenPhim;
        MoTa = moTa;
        AnhPoster = anhPoster;
        ThoiLuong = thoiLuong;
        DaoDien = daoDien;
        DienVien = dienVien;
        TheLoai = theLoai;
        TrangThai = trangThai;
        NgayKhoiChieu = ngayKhoiChieu;
        NgayTao = ngayTao;
    }

    public int getMaPhim() {
        return MaPhim;
    }

    public void setMaPhim(int maPhim) {
        MaPhim = maPhim;
    }

    public String getTenPhim() {
        return TenPhim;
    }

    public void setTenPhim(String tenPhim) {
        TenPhim = tenPhim;
    }

    public String getMoTa() {
        return MoTa;
    }

    public void setMoTa(String moTa) {
        MoTa = moTa;
    }

    public String getAnhPoster() {
        return AnhPoster;
    }

    public void setAnhPoster(String anhPoster) {
        AnhPoster = anhPoster;
    }

    public int getThoiLuong() {
        return ThoiLuong;
    }

    public void setThoiLuong(int thoiLuong) {
        ThoiLuong = thoiLuong;
    }

    public String getDaoDien() {
        return DaoDien;
    }

    public void setDaoDien(String daoDien) {
        DaoDien = daoDien;
    }

    public String getDienVien() {
        return DienVien;
    }

    public void setDienVien(String dienVien) {
        DienVien = dienVien;
    }

    public String getTheLoai() {
        return TheLoai;
    }

    public void setTheLoai(String theLoai) {
        TheLoai = theLoai;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }

    public Timestamp getNgayKhoiChieu() {
        return NgayKhoiChieu;
    }

    public void setNgayKhoiChieu(Timestamp ngayKhoiChieu) {
        NgayKhoiChieu = ngayKhoiChieu;
    }

    public Timestamp getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        NgayTao = ngayTao;
    }
}

