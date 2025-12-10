<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .sidebar { background: #1a1a1a; }
        .stat-card {
            background: #222;
            border-left: 4px solid #e50914;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(229, 9, 20, 0.2);
        }
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #e50914;
        }
        .stat-label {
            font-size: 14px;
            color: #999;
            margin-top: 10px;
        }
        .stat-icon {
            font-size: 48px;
            color: #e50914;
            opacity: 0.1;
            position: absolute;
            right: 15px;
            top: 15px;
        }
        .table-dark {
            background: #222;
        }
        .table-dark thead th {
            border-color: #333;
            color: #e50914;
        }
        .table-dark tbody td {
            border-color: #333;
        }
        .section-title {
            border-bottom: 2px solid #e50914;
            padding-bottom: 10px;
            margin-bottom: 20px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 sidebar p-4">
                <jsp:include page="../../components/admin-sidebar.jsp" />
            </div>

            <!-- Main Content -->
            <div class="col-md-9 p-4">
                <h1 class="mb-4"><i class="fas fa-chart-bar me-2"></i>Thống kê và Báo cáo</h1>

                <!-- Statistics Cards -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="stat-card position-relative">
                            <i class="fas fa-users stat-icon"></i>
                            <div class="stat-number">${totalUsers}</div>
                            <div class="stat-label">Tổng người dùng</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="stat-card position-relative">
                            <i class="fas fa-film stat-icon"></i>
                            <div class="stat-number">${totalMovies}</div>
                            <div class="stat-label">Tổng phim</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="stat-card position-relative">
                            <i class="fas fa-ticket-alt stat-icon"></i>
                            <div class="stat-number">${totalBookings}</div>
                            <div class="stat-label">Tổng đặt vé</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="stat-card position-relative">
                            <i class="fas fa-money-bill-wave stat-icon"></i>
                            <div class="stat-number"><fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00" />đ</div>
                            <div class="stat-label">Tổng doanh thu</div>
                        </div>
                    </div>
                </div>

                <!-- Recent Bookings -->
                <div class="section-title">
                    <h4><i class="fas fa-history me-2"></i>Đơn đặt vé gần đây</h4>
                </div>

                <c:choose>
                    <c:when test="${not empty recentBookings}">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>Mã đơn</th>
                                        <th>Khách hàng</th>
                                        <th>Phim</th>
                                        <th>Ngày chiếu</th>
                                        <th>Giá vé</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${recentBookings}">
                                        <tr>
                                            <td>#${booking.maDatVe}</td>
                                            <td>${booking.hoTen}</td>
                                            <td>${booking.tenPhim}</td>
                                            <td>${booking.ngayChieu}</td>
                                            <td><fmt:formatNumber value="${booking.giaVe}" pattern="#,##0.00" />đ</td>
                                            <td>
                                                <span class="badge bg-success">${booking.trangThai}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>Chưa có đơn đặt vé nào
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Quick Links -->
                <div class="section-title">
                    <h4><i class="fas fa-link me-2"></i>Báo cáo chi tiết</h4>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <a href="${pageContext.request.contextPath}/admin/statistics?view=revenue" class="btn btn-outline-danger w-100 mb-2">
                            <i class="fas fa-chart-line me-2"></i>Báo cáo doanh thu
                        </a>
                    </div>
                    <div class="col-md-6">
                        <a href="${pageContext.request.contextPath}/admin/statistics?view=report" class="btn btn-outline-danger w-100 mb-2">
                            <i class="fas fa-file-alt me-2"></i>Báo cáo chi tiết
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
