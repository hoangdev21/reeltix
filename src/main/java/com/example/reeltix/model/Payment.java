package com.example.reeltix.model;

import java.sql.Timestamp;

public class Payment {
    private int MaThanhToan;
    private String MaDon;
    private String PhuongThuc;
    private double SoTien;
    private String TrangThai;
    private Timestamp NgayThanhToan;

    public Payment() {
    }

    public Payment(int maThanhToan, String maDon, String phuongThuc, double soTien, String trangThai, Timestamp ngayThanhToan) {
        MaThanhToan = maThanhToan;
        MaDon = maDon;
        PhuongThuc = phuongThuc;
        SoTien = soTien;
        TrangThai = trangThai;
        NgayThanhToan = ngayThanhToan;
    }

    public int getMaThanhToan() {
        return MaThanhToan;
    }

    public void setMaThanhToan(int maThanhToan) {
        MaThanhToan = maThanhToan;
    }

    public String getMaDon() {
        return MaDon;
    }

    public void setMaDon(String maDon) {
        MaDon = maDon;
    }

    public String getPhuongThuc() {
        return PhuongThuc;
    }

    public void setPhuongThuc(String phuongThuc) {
        PhuongThuc = phuongThuc;
    }

    public double getSoTien() {
        return SoTien;
    }

    public void setSoTien(double soTien) {
        SoTien = soTien;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }

    public Timestamp getNgayThanhToan() {
        return NgayThanhToan;
    }

    public void setNgayThanhToan(Timestamp ngayThanhToan) {
        NgayThanhToan = ngayThanhToan;
    }
}
