<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm phim mới - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .form-control::placeholder { color: #9ca3af; }
        .preview-poster { max-width: 200px; max-height: 300px; border-radius: 10px; }
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
                    <h1><i class="fas fa-plus-circle me-2"></i>Thêm phim mới</h1>
                    <a href="${pageContext.request.contextPath}/admin/movies" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card bg-dark">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/movies/add" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="mb-3">
                                        <label for="tenPhim" class="form-label text-white">Tên phim <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="tenPhim" name="tenPhim" required
                                               value="${param.tenPhim}" placeholder="Nhập tên phim">
                                    </div>

                                    <div class="mb-3">
                                        <label for="moTa" class="form-label text-white">Mô tả</label>
                                        <textarea class="form-control" id="moTa" name="moTa" rows="4"
                                                  placeholder="Nhập mô tả phim">${param.moTa}</textarea>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="theLoai" class="form-label text-white">Thể loại <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="theLoai" name="theLoai" required
                                                   value="${param.theLoai}" placeholder="VD: Hành động, Phiêu lưu">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="thoiLuong" class="form-label text-white">Thời lượng (phút) <span class="text-danger">*</span></label>
                                            <input type="number" class="form-control" id="thoiLuong" name="thoiLuong" required
                                                   value="${param.thoiLuong}" min="1" placeholder="VD: 120">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="daoDien" class="form-label text-white">Đạo diễn</label>
                                            <input type="text" class="form-control" id="daoDien" name="daoDien"
                                                   value="${param.daoDien}" placeholder="Nhập tên đạo diễn">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="dienVien" class="form-label text-white">Diễn viên</label>
                                            <input type="text" class="form-control" id="dienVien" name="dienVien"
                                                   value="${param.dienVien}" placeholder="VD: Tom Holland, Zendaya">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="ngayKhoiChieu" class="form-label text-white">Ngày khởi chiếu <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="ngayKhoiChieu" name="ngayKhoiChieu" required
                                                   value="${param.ngayKhoiChieu}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="trangThai" class="form-label text-white">Trạng thái</label>
                                            <select class="form-select" id="trangThai" name="trangThai">
                                                <option value="SapChieu" ${param.trangThai == 'SapChieu' ? 'selected' : ''}>Sắp chiếu</option>
                                                <option value="DangChieu" ${param.trangThai == 'DangChieu' ? 'selected' : ''}>Đang chiếu</option>
                                                <option value="NgungChieu" ${param.trangThai == 'NgungChieu' ? 'selected' : ''}>Ngừng chiếu</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label for="poster" class="form-label text-white">Poster phim</label>
                                        <input type="file" class="form-control" id="poster" name="poster" accept="image/*"
                                               onchange="previewImage(this)">
                                        <div class="mt-3 text-center">
                                            <img id="posterPreview" src="${pageContext.request.contextPath}/assets/images/no-poster.svg"
                                                 alt="Preview" class="preview-poster">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="border-secondary">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/movies" class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-save me-2"></i>Lưu phim
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('posterPreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
