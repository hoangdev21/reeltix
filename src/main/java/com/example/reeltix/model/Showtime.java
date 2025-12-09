package com.example.reeltix.model;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;

public class Showtime {
    private int MaSuatChieu;
    private int MaPhim;
    private int MaPhong;
    private LocalDate NgayChieu;
    private LocalTime GioChieu;
    private double GiaVe;
    private String TrangThai;
    private Timestamp NgayTao;
    private String TenPhim;
    private String TenPhong;

    public Showtime() {
    }

    public Showtime(int maSuatChieu, int maPhim, int maPhong, LocalDate ngayChieu, LocalTime gioChieu, double giaVe, String trangThai, Timestamp ngayTao) {
        MaSuatChieu = maSuatChieu;
        MaPhim = maPhim;
        MaPhong = maPhong;
        NgayChieu = ngayChieu;
        GioChieu = gioChieu;
        GiaVe = giaVe;
        TrangThai = trangThai;
        NgayTao = ngayTao;
    }

    public int getMaSuatChieu() {
        return MaSuatChieu;
    }

    public void setMaSuatChieu(int maSuatChieu) {
        MaSuatChieu = maSuatChieu;
    }

    public int getMaPhim() {
        return MaPhim;
    }

    public void setMaPhim(int maPhim) {
        MaPhim = maPhim;
    }

    public int getMaPhong() {
        return MaPhong;
    }

    public void setMaPhong(int maPhong) {
        MaPhong = maPhong;
    }

    public LocalDate getNgayChieu() {
        return NgayChieu;
    }

    public void setNgayChieu(LocalDate ngayChieu) {
        NgayChieu = ngayChieu;
    }

    public LocalTime getGioChieu() {
        return GioChieu;
    }

    public void setGioChieu(LocalTime gioChieu) {
        GioChieu = gioChieu;
    }

    public double getGiaVe() {
        return GiaVe;
    }

    public void setGiaVe(double giaVe) {
        GiaVe = giaVe;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }

    public Timestamp getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        NgayTao = ngayTao;
    }

    public String getTenPhim() {
        return TenPhim;
    }

    public void setTenPhim(String tenPhim) {
        TenPhim = tenPhim;
    }

    public String getTenPhong() {
        return TenPhong;
    }

    public void setTenPhong(String tenPhong) {
        TenPhong = tenPhong;
    }
}
