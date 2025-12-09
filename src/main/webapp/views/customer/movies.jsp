<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách phim - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/customer/movies.css" rel="stylesheet">
    <style>
        /* ============================================
           REELTIX MOVIES - INLINE CSS (Backup)
           ============================================ */
        :root {
            --primary-color: #a14d51;
            --primary-hover: #bd6a6e;
            --secondary-color: #141414;
            --dark-bg: #0a0a0a;
            --card-bg: #1a1a1a;
            --card-hover: #252525;
            --text-primary: #ffffff;
            --text-secondary: #b3b3b3;
            --text-muted: #808080;
            --border-color: #333333;
            --gold-color: #ffc107;
            --success-color: #28a745;
            --gradient-primary: linear-gradient(135deg, #e50914 0%, #b8070f 100%);
            --gradient-dark: linear-gradient(180deg, #1a1a1a 0%, #0a0a0a 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.3);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.4);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.5);
            --shadow-xl: 0 20px 40px rgba(0, 0, 0, 0.6);
            --transition-fast: 0.2s ease;
            --transition-normal: 0.3s ease;
            --border-radius-sm: 8px;
            --border-radius-md: 12px;
            --border-radius-lg: 20px;
        }

        /* HERO SECTION */
        .movies-hero {
            position: relative;
            height: 500px;
            background: linear-gradient(135deg, #1a0033 0%, #2d0a4e 50%, #0a0a0a 100%);
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        .movies-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 50%, rgba(229, 9, 20, 0.1) 0%, transparent 50%), radial-gradient(circle at 80% 80%, rgba(102, 126, 234, 0.1) 0%, transparent 50%);
            animation: backgroundShift 8s ease-in-out infinite;
            pointer-events: none;
        }

        .movies-hero::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(229, 9, 20, 0.05), transparent 70%);
            border-radius: 50%;
            top: -100px;
            right: -100px;
            animation: float 6s ease-in-out infinite;
            pointer-events: none;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(180deg, rgba(0, 0, 0, 0.3) 0%, rgba(0, 0, 0, 0.5) 50%, rgba(0, 0, 0, 0.7) 100%);
            backdrop-filter: blur(0.5px);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
            max-width: 900px;
            width: 90%;
            padding: 0 2rem;
            animation: slideInUp 1s ease-out;
        }

        .hero-title {
            font-size: 4.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1.5rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            letter-spacing: -0.5px;
            flex-wrap: wrap;
        }

        .hero-title i {
            color: var(--primary-color);
            font-size: 4rem;
            animation: pulse 2s ease-in-out infinite;
            filter: drop-shadow(0 0 20px rgba(229, 9, 20, 0.6));
        }

        .hero-title span {
            background: linear-gradient(135deg, #ffffff 0%, #b3b3b3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 3rem;
            opacity: 0.95;
            font-weight: 300;
            letter-spacing: 0.5px;
        }

        .hero-stats {
            display: flex;
            justify-content: center;
            gap: 4rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .stat-item {
            text-align: center;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--border-radius-md);
            border: 1px solid rgba(229, 9, 20, 0.2);
            backdrop-filter: blur(10px);
            transition: all var(--transition-normal);
            cursor: pointer;
            min-width: 150px;
        }

        .stat-item:hover {
            background: rgba(229, 9, 20, 0.1);
            border-color: rgba(229, 9, 20, 0.5);
            transform: translateY(-5px);
        }

        .stat-number {
            display: block;
            font-size: 3rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary-color), #ff6b6b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 0.95rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            opacity: 0.85;
            color: var(--text-secondary);
        }

        /* MAIN CONTENT */
        .movies-main {
            background: linear-gradient(180deg, var(--secondary-color) 0%, #0a0a0a 100%);
            padding: 4rem 0 5rem;
            /* Các lựa chọn màu sắc khác bạn có thể sử dụng:

               1. GRADIENT (hiện tại):
               background: linear-gradient(180deg, var(--secondary-color) 0%, #0a0a0a 100%);

               2. MÀU ĐƠNG GIẢN:
               background: #141414;          (Tối - giống secondary-color)
               background: #0a0a0a;          (Rất tối - dark-bg)
               background: #1a1a1a;          (Tối nhưng sáng hơn một chút)
               background: #1f1f1f;          (Xám tối)
               background: #0f0f0f;          (Đen sạch)

               3. GRADIENT KHÁC:
               background: linear-gradient(135deg, #0a0a0a 0%, #1a1a1a 100%);
               background: linear-gradient(135deg, #141414 0%, #0a0a0a 100%);
               background: linear-gradient(180deg, #1a1a1a 0%, #0f0f0f 100%);
               background: linear-gradient(90deg, #0a0a0a 0%, #141414 50%, #0a0a0a 100%);

               4. VỚI OVERLAY NHẸ:
               background: linear-gradient(135deg, rgba(20, 20, 20, 0.95) 0%, rgba(10, 10, 10, 0.95) 100%);
            */
        }

        /* FILTER SECTION */
        .filter-search-section {
            margin-bottom: 3.5rem;
            animation: fadeIn 0.8s ease-out;
        }

        .filter-container {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.8), rgba(20, 20, 20, 0.8));
            border-radius: var(--border-radius-lg);
            padding: 2.5rem;
            border: 1px solid rgba(229, 9, 20, 0.15);
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            transition: all var(--transition-normal);
        }

        .filter-container:hover {
            border-color: rgba(229, 9, 20, 0.25);
            box-shadow: 0 8px 40px rgba(229, 9, 20, 0.1);
        }

        .filter-tabs-wrapper {
            margin-bottom: 2.5rem;
        }

        .filter-tabs {
            border: none;
            background: rgba(255, 255, 255, 0.03);
            border-radius: var(--border-radius-md);
            padding: 0.6rem;
            gap: 0.8rem;
            display: flex;
            flex-wrap: wrap;
            border: 1px solid rgba(255, 255, 255, 0.08);
        }

        .filter-tabs .nav-link {
            border: none;
            background: transparent;
            color: var(--text-secondary);
            padding: 0.8rem 1.8rem;
            border-radius: var(--border-radius-sm);
            transition: all var(--transition-fast);
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
        }

        .filter-tabs .nav-link:hover {
            background: rgba(255, 255, 255, 0.08);
            color: var(--primary-color);
            transform: translateY(-3px);
        }

        .filter-tabs .nav-link.active {
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.4);
        }

        .tab-count {
            background: rgba(255, 255, 255, 0.15);
            padding: 0.3rem 0.7rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            margin-left: auto;
            letter-spacing: 0.5px;
        }

        .filter-tabs .nav-link.active .tab-count {
            background: rgba(255, 255, 255, 0.3);
        }

        /* SEARCH */
        .search-wrapper {
            max-width: 700px;
            margin: 0 auto;
        }

        .search-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-input-group {
            flex: 1;
            position: relative;
        }

        .search-icon {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 1.1rem;
            transition: var(--transition-fast);
            pointer-events: none;
        }

        .search-input {
            width: 100%;
            padding: 1rem 1.2rem 1rem 3.5rem;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 50px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all var(--transition-fast);
            font-weight: 500;
        }

        .search-input::placeholder {
            color: var(--text-muted);
        }

        .search-input:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 30px rgba(229, 9, 20, 0.25);
        }

        .search-input:focus ~ .search-icon {
            color: var(--primary-color);
        }

        .search-clear {
            position: absolute;
            right: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0.4rem;
            transition: all var(--transition-fast);
            font-size: 1rem;
        }

        .search-clear:hover {
            color: var(--primary-color);
            transform: translateY(-50%) scale(1.2);
        }

        .btn-search {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 700;
            transition: all var(--transition-fast);
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.35);
            display: flex;
            align-items: center;
            gap: 0.7rem;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .btn-search:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(229, 9, 20, 0.5);
        }

        /* SORT & VIEW */
        .sort-view-section {
            margin-bottom: 2.5rem;
            animation: fadeIn 0.8s ease-out 0.2s backwards;
        }

        .sort-view-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .results-info {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .results-info i {
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .results-count strong {
            color: var(--primary-color);
            font-weight: 700;
        }

        .view-options {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .sort-dropdown .form-select {
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.12);
            color: var(--text-primary);
            padding: 0.65rem 1.2rem;
            border-radius: var(--border-radius-sm);
            min-width: 200px;
            font-weight: 500;
            transition: all var(--transition-fast);
            cursor: pointer;
        }

        .sort-dropdown .form-select:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: var(--primary-color);
            box-shadow: 0 0 20px rgba(229, 9, 20, 0.2);
            outline: none;
        }

        .view-toggle {
            display: flex;
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: var(--border-radius-sm);
            overflow: hidden;
            background: rgba(255, 255, 255, 0.03);
        }

        .view-btn {
            background: transparent;
            border: none;
            padding: 0.65rem 1.2rem;
            color: var(--text-secondary);
            transition: all var(--transition-fast);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 1.1rem;
        }

        .view-btn:hover {
            background: rgba(255, 255, 255, 0.08);
            color: var(--primary-color);
        }

        .view-btn.active {
            background: var(--gradient-primary);
            color: white;
            box-shadow: inset 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        /* MOVIE CARDS */
        .movies-section {
            margin-top: 2.5rem;
        }

        .movie-card {
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.9), rgba(10, 10, 10, 0.9));
            border-radius: var(--border-radius-md);
            overflow: hidden;
            box-shadow: var(--shadow-md);
            transition: all var(--transition-normal);
            height: 100%;
            position: relative;
            border: 1px solid rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(10px);
            cursor: pointer;
        }

        .movie-card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: var(--shadow-xl);
            border-color: rgba(229, 9, 20, 0.4);
        }

        .movie-poster-wrapper {
            position: relative;
            overflow: hidden;
            aspect-ratio: 2 / 3;
            border-radius: var(--border-radius-md) var(--border-radius-md) 0 0;
            background: linear-gradient(135deg, #2a0a0a, #0a0a0a);
        }

        .movie-poster {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all var(--transition-normal);
            filter: brightness(0.85) contrast(1.05);
        }

        .movie-card:hover .movie-poster {
            transform: scale(1.08);
            filter: brightness(1.15) contrast(1.1);
        }

        .movie-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(229, 9, 20, 0.95) 0%, rgba(20, 20, 20, 0.85) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: all var(--transition-normal);
            backdrop-filter: blur(5px);
        }

        .movie-card:hover .movie-overlay {
            opacity: 1;
            visibility: visible;
        }

        .overlay-content {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            animation: slideInUp 0.3s ease-out;
        }

        .btn-detail, .btn-book {
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            transition: all var(--transition-fast);
            display: flex;
            align-items: center;
            gap: 0.6rem;
            font-size: 0.95rem;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
        }

        .btn-detail {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
        }

        .btn-detail:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(255, 255, 255, 0.2);
        }

        .btn-book {
            background: #ffffff;
            color: var(--primary-color);
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.4);
            font-weight: 800;
        }

        .btn-book:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(229, 9, 20, 0.6);
            background: #f0f0f0;
        }

        .movie-badges {
            position: absolute;
            top: 12px;
            left: 12px;
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
            z-index: 3;
        }

        .badge {
            padding: 0.5rem 0.95rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            border: none;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .badge-coming {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));
            color: white;
        }

        .badge-showing {
            background: linear-gradient(135deg, rgba(229, 9, 20, 0.95), rgba(184, 7, 15, 0.9));
            color: white;
        }

        .movie-info {
            padding: 1.5rem;
            text-align: center;
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .movie-title {
            margin: 0;
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-primary);
            min-height: 50px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .movie-title a {
            color: var(--text-primary);
            text-decoration: none;
            font-size: 1.15rem;
            font-weight: 700;
            transition: var(--transition-fast);
            display: block;
            letter-spacing: -0.3px;
        }

        .movie-title a:hover {
            color: var(--primary-color);
        }

        .movie-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            justify-content: center;
            font-size: 0.85rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .meta-item i {
            color: var(--primary-color);
            font-size: 0.9rem;
        }

        .movie-description {
            color: var(--text-secondary);
            font-size: 0.9rem;
            line-height: 1.6;
            flex-grow: 1;
        }

        .movie-description p {
            margin: 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* EMPTY STATE */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
            background: linear-gradient(135deg, rgba(26, 26, 26, 0.6), rgba(20, 20, 20, 0.6));
            border-radius: var(--border-radius-lg);
            border: 2px dashed rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .empty-icon {
            font-size: 5rem;
            color: var(--primary-color);
            margin-bottom: 2rem;
            opacity: 0.7;
            animation: float 3s ease-in-out infinite;
        }

        .empty-title {
            color: var(--text-primary);
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -0.5px;
        }

        .empty-message {
            color: var(--text-secondary);
            margin-bottom: 2.5rem;
            line-height: 1.8;
            font-weight: 500;
        }

        .empty-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .empty-actions .btn {
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            transition: all var(--transition-fast);
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .empty-actions .btn-primary {
            background: var(--gradient-primary);
            border: none;
            box-shadow: 0 4px 20px rgba(229, 9, 20, 0.4);
            color: white;
        }

        .empty-actions .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(229, 9, 20, 0.6);
        }

        .empty-actions .btn-outline-light {
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--text-secondary);
            background: transparent;
        }

        .empty-actions .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--primary-color);
            color: var(--text-primary);
        }

        /* ANIMATIONS */
        @keyframes slideInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        @keyframes backgroundShift {
            0%, 100% { transform: translateX(0); }
            50% { transform: translateX(10px); }
        }

        .movie-item {
            animation: slideInUp 0.5s ease-out forwards;
        }

        .movie-item:nth-child(1) { animation-delay: 0.05s; }
        .movie-item:nth-child(2) { animation-delay: 0.1s; }
        .movie-item:nth-child(3) { animation-delay: 0.15s; }
        .movie-item:nth-child(4) { animation-delay: 0.2s; }
        .movie-item:nth-child(5) { animation-delay: 0.25s; }
        .movie-item:nth-child(6) { animation-delay: 0.3s; }
        .movie-item:nth-child(7) { animation-delay: 0.35s; }
        .movie-item:nth-child(8) { animation-delay: 0.4s; }
        .movie-item:nth-child(n+9) { animation-delay: 0.45s; }

        .movie-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: left 0.6s;
            z-index: 1;
            pointer-events: none;
        }

        .movie-card:hover::before {
            left: 100%;
        }

        /* RESPONSIVE */
        @media (max-width: 1200px) {
            .hero-title { font-size: 3.5rem; }
            .hero-stats { gap: 2rem; }
            .stat-number { font-size: 2.5rem; }
            .search-form { flex-direction: column; }
            .btn-search { width: 100%; justify-content: center; }
        }

        @media (max-width: 768px) {
            .movies-hero { height: 380px; }
            .hero-title { font-size: 2.5rem; gap: 0.8rem; }
            .hero-title i { font-size: 2.5rem; }
            .hero-subtitle { font-size: 1.1rem; }
            .hero-stats { flex-direction: column; gap: 1.5rem; }
            .stat-item { min-width: auto; padding: 1rem; }
            .stat-number { font-size: 2rem; }
            .filter-container { padding: 1.5rem; }
            .filter-tabs { padding: 0.4rem; }
            .filter-tabs .nav-link { padding: 0.6rem 1.2rem; font-size: 0.85rem; }
            .tab-count { display: none; }
            .search-wrapper { max-width: 100%; }
            .search-input { padding: 0.85rem 1rem 0.85rem 3rem; font-size: 0.95rem; }
            .sort-view-container { flex-direction: column; gap: 1.5rem; align-items: stretch; }
            .results-info { justify-content: center; }
            .view-options { justify-content: space-between; gap: 1rem; }
            .sort-dropdown .form-select { min-width: auto; flex: 1; }
            .btn-detail, .btn-book { width: 100%; justify-content: center; padding: 0.8rem 1.5rem; }
            .empty-state { padding: 3rem 1.5rem; }
            .empty-icon { font-size: 3.5rem; margin-bottom: 1.5rem; }
            .empty-title { font-size: 1.4rem; }
            .empty-actions { flex-direction: column; gap: 0.8rem; }
            .empty-actions .btn { width: 100%; justify-content: center; padding: 0.8rem 1.5rem; }
        }

        @media (max-width: 576px) {
            .hero-title { font-size: 1.8rem; flex-direction: column; gap: 0.5rem; }
            .hero-title i { font-size: 2rem; }
            .hero-subtitle { font-size: 1rem; margin-bottom: 1.5rem; }
            .hero-stats { gap: 1rem; }
            .stat-item { padding: 0.8rem; }
            .stat-number { font-size: 1.5rem; margin-bottom: 0.25rem; }
            .stat-label { font-size: 0.75rem; }
            .filter-container { padding: 1rem; }
            .filter-tabs .nav-link { padding: 0.5rem 1rem; font-size: 0.8rem; }
            .btn-search { padding: 0.8rem 1.5rem; font-size: 0.85rem; }
            .movie-meta { gap: 0.8rem; }
            .movie-badges { top: 8px; left: 8px; gap: 0.4rem; }
            .badge { padding: 0.4rem 0.7rem; font-size: 0.65rem; }
            .movie-title { font-size: 1rem; }
            .movie-title a { font-size: 1rem; }
            .movie-description p { -webkit-line-clamp: 1; }
        }

        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: rgba(0, 0, 0, 0.3); }
        ::-webkit-scrollbar-thumb { background: rgba(229, 9, 20, 0.5); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: rgba(229, 9, 20, 0.8); }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <!-- Hero Section -->
    <section class="movies-hero">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="hero-title">
                <i class="fas fa-film"></i>
                <span>Khám phá thế giới điện ảnh</span>
            </h1>
            <p class="hero-subtitle">Trải nghiệm những bộ phim hay nhất với chất lượng cao</p>
            <div class="hero-stats">
                <div class="stat-item">
                    <span class="stat-number">${totalMovies != null ? totalMovies : '50+'}</span>
                    <span class="stat-label">Bộ phim</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">${showingMovies != null ? showingMovies : '20+'}</span>
                    <span class="stat-label">Đang chiếu</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">${comingMovies != null ? comingMovies : '10+'}</span>
                    <span class="stat-label">Sắp chiếu</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="movies-main">
        <div class="container">
            <!-- Filter & Search Section -->
            <section class="filter-search-section">
                <div class="filter-container">
                    <div class="filter-tabs-wrapper">
                        <ul class="nav nav-pills filter-tabs" id="movieFilterTabs">
                            <li class="nav-item">
                                <a class="nav-link ${param.status == null || param.status == 'all' ? 'active' : ''}"
                                   href="${pageContext.request.contextPath}/movies" data-filter="all">
                                    <i class="fas fa-th-large"></i>
                                    <span>Tất cả</span>
                                    <span class="tab-count">${totalMovies != null ? totalMovies : '50'}</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link ${param.status == 'showing' ? 'active' : ''}"
                                   href="${pageContext.request.contextPath}/movies?status=showing" data-filter="showing">
                                    <i class="fas fa-play-circle"></i>
                                    <span>Đang chiếu</span>
                                    <span class="tab-count">${showingMovies != null ? showingMovies : '20'}</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link ${param.status == 'coming' ? 'active' : ''}"
                                   href="${pageContext.request.contextPath}/movies?status=coming" data-filter="coming">
                                    <i class="fas fa-clock"></i>
                                    <span>Sắp chiếu</span>
                                    <span class="tab-count">${comingMovies != null ? comingMovies : '10'}</span>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="search-wrapper">
                        <form action="${pageContext.request.contextPath}/movies" method="get" class="search-form">
                            <div class="search-input-group">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" name="keyword" id="movieSearch"
                                       placeholder="Tìm kiếm theo tên phim, diễn viên, đạo diễn..."
                                       value="${param.keyword}" class="search-input">
                                <button type="button" class="search-clear" id="searchClear" style="display: none;">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            <button type="submit" class="btn btn-search">
                                <i class="fas fa-search"></i>
                                <span>Tìm kiếm</span>
                            </button>
                        </form>
                    </div>
                </div>
            </section>

            <!-- Sort & View Options -->
            <section class="sort-view-section">
                <div class="sort-view-container">
                    <div class="results-info">
                        <span class="results-count">
                            <i class="fas fa-film"></i>
                            Hiển thị <strong>${not empty movies ? movies.size() : 0}</strong> phim
                        </span>
                    </div>

                    <div class="view-options">
                        <div class="sort-dropdown">
                            <select class="form-select sort-select" id="sortSelect">
                                <option value="name">Sắp xếp theo tên</option>
                                <option value="popular">Phổ biến nhất</option>
                            </select>
                        </div>

                        <div class="view-toggle">
                            <button class="view-btn active" data-view="grid" id="gridView">
                                <i class="fas fa-th"></i>
                            </button>
                            <button class="view-btn" data-view="list" id="listView">
                                <i class="fas fa-list"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Movies Grid/List -->
            <section class="movies-section">
                <div class="movies-container" id="moviesContainer">
                    <div class="row g-4" id="moviesGrid">
                        <c:forEach var="movie" items="${movies}" varStatus="loop">
                            <div class="col-xl-3 col-lg-4 col-md-6 col-12 movie-item"
                                 data-movie-id="${movie.maPhim}">
                                <div class="movie-card">
                                    <div class="movie-poster-wrapper">
                                        <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                             alt="${movie.tenPhim}" class="movie-poster"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/no-poster.svg'">

                                        <div class="movie-overlay">
                                            <div class="overlay-content">
                                                <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.maPhim}"
                                                   class="btn btn-detail">
                                                    <i class="fas fa-info-circle"></i>
                                                    <span>Chi tiết</span>
                                                </a>
                                                <c:if test="${movie.trangThai != 'SapChieu'}">
                                                    <a href="${pageContext.request.contextPath}/showtimes?movie=${movie.maPhim}"
                                                       class="btn btn-book">
                                                        <i class="fas fa-ticket-alt"></i>
                                                        <span>Đặt vé</span>
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>

                                        <!-- Movie Badges -->
                                        <div class="movie-badges">
                                            <c:choose>
                                                <c:when test="${movie.trangThai == 'SapChieu'}">
                                                    <span class="badge badge-coming">Sắp chiếu</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-showing">Đang chiếu</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <!-- Rating -->
                                    </div>

                                    <div class="movie-info">
                                        <h3 class="movie-title">
                                            <a href="${pageContext.request.contextPath}/movie-detail?id=${movie.maPhim}">
                                                ${movie.tenPhim}
                                            </a>
                                        </h3>

                                        <div class="movie-meta">
                                            <div class="meta-item">
                                                <i class="fas fa-tag"></i>
                                                <span>${movie.theLoai}</span>
                                            </div>
                                            <div class="meta-item">
                                                <i class="fas fa-clock"></i>
                                                <span>${movie.thoiLuong} phút</span>
                                            </div>
                                        </div>

                                        <div class="movie-description">
                                            <p>${movie.moTa != null ? movie.moTa : 'Chưa có mô tả cho bộ phim này.'}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Empty State -->
                    <c:if test="${empty movies}">
                        <div class="empty-state">
                            <div class="empty-state-content">
                                <div class="empty-icon">
                                    <i class="fas fa-film"></i>
                                </div>
                                <h3 class="empty-title">Không tìm thấy phim nào</h3>
                                <p class="empty-message">
                                    <c:choose>
                                        <c:when test="${not empty param.keyword}">
                                            Không có phim nào khớp với từ khóa "<strong>${param.keyword}</strong>"
                                        </c:when>
                                        <c:otherwise>
                                            Hiện tại chưa có phim nào trong danh mục này
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <div class="empty-actions">
                                    <a href="${pageContext.request.contextPath}/movies" class="btn btn-primary">
                                        <i class="fas fa-arrow-left"></i>
                                        <span>Xem tất cả phim</span>
                                    </a>
                                    <c:if test="${not empty param.keyword}">
                                        <button type="button" class="btn btn-outline-light" onclick="clearSearch()">
                                            <i class="fas fa-times"></i>
                                            <span>Xóa tìm kiếm</span>
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </section>
        </div>
    </main>

    <jsp:include page="../components/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Movies page JavaScript
        document.addEventListener('DOMContentLoaded', function() {
            // Search functionality
            const searchInput = document.getElementById('movieSearch');
            const searchClear = document.getElementById('searchClear');

            if (searchInput && searchClear) {
                // Show/hide clear button
                searchInput.addEventListener('input', function() {
                    searchClear.style.display = this.value.length > 0 ? 'block' : 'none';
                });

                // Clear search
                searchClear.addEventListener('click', function() {
                    searchInput.value = '';
                    searchInput.focus();
                    this.style.display = 'none';
                });

                // Initial state
                searchClear.style.display = searchInput.value.length > 0 ? 'block' : 'none';
            }

            // View toggle functionality
            const gridView = document.getElementById('gridView');
            const listView = document.getElementById('listView');
            const moviesContainer = document.getElementById('moviesContainer');

            if (gridView && listView && moviesContainer) {
                gridView.addEventListener('click', function() {
                    gridView.classList.add('active');
                    listView.classList.remove('active');
                    moviesContainer.classList.remove('list-view');
                    moviesContainer.classList.add('grid-view');
                });

                listView.addEventListener('click', function() {
                    listView.classList.add('active');
                    gridView.classList.remove('active');
                    moviesContainer.classList.remove('grid-view');
                    moviesContainer.classList.add('list-view');
                });
            }

            // Sort functionality
            const sortSelect = document.getElementById('sortSelect');
            if (sortSelect) {
                sortSelect.addEventListener('change', function() {
                    const sortBy = this.value;
                    sortMovies(sortBy);
                });
            }

            // Movie card hover effects
            const movieCards = document.querySelectorAll('.movie-card');
            movieCards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.classList.add('hovered');
                });

                card.addEventListener('mouseleave', function() {
                    this.classList.remove('hovered');
                });
            });

            // Filter tabs animation
            const filterTabs = document.querySelectorAll('#movieFilterTabs .nav-link');
            filterTabs.forEach(tab => {
                tab.addEventListener('click', function(e) {
                    // Remove active class from all tabs
                    filterTabs.forEach(t => t.classList.remove('active'));
                    // Add active class to clicked tab
                    this.classList.add('active');
                });
            });
        });

        // Sort movies function
        function sortMovies(sortBy) {
            const movieItems = Array.from(document.querySelectorAll('.movie-item'));
            const container = document.getElementById('moviesGrid');

            movieItems.sort((a, b) => {
                switch(sortBy) {
                    case 'name':
                        const nameA = a.querySelector('.movie-title a').textContent.trim().toLowerCase();
                        const nameB = b.querySelector('.movie-title a').textContent.trim().toLowerCase();
                        return nameA.localeCompare(nameB);
                    case 'popular':
                        // For now, just a placeholder, no real popularity data
                        return 0;
                    default:
                        return 0;
                }
            });

            // Reorder DOM elements
            movieItems.forEach(item => {
                container.appendChild(item);
            });
        }

        // Clear search function
        function clearSearch() {
            const searchInput = document.getElementById('movieSearch');
            const searchClear = document.getElementById('searchClear');
            if (searchInput) {
                searchInput.value = '';
                searchClear.style.display = 'none';
                // Redirect to movies page without search
                window.location.href = '${pageContext.request.contextPath}/movies';
            }
        }

        // Lazy loading for images
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        img.classList.add('loaded');
                        observer.unobserve(img);
                    }
                });
            });

            document.querySelectorAll('.movie-poster').forEach(img => {
                imageObserver.observe(img);
            });
        }
    </script>
</body>
</html>
