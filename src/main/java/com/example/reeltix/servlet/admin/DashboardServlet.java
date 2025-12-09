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
import java.util.ArrayList;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final MovieDAO movieDAO = new MovieDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thống kê tổng quan
            int totalUsers = 0;
            int totalMovies = 0;
            int totalBookings = 0;
            double totalRevenue = 0.0;

            try {
                totalUsers = userDAO.countAll();
            } catch (Exception e) {
                e.printStackTrace();
                totalUsers = 0;
            }

            try {
                totalMovies = movieDAO.countAll();
            } catch (Exception e) {
                e.printStackTrace();
                totalMovies = 0;
            }

            try {
                totalBookings = bookingDAO.countAll();
            } catch (Exception e) {
                e.printStackTrace();
                totalBookings = 0;
            }

            try {
                totalRevenue = bookingDAO.getTotalRevenue();
            } catch (Exception e) {
                e.printStackTrace();
                totalRevenue = 0.0;
            }

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalMovies", totalMovies);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalRevenue", String.format("%.0f", totalRevenue));

            try {
                request.setAttribute("recentBookings", bookingDAO.getRecentBookings(5));
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("recentBookings", new ArrayList<>());
            }

            try {
                request.setAttribute("topMovies", movieDAO.findAll().stream()
                    .limit(5)
                    .collect(java.util.stream.Collectors.toList()));
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("topMovies", new ArrayList<>());
            }

            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Set default values on error
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalMovies", 0);
            request.setAttribute("totalBookings", 0);
            request.setAttribute("totalRevenue", "0");
            request.setAttribute("recentBookings", new ArrayList<>());
            request.setAttribute("topMovies", new ArrayList<>());
            try {
                request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
