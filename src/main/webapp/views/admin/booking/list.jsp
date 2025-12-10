<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt vé - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .table-dark th { background-color: #16213e; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
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
                    <h1><i class="fas fa-ticket-alt me-2"></i>Quản lý đặt vé</h1>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Filter -->
                <div class="card bg-dark mb-4">
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Mã đơn</label>
                                <input type="text" name="orderId" class="form-control" placeholder="Nhập mã đơn..." value="${param.orderId}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Khách hàng</label>
                                <input type="text" name="customer" class="form-control" placeholder="Tên hoặc SĐT..." value="${param.customer}">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Từ ngày</label>
                                <input type="date" name="fromDate" class="form-control" value="${param.fromDate}">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Đến ngày</label>
                                <input type="date" name="toDate" class="form-control" value="${param.toDate}">
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-1"></i>Tìm kiếm
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Bookings Table -->
                <div class="card bg-dark">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng</th>
                                        <th>Phim</th>
                                        <th>Suất chiếu</th>
                                        <th>Số vé</th>
                                        <th>Tổng tiền</th>
                                        <th>Ngày đặt</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr>
                                            <td>
                                                <strong class="text-primary">${booking.maDon}</strong>
                                            </td>
                                            <td>
                                                <div>${booking.tenKhachHang}</div>
                                                <small class="text-muted">${booking.soDienThoai}</small>
                                            </td>
                                            <td>${booking.tenPhim}</td>
                                            <td>
                                                <div>${booking.ngayChieu}</div>
                                                <small class="text-muted">${booking.gioChieu} - ${booking.tenPhong}</small>
                                            </td>
                                            <td>${booking.soLuongVe}</td>
                                            <td>
                                                <strong class="text-success">
                                                    <fmt:formatNumber value="${booking.tongTien}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ
                                                </strong>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${booking.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${booking.trangThai == 'DaXacNhan'}">
                                                        <span class="badge badge-confirmed">Đã xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${booking.trangThai == 'ChoXacNhan'}">
                                                        <span class="badge badge-pending">Chờ xác nhận</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-cancelled">Đã hủy</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/bookings/detail?id=${booking.maDon}"
                                                   class="btn btn-sm btn-info" title="Chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${booking.trangThai != 'DaHuy'}">
                                                    <button type="button" class="btn btn-sm btn-danger"
                                                            onclick="confirmCancel('${booking.maDon}')" title="Hủy đơn">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty bookings}">
                                        <tr>
                                            <td colspan="9" class="text-center py-4">
                                                <i class="fas fa-ticket-alt fa-3x mb-3 text-muted"></i>
                                                <p class="text-muted">Không có đơn đặt vé nào</p>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Cancel Confirmation Modal -->
    <div class="modal fade" id="cancelModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content bg-dark">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title">Xác nhận hủy đơn</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn hủy đơn đặt vé <strong id="bookingId"></strong>?</p>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <form id="cancelForm" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Hủy đơn</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmCancel(id) {
            document.getElementById('bookingId').textContent = id;
            document.getElementById('cancelForm').action = '${pageContext.request.contextPath}/admin/bookings/cancel?id=' + id;
            new bootstrap.Modal(document.getElementById('cancelModal')).show();
        }
    </script>
</body>
</html>
