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
    <title>Thông tin cá nhân - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .btn-primary { background-color: #e50914; border-color: #e50914; }
        .form-control { background-color: #2a2a2a; border-color: #444; color: #fff; }
        .form-control:focus { background-color: #333; border-color: #e50914; color: #fff; }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card bg-dark text-white">
                    <div class="card-header">
                        <h4><i class="fas fa-user-circle me-2"></i>Thông tin cá nhân</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty success}">
                            <div class="alert alert-success">${success}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/customer/profile" method="post">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Họ tên</label>
                                    <input type="text" name="hoTen" class="form-control" value="${user.hoTen}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" value="${user.tenDangNhap}" disabled>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" value="${user.email}" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" name="soDienThoai" class="form-control" value="${user.soDienThoai}">
                                </div>
                            </div>
                            <hr>
                            <h5 class="mb-3">Đổi mật khẩu (để trống nếu không đổi)</h5>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label class="form-label">Mật khẩu hiện tại</label>
                                    <input type="password" name="matKhauHienTai" class="form-control">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Mật khẩu mới</label>
                                    <input type="password" name="matKhauMoi" class="form-control">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" name="xacNhanMatKhau" class="form-control">
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu thay đổi
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
