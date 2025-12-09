<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Reeltix</title>
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
        }
        .login-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
        }
        .login-card h2 {
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
    <div class="login-card">
        <div class="text-center mb-4">
            <h2><i class="fas fa-film me-2"></i>Reeltix</h2>
            <p class="text-white-50">Đăng nhập để tiếp tục</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/login" method="post">
            <div class="mb-3">
                <label class="form-label text-white">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark text-white border-secondary">
                        <i class="fas fa-user"></i>
                    </span>
                    <input type="text" name="tenDangNhap" class="form-control" placeholder="Nhập tên đăng nhập" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark text-white border-secondary">
                        <i class="fas fa-lock"></i>
                    </span>
                    <input type="password" name="matKhau" class="form-control" placeholder="Nhập mật khẩu" required>
                </div>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember" name="remember">
                <label class="form-check-label text-white" for="remember">Ghi nhớ đăng nhập</label>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-3">
                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
            </button>
        </form>

        <div class="text-center">
            <p class="text-white-50 mb-2">Chưa có tài khoản?
                <a href="${pageContext.request.contextPath}/auth/register">Đăng ký ngay</a>
            </p>
            <a href="${pageContext.request.contextPath}/" class="text-white-50">
                <i class="fas fa-arrow-left me-1"></i>Quay lại trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
