<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .admin-sidebar {
        background: linear-gradient(180deg, #1a1f3a 0%, #0f1423 100%);
        border-right: 2px solid #e50914;
        min-height: 100vh;
        padding: 20px 0;
        display: flex;
        flex-direction: column;
        box-shadow: 2px 0 10px rgba(0, 0, 0, 0.3);
    }

    .sidebar-brand {
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        margin-bottom: 10px;
    }

    .sidebar-brand-text {
        font-size: 18px;
        font-weight: bold;
        color: #e50914;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .sidebar-brand-text i {
        font-size: 22px;
    }

    .sidebar-divider {
        border-top: 1px solid rgba(229, 9, 20, 0.2);
        margin: 15px 15px;
    }

    .sidebar-nav {
        flex: 1;
        padding: 0 10px;
        list-style: none;
        margin: 0;
    }

    .sidebar-nav-item {
        margin-bottom: 8px;
    }

    .sidebar-nav-link {
        display: flex;
        align-items: center;
        gap: 12px;
        color: #aaa;
        text-decoration: none;
        padding: 12px 15px;
        border-radius: 8px;
        transition: all 0.3s ease;
        font-size: 14px;
        font-weight: 500;
    }

    .sidebar-nav-link:hover {
        color: #fff;
        background: rgba(229, 9, 20, 0.1);
        transform: translateX(5px);
    }

    .sidebar-nav-link.active {
        background: linear-gradient(90deg, #e50914, #ff1744);
        color: #fff;
        box-shadow: 0 4px 12px rgba(229, 9, 20, 0.3);
    }

    .sidebar-nav-link i {
        font-size: 16px;
        min-width: 20px;
        text-align: center;
        color: #e50914;
    }

    .sidebar-nav-link.active i {
        color: #fff;
    }

    .sidebar-footer {
        padding: 15px;
        border-top: 1px solid rgba(229, 9, 20, 0.2);
    }

    .sidebar-user-menu {
        display: flex;
        align-items: center;
        gap: 10px;
        text-decoration: none;
        color: #fff;
        padding: 10px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .sidebar-user-menu:hover {
        background: rgba(229, 9, 20, 0.1);
    }

    .sidebar-user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, #e50914, #ff1744);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        flex-shrink: 0;
    }

    .sidebar-user-info {
        flex: 1;
        overflow: hidden;
    }

    .sidebar-user-name {
        font-size: 13px;
        font-weight: bold;
        color: #fff;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .sidebar-user-toggle {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        background: rgba(229, 9, 20, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #e50914;
        cursor: pointer;
        transition: all 0.2s ease;
        flex-shrink: 0;
    }

    .sidebar-user-menu:hover .sidebar-user-toggle {
        background: rgba(229, 9, 20, 0.4);
        transform: scale(1.1);
    }

    .dropdown-menu-dark {
        background: linear-gradient(135deg, #1a1f3a 0%, #0f1423 100%) !important;
        border: 1px solid rgba(229, 9, 20, 0.2);
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5) !important;
        border-radius: 8px;
    }

    .dropdown-menu-dark .dropdown-item {
        color: #aaa;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 14px;
    }

    .dropdown-menu-dark .dropdown-item i {
        color: #e50914;
        font-size: 14px;
        min-width: 18px;
    }

    .dropdown-menu-dark .dropdown-item:hover {
        background: rgba(229, 9, 20, 0.15);
        color: #fff;
        padding-left: 1.5rem;
    }

    .dropdown-menu-dark .dropdown-divider {
        border-color: rgba(229, 9, 20, 0.1);
    }

    @media (max-width: 768px) {
        .admin-sidebar {
            width: 100% !important;
            min-height: auto;
            border-right: none;
            border-bottom: 2px solid #e50914;
        }

        .sidebar-nav {
            display: flex;
            flex-wrap: wrap;
            padding: 10px;
        }

        .sidebar-nav-item {
            flex: 0 1 calc(50% - 5px);
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .sidebar-footer {
            border-top: 1px solid rgba(229, 9, 20, 0.2);
            border-left: none;
        }
    }

    @media (max-width: 576px) {
        .sidebar-nav-link {
            padding: 10px 12px;
            font-size: 13px;
        }

        .sidebar-user-name {
            font-size: 12px;
        }
    }
</style>

<div class="d-flex flex-column flex-shrink-0 admin-sidebar" style="width: 280px;">
    <!-- Sidebar Brand -->
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-brand">
        <div class="sidebar-brand-text">
            <i class="fas fa-film"></i>
            <span>Reeltix Admin</span>
        </div>
    </a>

    <div class="sidebar-divider"></div>

    <!-- Sidebar Navigation -->
    <ul class="sidebar-nav mb-auto">
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="sidebar-nav-link ${param.active == 'dashboard' ? 'active' : ''}">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/movies"
               class="sidebar-nav-link ${param.active == 'movies' ? 'active' : ''}">
                <i class="fas fa-film"></i>
                <span>Quản lý phim</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/rooms"
               class="sidebar-nav-link ${param.active == 'rooms' ? 'active' : ''}">
                <i class="fas fa-door-open"></i>
                <span>Quản lý phòng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/showtimes"
               class="sidebar-nav-link ${param.active == 'showtimes' ? 'active' : ''}">
                <i class="fas fa-calendar-alt"></i>
                <span>Quản lý suất chiếu</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/bookings"
               class="sidebar-nav-link ${param.active == 'bookings' ? 'active' : ''}">
                <i class="fas fa-ticket-alt"></i>
                <span>Quản lý đặt vé</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/users"
               class="sidebar-nav-link ${param.active == 'users' ? 'active' : ''}">
                <i class="fas fa-users"></i>
                <span>Quản lý người dùng</span>
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="${pageContext.request.contextPath}/admin/statistics"
               class="sidebar-nav-link ${param.active == 'statistics' ? 'active' : ''}">
                <i class="fas fa-chart-bar"></i>
                <span>Thống kê</span>
            </a>
        </li>
    </ul>

    <div class="sidebar-divider"></div>

    <!-- Sidebar Footer - User Menu -->
    <div class="sidebar-footer">
        <div class="dropdown">
            <a href="#" class="sidebar-user-menu dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                <div class="sidebar-user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <div class="sidebar-user-info">
                    <div class="sidebar-user-name">${sessionScope.admin.hoTen}</div>
                </div>
                <div class="sidebar-user-toggle">
                    <i class="fas fa-chevron-down"></i>
                </div>
            </a>
            <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                <li>
                    <div style="padding: 12px 16px; border-bottom: 1px solid rgba(229, 9, 20, 0.2);">
                        <div style="font-weight: bold; color: white; font-size: 13px;">${sessionScope.admin.hoTen}</div>
                        <small style="color: #999; font-size: 12px;">Admin</small>
                    </div>
                </li>
                <li>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile">
                        <i class="fas fa-user-circle"></i>
                        <span>Thông tin cá nhân</span>
                    </a>
                </li>
                <li>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/settings">
                        <i class="fas fa-cog"></i>
                        <span>Cài đặt</span>
                    </a>
                </li>
                <li><hr class="dropdown-divider"></li>
                <li>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/logout"
                       style="color: #ff1744;">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Đăng xuất</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
