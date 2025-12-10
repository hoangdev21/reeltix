package com.example.reeltix.servlet.customer;

import com.example.reeltix.dao.*;
import com.example.reeltix.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/customer/payment"})
public class PaymentServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();
    private BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();
    private SeatDAO seatDAO = new SeatDAO();
    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String showtimeIdParam = request.getParameter("showtimeId");
        String selectedSeatsParam = request.getParameter("selectedSeats");
        String totalPriceParam = request.getParameter("totalPrice");

        if (showtimeIdParam == null || showtimeIdParam.isEmpty() ||
            selectedSeatsParam == null || selectedSeatsParam.isEmpty() ||
            totalPriceParam == null || totalPriceParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        try {
            int showtimeId = Integer.parseInt(showtimeIdParam);
            double totalPrice = Double.parseDouble(totalPriceParam);

            // Lấy user ID từ session
            Object userObj = session.getAttribute("user");
            int userId = 0;
            if (userObj instanceof com.example.reeltix.model.User) {
                userId = ((com.example.reeltix.model.User) userObj).getMaNguoiDung();
            }

            // Tạo mã đặt vé
            String bookingId = bookingDAO.generateBookingId();

            // Tách danh sách ghế đã chọn
            String[] seatIdStrings = selectedSeatsParam.split(",");
            int seatCount = seatIdStrings.length;

            // Tạo và insert booking
            Booking booking = new Booking();
            booking.setMaDon(bookingId);
            booking.setMaKhachHang(userId);
            booking.setMaSuatChieu(showtimeId);
            booking.setSoLuongVe(seatCount);
            booking.setTongTien(totalPrice);
            booking.setNgayDat(new Timestamp(System.currentTimeMillis()));
            booking.setNgayTao(new Timestamp(System.currentTimeMillis()));

            if (!bookingDAO.insert(booking)) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Tạo và insert booking details
            List<String> seatNames = new ArrayList<>();
            for (String seatIdStr : seatIdStrings) {
                int seatId = Integer.parseInt(seatIdStr.trim());
                Seat seat = seatDAO.findById(seatId);

                if (seat != null) {
                    BookingDetail detail = new BookingDetail();
                    detail.setMaDon(bookingId);
                    detail.setMaGhe(seatId);
                    detail.setGiaGhe(seat.getGiaGhe());

                    bookingDetailDAO.insert(detail);
                    seatNames.add(seat.getTenGhe());
                }
            }

            // Tạo và insert payment
            Payment payment = new Payment();
            payment.setMaDon(bookingId);
            payment.setPhuongThuc("VNPay");
            payment.setSoTien(totalPrice);
            payment.setTrangThai("ThanhCong");
            payment.setNgayThanhToan(new Timestamp(System.currentTimeMillis()));

            if (!paymentDAO.insert(payment)) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }

            // Lấy thông tin showtime, movie, room để hiển thị
            Showtime showtime = showtimeDAO.findById(showtimeId);
            Movie movie = null;
            Room room = null;
            if (showtime != null) {
                movie = movieDAO.findById(showtime.getMaPhim());
                room = roomDAO.findById(showtime.getMaPhong());
            }

            request.setAttribute("booking", booking);
            request.setAttribute("movie", movie);
            request.setAttribute("showtime", showtime);
            request.setAttribute("room", room);
            request.setAttribute("selectedSeatNames", String.join(", ", seatNames));

            request.getRequestDispatcher("/views/customer/booking-success.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
