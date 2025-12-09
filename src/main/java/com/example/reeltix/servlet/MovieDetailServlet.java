package com.example.reeltix.servlet;

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
import java.util.List;

@WebServlet("/movie-detail")
public class MovieDetailServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();
    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        try {
            int movieId = Integer.parseInt(idParam);
            Movie movie = movieDAO.findById(movieId);

            if (movie == null) {
                response.sendRedirect(request.getContextPath() + "/movies");
                return;
            }

            List<Showtime> showtimes = showtimeDAO.findByMovie(movieId);

            request.setAttribute("movie", movie);
            request.setAttribute("showtimes", showtimes);
            request.getRequestDispatcher("/views/customer/movie-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/movies");
        }
    }
}

