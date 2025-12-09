package com.example.reeltix.model;

public class Seat {
    private int MaGhe;
    private int MaPhong;
    private String TenGhe;
    private String LoaiGhe;
    private double GiaGhe;
    private String TrangThai;

    public Seat() {
    }

    public Seat(int maGhe, int maPhong, String tenGhe, String loaiGhe, double giaGhe, String trangThai) {
        MaGhe = maGhe;
        MaPhong = maPhong;
        TenGhe = tenGhe;
        LoaiGhe = loaiGhe;
        GiaGhe = giaGhe;
        TrangThai = trangThai;
    }

    public int getMaGhe() {
        return MaGhe;
    }

    public void setMaGhe(int maGhe) {
        MaGhe = maGhe;
    }

    public int getMaPhong() {
        return MaPhong;
    }

    public void setMaPhong(int maPhong) {
        MaPhong = maPhong;
    }

    public String getTenGhe() {
        return TenGhe;
    }

    public void setTenGhe(String tenGhe) {
        TenGhe = tenGhe;
    }

    public String getLoaiGhe() {
        return LoaiGhe;
    }

    public void setLoaiGhe(String loaiGhe) {
        LoaiGhe = loaiGhe;
    }

    public double getGiaGhe() {
        return GiaGhe;
    }

    public void setGiaGhe(double giaGhe) {
        GiaGhe = giaGhe;
    }

    public String getTrangThai() {
        return TrangThai;
    }

    public void setTrangThai(String trangThai) {
        TrangThai = trangThai;
    }
}
