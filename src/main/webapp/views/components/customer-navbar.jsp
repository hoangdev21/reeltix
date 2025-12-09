<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .customer-navbar {
        background: linear-gradient(135deg, #0a0e27 0%, #1a1f3a 100%);
        border-bottom: 2px solid #e50914;
        padding: 12px 0;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .customer-navbar-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
    }

    .customer-nav-brand {
        font-size: 18px;
        font-weight: bold;
        color: #e50914;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }

    .customer-nav-brand:hover {
        transform: scale(1.05);
        text-shadow: 0 0 10px rgba(229, 9, 20, 0.5);
    }

    .customer-nav-brand i {
        font-size: 20px;
    }

    .customer-nav-links {
        display: flex;
        gap: 30px;
        align-items: center;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .customer-nav-link {
        color: #fff;
        text-decoration: none;
        font-size: 14px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 6px;
        font-weight: 500;
    }

    .customer-nav-link:hover {
        color: #e50914;
        transform: translateY(-2px);
    }

    .customer-nav-link i {
        font-size: 16px;
    }

    .customer-nav-actions {
        display: flex;
        gap: 15px;
        align-items: center;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .customer-nav-action-link {
        color: #fff;
        text-decoration: none;
        font-size: 14px;
        padding: 8px 12px;
        border-radius: 6px;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .customer-nav-action-link:hover {
        background: rgba(229, 9, 20, 0.1);
        color: #e50914;
    }

    .customer-nav-action-link i {
        font-size: 16px;
    }

    .customer-nav-btn {
        padding: 8px 16px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 6px;
        border: none;
        cursor: pointer;
    }

    .customer-nav-btn-primary {
        background: linear-gradient(135deg, #e50914, #ff1744);
        color: white;
    }

    .customer-nav-btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 20px rgba(229, 9, 20, 0.4);
    }

    .customer-nav-btn-secondary {
        background: transparent;
        border: 2px solid #e50914;
        color: #e50914;
    }

    .customer-nav-btn-secondary:hover {
        background: #e50914;
        color: white;
        box-shadow: 0 0 15px rgba(229, 9, 20, 0.4);
    }

    @media (max-width: 768px) {
        .customer-navbar-container {
            flex-wrap: wrap;
            padding: 0 15px;
        }

        .customer-nav-links {
            gap: 15px;
            order: 3;
            width: 100%;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid rgba(229, 9, 20, 0.1);
            display: none;
        }

        .customer-nav-actions {
            gap: 10px;
        }

        .customer-nav-link {
            font-size: 13px;
        }

        .customer-nav-action-link {
            font-size: 12px;
            padding: 6px 10px;
        }
    }

    @media (max-width: 480px) {
        .customer-navbar-container {
            padding: 0 10px;
        }

        .customer-nav-links {
            gap: 10px;
        }

        .customer-nav-actions {
            gap: 8px;
        }

        .customer-nav-btn {
            padding: 6px 12px;
            font-size: 12px;
        }
    }
</style>

<!-- Customer Navbar -->
<nav class="customer-navbar">
    <div class="customer-navbar-container">
        <!-- Brand -->
        <a href="${pageContext.request.contextPath}/" class="customer-nav-brand">
            <i class="fas fa-film"></i>
            <span>Reeltix</span>
        </a>

        <!-- Navigation Links -->
        <ul class="customer-nav-links">
            <li>
                <a href="${pageContext.request.contextPath}/" class="customer-nav-link">
                    <i class="fas fa-home"></i>Trang chủ
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/movies" class="customer-nav-link">
                    <i class="fas fa-film"></i>Phim
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/showtimes" class="customer-nav-link">
                    <i class="fas fa-calendar-alt"></i>Lịch chiếu
                </a>
            </li>
        </ul>

        <!-- Action Links & Buttons -->
        <ul class="customer-nav-actions">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- User is logged in -->
                    <li>
                        <a href="${pageContext.request.contextPath}/customer/my-bookings" class="customer-nav-action-link">
                            <i class="fas fa-ticket-alt"></i>Vé của tôi
                        </a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="customer-nav-action-link dropdown-toggle" data-bs-toggle="dropdown"
                           style="gap: 8px; align-items: center;">
                            <div style="width: 28px; height: 28px; border-radius: 50%; background: linear-gradient(135deg, #e50914, #ff1744); display: flex; align-items: center; justify-content: center; font-size: 14px;">
                                <i class="fas fa-user"></i>
                            </div>
                            <span class="d-none d-md-inline">${sessionScope.user.hoTen}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end" style="background: linear-gradient(135deg, #1a1f3a 0%, #0f1423 100%); border: 1px solid rgba(229, 9, 20, 0.2); border-radius: 8px; box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/customer/profile"
                                   style="color: #aaa; font-size: 14px; transition: all 0.2s ease;">
                                    <i class="fas fa-user-circle" style="color: #e50914; margin-right: 8px;"></i>Thông tin cá nhân
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/customer/my-bookings"
                                   style="color: #aaa; font-size: 14px; transition: all 0.2s ease;">
                                    <i class="fas fa-history" style="color: #e50914; margin-right: 8px;"></i>Lịch sử đặt vé
                                </a>
                            </li>
                            <li><hr class="dropdown-divider" style="border-color: rgba(229, 9, 20, 0.1); margin: 8px 0;"></li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout"
                                   style="color: #ff1744; font-size: 14px; transition: all 0.2s ease;">
                                    <i class="fas fa-sign-out-alt" style="color: #ff1744; margin-right: 8px;"></i>Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <!-- User is not logged in -->
                    <li>
                        <a href="${pageContext.request.contextPath}/auth/login" class="customer-nav-btn customer-nav-btn-secondary">
                            <i class="fas fa-sign-in-alt"></i>Đăng nhập
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/auth/register" class="customer-nav-btn customer-nav-btn-primary">
                            <i class="fas fa-user-plus"></i>Đăng ký
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
