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
    <title>Vé của tôi - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css?v=1.0" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .btn-primary { background-color: #e50914; border-color: #e50914; }
        .ticket-card { background-color: #1f1f1f; border-radius: 10px; overflow: hidden; margin-bottom: 20px; }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="container py-5">
        <h1 class="mb-4"><i class="fas fa-ticket-alt me-2"></i>Vé của tôi</h1>

        <c:forEach var="booking" items="${bookings}">
            <div class="ticket-card">
                <div class="row g-0">
                    <div class="col-md-3">
                        <img src="${pageContext.request.contextPath}/uploads/posters/${booking.anhPoster}"
                             class="img-fluid h-100" style="object-fit: cover;"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                    </div>
                    <div class="col-md-9">
                        <div class="p-4">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <h4>${booking.tenPhim}</h4>
                                    <p class="text-muted mb-2">Mã đơn: ${booking.maDon}</p>
                                </div>
                                <span class="badge bg-success">${booking.trangThaiThanhToan}</span>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><i class="fas fa-calendar me-2"></i><strong>Ngày chiếu:</strong> ${booking.ngayChieu}</p>
                                    <p><i class="fas fa-clock me-2"></i><strong>Giờ chiếu:</strong> ${booking.gioChieu}</p>
                                    <p><i class="fas fa-door-open me-2"></i><strong>Phòng:</strong> ${booking.tenPhong}</p>
                                </div>
                                <div class="col-md-6">
                                    <p><i class="fas fa-couch me-2"></i><strong>Ghế:</strong> ${booking.danhSachGhe}</p>
                                    <p><i class="fas fa-ticket-alt me-2"></i><strong>Số lượng:</strong> ${booking.soLuongVe} vé</p>
                                    <p><i class="fas fa-money-bill me-2"></i><strong>Tổng tiền:</strong> <span class="text-danger">${booking.tongTien}đ</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty bookings}">
            <div class="text-center py-5">
                <i class="fas fa-ticket-alt fa-5x text-muted mb-4"></i>
                <h4 class="text-muted">Bạn chưa có vé nào</h4>
                <a href="${pageContext.request.contextPath}/movies" class="btn btn-primary mt-3">
                    <i class="fas fa-film me-2"></i>Đặt vé ngay
                </a>
            </div>
        </c:if>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
