<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phòng chiếu - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .table-dark th { background-color: #16213e; }
        .badge-active { background-color: #28a745; }
        .badge-inactive { background-color: #dc3545; }
        .badge-maintenance { background-color: #ffc107; color: #000; }
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
                    <h1><i class="fas fa-door-open me-2"></i>Quản lý phòng chiếu</h1>
                    <a href="${pageContext.request.contextPath}/admin/rooms/add" class="btn btn-danger">
                        <i class="fas fa-plus me-2"></i>Thêm phòng mới
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

                <!-- Rooms Table -->
                <div class="card bg-dark">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên phòng</th>
                                        <th>Số lượng ghế</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="room" items="${rooms}">
                                        <tr>
                                            <td>${room.maPhong}</td>
                                            <td>
                                                <i class="fas fa-door-open me-2 text-primary"></i>
                                                <strong>${room.tenPhong}</strong>
                                            </td>
                                            <td>
                                                <i class="fas fa-chair me-1"></i>${room.soLuongGhe} ghế
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${room.trangThai == 'HoatDong'}">
                                                        <span class="badge badge-active">Hoạt động</span>
                                                    </c:when>
                                                    <c:when test="${room.trangThai == 'BaoTri'}">
                                                        <span class="badge badge-maintenance">Bảo trì</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-inactive">Ngừng hoạt động</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/rooms/seats?id=${room.maPhong}"
                                                   class="btn btn-sm btn-info" title="Cấu hình ghế">
                                                    <i class="fas fa-chair"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/rooms/edit?id=${room.maPhong}"
                                                   class="btn btn-sm btn-warning" title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-danger"
                                                        onclick="confirmDelete(${room.maPhong}, '${room.tenPhong}')" title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty rooms}">
                                        <tr>
                                            <td colspan="5" class="text-center py-4">
                                                <i class="fas fa-door-open fa-3x mb-3 text-muted"></i>
                                                <p class="text-muted">Chưa có phòng chiếu nào</p>
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
                    <p>Bạn có chắc chắn muốn xóa phòng "<span id="roomName"></span>"?</p>
                    <p class="text-warning"><i class="fas fa-exclamation-triangle me-2"></i>Lưu ý: Tất cả ghế và suất chiếu liên quan sẽ bị xóa!</p>
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
        function confirmDelete(id, name) {
            document.getElementById('roomName').textContent = name;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/rooms/delete?id=' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
