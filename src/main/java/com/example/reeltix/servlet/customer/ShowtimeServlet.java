package com.example.reeltix.servlet.customer;

import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.dao.ShowtimeDAO;
import com.example.reeltix.model.Movie;
import com.example.reeltix.model.Showtime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/showtimes"})
public class ShowtimeServlet extends HttpServlet {

    private ShowtimeDAO showtimeDAO;
    private MovieDAO movieDAO;

    @Override
    public void init() throws ServletException {
        try {
            showtimeDAO = new ShowtimeDAO();
            movieDAO = new MovieDAO();
        } catch (Exception e) {
            System.err.println("Lỗi khởi tạo: " + e.getMessage());
            e.printStackTrace();
            showtimeDAO = null;
            movieDAO = null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String movieId = request.getParameter("movie");
            List<Showtime> showtimes = new ArrayList<>();
            Movie movie = null;

            if (movieId != null && !movieId.isEmpty() && showtimeDAO != null) {
                int maphim = Integer.parseInt(movieId);
                showtimes = showtimeDAO.findByMovie(maphim);

                // Lấy thông tin phim
                if (movieDAO != null) {
                    movie = movieDAO.findById(maphim);
                }
            }

            request.setAttribute("showtimes", showtimes != null ? showtimes : new ArrayList<>());
            request.setAttribute("movieId", movieId);
            request.setAttribute("movie", movie);

            request.getRequestDispatcher("/views/customer/showtimes.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("Invalid movie ID format: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID");
        } catch (Exception e) {
            System.err.println("Error in ShowtimeServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }
}
