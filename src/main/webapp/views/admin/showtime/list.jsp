<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý suất chiếu - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .table-dark th { background-color: #16213e; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .badge-active { background-color: #28a745; }
        .badge-cancelled { background-color: #dc3545; }
        .badge-full { background-color: #ffc107; color: #000; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="showtimes"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-calendar-alt me-2"></i>Quản lý suất chiếu</h1>
                    <a href="${pageContext.request.contextPath}/admin/showtimes/add" class="btn btn-danger">
                        <i class="fas fa-plus me-2"></i>Thêm suất chiếu
                    </a>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Filter -->
                <div class="card bg-dark mb-4">
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Phim</label>
                                <select name="movieId" class="form-select">
                                    <option value="">Tất cả phim</option>
                                    <c:forEach var="movie" items="${movies}">
                                        <option value="${movie.maPhim}" ${param.movieId == movie.maPhim ? 'selected' : ''}>${movie.tenPhim}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Phòng</label>
                                <select name="roomId" class="form-select">
                                    <option value="">Tất cả phòng</option>
                                    <c:forEach var="room" items="${rooms}">
                                        <option value="${room.maPhong}" ${param.roomId == room.maPhong ? 'selected' : ''}>${room.tenPhong}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Ngày chiếu</label>
                                <input type="date" name="date" class="form-control" value="${param.date}">
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">Trạng thái</label>
                                <select name="status" class="form-select">
                                    <option value="">Tất cả</option>
                                    <option value="HoatDong" ${param.status == 'HoatDong' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="DaHuy" ${param.status == 'DaHuy' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-1"></i>Lọc
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Showtimes Table -->
                <div class="card bg-dark">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Phim</th>
                                        <th>Phòng</th>
                                        <th>Ngày chiếu</th>
                                        <th>Giờ chiếu</th>
                                        <th>Giá vé</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="showtime" items="${showtimes}">
                                        <tr>
                                            <td>${showtime.maSuatChieu}</td>
                                            <td>
                                                <strong>${showtime.tenPhim}</strong>
                                            </td>
                                            <td>
                                                <i class="fas fa-door-open me-1"></i>${showtime.tenPhong}
                                            </td>
                                            <td>${showtime.ngayChieu}</td>
                                            <td>
                                                <i class="fas fa-clock me-1"></i>${showtime.gioChieu}
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${showtime.giaVe}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${showtime.trangThai == 'HoatDong'}">
                                                        <span class="badge badge-active">Hoạt động</span>
                                                    </c:when>
                                                    <c:when test="${showtime.trangThai == 'DaHuy'}">
                                                        <span class="badge badge-cancelled">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-full">Đã đầy</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/showtimes/edit?id=${showtime.maSuatChieu}"
                                                   class="btn btn-sm btn-warning" title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-danger"
                                                        onclick="confirmDelete(${showtime.maSuatChieu})" title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty showtimes}">
                                        <tr>
                                            <td colspan="8" class="text-center py-4">
                                                <i class="fas fa-calendar-times fa-3x mb-3 text-muted"></i>
                                                <p class="text-muted">Không có suất chiếu nào</p>
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

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content bg-dark">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa suất chiếu này?</p>
                    <p class="text-warning"><i class="fas fa-exclamation-triangle me-2"></i>Lưu ý: Các đơn đặt vé liên quan sẽ bị ảnh hưởng!</p>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="deleteForm" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id) {
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/showtimes/delete?id=' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
