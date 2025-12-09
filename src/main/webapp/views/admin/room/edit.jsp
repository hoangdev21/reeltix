<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa phòng chiếu - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .form-control::placeholder { color: #9ca3af; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="rooms"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-edit me-2"></i>Chỉnh sửa phòng chiếu</h1>
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">
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
                        <form action="${pageContext.request.contextPath}/admin/rooms/edit" method="post">
                            <input type="hidden" name="maPhong" value="${room.maPhong}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="tenPhong" class="form-label">Tên phòng <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="tenPhong" name="tenPhong" required
                                               value="${room.tenPhong}" placeholder="VD: Phòng 1, Phòng VIP">
                                    </div>

                                    <div class="mb-3">
                                        <label for="trangThai" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="trangThai" name="trangThai">
                                            <option value="HoatDong" ${room.trangThai == 'HoatDong' ? 'selected' : ''}>Hoạt động</option>
                                            <option value="BaoTri" ${room.trangThai == 'BaoTri' ? 'selected' : ''}>Bảo trì</option>
                                            <option value="NgungHoatDong" ${room.trangThai == 'NgungHoatDong' ? 'selected' : ''}>Ngừng hoạt động</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card bg-secondary">
                                        <div class="card-header">
                                            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin phòng</h5>
                                        </div>
                                        <div class="card-body">
                                            <p><i class="fas fa-chair me-2"></i>Số ghế hiện tại: <strong>${room.soLuongGhe}</strong></p>
                                            <p><i class="fas fa-hashtag me-2"></i>Mã phòng: <strong>${room.maPhong}</strong></p>
                                            <hr>
                                            <a href="${pageContext.request.contextPath}/admin/rooms/seats?id=${room.maPhong}" class="btn btn-info w-100">
                                                <i class="fas fa-chair me-2"></i>Cấu hình ghế ngồi
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="border-secondary">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-save me-2"></i>Cập nhật phòng
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

