package com.example.reeltix.servlet.customer;

import com.example.reeltix.dao.BookingDetailDAO;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {"/customer/seat-selection"})
public class SeatSelectionServlet extends HttpServlet {

    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private SeatDAO seatDAO = new SeatDAO();
    private BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String showtimeIdParam = request.getParameter("showtimeId");

        if (showtimeIdParam == null || showtimeIdParam.isEmpty()) {
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

            // Get all seats for the room
            List<Seat> seats = seatDAO.findAvailableByRoom(showtime.getMaPhong());

            // Get booked seats for this showtime
            List<Integer> bookedSeatIds = bookingDetailDAO.findBookedSeatsByShowtime(showtimeId);

            // Create seat rows for display (organize by row letter)
            List<List<Map<String, Object>>> seatRows = organizeSeatsByRow(seats, bookedSeatIds);

            // Set attributes for JSP
            request.setAttribute("showtime", showtime);
            request.setAttribute("movie", movie);
            request.setAttribute("room", room);
            request.setAttribute("seatRows", seatRows);

            request.getRequestDispatcher("/views/customer/seat-selection.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/customer/home");
        }
    }

    private List<List<Map<String, Object>>> organizeSeatsByRow(List<Seat> seats, List<Integer> bookedSeatIds) {
        // Group seats by row (assuming seat names are like A1, A2, B1, B2, etc.)
        Map<String, List<Map<String, Object>>> rowMap = new HashMap<>();

        for (Seat seat : seats) {
            String seatName = seat.getTenGhe();
            String rowLetter = seatName.replaceAll("[0-9]", ""); // Extract row letter

            Map<String, Object> seatInfo = new HashMap<>();
            seatInfo.put("maGhe", seat.getMaGhe());
            seatInfo.put("tenGhe", seat.getTenGhe());
            seatInfo.put("loaiGhe", seat.getLoaiGhe());
            seatInfo.put("giaGhe", seat.getGiaGhe());
            seatInfo.put("booked", bookedSeatIds.contains(seat.getMaGhe()));

            rowMap.computeIfAbsent(rowLetter, k -> new ArrayList<>()).add(seatInfo);
        }

        // Convert to list of rows, sorted by row letter
        List<List<Map<String, Object>>> seatRows = new ArrayList<>();
        rowMap.keySet().stream().sorted().forEach(rowLetter -> {
            seatRows.add(rowMap.get(rowLetter));
        });

        return seatRows;
    }
}
