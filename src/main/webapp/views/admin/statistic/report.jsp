<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:10 AM
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
    <title>Báo cáo tổng hợp - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .report-card { background-color: #16213e; border-radius: 15px; padding: 20px; height: 100%; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .table-dark th { background-color: #0f172a; }
        .trend-up { color: #10b981; }
        .trend-down { color: #ef4444; }
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
                    <h1><i class="fas fa-file-alt me-2"></i>Báo cáo tổng hợp</h1>
                    <div class="btn-group">
                        <a href="${pageContext.request.contextPath}/admin/statistics/revenue" class="btn btn-outline-light">
                            <i class="fas fa-chart-line me-1"></i>Doanh thu
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/statistics/report" class="btn btn-danger">
                            <i class="fas fa-file-alt me-1"></i>Báo cáo
                        </a>
                    </div>
                </div>

                <!-- Filter -->
                <div class="card bg-dark mb-4">
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Tháng</label>
                                <select name="month" class="form-select">
                                    <c:forEach var="i" begin="1" end="12">
                                        <option value="${i}" ${param.month == i || (param.month == null && currentMonth == i) ? 'selected' : ''}>Tháng ${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Năm</label>
                                <select name="year" class="form-select">
                                    <c:forEach var="y" begin="2023" end="2025">
                                        <option value="${y}" ${param.year == y || (param.year == null && currentYear == y) ? 'selected' : ''}>${y}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-sync me-1"></i>Cập nhật
                                </button>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="button" class="btn btn-success w-100" onclick="window.print()">
                                    <i class="fas fa-print me-1"></i>In báo cáo
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <!-- Overview -->
                    <div class="col-md-6">
                        <div class="report-card">
                            <h5 class="mb-4"><i class="fas fa-chart-pie me-2"></i>Tổng quan tháng ${month}/${year}</h5>
                            <div class="row g-3">
                                <div class="col-6">
                                    <div class="border border-secondary rounded p-3 text-center">
                                        <i class="fas fa-money-bill-wave fa-2x text-success mb-2"></i>
                                        <h4><fmt:formatNumber value="${monthRevenue != null ? monthRevenue : 0}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</h4>
                                        <small class="text-muted">Doanh thu</small>
                                        <c:if test="${revenueTrend != null}">
                                            <div class="${revenueTrend >= 0 ? 'trend-up' : 'trend-down'}">
                                                <i class="fas fa-${revenueTrend >= 0 ? 'arrow-up' : 'arrow-down'}"></i> ${revenueTrend}%
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="border border-secondary rounded p-3 text-center">
                                        <i class="fas fa-ticket-alt fa-2x text-primary mb-2"></i>
                                        <h4>${monthTickets != null ? monthTickets : 0}</h4>
                                        <small class="text-muted">Vé bán ra</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="border border-secondary rounded p-3 text-center">
                                        <i class="fas fa-users fa-2x text-warning mb-2"></i>
                                        <h4>${newUsers != null ? newUsers : 0}</h4>
                                        <small class="text-muted">Khách hàng mới</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="border border-secondary rounded p-3 text-center">
                                        <i class="fas fa-film fa-2x text-danger mb-2"></i>
                                        <h4>${activeMovies != null ? activeMovies : 0}</h4>
                                        <small class="text-muted">Phim đang chiếu</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Daily Revenue Chart -->
                    <div class="col-md-6">
                        <div class="report-card">
                            <h5 class="mb-4"><i class="fas fa-chart-bar me-2"></i>Doanh thu theo ngày</h5>
                            <canvas id="dailyChart" height="200"></canvas>
                        </div>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <!-- Top Movies -->
                    <div class="col-md-6">
                        <div class="report-card">
                            <h5 class="mb-3"><i class="fas fa-film me-2"></i>Phim bán chạy nhất</h5>
                            <table class="table table-dark table-sm">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Phim</th>
                                        <th>Vé</th>
                                        <th>Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="movie" items="${topMoviesMonth}" varStatus="s">
                                        <tr>
                                            <td>${s.index + 1}</td>
                                            <td>${movie.tenPhim}</td>
                                            <td>${movie.soVeBan}</td>
                                            <td><fmt:formatNumber value="${movie.doanhThu}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty topMoviesMonth}">
                                        <tr><td colspan="4" class="text-center text-muted">Chưa có dữ liệu</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Peak Hours -->
                    <div class="col-md-6">
                        <div class="report-card">
                            <h5 class="mb-3"><i class="fas fa-clock me-2"></i>Giờ cao điểm</h5>
                            <canvas id="peakHoursChart" height="200"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Summary Table -->
                <div class="card bg-dark">
                    <div class="card-header">
                        <h5><i class="fas fa-table me-2"></i>Bảng tổng hợp theo tuần</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>Tuần</th>
                                        <th>Số đơn</th>
                                        <th>Số vé</th>
                                        <th>Doanh thu</th>
                                        <th>TB/đơn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="week" items="${weeklyData}">
                                        <tr>
                                            <td>Tuần ${week.weekNumber}</td>
                                            <td>${week.orders}</td>
                                            <td>${week.tickets}</td>
                                            <td><fmt:formatNumber value="${week.revenue}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</td>
                                            <td><fmt:formatNumber value="${week.avgOrder}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty weeklyData}">
                                        <tr><td colspan="5" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
                                    </c:if>
                                </tbody>
                                <tfoot>
                                    <tr class="table-secondary">
                                        <td><strong>Tổng cộng</strong></td>
                                        <td><strong>${totalOrders}</strong></td>
                                        <td><strong>${totalTickets}</strong></td>
                                        <td><strong><fmt:formatNumber value="${monthRevenue}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</strong></td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Daily Revenue Chart
        new Chart(document.getElementById('dailyChart'), {
            type: 'bar',
            data: {
                labels: [<c:forEach var="d" items="${dailyData}" varStatus="s">'${d.day}'<c:if test="${!s.last}">,</c:if></c:forEach>],
                datasets: [{
                    label: 'Doanh thu',
                    data: [<c:forEach var="d" items="${dailyData}" varStatus="s">${d.revenue}<c:if test="${!s.last}">,</c:if></c:forEach>],
                    backgroundColor: '#e50914'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    x: { ticks: { color: '#9ca3af' }, grid: { display: false } },
                    y: { ticks: { color: '#9ca3af' }, grid: { color: '#374151' } }
                }
            }
        });

        // Peak Hours Chart
        new Chart(document.getElementById('peakHoursChart'), {
            type: 'line',
            data: {
                labels: ['8h', '10h', '12h', '14h', '16h', '18h', '20h', '22h'],
                datasets: [{
                    label: 'Số vé',
                    data: [<c:forEach var="h" items="${peakHours}" varStatus="s">${h}<c:if test="${!s.last}">,</c:if></c:forEach>],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    x: { ticks: { color: '#9ca3af' }, grid: { display: false } },
                    y: { ticks: { color: '#9ca3af' }, grid: { color: '#374151' } }
                }
            }
        });
    </script>
</body>
</html>
