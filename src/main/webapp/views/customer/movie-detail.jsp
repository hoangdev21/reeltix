<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phim - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .btn-primary { background-color: #e50914; border-color: #e50914; }
        .btn-primary:hover { background-color: #b8070f; border-color: #b8070f; }
        .movie-poster { width: 100%; max-width: 300px; border-radius: 10px; }
        .showtime-btn { margin: 5px; }
        .showtime-btn:hover { background-color: #e50914; border-color: #e50914; }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="container py-5">
        <div class="row">
            <div class="col-md-4">
                <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                     alt="${movie.tenPhim}" class="movie-poster img-fluid"
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
            </div>
            <div class="col-md-8">
                <h1 class="mb-3">${movie.tenPhim}</h1>
                <div class="mb-3">
                    <span class="badge bg-danger me-2">${movie.trangThai == 'DangChieu' ? 'Đang chiếu' : 'Sắp chiếu'}</span>
                    <span class="badge bg-secondary">${movie.thoiLuong} phút</span>
                </div>
                <p><strong>Thể loại:</strong> ${movie.theLoai}</p>
                <p><strong>Đạo diễn:</strong> ${movie.daoDien}</p>
                <p><strong>Diễn viên:</strong> ${movie.dienVien}</p>
                <p><strong>Ngày khởi chiếu:</strong> ${movie.ngayKhoiChieu}</p>
                <hr>
                <h5>Nội dung phim</h5>
                <p>${movie.moTa}</p>

                <c:if test="${movie.trangThai == 'DangChieu'}">
                    <hr>
                    <h5><i class="fas fa-calendar-alt me-2"></i>Chọn suất chiếu</h5>
                    <div class="mb-3">
                        <c:forEach var="showtime" items="${showtimes}">
                            <a href="${pageContext.request.contextPath}/customer/seat-selection?showtimeId=${showtime.maSuatChieu}"
                               class="btn btn-outline-light showtime-btn">
                                ${showtime.ngayChieu} - ${showtime.gioChieu}
                                <small class="d-block"><fmt:formatNumber value="${showtime.giaVe}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</small>
                            </a>
                        </c:forEach>
                        <c:if test="${empty showtimes}">
                            <p class="text-muted">Chưa có suất chiếu</p>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
