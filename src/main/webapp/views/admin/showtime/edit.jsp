<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa suất chiếu - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
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
                    <h1><i class="fas fa-edit me-2"></i>Chỉnh sửa suất chiếu</h1>
                    <a href="${pageContext.request.contextPath}/admin/showtimes" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card bg-dark">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/showtimes/edit" method="post">
                            <input type="hidden" name="maSuatChieu" value="${showtime.maSuatChieu}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="maPhim" class="form-label">Phim <span class="text-danger">*</span></label>
                                        <select class="form-select" id="maPhim" name="maPhim" required>
                                            <option value="">-- Chọn phim --</option>
                                            <c:forEach var="movie" items="${movies}">
                                                <option value="${movie.maPhim}" ${showtime.maPhim == movie.maPhim ? 'selected' : ''}>
                                                    ${movie.tenPhim}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="maPhong" class="form-label">Phòng chiếu <span class="text-danger">*</span></label>
                                        <select class="form-select" id="maPhong" name="maPhong" required>
                                            <option value="">-- Chọn phòng --</option>
                                            <c:forEach var="room" items="${rooms}">
                                                <option value="${room.maPhong}" ${showtime.maPhong == room.maPhong ? 'selected' : ''}>
                                                    ${room.tenPhong} (${room.soLuongGhe} ghế)
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="ngayChieu" class="form-label">Ngày chiếu <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="ngayChieu" name="ngayChieu" required
                                                   value="${showtime.ngayChieu}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="gioChieu" class="form-label">Giờ chiếu <span class="text-danger">*</span></label>
                                            <input type="time" class="form-control" id="gioChieu" name="gioChieu" required
                                                   value="${showtime.gioChieu}">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="giaVe" class="form-label">Giá vé (VNĐ) <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="giaVe" name="giaVe" required
                                               value="${showtime.giaVe}" min="10000" step="5000">
                                    </div>

                                    <div class="mb-3">
                                        <label for="trangThai" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="trangThai" name="trangThai">
                                            <option value="MoCua" ${showtime.trangThai == 'MoCua' ? 'selected' : ''}>Mở cửa</option>
                                            <option value="DaDong" ${showtime.trangThai == 'DaDong' ? 'selected' : ''}>Đã đóng</option>
                                            <option value="Huy" ${showtime.trangThai == 'Huy' ? 'selected' : ''}>Hủy</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card bg-secondary">
                                        <div class="card-header">
                                            <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin</h6>
                                        </div>
                                        <div class="card-body">
                                            <p><strong>Mã suất chiếu:</strong> ${showtime.maSuatChieu}</p>
                                            <p><strong>Số vé đã bán:</strong> ${ticketsSold != null ? ticketsSold : 0}</p>
                                            <c:if test="${ticketsSold > 0}">
                                                <div class="alert alert-warning mb-0">
                                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                                    Suất chiếu này đã có vé được đặt. Thay đổi sẽ ảnh hưởng đến khách hàng!
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="border-secondary">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/showtimes" class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-save me-2"></i>Cập nhật
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
