<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reeltix - Hệ thống đặt vé xem phim</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #e50914;
            --secondary-color: #141414;
            --text-color: #fff;
        }
        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-brand {
            color: var(--primary-color) !important;
            font-weight: bold;
            font-size: 1.8rem;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: #b8070f;
            border-color: #b8070f;
        }
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('${pageContext.request.contextPath}/assets/images/hero-bg.png');
            background-size: cover;
            background-position: center;
            padding: 100px 0;
            text-align: center;
        }
        .movie-card {
            background-color: #1f1f1f;
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        .movie-card:hover {
            transform: scale(1.05);
        }
        .movie-poster {
            width: 100%;
            height: 350px;
            object-fit: cover;
        }
        .movie-info {
            padding: 15px;
        }
        .movie-title {
            font-size: 1.1rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .movie-genre {
            color: #aaa;
            font-size: 0.9rem;
        }
        .section-title {
            color: var(--primary-color);
            margin-bottom: 30px;
        }

        /* Now Showing Section Styling */
        .now-showing-section {
            background-color: #0a0a0a;
        }

        /* Coming Soon Section Styling */
        .coming-soon-section {
            background-color: #1a1a1a;
        }
    </style>
</head>
<body>
    <jsp:include page="views/components/header.jsp" />

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">Chào mừng đến với Reeltix</h1>
            <p class="lead mb-4">Đặt vé xem phim trực tuyến - Nhanh chóng, tiện lợi</p>
            <a href="${pageContext.request.contextPath}/movies" class="btn btn-primary btn-lg">
                <i class="fas fa-film me-2"></i>Xem phim đang chiếu
            </a>
        </div>
    </section>

    <!-- Now Showing Section -->
    <section class="py-5 now-showing-section">
        <div class="container">
            <h2 class="section-title"><i class="fas fa-fire me-2"></i>Phim đang chiếu</h2>
            <div class="row g-4">
                <c:forEach var="movie" items="${nowShowingMovies}">
                    <div class="col-md-3">
                        <div class="movie-card">
                            <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                 alt="${movie.tenPhim}" class="movie-poster"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                            <div class="movie-info">
                                <div class="movie-title">${movie.tenPhim}</div>
                                <div class="movie-genre">${movie.theLoai}</div>
                                <div class="mt-2">
                                    <span class="badge bg-secondary">${movie.thoiLuong} phút</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.maPhim}"
                                   class="btn btn-primary btn-sm w-100 mt-3">
                                    <i class="fas fa-ticket-alt me-1"></i>Đặt vé
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty nowShowingMovies}">
                    <div class="col-12 text-center">
                        <p class="text-muted">Chưa có phim đang chiếu</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Coming Soon Section -->
    <section class="py-5 coming-soon-section">
        <div class="container">
            <h2 class="section-title"><i class="fas fa-clock me-2"></i>Phim sắp chiếu</h2>
            <div class="row g-4">
                <c:forEach var="movie" items="${comingSoonMovies}">
                    <div class="col-md-3">
                        <div class="movie-card">
                            <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                 alt="${movie.tenPhim}" class="movie-poster"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">
                            <div class="movie-info">
                                <div class="movie-title">${movie.tenPhim}</div>
                                <div class="movie-genre">${movie.theLoai}</div>
                                <div class="mt-2">
                                    <span class="badge bg-warning text-dark">Sắp chiếu</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty comingSoonMovies}">
                    <div class="col-12 text-center">
                        <p class="text-muted">Chưa có phim sắp chiếu</p>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <jsp:include page="views/components/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>