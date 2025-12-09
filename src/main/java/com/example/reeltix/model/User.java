package com.example.reeltix.model;

import java.sql.Timestamp;

public class User {
    private int MaNguoiDung;
    private String TenDangNhap;
    private String MatKhau;
    private String HoTen;
    private String Email;
    private String VaiTro;
    private String SoDienThoai;
    private String TrangThai;
    private Timestamp NgayTao;

    public User() {
    }

    public User(int maNguoiDung, String tenDangNhap, String matKhau, String hoTen, String email, String vaiTro, String soDienThoai, String trangThai, Timestamp ngayTao) {
        MaNguoiDung = maNguoiDung;
        TenDangNhap = tenDangNhap;
        MatKhau = matKhau;
        HoTen = hoTen;
        Email = email;
        VaiTro = vaiTro;
        SoDienThoai = soDienThoai;
        TrangThai = trangThai;
        NgayTao = ngayTao;
    }

    public int getMaNguoiDung() {
        return MaNguoiDung;
    }

    public void setMaNguoiDung(int maNguoiDung) {
        MaNguoiDung = maNguoiDung;
    }

    public String getTenDangNhap() {
        return TenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        TenDangNhap = tenDangNhap;
    }

    public String getMatKhau() {
        return MatKhau;
    }

    public void setMatKhau(String matKhau) {
        MatKhau = matKhau;
    }

    public String getHoTen() {
        return HoTen;
    }

    public void setHoTen(String hoTen) {
        HoTen = hoTen;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getVaiTro() {
        return VaiTro;
    }

    public void setVaiTro(String vaiTro) {
        VaiTro = vaiTro;
    }

    public String getSoDienThoai() {
        return SoDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        SoDienThoai = soDienThoai;
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
}
