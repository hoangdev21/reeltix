package com.example.reeltix.servlet.customer;

import com.example.reeltix.dao.BookingDAO;
import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.dao.PaymentDAO;
import com.example.reeltix.dao.ShowtimeDAO;
import com.example.reeltix.model.Booking;
import com.example.reeltix.model.Movie;
import com.example.reeltix.model.Payment;
import com.example.reeltix.model.Showtime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/customer/my-bookings"})
public class MyBookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final MovieDAO movieDAO = new MovieDAO();
    private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            // Get user ID from session
            Object userObj = session.getAttribute("user");
            int userId = 0;
            if (userObj instanceof com.example.reeltix.model.User) {
                userId = ((com.example.reeltix.model.User) userObj).getMaNguoiDung();
            }

            // Get all bookings for this user
            List<Booking> bookings = bookingDAO.findByCustomer(userId);

            // Enrich bookings with movie, showtime, and payment information
            List<Map<String, Object>> enrichedBookings = new ArrayList<>();
            for (Booking booking : bookings) {
                Map<String, Object> bookingInfo = new HashMap<>();

                // Get showtime and movie details
                Showtime showtime = showtimeDAO.findById(booking.getMaSuatChieu());
                Movie movie = null;
                if (showtime != null) {
                    movie = movieDAO.findById(showtime.getMaPhim());
                }

                // Get payment information
                Payment payment = paymentDAO.findByBooking(booking.getMaDon());

                // Build enriched booking info
                bookingInfo.put("maDon", booking.getMaDon());
                bookingInfo.put("soLuongVe", booking.getSoLuongVe());
                bookingInfo.put("tongTien", booking.getTongTien());
                bookingInfo.put("ngayDat", booking.getNgayDat());

                if (movie != null) {
                    bookingInfo.put("tenPhim", movie.getTenPhim());
                    bookingInfo.put("anhPoster", movie.getAnhPoster());
                }

                if (showtime != null) {
                    bookingInfo.put("ngayChieu", showtime.getNgayChieu());
                    bookingInfo.put("gioChieu", showtime.getGioChieu());
                }

                if (payment != null) {
                    bookingInfo.put("trangThaiThanhToan", payment.getTrangThai());
                    bookingInfo.put("ngayThanhToan", payment.getNgayThanhToan());
                    bookingInfo.put("phuongThuc", payment.getPhuongThuc());
                }

                enrichedBookings.add(bookingInfo);
            }

            // Set attribute for JSP
            request.setAttribute("bookings", enrichedBookings);

            request.getRequestDispatcher("/views/customer/my-bookings.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
