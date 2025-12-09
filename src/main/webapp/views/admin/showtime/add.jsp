e<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm suất chiếu - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .form-control, .form-select { background-color: #16213e; border-color: #374151; color: #fff; }
        .form-control:focus, .form-select:focus { background-color: #1f2937; border-color: #e50914; color: #fff; }
        .form-control::placeholder { color: #9ca3af; }
        .movie-info { display: none; padding: 15px; background: #16213e; border-radius: 10px; }
        .movie-poster { width: 100px; height: 150px; object-fit: cover; border-radius: 8px; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="showtimes"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-plus-circle me-2"></i>Thêm suất chiếu</h1>
                    <a href="${pageContext.request.contextPath}/admin/showtimes" class="btn btn-secondary">
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
                        <form action="${pageContext.request.contextPath}/admin/showtimes/add" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="maPhim" class="form-label">Phim <span class="text-danger">*</span></label>
                                        <select class="form-select" id="maPhim" name="maPhim" required onchange="showMovieInfo(this)">
                                            <option value="">-- Chọn phim --</option>
                                            <c:forEach var="movie" items="${movies}">
                                                <option value="${movie.maPhim}"
                                                        data-duration="${movie.thoiLuong}"
                                                        data-poster="${movie.anhPoster}"
                                                        data-genre="${movie.theLoai}"
                                                        ${param.maPhim == movie.maPhim ? 'selected' : ''}>
                                                    ${movie.tenPhim}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="maPhong" class="form-label">Phòng chiếu <span class="text-danger">*</span></label>
                                        <select class="form-select" id="maPhong" name="maPhong" required>
                                            <option value="">-- Chọn phòng --</option>
                                            <c:forEach var="room" items="${rooms}">
                                                <option value="${room.maPhong}" ${param.maPhong == room.maPhong ? 'selected' : ''}>
                                                    ${room.tenPhong} (${room.soLuongGhe} ghế)
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="ngayChieu" class="form-label">Ngày chiếu <span class="text-danger">*</span></label>
                                            <input type="date" class="form-control" id="ngayChieu" name="ngayChieu" required
                                                   value="${param.ngayChieu}" min="${today}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="gioChieu" class="form-label">Giờ chiếu <span class="text-danger">*</span></label>
                                            <input type="time" class="form-control" id="gioChieu" name="gioChieu" required
                                                   value="${param.gioChieu}">
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="giaVe" class="form-label">Giá vé (VNĐ) <span class="text-danger">*</span></label>
                                        <input type="number" class="form-control" id="giaVe" name="giaVe" required
                                               value="${param.giaVe != null ? param.giaVe : 75000}" min="10000" step="5000"
                                               placeholder="VD: 75000">
                                    </div>

                                    <div class="mb-3">
                                        <label for="trangThai" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="trangThai" name="trangThai">
                                            <option value="MoCua" ${param.trangThai == 'MoCua' || param.trangThai == null ? 'selected' : ''}>Mở cửa</option>
                                            <option value="DaDong" ${param.trangThai == 'DaDong' ? 'selected' : ''}>Đã đóng</option>
                                            <option value="Huy" ${param.trangThai == 'Huy' ? 'selected' : ''}>Hủy</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="movie-info" id="movieInfo">
                                        <h5 class="mb-3"><i class="fas fa-film me-2"></i>Thông tin phim</h5>
                                        <div class="d-flex gap-3">
                                            <img id="moviePoster" src="" alt="Poster" class="movie-poster">
                                            <div>
                                                <p><strong>Thể loại:</strong> <span id="movieGenre"></span></p>
                                                <p><strong>Thời lượng:</strong> <span id="movieDuration"></span> phút</p>
                                                <p><strong>Giờ kết thúc dự kiến:</strong> <span id="endTime"></span></p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card bg-secondary mt-3">
                                        <div class="card-header">
                                            <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Lưu ý</h6>
                                        </div>
                                        <div class="card-body">
                                            <ul class="mb-0 small">
                                                <li>Đảm bảo không có suất chiếu trùng giờ trong cùng phòng</li>
                                                <li>Thời gian giữa các suất chiếu nên cách nhau ít nhất 30 phút để dọn dẹp</li>
                                                <li>Giá vé có thể điều chỉnh theo ngày (cuối tuần, lễ tết)</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr class="border-secondary">
                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/showtimes" class="btn btn-secondary">Hủy</a>
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-save me-2"></i>Lưu suất chiếu
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
        function showMovieInfo(select) {
            const option = select.options[select.selectedIndex];
            const infoDiv = document.getElementById('movieInfo');

            if (option.value) {
                infoDiv.style.display = 'block';
                document.getElementById('moviePoster').src = '${pageContext.request.contextPath}/uploads/posters/' + option.dataset.poster;
                document.getElementById('movieGenre').textContent = option.dataset.genre;
                document.getElementById('movieDuration').textContent = option.dataset.duration;
                updateEndTime();
            } else {
                infoDiv.style.display = 'none';
            }
        }

        function updateEndTime() {
            const timeInput = document.getElementById('gioChieu').value;
            const movieSelect = document.getElementById('maPhim');
            const option = movieSelect.options[movieSelect.selectedIndex];

            if (timeInput && option.value) {
                const duration = parseInt(option.dataset.duration) || 0;
                const [hours, minutes] = timeInput.split(':').map(Number);
                const endDate = new Date();
                endDate.setHours(hours, minutes + duration);
                document.getElementById('endTime').textContent =
                    endDate.getHours().toString().padStart(2, '0') + ':' +
                    endDate.getMinutes().toString().padStart(2, '0');
            }
        }

        document.getElementById('gioChieu').addEventListener('change', updateEndTime);

        // Init if movie is preselected
        if (document.getElementById('maPhim').value) {
            showMovieInfo(document.getElementById('maPhim'));
        }
    </script>
</body>
</html>
