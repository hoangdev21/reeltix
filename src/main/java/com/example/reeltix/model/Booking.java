package com.example.reeltix.model;

import java.sql.Timestamp;

public class Booking {
    private String MaDon;
    private int MaKhachHang;
    private int MaSuatChieu;
    private int SoLuongVe;
    private double TongTien;
    private Timestamp NgayDat;
    private Timestamp NgayTao;
    private String TenKhachHang;
    private String SoDienThoai;
    private String TenPhim;
    private String NgayChieu;
    private String GioChieu;
    private String TenPhong;
    private String TrangThai;

    public Booking() {
    }

    public Booking(String maDon, int maKhachHang, int maSuatChieu, int soLuongVe, double tongTien, Timestamp ngayDat, Timestamp ngayTao) {
        MaDon = maDon;
        MaKhachHang = maKhachHang;
        MaSuatChieu = maSuatChieu;
        SoLuongVe = soLuongVe;
        TongTien = tongTien;
        NgayDat = ngayDat;
        NgayTao = ngayTao;
    }

    public String getMaDon() {
        return MaDon;
    }

    public void setMaDon(String maDon) {
        MaDon = maDon;
    }

    public int getMaKhachHang() {
        return MaKhachHang;
    }

    public void setMaKhachHang(int maKhachHang) {
        MaKhachHang = maKhachHang;
    }

    public int getMaSuatChieu() {
        return MaSuatChieu;
    }

    public void setMaSuatChieu(int maSuatChieu) {
        MaSuatChieu = maSuatChieu;
    }

    public int getSoLuongVe() {
        return SoLuongVe;
    }

    public void setSoLuongVe(int soLuongVe) {
        SoLuongVe = soLuongVe;
    }

    public double getTongTien() {
        return TongTien;
    }

    public void setTongTien(double tongTien) {
        TongTien = tongTien;
    }

    public Timestamp getNgayDat() {
        return NgayDat;
    }

    public void setNgayDat(Timestamp ngayDat) {
        NgayDat = ngayDat;
    }

    public Timestamp getNgayTao() {
        return NgayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        NgayTao = ngayTao;
    }

    public String getTenKhachHang() {
        return TenKhachHang;
    }

    public void setTenKhachHang(String tenKhachHang) {
        TenKhachHang = tenKhachHang;
    }

    public String getSoDienThoai() {
        return SoDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        SoDienThoai = soDienThoai;
    }

    public String getTenPhim() {
        return TenPhim;
    }

    public void setTenPhim(String tenPhim) {
        TenPhim = tenPhim;
    }

    public String getNgayChieu() {
        return NgayChieu;
    }

    public void setNgayChieu(String ngayChieu) {
        NgayChieu = ngayChieu;
    }

    public String getGioChieu() {
        return GioChieu;
    }

    public void setGioChieu(String gioChieu) {
        GioChieu = gioChieu;
    }

    public String getTenPhong() {
        return TenPhong;
    }

    public void setTenPhong(String tenPhong) {
        TenPhong = tenPhong;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }
}
