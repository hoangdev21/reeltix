<%--
  Reeltix - Footer Component
  Professional Cinema Booking System
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .footer-main {
        background: linear-gradient(180deg, #141414 0%, #0a0e27 100%);
        color: #fff;
        padding: 60px 0 0;
        margin-top: 80px;
        border-top: 2px solid #e50914;
    }

    .footer-brand {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 24px;
        font-weight: bold;
        color: #e50914;
        margin-bottom: 20px;
    }

    .footer-brand i {
        font-size: 28px;
    }

    .footer-description {
        color: #aaa;
        line-height: 1.6;
        margin-bottom: 20px;
        font-size: 14px;
    }

    .social-links {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
    }

    .social-links a {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, #e50914, #ff1744);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        transition: all 0.3s ease;
        text-decoration: none;
    }

    .social-links a:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(229, 9, 20, 0.4);
    }

    .footer-title {
        font-size: 16px;
        font-weight: bold;
        color: #fff;
        margin-bottom: 20px;
        text-transform: uppercase;
        letter-spacing: 1px;
        position: relative;
        padding-bottom: 10px;
    }

    .footer-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 40px;
        height: 2px;
        background: #e50914;
    }

    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-links li {
        margin-bottom: 12px;
    }

    .footer-links a {
        color: #aaa;
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
    }

    .footer-links a:hover {
        color: #e50914;
        transform: translateX(5px);
    }

    .footer-links i {
        font-size: 12px;
        color: #e50914;
    }

    .footer-contact {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .footer-contact li {
        display: flex;
        gap: 12px;
        margin-bottom: 15px;
        font-size: 14px;
        color: #aaa;
    }

    .footer-contact i {
        color: #e50914;
        font-size: 16px;
        min-width: 20px;
        margin-top: 2px;
    }

    .footer-contact strong {
        color: #fff;
    }

    .newsletter-form {
        display: flex;
        gap: 8px;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(229, 9, 20, 0.2);
        border-radius: 6px;
        padding: 6px;
        transition: all 0.3s ease;
    }

    .newsletter-form:focus-within {
        background: rgba(229, 9, 20, 0.1);
        border-color: #e50914;
        box-shadow: 0 0 15px rgba(229, 9, 20, 0.2);
    }

    .newsletter-form input {
        flex: 1;
        background: transparent;
        border: none;
        color: #fff;
        padding: 10px;
        font-size: 13px;
        outline: none;
    }

    .newsletter-form input::placeholder {
        color: #666;
    }

    .newsletter-form button {
        background: linear-gradient(135deg, #e50914, #ff1744);
        border: none;
        color: white;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 14px;
    }

    .newsletter-form button:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 12px rgba(229, 9, 20, 0.4);
    }

    .footer-bottom {
        background: rgba(0, 0, 0, 0.4);
        border-top: 1px solid rgba(229, 9, 20, 0.1);
        padding: 30px 0;
        margin-top: 40px;
    }

    .footer-bottom-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }

    .footer-copyright {
        color: #aaa;
        font-size: 13px;
    }

    .footer-copyright a {
        color: #e50914;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .footer-copyright a:hover {
        text-decoration: underline;
    }

    .footer-bottom-links {
        display: flex;
        gap: 30px;
        flex-wrap: wrap;
    }

    .footer-bottom-links a {
        color: #aaa;
        text-decoration: none;
        font-size: 13px;
        transition: all 0.2s ease;
    }

    .footer-bottom-links a:hover {
        color: #e50914;
    }

    .back-to-top {
        position: fixed;
        bottom: 30px;
        right: 30px;
        width: 45px;
        height: 45px;
        background: linear-gradient(135deg, #e50914, #ff1744);
        border: none;
        border-radius: 50%;
        color: white;
        font-size: 18px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
        z-index: 999;
        box-shadow: 0 4px 15px rgba(229, 9, 20, 0.3);
    }

    .back-to-top.show {
        opacity: 1;
        visibility: visible;
    }

    .back-to-top:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(229, 9, 20, 0.5);
    }

    @media (max-width: 768px) {
        .footer-bottom-content {
            flex-direction: column;
            text-align: center;
        }

        .footer-bottom-links {
            justify-content: center;
        }

        .back-to-top {
            width: 40px;
            height: 40px;
            bottom: 20px;
            right: 20px;
            font-size: 16px;
        }
    }
</style>

<footer class="footer-main">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="footer-brand">
                    <i class="fas fa-film"></i>
                    <span>Reeltix</span>
                </div>
                <p class="footer-description">
                    Hệ thống đặt vé xem phim trực tuyến hàng đầu Việt Nam.
                    Trải nghiệm điện ảnh đỉnh cao với công nghệ hiện đại và dịch vụ chuyên nghiệp.
                </p>
                <div class="social-links">
                    <a href="https://www.facebook.com/hoangmis21/" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://www.instagram.com/stories/_hoanggmis_/" title="Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="#" title="YouTube"><i class="fab fa-youtube"></i></a>
                    <a href="#" title="TikTok"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>

            <!-- Liên kết nhanh -->
            <div class="col-lg-2 col-md-6">
                <h5 class="footer-title">Khám phá</h5>
                <ul class="footer-links">
                    <li>
                        <a href="${pageContext.request.contextPath}/">
                            <i class="fas fa-chevron-right"></i>Trang chủ
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/movies">
                            <i class="fas fa-chevron-right"></i>Phim đang chiếu
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/movies?status=coming">
                            <i class="fas fa-chevron-right"></i>Phim sắp chiếu
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/showtimes">
                            <i class="fas fa-chevron-right"></i>Lịch chiếu
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/promotions">
                            <i class="fas fa-chevron-right"></i>Khuyến mãi
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Liên kết hỗ trợ -->
            <div class="col-lg-2 col-md-6">
                <h5 class="footer-title">Hỗ trợ</h5>
                <ul class="footer-links">
                    <li>
                        <a href="${pageContext.request.contextPath}/faq">
                            <i class="fas fa-chevron-right"></i>Câu hỏi thường gặp
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/terms">
                            <i class="fas fa-chevron-right"></i>Điều khoản sử dụng
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/privacy">
                            <i class="fas fa-chevron-right"></i>Chính sách bảo mật
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/refund">
                            <i class="fas fa-chevron-right"></i>Chính sách hoàn vé
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/contact">
                            <i class="fas fa-chevron-right"></i>Liên hệ
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Thông tin liên hệ -->
            <div class="col-lg-4 col-md-6">
                <h5 class="footer-title">Liên hệ với chúng tôi</h5>
                <ul class="footer-contact">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <span>Hòa Minh, Liên Chiểu, Đà Nẵng</span>
                    </li>
                    <li>
                        <i class="fas fa-phone-alt"></i>
                        <span>Hotline: <strong>1900 1234</strong> (8:00 - 22:00)</span>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <span>Email: support@reeltix.com</span>
                    </li>
                    <li>
                        <i class="fas fa-clock"></i>
                        <span>Giờ hoạt động: 8:00 - 24:00 hàng ngày</span>
                    </li>
                </ul>

                <!-- Bản tin -->
                <div style="margin-top: 20px;">
                    <h6 style="color: white; margin-bottom: 12px; font-weight: bold;">Đăng ký nhận tin</h6>
                    <form class="newsletter-form">
                        <input type="email" placeholder="Email của bạn..." required>
                        <button type="submit" title="Đăng ký">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Chân trang -->
    <div class="footer-bottom">
        <div class="container">
            <div class="footer-bottom-content">
                <div class="footer-copyright">
                    &copy; 2025 <a href="${pageContext.request.contextPath}/">Reeltix</a>.
                    All rights reserved. ReelTix <i class="fas fa-heart text-danger"></i> in Vietnam.
                </div>
                <div class="footer-bottom-links">
                    <a href="${pageContext.request.contextPath}/terms">Điều khoản</a>
                    <a href="${pageContext.request.contextPath}/privacy">Bảo mật</a>
                    <a href="${pageContext.request.contextPath}/sitemap">Sitemap</a>
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Trở về top trang -->
<button class="back-to-top" id="backToTop" title="Lên đầu trang">
    <i class="fas fa-chevron-up"></i>
</button>

<script>
    // Quay lạ đầu trang
    document.addEventListener('DOMContentLoaded', function() {
        const backToTop = document.getElementById('backToTop');

        window.addEventListener('scroll', function() {
            if (window.scrollY > 300) {
                backToTop.classList.add('show');
            } else {
                backToTop.classList.remove('show');
            }
        });

        backToTop.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });

        // Mẫu đăng ký nhận tin
        const newsletterForm = document.querySelector('.newsletter-form');
        if (newsletterForm) {
            newsletterForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const email = this.querySelector('input[type="email"]').value;
                // TODO: Implement newsletter subscription
                alert('Cảm ơn bạn đã đăng ký nhận tin từ Reeltix!');
                this.reset();
            });
        }
    });
</script>
