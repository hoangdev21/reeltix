<%--
  Reeltix - Header Component
  Professional Cinema Booking System
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    :root {
        --primary-color: #e50914;
        --secondary-color: #72454e;
        --dark-bg: #0a0e27;
        --darker-bg: #141414;
        --card-bg: #1a1f3a;
        --text-primary: #ffffff;
        --text-secondary: #aaaaaa;
        --border-color: rgba(229, 9, 20, 0.2);
    }

    .navbar-main {
        background: linear-gradient(135deg, #0a0e27 0%, #1a1f3a 100%);
        border-bottom: 2px solid var(--primary-color);
        padding: 15px 0;
        transition: all 0.3s ease;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .navbar-main.scrolled {
        padding: 10px 0;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
    }

    .navbar-brand {
        font-size: 20px;
        font-weight: bold;
        color: var(--primary-color) !important;
        transition: all 0.3s ease;
        text-decoration: none;
    }

    .navbar-brand:hover {
        transform: scale(1.05);
        text-shadow: 0 0 10px rgba(229, 9, 20, 0.5);
    }

    .navbar-brand i {
        margin-right: 8px;
    }

    .brand-text {
        letter-spacing: 1px;
        font-weight: 700;
    }

    .navbar-nav .nav-link {
        color: var(--text-primary) !important;
        margin: 0 8px;
        position: relative;
        transition: all 0.3s ease;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .navbar-nav .nav-link:hover {
        color: var(--secondary-color) !important;
        transform: translateY(-2px);
    }

    .navbar-nav .nav-link::after {
        content: '';
        position: absolute;
        bottom: -5px;
        left: 0;
        right: 0;
        height: 2px;
        background: var(--primary-color);
        transform: scaleX(0);
        transition: transform 0.3s ease;
    }

    .navbar-nav .nav-link:hover::after,
    .navbar-nav .nav-link.active::after {
        transform: scaleX(1);
    }

    .navbar-nav .nav-link.active {
        color: var(--secondary-color) !important;
    }

    .navbar-nav .nav-link i {
        font-size: 16px;
    }

    .header-search {
        display: flex !important;
        align-items: center;
        background: rgba(255, 255, 255, 0.1);
        border: 1px solid var(--border-color);
        border-radius: 20px;
        padding: 8px 15px;
        margin: 0 20px;
        transition: all 0.3s ease;
    }

    .header-search:hover,
    .header-search:focus-within {
        background: rgba(229, 9, 20, 0.15);
        border-color: var(--primary-color);
        box-shadow: 0 0 15px rgba(229, 9, 20, 0.3);
    }

    .header-search i {
        color: var(--primary-color);
        margin-right: 10px;
        font-size: 14px;
    }

    .header-search input {
        background: transparent;
        border: none;
        color: var(--text-primary);
        font-size: 13px;
        width: 200px;
        outline: none;
    }

    .header-search input::placeholder {
        color: var(--text-secondary);
    }

    .user-dropdown .nav-link {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 12px !important;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .user-dropdown .nav-link:hover {
        background: rgba(229, 9, 20, 0.2);
    }

    .user-avatar {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
    }

    .btn-auth-login {
        background: transparent;
        border: 2px solid var(--primary-color);
        color: var(--primary-color) !important;
        border-radius: 6px;
        padding: 8px 16px !important;
        transition: all 0.3s ease;
    }

    .btn-auth-login:hover {
        background: var(--primary-color);
        color: white !important;
        box-shadow: 0 0 15px rgba(229, 9, 20, 0.4);
    }

    .btn-auth-register {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white !important;
        border-radius: 6px;
        padding: 8px 16px !important;
        transition: all 0.3s ease;
    }

    .btn-auth-register:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 20px rgba(229, 9, 20, 0.4);
    }

    .dropdown-menu-dark {
        background: linear-gradient(135deg, #1a1f3a 0%, #0f1423 100%) !important;
        border: 1px solid var(--border-color);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5) !important;
    }

    .dropdown-menu-dark .dropdown-item {
        color: var(--text-primary);
        transition: all 0.2s ease;
    }

    .dropdown-menu-dark .dropdown-item:hover {
        background: rgba(229, 9, 20, 0.15);
        color: var(--secondary-color);
        padding-left: 1.5rem;
    }

    .dropdown-menu-dark .dropdown-item i {
        margin-right: 8px;
        color: var(--primary-color);
    }

    .navbar-toggler {
        border: 1px solid var(--primary-color) !important;
    }

    .navbar-toggler:focus {
        box-shadow: 0 0 10px rgba(229, 9, 20, 0.3);
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='%23e50914' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    @media (max-width: 991px) {
        .header-search {
            margin: 10px 0;
            width: 100%;
        }

        .header-search input {
            width: 100%;
        }

        .navbar-nav {
            padding-top: 10px;
        }

        .navbar-nav .nav-link {
            padding: 10px 8px !important;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-main sticky-top">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-film"></i>
            <span class="brand-text">Reeltix</span>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Nội dung menu -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Điều hướng -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('home') ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('movie') ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/movies">
                        <i class="fas fa-film"></i>Phim
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${pageContext.request.requestURI.contains('showtime') ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/showtimes">
                        <i class="fas fa-calendar-alt"></i>Lịch chiếu
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/promotions">
                        <i class="fas fa-tags"></i>Khuyến mãi
                    </a>
                </li>
            </ul>

            <!-- Ô search -->
            <div class="header-search d-none d-lg-flex">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Tìm kiếm phim..." id="headerSearch"
                       onkeypress="if(event.key==='Enter') window.location.href='${pageContext.request.contextPath}/movies?search='+this.value">
            </div>

            <!-- Hành động ng dùng -->
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <!-- Ng dùng đã đăng nhập -->
                        <li class="nav-item dropdown user-dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <div class="user-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <span class="d-none d-md-inline">${sessionScope.user.hoTen}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark">
                                <li>
                                    <div style="padding: 12px 16px; border-bottom: 1px solid rgba(229, 9, 20, 0.2);">
                                        <div style="font-weight: bold; color: white;">${sessionScope.user.hoTen}</div>
                                        <small style="color: #aaa;">${sessionScope.user.email}</small>
                                    </div>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/customer/profile">
                                        <i class="fas fa-user-circle"></i>Thông tin cá nhân
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/customer/my-bookings">
                                        <i class="fas fa-ticket-alt"></i>Vé của tôi
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/customer/favorites">
                                        <i class="fas fa-heart"></i>Phim yêu thích
                                    </a>
                                </li>
                                <li><hr style="margin: 8px 0; opacity: 0.3; border-color: rgba(229, 9, 20, 0.2)"></li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout"
                                       style="color: #ff1744;">
                                        <i class="fas fa-sign-out-alt"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Người dùng khách -->
                        <li class="nav-item">
                            <a class="nav-link btn-auth-login" href="${pageContext.request.contextPath}/auth/login">
                                <i class="fas fa-sign-in-alt"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item ms-2">
                            <a class="nav-link btn-auth-register" href="${pageContext.request.contextPath}/auth/register">
                                <i class="fas fa-user-plus"></i>Đăng ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Cuộn -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const navbar = document.querySelector('.navbar-main');
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    });
</script>
