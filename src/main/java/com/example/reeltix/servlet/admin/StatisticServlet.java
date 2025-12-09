package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.BookingDAO;
import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/statistics")
public class StatisticServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final MovieDAO movieDAO = new MovieDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thống kê tổng quan
            int totalUsers = userDAO.countAll();
            int totalMovies = movieDAO.countAll();
            int totalBookings = bookingDAO.countAll();
            double totalRevenue = bookingDAO.getTotalRevenue();

            // Lấy thống kê theo tháng
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalMovies", totalMovies);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalRevenue", totalRevenue);

            // Các thống kê khác có thể thêm vào đây
            request.setAttribute("recentBookings", bookingDAO.getRecentBookings(10));
            request.setAttribute("allMovies", movieDAO.findAll());

            request.getRequestDispatcher("/views/admin/statistic/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Set default values on error
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalMovies", 0);
            request.setAttribute("totalBookings", 0);
            request.setAttribute("totalRevenue", 0);
            request.setAttribute("recentBookings", new java.util.ArrayList<>());
            request.setAttribute("allMovies", new java.util.ArrayList<>());
            request.getRequestDispatcher("/views/admin/statistic/index.jsp").forward(request, response);
        }
    }
}
