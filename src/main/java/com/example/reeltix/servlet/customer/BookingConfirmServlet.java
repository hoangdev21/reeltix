package com.example.reeltix.servlet.customer;

import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.dao.RoomDAO;
import com.example.reeltix.dao.SeatDAO;
import com.example.reeltix.dao.ShowtimeDAO;
import com.example.reeltix.model.Movie;
import com.example.reeltix.model.Room;
import com.example.reeltix.model.Seat;
import com.example.reeltix.model.Showtime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/customer/booking-confirm"})
public class BookingConfirmServlet extends HttpServlet {

    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private SeatDAO seatDAO = new SeatDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String showtimeIdParam = request.getParameter("showtimeId");
        String selectedSeatsParam = request.getParameter("selectedSeats");
        String totalPriceParam = request.getParameter("totalPrice");

        if (showtimeIdParam == null || showtimeIdParam.isEmpty() ||
            selectedSeatsParam == null || selectedSeatsParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/customer/home");
            return;
        }

        try {
            int showtimeId = Integer.parseInt(showtimeIdParam);

            // Get showtime information
            Showtime showtime = showtimeDAO.findById(showtimeId);
            if (showtime == null) {
                response.sendRedirect(request.getContextPath() + "/customer/home");
                return;
            }

            // Get movie information
            Movie movie = movieDAO.findById(showtime.getMaPhim());

            // Get room information
            Room room = roomDAO.findById(showtime.getMaPhong());

            // Parse selected seats (format: "1,2,3" - seat IDs)
            String[] seatIdStrings = selectedSeatsParam.split(",");
            List<Seat> selectedSeats = new ArrayList<>();
            for (String seatIdStr : seatIdStrings) {
                int seatId = Integer.parseInt(seatIdStr.trim());
                Seat seat = seatDAO.findById(seatId);
                if (seat != null) {
                    selectedSeats.add(seat);
                }
            }

            // Parse total price
            double totalPrice = 0;
            if (totalPriceParam != null && !totalPriceParam.isEmpty()) {
                totalPrice = Double.parseDouble(totalPriceParam);
            }

            // Set attributes for JSP
            request.setAttribute("showtime", showtime);
            request.setAttribute("movie", movie);
            request.setAttribute("room", room);
            request.setAttribute("selectedSeats", selectedSeats);
            request.setAttribute("selectedSeatsParam", selectedSeatsParam);
            request.setAttribute("totalPrice", totalPrice);

            request.getRequestDispatcher("/views/customer/booking-confirm.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to home
        response.sendRedirect(request.getContextPath() + "/customer/home");
    }
}

