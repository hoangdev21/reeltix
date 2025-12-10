<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #1a1a2e;
            color: #fff;
            overflow-x: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .content-wrapper {
            margin-left: 280px;
            padding: 25px 40px;
            max-height: calc(100vh - 20px);
            overflow-y: auto;
        }

        .dashboard-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 25px;
            color: #fff;
            letter-spacing: 0.5px;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            height: 100%;
        }

        .card-header {
            background-color: rgba(255, 255, 255, 0.08);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 15px 18px;
        }

        .card-header h5 {
            font-size: 1.05rem;
            font-weight: 600;
            margin: 0;
            color: white;
        }

        .card-body {
            padding: 15px 18px;
        }

        .table {
            font-size: 0.85rem;
            margin-bottom: 0;
        }

        .table thead th {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 10px 12px;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 10px 12px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.08);
        }

        .movie-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            padding: 10px;
            padding-bottom: 12px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            transition: background-color 0.2s ease;
            border-radius: 6px;
        }

        .movie-item:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }

        .movie-item:last-child {
            margin-bottom: 0;
            border-bottom: none;
        }

        .movie-poster {
            width: 45px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            margin-right: 12px;
            background-color: #333;
            flex-shrink: 0;
        }

        .movie-info h6 {
            font-size: 0.9rem;
            margin-bottom: 4px;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 180px;
            color: white;
        }

        .movie-info small {
            font-size: 0.75rem;
            display: block;
            color: #aaa;
        }

        .empty-state {
            text-align: center;
            color: #888;
            padding: 25px 20px;
            font-size: 0.9rem;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 16px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: linear-gradient(135deg, #333333 0%, #676767 100%);
            border-radius: 12px;
            padding: 20px;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            flex: 1;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        .stat-card.movies {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .stat-card.bookings {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .stat-card.revenue {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        .stat-card h3 {
            font-size: 2.2rem;
            font-weight: bold;
            margin: 0;
            margin-top: 8px;
        }

        .stat-card p {
            font-size: 0.95rem;
            font-weight: 500;
            opacity: 0.9;
            margin-bottom: 0;
        }

        .stat-card i {
            opacity: 0.7;
            font-size: 2.8rem;
        }

        .stats-row {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: nowrap;
        }

        .content-row {
            display: grid;
            grid-template-columns: 3fr 2fr;
            gap: 20px;
        }

        @media (max-width: 1400px) {
            .content-wrapper {
                margin-left: 0;
                padding: 20px 30px;
            }

            .stat-card h3 {
                font-size: 1.9rem;
            }
        }

        @media (max-width: 1024px) {
            .content-wrapper {
                padding: 18px 25px;
            }

            .content-row {
                grid-template-columns: 1fr;
            }

            .stat-card {
                padding: 16px;
            }

            .stat-card h3 {
                font-size: 1.7rem;
            }

            .movie-poster {
                width: 40px;
                height: 55px;
            }

            .movie-info h6 {
                max-width: none;
            }
        }

        @media (max-width: 768px) {
            .content-wrapper {
                padding: 15px 20px;
            }

            .stats-row {
                gap: 15px;
            }

            .content-row {
                grid-template-columns: 1fr;
            }

            .table {
                font-size: 0.75rem;
            }

            .table thead th, .table tbody td {
                padding: 6px 8px;
            }

            .stat-card {
                padding: 14px;
            }

            .stat-card h3 {
                font-size: 1.5rem;
            }

            .stat-card i {
                font-size: 2rem;
            }

            .dashboard-title {
                font-size: 1.4rem;
                margin-bottom: 18px;
            }
        }

        @media (max-width: 480px) {
            .content-wrapper {
                padding: 12px 15px;
            }

            .stats-row {
                gap: 12px;
            }

            .stat-card {
                padding: 12px;
            }

            .stat-card h3 {
                font-size: 1.3rem;
            }

            .table {
                font-size: 0.7rem;
            }

            .movie-poster {
                width: 35px;
                height: 50px;
            }

            .movie-info h6 {
                font-size: 0.8rem;
                max-width: none;
            }

            .dashboard-title {
                font-size: 1.2rem;
            }
        }
        .logo-card {
            width: 50px;
            height: 50px;
            object-fit: contain;
            opacity: 0.8;
        }

        .data-card {
            background-color: rgba(255, 255, 255, 0.95);
            border: 1px solid rgba(0, 0, 0, 0.1);
            color: #000;
        }

        .data-card .card-header {
            background-color: rgba(255, 255, 255, 1);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .data-card .card-header h5 {
            color: #000;
        }

        .data-table {
            background-color: #fff;
            color: #000;
        }

        .data-table thead th {
            background-color: #f8f9fa;
            color: #000;
            border-bottom: 1px solid #dee2e6;
        }

        .data-table tbody td {
            border-bottom: 1px solid #dee2e6;
        }

        .data-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .data-card .movie-item {
            background-color: #fff;
            border-bottom: 1px solid #dee2e6;
            color: #000;
        }

        .data-card .movie-item:hover {
            background-color: #f8f9fa;
        }

        .data-card .movie-info h6 {
            color: #000;
        }

        .data-card .movie-info small {
            color: #666;
        }

        .data-card .empty-state {
            color: #666;
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../components/admin-sidebar.jsp">
            <jsp:param name="active" value="dashboard"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <h1 class="dashboard-title"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</h1>

                <!-- Stat Cards -->
                <div class="stats-row">
                    <div class="stat-card stat-users">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="stat-content">
                                <p class="mb-1 stat-label text-white ">Người dùng</p>
                                <h3 class="stat-value">${totalUsers != null ? totalUsers : 0}</h3>
                            </div>
                            <img src="${pageContext.request.contextPath}/assets/images/logo-dashboard/user.png" alt="Người dùng" class="logo-card">
                        </div>
                    </div>
                    <div class="stat-card stat-movies">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="stat-content">
                                <p class="mb-1 stat-label text-white">Phim</p>
                                <h3 class="stat-value">${totalMovies != null ? totalMovies : 0}</h3>
                            </div>
                            <img src="${pageContext.request.contextPath}/assets/images/logo-dashboard/phim.png" alt="Phim" class="logo-card">
                        </div>
                    </div>
                    <div class="stat-card stat-bookings">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="stat-content">
                                <p class="mb-1 stat-label text-white">Đơn đặt vé</p>
                                <h3 class="stat-value">${totalBookings != null ? totalBookings : 0}</h3>
                            </div>
                            <img src="${pageContext.request.contextPath}/assets/images/logo-dashboard/dondat.png" alt="Đơn đặt vé" class="logo-card">
                        </div>
                    </div>
                    <div class="stat-card stat-revenue">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="stat-content">
                                <p class="mb-1 stat-label text-white">Doanh thu</p>
                                <h3 class="stat-value" style="font-size: 1.5rem;">
                                    <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol=""
                                                      maxFractionDigits="0"/>đ
                                </h3>
                            </div>
                            <img src="${pageContext.request.contextPath}/assets/images/logo-dashboard/money.png" alt="Doanh thu" class="logo-card">
                        </div>
                    </div>
                </div>

                <!-- Data Tables -->
                <div class="content-row">
                    <div class="card data-card">
                        <div class="card-header">
                            <h5><i class="fas fa-list me-2"></i>Đơn đặt vé gần đây</h5>
                        </div>
                        <div class="card-body" style="max-height: 400px; overflow-y: auto;">
                            <c:choose>
                                <c:when test="${not empty recentBookings}">
                                    <div class="table-responsive">
                                        <table class="table table-hover data-table">
                                            <thead>
                                            <tr>
                                                <th>Mã đơn</th>
                                                <th>Khách hàng</th>
                                                <th>Phim</th>
                                                <th style="text-align: right;">Tổng tiền</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="booking" items="${recentBookings}">
                                                <tr>
                                                    <td><strong>${booking.maDon}</strong></td>
                                                    <td>${booking.tenKhachHang}</td>
                                                    <td>${booking.tenPhim}</td>
                                                    <td style="text-align: right;">
                                                        <strong>
                                                            <fmt:formatNumber value="${booking.tongTien}" type="currency"
                                                                              currencySymbol="" maxFractionDigits="0"/>đ
                                                        </strong>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-inbox fa-2x mb-2" style="display: block; opacity: 0.5;"></i>
                                        Chưa có đơn đặt vé nào
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="card data-card">
                        <div class="card-header">
                            <h5><i class="fas fa-fire me-2"></i>Phim nổi bật</h5>
                        </div>
                        <div class="card-body" style="max-height: 400px; overflow-y: auto;">
                            <c:choose>
                                <c:when test="${not empty topMovies}">
                                    <c:forEach var="movie" items="${topMovies}">
                                        <div class="movie-item">
                                            <c:if test="${not empty movie.anhPoster}">
                                                <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                                     alt="${movie.tenPhim}" class="movie-poster">
                                            </c:if>
                                            <c:if test="${empty movie.anhPoster}">
                                                <div class="movie-poster" style="background-color: #444; display: flex; align-items: center; justify-content: center;">
                                                    <i class="fas fa-image" style="color: #666;"></i>
                                                </div>
                                            </c:if>
                                            <div class="movie-info">
                                                <h6>${movie.tenPhim}</h6>
                                                <small><i class="fas fa-star" style="color: #ffc107;"></i>
                                                        ${movie.theLoai}
                                                </small>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-film fa-2x mb-2" style="display: block; opacity: 0.5;"></i>
                                        Chưa có dữ liệu
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
