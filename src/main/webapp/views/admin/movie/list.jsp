<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phim - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .table-dark th { background-color: #16213e; }
        .movie-poster { width: 60px; height: 90px; object-fit: cover; border-radius: 5px; }
        .badge-showing { background-color: #28a745; }
        .badge-coming { background-color: #ffc107; color: #000; }
        .badge-ended { background-color: #dc3545; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="movies"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-film me-2"></i>Quản lý phim</h1>
                    <a href="${pageContext.request.contextPath}/admin/movies/add" class="btn btn-danger">
                        <i class="fas fa-plus me-2"></i>Thêm phim mới
                    </a>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Search and Filter -->
                <div class="card bg-dark mb-4">
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-4">
                                <input type="text" name="search" class="form-control" placeholder="Tìm kiếm theo tên phim..." value="${param.search}">
                            </div>
                            <div class="col-md-3">
                                <select name="status" class="form-select">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="DangChieu" ${param.status == 'DangChieu' ? 'selected' : ''}>Đang chiếu</option>
                                    <option value="SapChieu" ${param.status == 'SapChieu' ? 'selected' : ''}>Sắp chiếu</option>
                                    <option value="NgungChieu" ${param.status == 'NgungChieu' ? 'selected' : ''}>Ngừng chiếu</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-1"></i>Tìm kiếm
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Movies Table -->
                <div class="card bg-dark">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-dark table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Poster</th>
                                        <th>Tên phim</th>
                                        <th>Thể loại</th>
                                        <th>Thời lượng</th>
                                        <th>Ngày khởi chiếu</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="movie" items="${movies}">
                                        <tr>
                                            <td>${movie.maPhim}</td>
                                            <td>
                                                <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                                     alt="${movie.tenPhim}" class="movie-poster"
                                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                                            </td>
                                            <td>
                                                <strong>${movie.tenPhim}</strong>
                                                <br><small class="text-white-50">Đạo diễn: ${movie.daoDien}</small>
                                            </td>
                                            <td>${movie.theLoai}</td>
                                            <td>${movie.thoiLuong} phút</td>
                                            <td><fmt:formatDate value="${movie.ngayKhoiChieu}" pattern="dd/MM/yyyy"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${movie.trangThai == 'DangChieu'}">
                                                        <span class="badge badge-showing">Đang chiếu</span>
                                                    </c:when>
                                                    <c:when test="${movie.trangThai == 'SapChieu'}">
                                                        <span class="badge badge-coming">Sắp chiếu</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-ended">Ngừng chiếu</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/movies/edit?id=${movie.maPhim}"
                                                   class="btn btn-sm btn-warning" title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-sm btn-danger"
                                                        onclick="confirmDelete(${movie.maPhim}, '${movie.tenPhim}')" title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty movies}">
                                        <tr>
                                            <td colspan="8" class="text-center py-4">
                                                <i class="fas fa-film fa-3x mb-3 text-white-50"></i>
                                                <p class="text-white-50">Không có phim nào</p>
                                            </td>
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

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content bg-dark">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa phim "<span id="movieName"></span>"?</p>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form id="deleteForm" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id, name) {
            document.getElementById('movieName').textContent = name;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/movies/delete?id=' + id;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html>
