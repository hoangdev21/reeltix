<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm phòng chiếu - Reeltix Admin</title>
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
                    <h1><i class="fas fa-plus-circle me-2"></i>Thêm phòng chiếu</h1>
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
                        <form action="${pageContext.request.contextPath}/admin/rooms/add" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="tenPhong" class="form-label text-white">Tên phòng <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="tenPhong" name="tenPhong" required
                                               value="${param.tenPhong}" placeholder="VD: Phòng 1, Phòng VIP">
                                    </div>

                                    <div class="mb-3">
                                        <label for="soHang" class="form-label text-white">Số hàng ghế <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="soHang" name="soHang" required
                                               value="${param.soHang}" min="1" max="26" placeholder="VD: 10">
                                        <small class="text-white-50">Tối đa 26 hàng (A-Z)</small>
                                    </div>

                                    <div class="mb-3">
                                        <label for="soCot" class="form-label text-white">Số ghế mỗi hàng <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="soCot" name="soCot" required
                                               value="${param.soCot}" min="1" max="20" placeholder="VD: 12">
                                        <small class="text-white-50">Tối đa 20 ghế mỗi hàng</small>
                                    </div>

                                    <div class="mb-3">
                                        <label for="trangThai" class="form-label text-white">Trạng thái</label>
                                        <select class="form-select" id="trangThai" name="trangThai">
                                            <option value="HoatDong" ${param.trangThai == 'HoatDong' ? 'selected' : ''}>Hoạt động</option>
                                            <option value="BaoTri" ${param.trangThai == 'BaoTri' ? 'selected' : ''}>Bảo trì</option>
                                            <option value="NgungHoatDong" ${param.trangThai == 'NgungHoatDong' ? 'selected' : ''}>Ngừng hoạt động</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card bg-secondary">
                                        <div class="card-header">
                                            <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin</h5>
                                        </div>
                                        <div class="card-body">
                                            <p><i class="fas fa-chair me-2"></i>Tổng số ghế: <strong id="totalSeats">0</strong></p>
                                            <p><i class="fas fa-th me-2"></i>Bố cục: <span id="layout">0 x 0</span></p>
                                            <hr>
                                            <p class="text-muted small mb-0">
                                                Ghế sẽ được tự động tạo theo bố cục hàng x cột.
                                                Bạn có thể cấu hình chi tiết ghế sau khi tạo phòng.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="border-secondary">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-save me-2"></i>Lưu phòng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateInfo() {
            const rows = parseInt(document.getElementById('soHang').value) || 0;
            const cols = parseInt(document.getElementById('soCot').value) || 0;
            document.getElementById('totalSeats').textContent = rows * cols;
            document.getElementById('layout').textContent = rows + ' x ' + cols;
        }
        document.getElementById('soHang').addEventListener('input', updateInfo);
        document.getElementById('soCot').addEventListener('input', updateInfo);
        updateInfo();
    </script>
</body>
</html>
