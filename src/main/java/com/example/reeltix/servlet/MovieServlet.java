package com.example.reeltix.servlet;

import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.model.Movie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        String keyword = request.getParameter("keyword");

        List<Movie> movies;

        if (keyword != null && !keyword.isEmpty()) {
            movies = movieDAO.search(keyword);
        } else if ("showing".equals(status)) {
            movies = movieDAO.findNowShowing();
        } else if ("coming".equals(status)) {
            movies = movieDAO.findComingSoon();
        } else {
            movies = movieDAO.findAll();
        }

        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/views/customer/movies.jsp").forward(request, response);
    }
}

