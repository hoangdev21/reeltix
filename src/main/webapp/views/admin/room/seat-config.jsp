<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cấu hình ghế - ${room.tenPhong} - Reeltix Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #1a1a2e; color: #fff; }
        .content-wrapper { margin-left: 280px; padding: 20px; }
        .screen { background: linear-gradient(to bottom, #4facfe, #00f2fe); height: 8px; border-radius: 50%; margin-bottom: 30px; }
        .screen-text { text-align: center; margin-bottom: 10px; color: #9ca3af; font-size: 14px; }
        .seat-grid { display: flex; flex-direction: column; align-items: center; gap: 8px; }
        .seat-row { display: flex; align-items: center; gap: 8px; }
        .row-label { width: 30px; text-align: center; font-weight: bold; color: #9ca3af; }
        .seat { width: 35px; height: 35px; border: none; border-radius: 5px; cursor: pointer; font-size: 10px; display: flex; align-items: center; justify-content: center; transition: all 0.2s; }
        .seat.normal { background-color: #3b82f6; color: white; }
        .seat.vip { background-color: #f59e0b; color: white; }
        .seat.couple { background-color: #ec4899; color: white; width: 75px; }
        .seat.disabled { background-color: #374151; color: #6b7280; cursor: not-allowed; }
        .seat:hover:not(.disabled) { transform: scale(1.1); }
        .legend { display: flex; gap: 20px; justify-content: center; margin-top: 30px; flex-wrap: wrap; }
        .legend-item { display: flex; align-items: center; gap: 8px; }
        .legend-box { width: 25px; height: 25px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="d-flex">
        <jsp:include page="../../components/admin-sidebar.jsp">
            <jsp:param name="active" value="rooms"/>
        </jsp:include>

        <div class="content-wrapper flex-grow-1">
            <div class="container-fluid">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1><i class="fas fa-chair me-2"></i>Cấu hình ghế - ${room.tenPhong}</h1>
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card bg-dark">
                            <div class="card-header">
                                <h5><i class="fas fa-tv me-2"></i>Sơ đồ phòng chiếu</h5>
                            </div>
                            <div class="card-body">
                                <div class="screen-text">MÀN HÌNH</div>
                                <div class="screen"></div>

                                <form action="${pageContext.request.contextPath}/admin/rooms/seats" method="post" id="seatForm">
                                    <input type="hidden" name="maPhong" value="${room.maPhong}">
                                    <div class="seat-grid">
                                        <c:forEach var="row" items="${seatRows}">
                                            <div class="seat-row">
                                                <span class="row-label">${row.key}</span>
                                                <c:forEach var="seat" items="${row.value}">
                                                    <c:choose>
                                                        <c:when test="${seat.loaiGhe == 'Couple'}">
                                                            <button type="button" class="seat couple"
                                                                    data-seat-id="${seat.maGhe}"
                                                                    data-seat-type="${seat.loaiGhe}"
                                                                    onclick="toggleSeatType(this)">
                                                                ${seat.tenGhe}
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${seat.loaiGhe == 'VIP'}">
                                                            <button type="button" class="seat vip"
                                                                    data-seat-id="${seat.maGhe}"
                                                                    data-seat-type="${seat.loaiGhe}"
                                                                    onclick="toggleSeatType(this)">
                                                                ${seat.tenGhe}
                                                            </button>
                                                        </c:when>
                                                        <c:when test="${seat.trangThai == 'Hong'}">
                                                            <button type="button" class="seat disabled"
                                                                    data-seat-id="${seat.maGhe}"
                                                                    data-seat-type="disabled"
                                                                    onclick="toggleSeatType(this)">
                                                                ${seat.tenGhe}
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="seat normal"
                                                                    data-seat-id="${seat.maGhe}"
                                                                    data-seat-type="${seat.loaiGhe}"
                                                                    onclick="toggleSeatType(this)">
                                                                ${seat.tenGhe}
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <input type="hidden" name="seatChanges" id="seatChanges">
                                </form>

                                <div class="legend">
                                    <div class="legend-item">
                                        <div class="legend-box" style="background-color: #3b82f6;"></div>
                                        <span>Ghế thường</span>
                                    </div>
                                    <div class="legend-item">
                                        <div class="legend-box" style="background-color: #f59e0b;"></div>
                                        <span>Ghế VIP</span>
                                    </div>
                                    <div class="legend-item">
                                        <div class="legend-box" style="background-color: #ec4899;"></div>
                                        <span>Ghế đôi</span>
                                    </div>
                                    <div class="legend-item">
                                        <div class="legend-box" style="background-color: #374151;"></div>
                                        <span>Ghế hỏng</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card bg-dark">
                            <div class="card-header">
                                <h5><i class="fas fa-tools me-2"></i>Công cụ</h5>
                            </div>
                            <div class="card-body">
                                <p class="text-muted">Click vào ghế để thay đổi loại ghế</p>
                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-primary" onclick="setAllSeats('Thuong')">
                                        <i class="fas fa-sync me-2"></i>Đặt tất cả thành ghế thường
                                    </button>
                                    <button type="button" class="btn btn-warning" onclick="setAllSeats('VIP')">
                                        <i class="fas fa-star me-2"></i>Đặt tất cả thành ghế VIP
                                    </button>
                                    <hr>
                                    <button type="submit" form="seatForm" class="btn btn-danger">
                                        <i class="fas fa-save me-2"></i>Lưu thay đổi
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="card bg-dark mt-3">
                            <div class="card-header">
                                <h5><i class="fas fa-info-circle me-2"></i>Thống kê</h5>
                            </div>
                            <div class="card-body">
                                <p><i class="fas fa-chair me-2 text-primary"></i>Ghế thường: <span id="normalCount">0</span></p>
                                <p><i class="fas fa-star me-2 text-warning"></i>Ghế VIP: <span id="vipCount">0</span></p>
                                <p><i class="fas fa-heart me-2 text-danger"></i>Ghế đôi: <span id="coupleCount">0</span></p>
                                <p><i class="fas fa-ban me-2 text-secondary"></i>Ghế hỏng: <span id="disabledCount">0</span></p>
                                <hr>
                                <p><strong>Tổng: <span id="totalCount">0</span> ghế</strong></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const seatTypes = ['Thuong', 'VIP', 'disabled'];
        const seatChanges = {};

        function toggleSeatType(btn) {
            const currentType = btn.dataset.seatType;
            const seatId = btn.dataset.seatId;
            let newType;

            if (currentType === 'Thuong') newType = 'VIP';
            else if (currentType === 'VIP') newType = 'disabled';
            else newType = 'Thuong';

            btn.dataset.seatType = newType;
            btn.className = 'seat ' + (newType === 'Thuong' ? 'normal' : newType === 'VIP' ? 'vip' : 'disabled');

            seatChanges[seatId] = newType;
            document.getElementById('seatChanges').value = JSON.stringify(seatChanges);
            updateCounts();
        }

        function setAllSeats(type) {
            document.querySelectorAll('.seat').forEach(btn => {
                if (!btn.classList.contains('couple')) {
                    btn.dataset.seatType = type;
                    btn.className = 'seat ' + (type === 'Thuong' ? 'normal' : type === 'VIP' ? 'vip' : 'disabled');
                    seatChanges[btn.dataset.seatId] = type;
                }
            });
            document.getElementById('seatChanges').value = JSON.stringify(seatChanges);
            updateCounts();
        }

        function updateCounts() {
            const seats = document.querySelectorAll('.seat');
            let normal = 0, vip = 0, couple = 0, disabled = 0;
            seats.forEach(s => {
                if (s.classList.contains('normal')) normal++;
                else if (s.classList.contains('vip')) vip++;
                else if (s.classList.contains('couple')) couple++;
                else if (s.classList.contains('disabled')) disabled++;
            });
            document.getElementById('normalCount').textContent = normal;
            document.getElementById('vipCount').textContent = vip;
            document.getElementById('coupleCount').textContent = couple;
            document.getElementById('disabledCount').textContent = disabled;
            document.getElementById('totalCount').textContent = normal + vip + couple;
        }

        updateCounts();
    </script>
</body>
</html>
