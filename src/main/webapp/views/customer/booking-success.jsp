<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt vé thành công - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .btn-primary { background-color: #e50914; border-color: #e50914; }
        .success-icon { font-size: 5rem; color: #28a745; }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="container py-5">
        <div class="text-center py-5">
            <i class="fas fa-check-circle success-icon mb-4"></i>
            <h1 class="mb-3">Đặt vé thành công!</h1>
            <p class="lead text-muted mb-4">Cảm ơn bạn đã sử dụng dịch vụ của Reeltix</p>

            <div class="card bg-dark text-white mx-auto" style="max-width: 500px;">
                <div class="card-body">
                    <h5 class="card-title mb-3">Thông tin vé</h5>
                    <p><strong>Mã đơn:</strong> ${booking.maDon}</p>
                    <p><strong>Phim:</strong> ${movie.tenPhim}</p>
                    <p><strong>Suất chiếu:</strong> ${showtime.ngayChieu} - ${showtime.gioChieu}</p>
                    <p><strong>Phòng:</strong> ${room.tenPhong}</p>
                    <p><strong>Ghế:</strong> ${selectedSeatNames}</p>
                    <p><strong>Tổng tiền:</strong> <span class="text-danger">${booking.tongTien}đ</span></p>
                </div>
            </div>

            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/customer/my-bookings" class="btn btn-primary me-2">
                    <i class="fas fa-ticket-alt me-2"></i>Xem vé của tôi
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light">
                    <i class="fas fa-home me-2"></i>Về trang chủ
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
