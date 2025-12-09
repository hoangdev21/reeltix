<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi máy chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; min-height: 100vh; display: flex; align-items: center; }
        .error-code { font-size: 8rem; color: #e50914; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container text-center">
        <div class="error-code">500</div>
        <h1 class="mb-4">Lỗi máy chủ</h1>
        <p class="text-muted mb-4">Đã xảy ra lỗi. Vui lòng thử lại sau.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-danger btn-lg">
            <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
    </div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Không tìm thấy trang</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; min-height: 100vh; display: flex; align-items: center; }
        .error-code { font-size: 8rem; color: #e50914; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container text-center">
        <div class="error-code">404</div>
        <h1 class="mb-4">Không tìm thấy trang</h1>
        <p class="text-muted mb-4">Trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.</p>
        <a href="${pageContext.request.contextPath}/" class="btn btn-danger btn-lg">
            <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
    </div>
</body>
</html>

