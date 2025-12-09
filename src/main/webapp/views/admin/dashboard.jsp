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

        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            padding: 18px;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
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
            font-size: 2rem;
            font-weight: bold;
            margin: 0;
        }

        .stat-card p {
            font-size: 0.95rem;
            font-weight: 500;
            opacity: 0.9;
        }

        .stat-card i {
            opacity: 0.6;
            font-size: 2.5rem;
        }

        .content-wrapper {
            margin-left: 280px;
            padding: 15px 20px;
            max-height: calc(100vh - 20px);
            overflow-y: auto;
        }

        .dashboard-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        .card-header {
            background-color: rgba(255, 255, 255, 0.08);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 12px 15px;
        }

        .card-header h5 {
            font-size: 1rem;
            font-weight: 600;
            margin: 0;
            color: white;
        }

        .card-body {
            padding: 12px 15px;
        }

        .table {
            font-size: 0.85rem;
            margin-bottom: 0;
        }

        .table thead th {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 8px 10px;
            font-weight: 600;
            font-size: 0.8rem;
        }

        .table tbody td {
            padding: 8px 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.05);
        }

        .movie-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .movie-item:last-child {
            margin-bottom: 0;
            border-bottom: none;
        }

        .movie-poster {
            width: 40px;
            height: 55px;
            object-fit: cover;
            border-radius: 4px;
            margin-right: 10px;
            background-color: #333;
        }

        .movie-info h6 {
            font-size: 0.85rem;
            margin-bottom: 3px;
            font-weight: 600;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
            color: white;
        }

        .movie-info small {
            font-size: 0.75rem;
            display: block;
            color: white;
        }

        .empty-state {
            text-align: center;
            color: #888;
            padding: 20px;
            font-size: 0.9rem;
        }

        .row.g-3 {
            gap: 12px !important;
        }

        .col-md-6, .col-md-4 {
            min-width: 0;
        }

        @media (max-width: 1400px) {
            .content-wrapper {
                margin-left: 0;
                padding: 10px 15px;
            }

            .stat-card h3 {
                font-size: 1.7rem;
            }
        }

        @media (max-width: 768px) {
            .table {
                font-size: 0.75rem;
            }

            .table thead th, .table tbody td {
                padding: 5px 8px;
            }

            .stat-card {
                padding: 12px;
            }
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
                <div class="row g-3 mb-3 flex-nowrap overflow-auto">
                    <div class="col-md-3 col-sm-6 flex-shrink-0">
                        <div class="stat-card stat-users">
                            <div class="d-flex justify-content-between align-items-center">
                                <div style="flex: 1;">
                                    <p class="mb-1 stat-label">Người dùng</p>
                                    <h3 class="stat-value">${totalUsers != null ? totalUsers : 0}</h3>
                                </div>
                                <i class="fas fa-users stat-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 flex-shrink-0">
                        <div class="stat-card stat-movies">
                            <div class="d-flex justify-content-between align-items-center">
                                <div style="flex: 1;">
                                    <p class="mb-1 stat-label">Phim</p>
                                    <h3 class="stat-value">${totalMovies != null ? totalMovies : 0}</h3>
                                </div>
                                <i class="fas fa-film stat-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 flex-shrink-0">
                        <div class="stat-card stat-bookings">
                            <div class="d-flex justify-content-between align-items-center">
                                <div style="flex: 1;">
                                    <p class="mb-1 stat-label">Đơn đặt vé</p>
                                    <h3 class="stat-value">${totalBookings != null ? totalBookings : 0}</h3>
                                </div>
                                <i class="fas fa-ticket-alt stat-icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 flex-shrink-0">
                        <div class="stat-card stat-revenue">
                            <div class="d-flex justify-content-between align-items-center">
                                <div style="flex: 1;">
                                    <p class="mb-1 stat-label">Doanh thu</p>
                                    <h3 class="stat-value" style="font-size: 1.5rem;">${totalRevenue}đ</h3>
                                </div>
                                <i class="fas fa-money-bill-wave stat-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Data Tables -->
                <div class="row g-3">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-list me-2"></i>Đơn đặt vé gần đây</h5>
                            </div>
                            <div class="card-body" style="max-height: 350px; overflow-y: auto;">
                                <c:choose>
                                    <c:when test="${not empty recentBookings}">
                                        <table class="table table-hover">
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
                                                        <td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100px;">${booking.tenPhim}</td>
                                                        <td style="text-align: right;"><strong>${booking.tongTien}đ</strong></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
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
                    </div>

                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <h5><i class="fas fa-fire me-2"></i>Phim nổi bật</h5>
                            </div>
                            <div class="card-body" style="max-height: 350px; overflow-y: auto;">
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
                                                    <small><i class="fas fa-star" style="color: #ffc107;"></i> ${movie.theLoai}</small>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
