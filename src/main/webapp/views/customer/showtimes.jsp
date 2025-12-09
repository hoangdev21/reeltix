<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn suất chiếu - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .btn-primary { background-color: #e50914; border-color: #e50914; }
        .btn-primary:hover { background-color: #b8070f; border-color: #b8070f; }
        .movie-header {
            background: linear-gradient(135deg, #222 0%, #1a1a1a 100%);
            border-bottom: 2px solid #e50914;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        .movie-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .movie-meta {
            font-size: 14px;
            color: #999;
        }
        .showtime-card {
            background: #222;
            border: 1px solid #333;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }
        .showtime-card:hover {
            border-color: #e50914;
            box-shadow: 0 0 20px rgba(229, 9, 20, 0.3);
        }
        .showtime-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .showtime-time {
            font-size: 24px;
            font-weight: bold;
            color: #e50914;
        }
        .showtime-date {
            font-size: 14px;
            color: #999;
        }
        .showtime-room {
            font-size: 14px;
            color: #ccc;
        }
        .showtime-price {
            font-size: 20px;
            font-weight: bold;
            color: #e50914;
        }
        .btn-book-showtime {
            background-color: #e50914;
            border-color: #e50914;
            color: #fff;
            width: 100%;
            padding: 10px;
        }
        .btn-book-showtime:hover {
            background-color: #b8070f;
            border-color: #b8070f;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        .empty-state i {
            font-size: 60px;
            color: #666;
            margin-bottom: 20px;
        }
        .breadcrumb-nav {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="container py-5">
        <!-- Breadcrumb Navigation -->
        <nav class="breadcrumb-nav" aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/movies">Phim</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chọn suất chiếu</li>
            </ol>
        </nav>

        <c:if test="${not empty movie}">
            <div class="movie-header">
                <h2 class="movie-title">${movie.tenPhim}</h2>
                <div class="movie-meta">
                    <span><i class="fas fa-tag me-1"></i>${movie.theLoai}</span>
                    <span class="ms-3"><i class="fas fa-clock me-1"></i>${movie.thoiLuong} phút</span>
                    <span class="ms-3"><i class="fas fa-user me-1"></i>${movie.daoDien}</span>
                </div>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-8">
                <h3 class="mb-4"><i class="fas fa-calendar-alt me-2"></i>Chọn suất chiếu</h3>

                <c:choose>
                    <c:when test="${not empty showtimes}">
                        <c:forEach var="showtime" items="${showtimes}">
                            <div class="showtime-card">
                                <div class="showtime-info">
                                    <div>
                                        <div class="showtime-time">${showtime.gioChieu}</div>
                                        <div class="showtime-date">${showtime.ngayChieu}</div>
                                    </div>
                                    <div class="text-end">
                                        <div class="showtime-room">
                                            <i class="fas fa-door-open me-1"></i>
                                            Phòng ${showtime.maPhong}
                                        </div>
                                        <div class="showtime-price">${showtime.giaVe}đ</div>
                                    </div>
                                </div>
                                <a href="${pageContext.request.contextPath}/customer/seat-selection?showtimeId=${showtime.maSuatChieu}"
                                   class="btn btn-book-showtime">
                                    <i class="fas fa-ticket-alt me-2"></i>Chọn ghế
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-film"></i>
                            <p class="mt-3">Chưa có suất chiếu cho phim này</p>
                            <a href="${pageContext.request.contextPath}/movies" class="btn btn-primary mt-3">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách phim
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="col-md-4">
                <div class="card bg-dark text-white sticky-top" style="top: 20px;">
                    <div class="card-header">
                        <h5><i class="fas fa-info-circle me-2"></i>Thông tin</h5>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty movie}">
                            <p>
                                <strong>Phim:</strong><br>
                                <span class="text-muted">${movie.tenPhim}</span>
                            </p>
                            <hr>
                        </c:if>
                        <p>
                            <strong>Tổng suất chiếu:</strong><br>
                            <span class="text-danger">${showtimes.size()} suất</span>
                        </p>
                        <hr>
                        <p class="text-muted small">
                            <i class="fas fa-lightbulb me-1"></i>
                            Chọn một suất chiếu để tiếp tục đặt vé
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
