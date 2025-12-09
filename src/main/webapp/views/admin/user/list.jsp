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
    <title>Quản lý người dùng - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .table-dark th { background-color: #16213e; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .badge-active { background-color: #28a745; }
        .badge-inactive { background-color: #dc3545; }
        .badge-admin { background-color: #9333ea; }
        .badge-customer { background-color: #3b82f6; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background-color: #374151; display: flex; align-items: center; justify-content: center; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="users"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-users me-2"></i>Quản lý người dùng</h1>
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
                            <div class="col-md-4">
                                <input type="text" name="search" class="form-control" placeholder="Tìm theo tên, email, SĐT..." value="${param.search}">
                            </div>
                            <div class="col-md-2">
                                <select name="role" class="form-select">
                                    <option value="">Tất cả vai trò</option>
                                    <option value="Admin" ${param.role == 'Admin' ? 'selected' : ''}>Admin</option>
                                    <option value="KhachHang" ${param.role == 'KhachHang' ? 'selected' : ''}>Khách hàng</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select name="status" class="form-select">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="HoatDong" ${param.status == 'HoatDong' ? 'selected' : ''}>Hoạt động</option>
                                    <option value="BiKhoa" ${param.status == 'BiKhoa' ? 'selected' : ''}>Bị khóa</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-1"></i>Tìm kiếm
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Users Table -->
                <div class="card bg-dark">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Người dùng</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Vai trò</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>${user.maNguoiDung}</td>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <div class="user-avatar">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <div>
                                                        <strong>${user.hoTen}</strong>
                                                        <br><small class="text-muted">@${user.tenDangNhap}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>${user.email}</td>
                                            <td>${user.soDienThoai}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.vaiTro == 'Admin'}">
                                                        <span class="badge badge-admin"><i class="fas fa-shield-alt me-1"></i>Admin</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-customer"><i class="fas fa-user me-1"></i>Khách hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.trangThai == 'HoatDong'}">
                                                        <span class="badge badge-active">Hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-inactive">Bị khóa</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${user.ngayTao}" pattern="dd/MM/yyyy"/></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/users/detail?id=${user.maNguoiDung}"
                                                   class="btn btn-sm btn-info" title="Chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <c:if test="${user.trangThai == 'HoatDong'}">
                                                    <button type="button" class="btn btn-sm btn-warning"
                                                            onclick="confirmLock(${user.maNguoiDung}, '${user.hoTen}')" title="Khóa">
                                                        <i class="fas fa-lock"></i>
                                                    </button>
                                                </c:if>
                                                <c:if test="${user.trangThai == 'BiKhoa'}">
                                                    <button type="button" class="btn btn-sm btn-success"
                                                            onclick="confirmUnlock(${user.maNguoiDung}, '${user.hoTen}')" title="Mở khóa">
                                                        <i class="fas fa-unlock"></i>
                                                    </button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty users}">
                                        <tr>
                                            <td colspan="8" class="text-center py-4">
                                                <i class="fas fa-users fa-3x mb-3 text-muted"></i>
                                                <p class="text-muted">Không có người dùng nào</p>
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

    <!-- Lock/Unlock Modal -->
    <div class="modal fade" id="actionModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content bg-dark">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title" id="modalTitle">Xác nhận</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="modalMessage"></p>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="actionForm" method="post" style="display: inline;">
                        <button type="submit" class="btn" id="actionBtn">Xác nhận</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmLock(id, name) {
            document.getElementById('modalTitle').textContent = 'Khóa tài khoản';
            document.getElementById('modalMessage').textContent = 'Bạn có chắc chắn muốn khóa tài khoản "' + name + '"?';
            document.getElementById('actionForm').action = '${pageContext.request.contextPath}/admin/users/lock?id=' + id;
            document.getElementById('actionBtn').className = 'btn btn-warning';
            document.getElementById('actionBtn').textContent = 'Khóa';
            new bootstrap.Modal(document.getElementById('actionModal')).show();
        }

        function confirmUnlock(id, name) {
            document.getElementById('modalTitle').textContent = 'Mở khóa tài khoản';
            document.getElementById('modalMessage').textContent = 'Bạn có chắc chắn muốn mở khóa tài khoản "' + name + '"?';
            document.getElementById('actionForm').action = '${pageContext.request.contextPath}/admin/users/unlock?id=' + id;
            document.getElementById('actionBtn').className = 'btn btn-success';
            document.getElementById('actionBtn').textContent = 'Mở khóa';
            new bootstrap.Modal(document.getElementById('actionModal')).show();
        }
    </script>
</body>
</html>
