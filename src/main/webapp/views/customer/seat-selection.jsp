<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn ghế - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #0a0e27;
            color: #fff;
        }

        /* Header info */
        .booking-header {
            background: linear-gradient(135deg, #1a1f3a 0%, #0f1423 100%);
            border-bottom: 2px solid #e50914;
            padding: 20px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .booking-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .booking-subtitle {
            font-size: 13px;
            color: #aaa;
        }

        /* Breadcrumb */
        .breadcrumb-nav {
            margin-bottom: 15px;
        }

        .breadcrumb {
            background-color: transparent;
            padding: 0;
        }

        .breadcrumb-item a {
            color: #e50914;
            text-decoration: none;
        }

        .breadcrumb-item a:hover {
            text-decoration: underline;
        }

        /* Main content area */
        .seat-selection-wrapper {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }

        .seat-area {
            flex: 1;
            min-width: 400px;
        }

        .info-sidebar {
            width: 320px;
            flex-shrink: 0;
        }

        /* Screen */
        .screen-container {
            text-align: center;
            margin-bottom: 40px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
        }

        .screen {
            background: linear-gradient(to bottom, #e0e0e0, #999);
            height: 15px;
            border-radius: 50%;
            margin-bottom: 10px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        }

        .screen-label {
            font-size: 12px;
            color: #999;
            font-weight: bold;
            letter-spacing: 2px;
        }

        /* Seats layout */
        .seats-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 10px;
            border: 1px solid rgba(229, 9, 20, 0.2);
        }

        .seat-row {
            display: flex;
            justify-content: center;
            gap: 8px;
            align-items: center;
        }

        .row-label {
            width: 30px;
            text-align: center;
            font-weight: bold;
            color: #e50914;
            font-size: 14px;
            min-width: 30px;
        }

        .row-seats {
            display: flex;
            gap: 8px;
            justify-content: center;
            flex: 1;
            flex-wrap: wrap;
        }

        /* Seats styling */
        .seat {
            width: 45px;
            height: 45px;
            border: 2px solid #444;
            border-radius: 6px;
            cursor: pointer;
            font-size: 11px;
            font-weight: bold;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #2a3b5a;
            color: #fff;
        }

        .seat:hover:not(:disabled) {
            transform: scale(1.1);
            border-color: #e50914;
            box-shadow: 0 0 12px rgba(229, 9, 20, 0.5);
        }

        .seat.available {
            background-color: #2a3b5a;
            color: #fff;
            cursor: pointer;
        }

        .seat.available:hover {
            background-color: #3a4b7a;
            border-color: #e50914;
        }

        .seat.selected {
            background: linear-gradient(135deg, #e50914, #ff1744);
            color: #fff;
            border-color: #ff1744;
            box-shadow: 0 0 20px rgba(229, 9, 20, 0.6);
            transform: scale(1.08);
        }

        .seat.booked {
            background-color: #1a1a2e;
            color: #555;
            cursor: not-allowed;
            opacity: 0.6;
            border-color: #333;
        }

        .seat.booked:hover {
            transform: none;
            border-color: #333;
        }

        .seat.vip {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: #000;
            border-color: #d68910;
        }

        .seat.vip.selected {
            background: linear-gradient(135deg, #e50914, #ff1744);
            color: #fff;
            border-color: #ff1744;
        }

        .seat.couple {
            width: 98px;
        }

        .seat:disabled {
            cursor: not-allowed;
        }

        /* Legend */
        .legend-section {
            background: rgba(255, 255, 255, 0.03);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid rgba(229, 9, 20, 0.1);
            margin-bottom: 30px;
        }

        .legend-title {
            font-size: 13px;
            font-weight: bold;
            text-transform: uppercase;
            color: #e50914;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .legend-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 15px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
        }

        .legend-box {
            width: 30px;
            height: 30px;
            border-radius: 4px;
            border: 2px solid #444;
            flex-shrink: 0;
        }

        /* Info sidebar */
        .info-card {
            background: linear-gradient(135deg, #1a1f3a 0%, #0f1423 100%);
            border: 2px solid #e50914;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(229, 9, 20, 0.15);
            position: sticky;
            top: 20px;
        }

        .info-header {
            background: linear-gradient(90deg, #e50914, #ff1744);
            padding: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 16px;
            font-weight: bold;
        }

        .info-body {
            padding: 20px;
        }

        .info-row {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .info-row:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .info-label {
            font-size: 12px;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .info-value {
            font-size: 15px;
            color: #fff;
            font-weight: 500;
        }

        .info-highlight {
            color: #e50914;
            font-weight: bold;
        }

        .price-section {
            background: rgba(229, 9, 20, 0.1);
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            border: 1px solid rgba(229, 9, 20, 0.3);
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 13px;
        }

        .price-row:last-child {
            margin-bottom: 0;
        }

        .price-label {
            color: #aaa;
        }

        .price-value {
            color: #fff;
            font-weight: 500;
        }

        .total-price {
            font-size: 18px !important;
            color: #ff1744 !important;
            font-weight: bold !important;
        }

        .selected-seats-list {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
        }

        .seat-badge {
            display: inline-block;
            background: linear-gradient(135deg, #e50914, #ff1744);
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }

        .empty-seats-text {
            color: #999;
            font-size: 13px;
            font-style: italic;
        }

        .info-footer {
            padding: 15px;
            background: rgba(0, 0, 0, 0.2);
        }

        .btn-continue {
            background: linear-gradient(90deg, #e50914, #ff1744);
            border: none;
            padding: 12px;
            font-weight: bold;
            font-size: 15px;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-continue:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(229, 9, 20, 0.4);
        }

        .btn-continue:disabled {
            background: linear-gradient(90deg, #666, #777);
            cursor: not-allowed;
            opacity: 0.6;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .seat-selection-wrapper {
                gap: 15px;
            }

            .info-sidebar {
                width: 100%;
            }

            .info-card {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .seat-area {
                min-width: 100%;
            }

            .seat {
                width: 40px;
                height: 40px;
                font-size: 10px;
            }

            .seat.couple {
                width: 88px;
            }

            .legend-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .row-label {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="booking-header">
        <div class="container">
            <nav class="breadcrumb-nav" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/movies">Phim</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/showtimes?movie=${showtime.maPhim}">Suất chiếu</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Chọn ghế</li>
                </ol>
            </nav>
            <div class="booking-title">
                <i class="fas fa-ticket-alt me-2"></i>${movie.tenPhim}
            </div>
            <div class="booking-subtitle">
                ${showtime.ngayChieu} - ${showtime.gioChieu} | ${room.tenPhong}
            </div>
        </div>
    </div>

    <div class="container py-5">
        <div class="seat-selection-wrapper">
            <!-- Main Seat Selection Area -->
            <div class="seat-area">
                <!-- Screen -->
                <div class="screen-container">
                    <div class="screen"></div>
                    <div class="screen-label">MÀN HÌNH</div>
                </div>

                <!-- Seats -->
                <div class="seats-container">
                    <c:set var="rowLetters" value="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
                    <c:forEach var="row" items="${seatRows}" varStatus="rowStatus">
                        <div class="seat-row">
                            <div class="row-label">${fn:substring(rowLetters, rowStatus.index, rowStatus.index + 1)}</div>
                            <div class="row-seats">
                                <c:forEach var="seat" items="${row}">
                                    <button type="button"
                                            class="seat ${seat.booked ? 'booked' : 'available'} ${seat.loaiGhe == 'VIP' ? 'vip' : ''} ${seat.loaiGhe == 'Doi' ? 'couple' : ''}"
                                            data-seat-id="${seat.maGhe}"
                                            data-seat-name="${seat.tenGhe}"
                                            data-price="${seat.giaGhe}"
                                            title="${seat.tenGhe} - ${seat.booked ? 'Đã đặt' : 'Trống'}"
                                            ${seat.booked ? 'disabled' : ''}
                                            onclick="toggleSeat(this)">
                                        ${seat.tenGhe}
                                    </button>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Legend -->
                <div class="legend-section">
                    <div class="legend-title">
                        <i class="fas fa-info-circle"></i> Chú thích
                    </div>
                    <div class="legend-grid">
                        <div class="legend-item">
                            <div class="legend-box" style="background-color: #2a3b5a; border-color: #444;"></div>
                            <span>Ghế trống</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box" style="background: linear-gradient(135deg, #f39c12, #e67e22);"></div>
                            <span>Ghế VIP</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box" style="background-color: #1a1a2e; border-color: #333; opacity: 0.6;"></div>
                            <span>Đã đặt</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box" style="background: linear-gradient(135deg, #e50914, #ff1744);"></div>
                            <span>Đang chọn</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Info Sidebar -->
            <div class="info-sidebar">
                <div class="info-card">
                    <div class="info-header">
                        <i class="fas fa-info-circle"></i>
                        Thông tin đặt vé
                    </div>

                    <div class="info-body">
                        <!-- Movie Info -->
                        <div class="info-row">
                            <div class="info-label"><i class="fas fa-film me-1"></i>Phim</div>
                            <div class="info-value">${movie.tenPhim}</div>
                        </div>

                        <!-- Showtime Info -->
                        <div class="info-row">
                            <div class="info-label"><i class="fas fa-calendar me-1"></i>Suất chiếu</div>
                            <div class="info-value">
                                <span class="info-highlight">${showtime.gioChieu}</span><br>
                                <small style="color: #aaa;">${showtime.ngayChieu}</small>
                            </div>
                        </div>

                        <!-- Room Info -->
                        <div class="info-row">
                            <div class="info-label"><i class="fas fa-door-open me-1"></i>Phòng chiếu</div>
                            <div class="info-value">${room.tenPhong}</div>
                        </div>

                        <!-- Selected Seats -->
                        <div class="info-row">
                            <div class="info-label"><i class="fas fa-chair me-1"></i>Ghế đã chọn</div>
                            <div class="selected-seats-list" id="selectedSeats">
                                <span class="empty-seats-text">Chưa chọn ghế</span>
                            </div>
                        </div>

                        <!-- Price Breakdown -->
                        <div class="price-section">
                            <div class="price-row">
                                <span class="price-label">Giá vé (cơ bản)</span>
                                <span class="price-value"><fmt:formatNumber value="${showtime.giaVe}" type="number" groupingUsed="true" maxFractionDigits="0"/> VNĐ</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">Số ghế</span>
                                <span class="price-value"><span id="seatCount">0</span> ghế</span>
                            </div>
                            <div class="price-row">
                                <span class="price-label">Phụ thu ghế</span>
                                <span class="price-value" id="seatExtra">0 VNĐ</span>
                            </div>
                            <hr style="margin: 10px 0; opacity: 0.3;">
                            <div class="price-row">
                                <span class="price-label total-price"><i class="fas fa-calculator me-1"></i>Tổng cộng</span>
                                <span class="price-value total-price"><span id="totalPrice">0</span> VNĐ</span>
                            </div>
                        </div>
                    </div>

                    <div class="info-footer">
                        <form id="bookingForm" action="${pageContext.request.contextPath}/customer/booking-confirm" method="post">
                            <input type="hidden" name="showtimeId" value="${showtime.maSuatChieu}">
                            <input type="hidden" name="selectedSeats" id="selectedSeatsInput">
                            <input type="hidden" name="totalPrice" id="totalPriceInput">
                            <button type="submit" class="btn btn-primary btn-continue" id="continueBtn" disabled>
                                <i class="fas fa-arrow-right me-2"></i>Tiếp tục thanh toán
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const basePrice = ${showtime.giaVe};
        let selectedSeats = [];

        function toggleSeat(btn) {
            const seatId = btn.dataset.seatId;
            const seatName = btn.dataset.seatName;
            const seatPrice = parseFloat(btn.dataset.price);

            if (btn.classList.contains('selected')) {
                btn.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s.id !== seatId);
            } else {
                btn.classList.add('selected');
                selectedSeats.push({ id: seatId, name: seatName, price: seatPrice });
            }

            updateSummary();
        }

        function updateSummary() {
            const seatsDiv = document.getElementById('selectedSeats');
            const extraSpan = document.getElementById('seatExtra');
            const totalSpan = document.getElementById('totalPrice');
            const seatCountSpan = document.getElementById('seatCount');
            const continueBtn = document.getElementById('continueBtn');
            const seatsInput = document.getElementById('selectedSeatsInput');
            const priceInput = document.getElementById('totalPriceInput');

            if (selectedSeats.length === 0) {
                seatsDiv.innerHTML = '<span class="empty-seats-text">Chưa chọn ghế</span>';
                extraSpan.textContent = '0 VNĐ';
                seatCountSpan.textContent = '0';
                totalSpan.textContent = '0';
                continueBtn.disabled = true;
            } else {
                seatsDiv.innerHTML = selectedSeats.map(s =>
                    '<span class="seat-badge">' + s.name + '</span>'
                ).join('');

                const extra = selectedSeats.reduce((sum, s) => sum + s.price, 0);
                const total = (basePrice * selectedSeats.length) + extra;

                extraSpan.textContent = extra.toLocaleString('vi-VN') + ' VNĐ';
                seatCountSpan.textContent = selectedSeats.length;
                totalSpan.textContent = total.toLocaleString('vi-VN');
                seatsInput.value = selectedSeats.map(s => s.id).join(',');
                priceInput.value = total;
                continueBtn.disabled = false;
            }
        }
    </script>
</body>
</html>
