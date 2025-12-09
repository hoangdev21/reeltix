<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Reeltix | Đặt vé xem phim trực tuyến</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-overlay"></div>
        <div class="container position-relative">
            <div class="row align-items-center min-vh-75 py-5">
                <div class="col-lg-6">
                    <span class="hero-badge">
                        <i class="fas fa-star me-1"></i>Trải nghiệm điện ảnh đỉnh cao
                    </span>
                    <h1 class="hero-title">
                        Đặt vé xem phim<br>
                        <span class="text-gradient">Nhanh chóng & Tiện lợi</span>
                    </h1>
                    <p class="hero-description">
                        Khám phá thế giới điện ảnh với hàng trăm bộ phim bom tấn.
                        Đặt vé chỉ trong vài giây, nhận vé điện tử ngay lập tức.
                    </p>
                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/movies" class="btn btn-primary btn-lg">
                            <i class="fas fa-film me-2"></i>Xem phim ngay
                        </a>
                        <a href="${pageContext.request.contextPath}/showtimes" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-calendar-alt me-2"></i>Lịch chiếu
                        </a>
                    </div>
                    <div class="hero-stats">
                        <div class="stat-item">
                            <span class="stat-number">500+</span>
                            <span class="stat-label">Phim hay</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">10K+</span>
                            <span class="stat-label">Khách hàng</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-number">4.9</span>
                            <span class="stat-label">Đánh giá</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Now Showing -->
    <section class="py-5">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-fire"></i>Phim đang chiếu</h2>
                <a href="${pageContext.request.contextPath}/movies" class="btn btn-outline-light btn-sm">
                    Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                </a>
            </div>
            <div class="row g-4">
                <c:forEach var="movie" items="${nowShowingMovies}">
                    <div class="col-lg-3 col-md-4 col-6">
                        <div class="movie-card">
                            <div class="movie-poster-wrapper">
                                <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                     alt="${movie.tenPhim}" class="movie-poster"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                                <div class="movie-overlay">
                                    <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.maPhim}"
                                       class="btn btn-primary">
                                        <i class="fas fa-ticket-alt me-1"></i>Đặt vé
                                    </a>
                                </div>
                                <span class="movie-badge now-showing">Đang chiếu</span>
                            </div>
                            <div class="movie-info">
                                <h5 class="movie-title">${movie.tenPhim}</h5>
                                <div class="movie-meta">
                                    <span><i class="fas fa-tag"></i>${movie.theLoai}</span>
                                    <span><i class="fas fa-clock"></i>${movie.thoiLuong} phút</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty nowShowingMovies}">
                    <div class="col-12">
                        <div class="empty-state">
                            <i class="fas fa-film"></i>
                            <p>Chưa có phim đang chiếu</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Coming Soon -->
    <section class="py-5 bg-section-dark">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-clock"></i>Phim sắp chiếu</h2>
                <a href="${pageContext.request.contextPath}/movies?status=coming" class="btn btn-outline-light btn-sm">
                    Xem tất cả <i class="fas fa-arrow-right ms-1"></i>
                </a>
            </div>
            <div class="row g-4">
                <c:forEach var="movie" items="${comingSoonMovies}">
                    <div class="col-lg-3 col-md-4 col-6">
                        <div class="movie-card">
                            <div class="movie-poster-wrapper">
                                <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                     alt="${movie.tenPhim}" class="movie-poster"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                                <div class="movie-overlay">
                                    <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.maPhim}"
                                       class="btn btn-outline-light">
                                        <i class="fas fa-info-circle me-1"></i>Chi tiết
                                    </a>
                                </div>
                                <span class="movie-badge coming-soon">Sắp chiếu</span>
                            </div>
                            <div class="movie-info">
                                <h5 class="movie-title">${movie.tenPhim}</h5>
                                <div class="movie-meta">
                                    <span><i class="fas fa-tag"></i>${movie.theLoai}</span>
                                    <span><i class="fas fa-clock"></i>${movie.thoiLuong} phút</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty comingSoonMovies}">
                    <div class="col-12">
                        <div class="empty-state">
                            <i class="fas fa-clock"></i>
                            <p>Chưa có phim sắp chiếu</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="section-title justify-content-center"><i class="fas fa-star"></i>Tại sao chọn Reeltix?</h2>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <h5>Đặt vé nhanh chóng</h5>
                        <p>Chỉ với vài thao tác đơn giản, bạn đã có vé trong tay</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h5>Thanh toán an toàn</h5>
                        <p>Bảo mật thông tin với các cổng thanh toán uy tín</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-percent"></i>
                        </div>
                        <h5>Ưu đãi hấp dẫn</h5>
                        <p>Nhiều chương trình khuyến mãi dành riêng cho thành viên</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h5>Hỗ trợ 24/7</h5>
                        <p>Đội ngũ chăm sóc khách hàng luôn sẵn sàng hỗ trợ</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
