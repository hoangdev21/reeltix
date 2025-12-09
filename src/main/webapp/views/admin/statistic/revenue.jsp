<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê doanh thu - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .stat-card { border-radius: 15px; padding: 25px; }
        .stat-card.revenue { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
        .stat-card.bookings { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        .stat-card.tickets { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); }
        .stat-card.avg { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .chart-container { background-color: #16213e; border-radius: 15px; padding: 20px; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="statistics"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-chart-line me-2"></i>Thống kê doanh thu</h1>
                </div>

                <!-- Filter -->
                <div class="card bg-dark mb-4">
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Từ ngày</label>
                                <input type="date" name="fromDate" class="form-control" value="${param.fromDate != null ? param.fromDate : fromDate}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Đến ngày</label>
                                <input type="date" name="toDate" class="form-control" value="${param.toDate != null ? param.toDate : toDate}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Nhóm theo</label>
                                <select name="groupBy" class="form-select">
                                    <option value="day" ${param.groupBy == 'day' ? 'selected' : ''}>Theo ngày</option>
                                    <option value="week" ${param.groupBy == 'week' ? 'selected' : ''}>Theo tuần</option>
                                    <option value="month" ${param.groupBy == 'month' ? 'selected' : ''}>Theo tháng</option>
                                </select>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-filter me-1"></i>Lọc
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Summary Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="stat-card revenue">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1 text-dark">Tổng doanh thu</p>
                                    <h3 class="text-dark"><fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</h3>
                                </div>
                                <i class="fas fa-money-bill-wave fa-3x text-dark opacity-50"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card bookings">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1 text-dark">Tổng đơn hàng</p>
                                    <h3 class="text-dark">${totalOrders != null ? totalOrders : 0}</h3>
                                </div>
                                <i class="fas fa-shopping-cart fa-3x text-dark opacity-50"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card tickets">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1 text-dark">Tổng vé bán</p>
                                    <h3 class="text-dark">${totalTickets != null ? totalTickets : 0}</h3>
                                </div>
                                <i class="fas fa-ticket-alt fa-3x text-dark opacity-50"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stat-card avg">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="mb-1">Trung bình/đơn</p>
                                    <h3><fmt:formatNumber value="${avgOrderValue != null ? avgOrderValue : 0}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</h3>
                                </div>
                                <i class="fas fa-chart-bar fa-3x opacity-50"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="row g-4 mb-4">
                    <div class="col-md-8">
                        <div class="chart-container">
                            <h5 class="mb-3"><i class="fas fa-chart-area me-2"></i>Biểu đồ doanh thu</h5>
                            <canvas id="revenueChart" height="300"></canvas>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="chart-container">
                            <h5 class="mb-3"><i class="fas fa-chart-pie me-2"></i>Doanh thu theo phim</h5>
                            <canvas id="movieChart" height="300"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Top Movies Table -->
                <div class="card bg-dark">
                    <div class="card-header">
                        <h5><i class="fas fa-trophy me-2"></i>Top phim có doanh thu cao nhất</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Phim</th>
                                        <th>Số vé bán</th>
                                        <th>Doanh thu</th>
                                        <th>Tỷ lệ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="movie" items="${topMovies}" varStatus="status">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${status.index == 0}"><i class="fas fa-trophy text-warning"></i></c:when>
                                                    <c:when test="${status.index == 1}"><i class="fas fa-medal text-secondary"></i></c:when>
                                                    <c:when test="${status.index == 2}"><i class="fas fa-medal" style="color: #cd7f32;"></i></c:when>
                                                    <c:otherwise>${status.index + 1}</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><strong>${movie.tenPhim}</strong></td>
                                            <td>${movie.soVeBan}</td>
                                            <td><fmt:formatNumber value="${movie.doanhThu}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</td>
                                            <td>
                                                <div class="progress" style="height: 20px;">
                                                    <div class="progress-bar bg-danger" style="width: ${movie.tyLe}%">${movie.tyLe}%</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty topMovies}">
                                        <tr>
                                            <td colspan="5" class="text-center py-4 text-muted">Chưa có dữ liệu</td>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: [<c:forEach var="item" items="${revenueData}" varStatus="s">'${item.label}'<c:if test="${!s.last}">,</c:if></c:forEach>],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: [<c:forEach var="item" items="${revenueData}" varStatus="s">${item.value}<c:if test="${!s.last}">,</c:if></c:forEach>],
                    borderColor: '#e50914',
                    backgroundColor: 'rgba(229, 9, 20, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { labels: { color: '#fff' } } },
                scales: {
                    x: { ticks: { color: '#9ca3af' }, grid: { color: '#374151' } },
                    y: { ticks: { color: '#9ca3af' }, grid: { color: '#374151' } }
                }
            }
        });

        // Movie Pie Chart
        const movieCtx = document.getElementById('movieChart').getContext('2d');
        new Chart(movieCtx, {
            type: 'doughnut',
            data: {
                labels: [<c:forEach var="movie" items="${topMovies}" varStatus="s">'${movie.tenPhim}'<c:if test="${!s.last}">,</c:if></c:forEach>],
                datasets: [{
                    data: [<c:forEach var="movie" items="${topMovies}" varStatus="s">${movie.doanhThu}<c:if test="${!s.last}">,</c:if></c:forEach>],
                    backgroundColor: ['#e50914', '#f59e0b', '#3b82f6', '#10b981', '#8b5cf6']
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom', labels: { color: '#fff' } } }
            }
        });
    </script>
</body>
</html>
