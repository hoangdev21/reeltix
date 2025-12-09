<%--
  Created by IntelliJ IDEA.
  User: Acer Predator
  Date: 12/9/2025
  Time: 11:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đặt vé - Reeltix</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        body { background-color: #141414; color: #fff; }
        .btn-primary { background-color: #e50914; border-color: #e50914; }
        .btn-primary:hover { background-color: #b20710; border-color: #b20710; }
        .card { background-color: #1f1f1f; border: 1px solid #333; }
        .card-header { background-color: #2a2a2a; border-bottom: 1px solid #333; }
        .table { color: #fff; }
        .table-dark { --bs-table-bg: #1f1f1f; }
    </style>
</head>
<body>
    <jsp:include page="../components/header.jsp" />

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0"><i class="fas fa-check-circle me-2 text-success"></i>Xác nhận đặt vé</h4>
                    </div>
                    <div class="card-body">
                        <h5 class="mb-4">Thông tin phim</h5>
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <c:choose>
                                    <c:when test="${not empty movie.anhPoster}">
                                        <img src="${pageContext.request.contextPath}/uploads/posters/${movie.anhPoster}"
                                             alt="${movie.tenPhim}" class="img-fluid rounded">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/no-poster.svg"
                                             alt="No poster" class="img-fluid rounded">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-md-8">
                                <h5>${movie.tenPhim}</h5>
                                <p><strong>Thể loại:</strong> ${movie.theLoai}</p>
                                <p><strong>Thời lượng:</strong> ${movie.thoiLuong} phút</p>
                            </div>
                        </div>

                        <h5 class="mb-3">Thông tin suất chiếu</h5>
                        <table class="table table-dark table-bordered mb-4">
                            <tr>
                                <th>Ngày chiếu</th>
                                <td>${showtime.ngayChieu}</td>
                            </tr>
                            <tr>
                                <th>Giờ chiếu</th>
                                <td>${showtime.gioChieu}</td>
                            </tr>
                            <tr>
                                <th>Phòng chiếu</th>
                                <td>${room.tenPhong}</td>
                            </tr>
                        </table>

                        <h5 class="mb-3">Ghế đã chọn</h5>
                        <div class="mb-4">
                            <c:forEach var="seat" items="${selectedSeats}" varStatus="status">
                                <span class="badge bg-danger me-1">${seat.tenGhe}</span>
                            </c:forEach>
                        </div>

                        <hr>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h4 class="mb-0">Tổng tiền:</h4>
                            <h4 class="text-danger mb-0">${totalPrice}đ</h4>
                        </div>

                        <form action="${pageContext.request.contextPath}/customer/payment" method="post">
                            <input type="hidden" name="showtimeId" value="${showtime.maSuatChieu}">
                            <input type="hidden" name="selectedSeats" value="${selectedSeatsParam}">
                            <input type="hidden" name="totalPrice" value="${totalPrice}">
                            <div class="d-flex gap-3">
                                <a href="${pageContext.request.contextPath}/customer/seat-selection?showtimeId=${showtime.maSuatChieu}"
                                   class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary flex-grow-1">
                                    <i class="fas fa-credit-card me-2"></i>Tiến hành thanh toán
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
