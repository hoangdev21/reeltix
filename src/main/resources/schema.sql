-- Schema Database cho hệ thống đặt vé xem phim Reeltix
-- Tên bảng và thuộc tính tiếng Việt không dấu

CREATE DATABASE IF NOT EXISTS reeltix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE reeltix;

-- Bảng NguoiDung (User)
CREATE TABLE IF NOT EXISTS NguoiDung (
    MaNguoiDung INT AUTO_INCREMENT PRIMARY KEY,
    TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
    MatKhau VARCHAR(255) NOT NULL,
    HoTen NVARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    VaiTro ENUM('Admin', 'KhachHang') DEFAULT 'KhachHang',
    SoDienThoai VARCHAR(15),
    TrangThai ENUM('HoatDong', 'Khoa') DEFAULT 'HoatDong',
    NgayTao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng Phim (Movie)
CREATE TABLE IF NOT EXISTS Phim (
    MaPhim INT AUTO_INCREMENT PRIMARY KEY,
    TenPhim NVARCHAR(200) NOT NULL,
    MoTa TEXT,
    AnhPoster VARCHAR(500),
    ThoiLuong INT NOT NULL COMMENT 'Thời lượng tính bằng phút',
    DaoDien NVARCHAR(100),
    DienVien TEXT,
    TheLoai NVARCHAR(100),
    TrangThai ENUM('DangChieu', 'SapChieu', 'NgungChieu') DEFAULT 'SapChieu',
    NgayKhoiChieu TIMESTAMP,
    NgayTao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng PhongChieu (Room)
CREATE TABLE IF NOT EXISTS PhongChieu (
    MaPhong INT AUTO_INCREMENT PRIMARY KEY,
    TenPhong NVARCHAR(50) NOT NULL,
    SoLuongGhe INT NOT NULL,
    TrangThai ENUM('HoatDong', 'BaoTri') DEFAULT 'HoatDong'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng GheNgoi (Seat)
CREATE TABLE IF NOT EXISTS GheNgoi (
    MaGhe INT AUTO_INCREMENT PRIMARY KEY,
    MaPhong INT NOT NULL,
    TenGhe VARCHAR(10) NOT NULL COMMENT 'Ví dụ: A1, A2, B1...',
    LoaiGhe ENUM('Thuong', 'VIP', 'Doi') DEFAULT 'Thuong',
    GiaGhe DECIMAL(10, 2) DEFAULT 0,
    TrangThai ENUM('HoatDong', 'Hong') DEFAULT 'HoatDong',
    FOREIGN KEY (MaPhong) REFERENCES PhongChieu(MaPhong) ON DELETE CASCADE,
    UNIQUE KEY unique_seat (MaPhong, TenGhe)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng SuatChieu (Showtime)
CREATE TABLE IF NOT EXISTS SuatChieu (
    MaSuatChieu INT AUTO_INCREMENT PRIMARY KEY,
    MaPhim INT NOT NULL,
    MaPhong INT NOT NULL,
    NgayChieu DATE NOT NULL,
    GioChieu TIME NOT NULL,
    GiaVe DECIMAL(10, 2) NOT NULL,
    TrangThai ENUM('MoCua', 'DaDong', 'Huy') DEFAULT 'MoCua',
    NgayTao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MaPhim) REFERENCES Phim(MaPhim) ON DELETE CASCADE,
    FOREIGN KEY (MaPhong) REFERENCES PhongChieu(MaPhong) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng DatVe (Booking)
CREATE TABLE IF NOT EXISTS DatVe (
    MaDon VARCHAR(20) PRIMARY KEY COMMENT 'Mã đơn đặt vé, ví dụ: DV20231209001',
    MaKhachHang INT NOT NULL,
    MaSuatChieu INT NOT NULL,
    SoLuongVe INT NOT NULL,
    TongTien DECIMAL(12, 2) NOT NULL,
    NgayDat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    NgayTao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MaKhachHang) REFERENCES NguoiDung(MaNguoiDung) ON DELETE CASCADE,
    FOREIGN KEY (MaSuatChieu) REFERENCES SuatChieu(MaSuatChieu) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng ChiTietDatVe (BookingDetail)
CREATE TABLE IF NOT EXISTS ChiTietDatVe (
    MaChiTietDatVe INT AUTO_INCREMENT PRIMARY KEY,
    MaDon VARCHAR(20) NOT NULL,
    MaGhe INT NOT NULL,
    GiaGhe DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaDon) REFERENCES DatVe(MaDon) ON DELETE CASCADE,
    FOREIGN KEY (MaGhe) REFERENCES GheNgoi(MaGhe) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng ThanhToan (Payment)
CREATE TABLE IF NOT EXISTS ThanhToan (
    MaThanhToan INT AUTO_INCREMENT PRIMARY KEY,
    MaDon VARCHAR(20) NOT NULL,
    PhuongThuc ENUM('TienMat', 'ChuyenKhoan', 'MoMo', 'VNPay', 'ZaloPay') NOT NULL,
    SoTien DECIMAL(12, 2) NOT NULL,
    TrangThai ENUM('ChoXuLy', 'ThanhCong', 'ThatBai', 'Huy') DEFAULT 'ChoXuLy',
    NgayThanhToan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MaDon) REFERENCES DatVe(MaDon) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Thêm dữ liệu mẫu

-- Thêm tài khoản Admin
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro, SoDienThoai, TrangThai) VALUES
('admin', 'admin123', 'Quản Trị Viên', 'admin@reeltix.com', 'Admin', '0123456789', 'HoatDong');

-- Thêm tài khoản Khách hàng mẫu
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro, SoDienThoai, TrangThai) VALUES
('khachhang1', '123456', 'Nguyễn Văn A', 'nguyenvana@gmail.com', 'KhachHang', '0987654321', 'HoatDong'),
('khachhang2', '123456', 'Trần Thị B', 'tranthib@gmail.com', 'KhachHang', '0912345678', 'HoatDong');

-- Thêm phim mẫu
INSERT INTO Phim (TenPhim, MoTa, AnhPoster, ThoiLuong, DaoDien, DienVien, TheLoai, TrangThai, NgayKhoiChieu) VALUES
('Avengers: Endgame', 'Các siêu anh hùng hợp sức để đánh bại Thanos và khôi phục vũ trụ.', 'avengers_endgame.jpg', 181, 'Anthony Russo, Joe Russo', 'Robert Downey Jr., Chris Evans, Scarlett Johansson', 'Hành động, Khoa học viễn tưởng', 'DangChieu', '2024-01-15 00:00:00'),
('Spider-Man: No Way Home', 'Peter Parker phải đối mặt với hậu quả khi danh tính bị lộ.', 'spiderman_nwh.jpg', 148, 'Jon Watts', 'Tom Holland, Zendaya, Benedict Cumberbatch', 'Hành động, Phiêu lưu', 'DangChieu', '2024-02-01 00:00:00'),
('The Batman', 'Batman điều tra một loạt các vụ án giết người bí ẩn tại Gotham.', 'the_batman.jpg', 176, 'Matt Reeves', 'Robert Pattinson, Zoë Kravitz, Paul Dano', 'Hành động, Tội phạm', 'SapChieu', '2024-03-01 00:00:00');

-- Thêm phòng chiếu mẫu
INSERT INTO PhongChieu (TenPhong, SoLuongGhe, TrangThai) VALUES
('Phòng 1', 50, 'HoatDong'),
('Phòng 2', 60, 'HoatDong'),
('Phòng 3', 40, 'HoatDong'),
('Phòng VIP', 30, 'HoatDong');

-- Thêm ghế cho Phòng 1 (5 hàng x 10 ghế)
INSERT INTO GheNgoi (MaPhong, TenGhe, LoaiGhe, GiaGhe, TrangThai) VALUES
(1, 'A1', 'Thuong', 0, 'HoatDong'), (1, 'A2', 'Thuong', 0, 'HoatDong'), (1, 'A3', 'Thuong', 0, 'HoatDong'), (1, 'A4', 'Thuong', 0, 'HoatDong'), (1, 'A5', 'Thuong', 0, 'HoatDong'),
(1, 'A6', 'Thuong', 0, 'HoatDong'), (1, 'A7', 'Thuong', 0, 'HoatDong'), (1, 'A8', 'Thuong', 0, 'HoatDong'), (1, 'A9', 'Thuong', 0, 'HoatDong'), (1, 'A10', 'Thuong', 0, 'HoatDong'),
(1, 'B1', 'Thuong', 0, 'HoatDong'), (1, 'B2', 'Thuong', 0, 'HoatDong'), (1, 'B3', 'Thuong', 0, 'HoatDong'), (1, 'B4', 'Thuong', 0, 'HoatDong'), (1, 'B5', 'Thuong', 0, 'HoatDong'),
(1, 'B6', 'Thuong', 0, 'HoatDong'), (1, 'B7', 'Thuong', 0, 'HoatDong'), (1, 'B8', 'Thuong', 0, 'HoatDong'), (1, 'B9', 'Thuong', 0, 'HoatDong'), (1, 'B10', 'Thuong', 0, 'HoatDong'),
(1, 'C1', 'VIP', 20000, 'HoatDong'), (1, 'C2', 'VIP', 20000, 'HoatDong'), (1, 'C3', 'VIP', 20000, 'HoatDong'), (1, 'C4', 'VIP', 20000, 'HoatDong'), (1, 'C5', 'VIP', 20000, 'HoatDong'),
(1, 'C6', 'VIP', 20000, 'HoatDong'), (1, 'C7', 'VIP', 20000, 'HoatDong'), (1, 'C8', 'VIP', 20000, 'HoatDong'), (1, 'C9', 'VIP', 20000, 'HoatDong'), (1, 'C10', 'VIP', 20000, 'HoatDong'),
(1, 'D1', 'VIP', 20000, 'HoatDong'), (1, 'D2', 'VIP', 20000, 'HoatDong'), (1, 'D3', 'VIP', 20000, 'HoatDong'), (1, 'D4', 'VIP', 20000, 'HoatDong'), (1, 'D5', 'VIP', 20000, 'HoatDong'),
(1, 'D6', 'VIP', 20000, 'HoatDong'), (1, 'D7', 'VIP', 20000, 'HoatDong'), (1, 'D8', 'VIP', 20000, 'HoatDong'), (1, 'D9', 'VIP', 20000, 'HoatDong'), (1, 'D10', 'VIP', 20000, 'HoatDong'),
(1, 'E1', 'Doi', 50000, 'HoatDong'), (1, 'E2', 'Doi', 50000, 'HoatDong'), (1, 'E3', 'Doi', 50000, 'HoatDong'), (1, 'E4', 'Doi', 50000, 'HoatDong'), (1, 'E5', 'Doi', 50000, 'HoatDong'),
(1, 'E6', 'Doi', 50000, 'HoatDong'), (1, 'E7', 'Doi', 50000, 'HoatDong'), (1, 'E8', 'Doi', 50000, 'HoatDong'), (1, 'E9', 'Doi', 50000, 'HoatDong'), (1, 'E10', 'Doi', 50000, 'HoatDong');

-- Thêm suất chiếu mẫu
INSERT INTO SuatChieu (MaPhim, MaPhong, NgayChieu, GioChieu, GiaVe, TrangThai) VALUES
(1, 1, '2024-12-10', '09:00:00', 80000, 'MoCua'),
(1, 1, '2024-12-10', '14:00:00', 90000, 'MoCua'),
(1, 2, '2024-12-10', '19:00:00', 100000, 'MoCua'),
(2, 2, '2024-12-10', '10:00:00', 85000, 'MoCua'),
(2, 3, '2024-12-10', '15:00:00', 95000, 'MoCua'),
(3, 4, '2024-12-15', '20:00:00', 120000, 'MoCua');

