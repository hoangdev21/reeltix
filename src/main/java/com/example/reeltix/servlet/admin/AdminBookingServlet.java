package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.BookingDAO;
import com.example.reeltix.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/bookings", "/admin/bookings/*"})
public class AdminBookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    // Xử lý các yêu cầu GET và POST
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị danh sách đặt vé
            listBookings(request, response);
        } else if (pathInfo.equals("/detail")) {
            // Hiển thị chi tiết đặt vé
            viewBookingDetail(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } else if (pathInfo.equals("/delete")) {
            // Xử lý xóa đặt vé
            deleteBooking(request, response);
        } else if (pathInfo.equals("/confirm")) {
            // Xử lý xác nhận đặt vé
            confirmBooking(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    // Hiển thị danh sách đặt vé
    private void listBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy message từ session và chuyển sang request attribute
        String message = (String) request.getSession().getAttribute("message");
        String error = (String) request.getSession().getAttribute("error");

        if (message != null) {
            request.setAttribute("message", message);
            request.getSession().removeAttribute("message");
        }
        if (error != null) {
            request.setAttribute("error", error);
            request.getSession().removeAttribute("error");
        }

        // Lấy danh sách đặt vé
        List<Booking> bookings = bookingDAO.findAll();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/views/admin/booking/list.jsp").forward(request, response);
    }

    // Hiển thị chi tiết đặt vé
    private void viewBookingDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            Booking booking = bookingDAO.findById(idParam);
            if (booking != null) {
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/views/admin/booking/detail.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }

    // Xóa đặt vé
    private void deleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                bookingDAO.delete(idParam);
                request.getSession().setAttribute("message", "Xóa đặt vé thành công!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xóa đặt vé!");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        }
    }

    // Xác nhận đặt vé
    private void confirmBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                // TODO: Implement confirm booking logic
                request.getSession().setAttribute("message", "Xác nhận đặt vé thành công!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi khi xác nhận đặt vé!");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        }
    }
}
