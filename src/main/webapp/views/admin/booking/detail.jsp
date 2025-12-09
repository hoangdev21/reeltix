<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn đặt vé - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .ticket-card { background: linear-gradient(135deg, #1f2937 0%, #374151 100%); border-radius: 15px; padding: 25px; }
        .seat-badge { display: inline-block; padding: 5px 12px; margin: 3px; background-color: #e50914; border-radius: 5px; font-weight: bold; }
        .info-label { color: #9ca3af; font-size: 14px; }
        .badge-confirmed { background-color: #28a745; }
        .badge-pending { background-color: #ffc107; color: #000; }
        .badge-cancelled { background-color: #dc3545; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="bookings"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-receipt me-2"></i>Chi tiết đơn đặt vé</h1>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="ticket-card mb-4">
                            <div class="row">
                                <div class="col-md-4 text-center border-end border-secondary">
                                    <img src="${pageContext.request.contextPath}/uploads/posters/${booking.anhPoster}"
                                         alt="${booking.tenPhim}" class="img-fluid rounded mb-3" style="max-height: 250px;"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                                </div>
                                <div class="col-md-8">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <h3 class="mb-0">${booking.tenPhim}</h3>
                                        <c:choose>
                                            <c:when test="${booking.trangThai == 'DaXacNhan'}">
                                                <span class="badge badge-confirmed fs-6">Đã xác nhận</span>
                                            </c:when>
                                            <c:when test="${booking.trangThai == 'ChoXacNhan'}">
                                                <span class="badge badge-pending fs-6">Chờ xác nhận</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-cancelled fs-6">Đã hủy</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <p class="info-label mb-1">Mã đơn hàng</p>
                                            <p class="fw-bold text-primary">${booking.maDon}</p>
                                        </div>
                                        <div class="col-6">
                                            <p class="info-label mb-1">Ngày đặt</p>
                                            <p class="fw-bold"><fmt:formatDate value="${booking.ngayDat}" pattern="dd/MM/yyyy HH:mm"/></p>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <p class="info-label mb-1"><i class="fas fa-calendar me-1"></i>Ngày chiếu</p>
                                            <p class="fw-bold">${booking.ngayChieu}</p>
                                        </div>
                                        <div class="col-6">
                                            <p class="info-label mb-1"><i class="fas fa-clock me-1"></i>Giờ chiếu</p>
                                            <p class="fw-bold">${booking.gioChieu}</p>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-6">
                                            <p class="info-label mb-1"><i class="fas fa-door-open me-1"></i>Phòng chiếu</p>
                                            <p class="fw-bold">${booking.tenPhong}</p>
                                        </div>
                                        <div class="col-6">
                                            <p class="info-label mb-1"><i class="fas fa-chair me-1"></i>Ghế</p>
                                            <div>
                                                <c:forEach var="seat" items="${seats}">
                                                    <span class="seat-badge">${seat}</span>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Info -->
                        <div class="card bg-dark">
                            <div class="card-header">
                                <h5><i class="fas fa-credit-card me-2"></i>Thông tin thanh toán</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-dark mb-0">
                                    <tr>
                                        <td>Số lượng vé</td>
                                        <td class="text-end">${booking.soLuongVe} vé</td>
                                    </tr>
                                    <tr>
                                        <td>Giá vé</td>
                                        <td class="text-end"><fmt:formatNumber value="${booking.giaVe}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ/vé</td>
                                    </tr>
                                    <tr>
                                        <td>Phương thức thanh toán</td>
                                        <td class="text-end">${booking.phuongThucThanhToan != null ? booking.phuongThucThanhToan : 'Tiền mặt'}</td>
                                    </tr>
                                    <tr class="fw-bold fs-5">
                                        <td>Tổng tiền</td>
                                        <td class="text-end text-success">
                                            <fmt:formatNumber value="${booking.tongTien}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <!-- Customer Info -->
                        <div class="card bg-dark mb-4">
                            <div class="card-header">
                                <h5><i class="fas fa-user me-2"></i>Thông tin khách hàng</h5>
                            </div>
                            <div class="card-body">
                                <p><strong>Họ tên:</strong> ${booking.tenKhachHang}</p>
                                <p><strong>Email:</strong> ${booking.email}</p>
                                <p><strong>SĐT:</strong> ${booking.soDienThoai}</p>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="card bg-dark">
                            <div class="card-header">
                                <h5><i class="fas fa-cog me-2"></i>Thao tác</h5>
                            </div>
                            <div class="card-body d-grid gap-2">
                                <button onclick="window.print()" class="btn btn-primary">
                                    <i class="fas fa-print me-2"></i>In vé
                                </button>
                                <c:if test="${booking.trangThai == 'ChoXacNhan'}">
                                    <form action="${pageContext.request.contextPath}/admin/bookings/confirm" method="post">
                                        <input type="hidden" name="id" value="${booking.maDon}">
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-check me-2"></i>Xác nhận đơn
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${booking.trangThai != 'DaHuy'}">
                                    <form action="${pageContext.request.contextPath}/admin/bookings/cancel" method="post"
                                          onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn này?')">
                                        <input type="hidden" name="id" value="${booking.maDon}">
                                        <button type="submit" class="btn btn-danger w-100">
                                            <i class="fas fa-times me-2"></i>Hủy đơn
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
