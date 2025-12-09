<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #141414 0%, #1a1a2e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
        }
        .register-card h2 {
            color: #e50914;
        }
        .form-control {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: #fff;
        }
        .form-control:focus {
            background: rgba(255,255,255,0.15);
            border-color: #e50914;
            color: #fff;
            box-shadow: 0 0 0 0.25rem rgba(229,9,20,0.25);
        }
        .form-control::placeholder {
            color: rgba(255,255,255,0.5);
        }
        .btn-primary {
            background-color: #e50914;
            border-color: #e50914;
        }
        .btn-primary:hover {
            background-color: #b8070f;
            border-color: #b8070f;
        }
        a {
            color: #e50914;
        }
    </style>
</head>
<body>
    <div class="register-card">
        <div class="text-center mb-4">
            <h2><i class="fas fa-film me-2"></i>Reeltix</h2>
            <p class="text-white-50">Tạo tài khoản mới</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-white">Họ tên</label>
                    <input type="text" name="hoTen" class="form-control" placeholder="Nhập họ tên" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-white">Tên đăng nhập</label>
                    <input type="text" name="tenDangNhap" class="form-control" placeholder="Nhập tên đăng nhập" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Email</label>
                <input type="email" name="email" class="form-control" placeholder="Nhập email" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Số điện thoại</label>
                <input type="tel" name="soDienThoai" class="form-control" placeholder="Nhập số điện thoại" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-white">Mật khẩu</label>
                    <input type="password" name="matKhau" class="form-control" placeholder="Nhập mật khẩu" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-white">Xác nhận mật khẩu</label>
                    <input type="password" name="xacNhanMatKhau" class="form-control" placeholder="Nhập lại mật khẩu" required>
                </div>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="agree" name="agree" required>
                <label class="form-check-label text-white" for="agree">
                    Tôi đồng ý với <a href="#">điều khoản sử dụng</a>
                </label>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="fas fa-user-plus me-2"></i>Đăng ký
            </button>
        </form>

        <div class="text-center">
            <p class="text-white-50 mb-2">Đã có tài khoản?
                <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a>
            </p>
            <a href="${pageContext.request.contextPath}/" class="text-white-50">
                <i class="fas fa-arrow-left me-1"></i>Quay lại trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
