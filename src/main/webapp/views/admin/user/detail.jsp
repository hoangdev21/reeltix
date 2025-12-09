<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .user-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 15px; padding: 30px; }
        .user-avatar-lg { width: 100px; height: 100px; border-radius: 50%; background-color: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 40px; }
        .badge-active { background-color: #28a745; }
        .badge-inactive { background-color: #dc3545; }
        .badge-admin { background-color: #9333ea; }
        .badge-customer { background-color: #3b82f6; }
        .table-dark th { background-color: #16213e; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="users"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-user me-2"></i>Chi tiết người dùng</h1>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <!-- User Info Card -->
                        <div class="user-header mb-4">
                            <div class="text-center">
                                <div class="user-avatar-lg mx-auto mb-3">
                                    <i class="fas fa-user"></i>
                                </div>
                                <h3>${user.hoTen}</h3>
                                <p class="mb-2">@${user.tenDangNhap}</p>
                                <c:choose>
                                    <c:when test="${user.vaiTro == 'Admin'}">
                                        <span class="badge badge-admin fs-6"><i class="fas fa-shield-alt me-1"></i>Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-customer fs-6"><i class="fas fa-user me-1"></i>Khách hàng</span>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${user.trangThai == 'HoatDong'}">
                                        <span class="badge badge-active fs-6">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive fs-6">Bị khóa</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="card bg-dark mb-4">
                            <div class="card-header">
                                <h5><i class="fas fa-info-circle me-2"></i>Thông tin liên hệ</h5>
                            </div>
                            <div class="card-body">
                                <p><i class="fas fa-envelope me-2 text-primary"></i><strong>Email:</strong> ${user.email}</p>
                                <p><i class="fas fa-phone me-2 text-success"></i><strong>SĐT:</strong> ${user.soDienThoai}</p>
                                <p><i class="fas fa-calendar me-2 text-warning"></i><strong>Ngày tạo:</strong> <fmt:formatDate value="${user.ngayTao}" pattern="dd/MM/yyyy HH:mm"/></p>
                            </div>
                        </div>

                        <div class="card bg-dark">
                            <div class="card-header">
                                <h5><i class="fas fa-cog me-2"></i>Thao tác</h5>
                            </div>
                            <div class="card-body d-grid gap-2">
                                <c:if test="${user.trangThai == 'HoatDong'}">
                                    <form action="${pageContext.request.contextPath}/admin/users/lock" method="post"
                                          onsubmit="return confirm('Bạn có chắc chắn muốn khóa tài khoản này?')">
                                        <input type="hidden" name="id" value="${user.maNguoiDung}">
                                        <button type="submit" class="btn btn-warning w-100">
                                            <i class="fas fa-lock me-2"></i>Khóa tài khoản
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${user.trangThai == 'BiKhoa'}">
                                    <form action="${pageContext.request.contextPath}/admin/users/unlock" method="post"
                                          onsubmit="return confirm('Bạn có chắc chắn muốn mở khóa tài khoản này?')">
                                        <input type="hidden" name="id" value="${user.maNguoiDung}">
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-unlock me-2"></i>Mở khóa tài khoản
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <!-- Statistics -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <div class="card bg-primary text-white">
                                    <div class="card-body text-center">
                                        <i class="fas fa-ticket-alt fa-2x mb-2"></i>
                                        <h3>${totalBookings != null ? totalBookings : 0}</h3>
                                        <p class="mb-0">Đơn đặt vé</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-success text-white">
                                    <div class="card-body text-center">
                                        <i class="fas fa-money-bill-wave fa-2x mb-2"></i>
                                        <h3><fmt:formatNumber value="${totalSpent != null ? totalSpent : 0}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</h3>
                                        <p class="mb-0">Tổng chi tiêu</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card bg-info text-white">
                                    <div class="card-body text-center">
                                        <i class="fas fa-film fa-2x mb-2"></i>
                                        <h3>${totalMoviesWatched != null ? totalMoviesWatched : 0}</h3>
                                        <p class="mb-0">Phim đã xem</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Bookings -->
                        <div class="card bg-dark">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="fas fa-history me-2"></i>Lịch sử đặt vé</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-dark table-hover">
                                        <thead>
                                            <tr>
                                                <th>Mã đơn</th>
                                                <th>Phim</th>
                                                <th>Ngày chiếu</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="booking" items="${userBookings}">
                                                <tr>
                                                    <td><a href="${pageContext.request.contextPath}/admin/bookings/detail?id=${booking.maDon}" class="text-primary">${booking.maDon}</a></td>
                                                    <td>${booking.tenPhim}</td>
                                                    <td>${booking.ngayChieu}</td>
                                                    <td><fmt:formatNumber value="${booking.tongTien}" type="currency" currencySymbol="" maxFractionDigits="0"/>đ</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${booking.trangThai == 'DaXacNhan'}">
                                                                <span class="badge badge-active">Đã xác nhận</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge badge-inactive">Đã hủy</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty userBookings}">
                                                <tr>
                                                    <td colspan="5" class="text-center py-4 text-muted">Chưa có đơn đặt vé nào</td>
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
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
