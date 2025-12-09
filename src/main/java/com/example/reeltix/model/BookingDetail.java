package com.example.reeltix.model;

public class BookingDetail {
    private int MaChiTietDatVe;
    private String MaDon;
    private int MaGhe;
    private double GiaGhe;

    public BookingDetail() {
    }

    public BookingDetail(int maChiTietDatVe, String maDon, int maGhe, double giaGhe) {
        MaChiTietDatVe = maChiTietDatVe;
        MaDon = maDon;
        MaGhe = maGhe;
        GiaGhe = giaGhe;
    }

    public int getMaChiTietDatVe() {
        return MaChiTietDatVe;
    }

    public void setMaChiTietDatVe(int maChiTietDatVe) {
        MaChiTietDatVe = maChiTietDatVe;
    }

    public String getMaDon() {
        return MaDon;
    }

    public void setMaDon(String maDon) {
        MaDon = maDon;
    }

    public int getMaGhe() {
        return MaGhe;
    }

    public void setMaGhe(int maGhe) {
        MaGhe = maGhe;
    }

    public double getGiaGhe() {
        return GiaGhe;
    }

    public void setGiaGhe(double giaGhe) {
        GiaGhe = giaGhe;
    }
}
