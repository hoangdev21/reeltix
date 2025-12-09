package com.example.reeltix.servlet;

import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.model.Movie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private MovieDAO movieDAO;

    @Override
    public void init() throws ServletException {
        try {
            movieDAO = new MovieDAO();
        } catch (Exception e) {
            System.err.println("Error initializing MovieDAO: " + e.getMessage());
            e.printStackTrace();
            movieDAO = null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Movie> nowShowingMovies = new ArrayList<>();
            List<Movie> comingSoonMovies = new ArrayList<>();

            if (movieDAO != null) {
                nowShowingMovies = movieDAO.findNowShowing();
                comingSoonMovies = movieDAO.findComingSoon();
            }

            // Ensure lists are never null for JSP
            request.setAttribute("nowShowingMovies", nowShowingMovies != null ? nowShowingMovies : new ArrayList<>());
            request.setAttribute("comingSoonMovies", comingSoonMovies != null ? comingSoonMovies : new ArrayList<>());

            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in HomeServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            // Set empty lists on error to prevent JSP errors
            request.setAttribute("nowShowingMovies", new ArrayList<>());
            request.setAttribute("comingSoonMovies", new ArrayList<>());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
