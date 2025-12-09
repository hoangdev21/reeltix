<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Admin - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-container {
            background-color: rgba(22, 33, 62, 0.95);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }
        .login-logo {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-logo i {
            font-size: 60px;
            color: #e50914;
        }
        .login-logo h1 {
            color: #fff;
            margin-top: 15px;
            font-weight: bold;
        }
        .login-logo p {
            color: #9ca3af;
        }
        .form-control {
            background-color: #1a1a2e;
            border: 2px solid #374151;
            color: #fff;
            padding: 12px 15px;
            border-radius: 10px;
        }
        .form-control:focus {
            background-color: #1a1a2e;
            border-color: #e50914;
            color: #fff;
            box-shadow: 0 0 0 0.2rem rgba(229, 9, 20, 0.25);
        }
        .form-control::placeholder {
            color: #6b7280;
        }
        .input-group-text {
            background-color: #1a1a2e;
            border: 2px solid #374151;
            border-right: none;
            color: #9ca3af;
            border-radius: 10px 0 0 10px;
        }
        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        .btn-login {
            background: linear-gradient(135deg, #e50914 0%, #b20710 100%);
            border: none;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 10px;
            width: 100%;
            transition: all 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(229, 9, 20, 0.4);
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #9ca3af;
            text-decoration: none;
        }
        .back-link a:hover {
            color: #e50914;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-logo">
            <i class="fas fa-film"></i>
            <h1>Reeltix Admin</h1>
            <p>Đăng nhập để quản trị hệ thống</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="mb-3">
                <label for="tenDangNhap" class="form-label text-white">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" class="form-control" id="tenDangNhap" name="tenDangNhap"
                           placeholder="Nhập tên đăng nhập" required value="${param.tenDangNhap}">
                </div>
            </div>

            <div class="mb-4">
                <label for="matKhau" class="form-label text-white">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" class="form-control" id="matKhau" name="matKhau"
                           placeholder="Nhập mật khẩu" required>
                </div>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember" name="remember">
                <label class="form-check-label text-white" for="remember">Ghi nhớ đăng nhập</label>
            </div>

            <button type="submit" class="btn btn-login text-white">
                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
            </button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/">
                <i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
