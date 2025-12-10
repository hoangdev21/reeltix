package com.example.reeltix.model;

public class Room {
    private int MaPhong;
    private String TenPhong;
    private int SoLuongGhe;
    private String TrangThai;
    private int SoHang;
    private int SoCot;

    // Constructors, getters, and setters
    public Room() {
    }

    public Room(int maPhong, String tenPhong, int soLuongGhe, String trangThai, int soHang, int soCot) {
        MaPhong = maPhong;
        TenPhong = tenPhong;
        SoLuongGhe = soLuongGhe;
        TrangThai = trangThai;
        SoHang = soHang;
        SoCot = soCot;
    }

    public int getMaPhong() {
        return MaPhong;
    }

    public void setMaPhong(int maPhong) {
        MaPhong = maPhong;
    }

    public String getTenPhong() {
        return TenPhong;
    }

    public void setTenPhong(String tenPhong) {
        TenPhong = tenPhong;
    }

    public int getSoLuongGhe() {
        return SoLuongGhe;
    }

    public void setSoLuongGhe(int soLuongGhe) {
        SoLuongGhe = soLuongGhe;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }

    public int getSoHang() {
        return SoHang;
    }

    public void setSoHang(int soHang) {
        SoHang = soHang;
    }

    public int getSoCot() {
        return SoCot;
    }

    public void setSoCot(int soCot) {
        SoCot = soCot;
    }
}
