package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.model.Movie;
import com.example.reeltix.util.FileUploadUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/movies", "/admin/movies/add", "/admin/movies/edit", "/admin/movies/delete"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminMovieServlet extends HttpServlet {

    private MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/movies/add".equals(path)) {
            request.getRequestDispatcher("/views/admin/movie/add.jsp").forward(request, response);
        } else if ("/admin/movies/edit".equals(path)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Movie movie = movieDAO.findById(id);
            if (movie != null) {
                request.setAttribute("movie", movie);
                request.getRequestDispatcher("/views/admin/movie/edit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/movies?error=notfound");
            }
        } else {
            // List movies
            String search = request.getParameter("search");
            String status = request.getParameter("status");
            List<Movie> movies;

            if ((search != null && !search.isEmpty()) || (status != null && !status.isEmpty())) {
                movies = movieDAO.findByStatusAndSearch(status, search);
            } else {
                movies = movieDAO.findAll();
            }
            request.setAttribute("movies", movies);
            request.getRequestDispatcher("/views/admin/movie/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/movies/add".equals(path)) {
            addMovie(request, response);
        } else if ("/admin/movies/edit".equals(path)) {
            updateMovie(request, response);
        } else if ("/admin/movies/delete".equals(path)) {
            deleteMovie(request, response);
        }
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Movie movie = new Movie();
            movie.setTenPhim(request.getParameter("tenPhim"));
            movie.setMoTa(request.getParameter("moTa"));
            movie.setTheLoai(request.getParameter("theLoai"));
            movie.setThoiLuong(Integer.parseInt(request.getParameter("thoiLuong")));
            movie.setDaoDien(request.getParameter("daoDien"));
            movie.setDienVien(request.getParameter("dienVien"));
            movie.setTrangThai(request.getParameter("trangThai"));

            String ngayKhoiChieu = request.getParameter("ngayKhoiChieu");
            if (ngayKhoiChieu != null && !ngayKhoiChieu.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                movie.setNgayKhoiChieu(new Timestamp(sdf.parse(ngayKhoiChieu).getTime()));
            }

            // Handle file upload
            try {
                Part filePart = request.getPart("poster");
                String uploadBasePath = FileUploadUtil.getUploadBasePath(
                    getServletContext().getRealPath("/")
                );
                String fileName = FileUploadUtil.uploadPoster(filePart, uploadBasePath);
                if (fileName != null) {
                    movie.setAnhPoster(fileName);
                }
            } catch (Exception e) {
                System.err.println("❌ Error uploading file: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi tải lên poster: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/movie/add.jsp").forward(request, response);
                return;
            }

            if (movieDAO.insert(movie)) {
                response.sendRedirect(request.getContextPath() + "/admin/movies?message=added");
            } else {
                request.setAttribute("error", "Không thể thêm phim!");
                request.getRequestDispatcher("/views/admin/movie/add.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Ngày khởi chiếu không hợp lệ!");
            request.getRequestDispatcher("/views/admin/movie/add.jsp").forward(request, response);
        }
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String maPhimStr = request.getParameter("maPhim");
            if (maPhimStr == null || maPhimStr.isEmpty()) {
                request.setAttribute("error", "ID phim không hợp lệ!");
                request.getRequestDispatcher("/views/admin/movie/list.jsp").forward(request, response);
                return;
            }
            
            int maPhim = Integer.parseInt(maPhimStr);
            Movie movie = movieDAO.findById(maPhim);

            if (movie == null) {
                response.sendRedirect(request.getContextPath() + "/admin/movies?error=notfound");
                return;
            }

            movie.setTenPhim(request.getParameter("tenPhim"));
            movie.setMoTa(request.getParameter("moTa"));
            movie.setTheLoai(request.getParameter("theLoai"));
            movie.setThoiLuong(Integer.parseInt(request.getParameter("thoiLuong")));
            movie.setDaoDien(request.getParameter("daoDien"));
            movie.setDienVien(request.getParameter("dienVien"));
            movie.setTrangThai(request.getParameter("trangThai"));

            String ngayKhoiChieu = request.getParameter("ngayKhoiChieu");
            if (ngayKhoiChieu != null && !ngayKhoiChieu.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                movie.setNgayKhoiChieu(new Timestamp(sdf.parse(ngayKhoiChieu).getTime()));
            }

            // Handle file upload
            try {
                Part filePart = request.getPart("poster");
                String uploadBasePath = FileUploadUtil.getUploadBasePath(
                    getServletContext().getRealPath("/")
                );
                String fileName = FileUploadUtil.uploadPoster(filePart, uploadBasePath);
                if (fileName != null) {
                    movie.setAnhPoster(fileName);
                }
            } catch (Exception e) {
                System.err.println("❌ Error uploading file: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi tải lên poster: " + e.getMessage());
                request.setAttribute("movie", movie);
                request.getRequestDispatcher("/views/admin/movie/edit.jsp").forward(request, response);
                return;
            }

            if (movieDAO.update(movie)) {
                response.sendRedirect(request.getContextPath() + "/admin/movies?message=updated");
            } else {
                request.setAttribute("error", "Không thể cập nhật phim!");
                request.setAttribute("movie", movie);
                request.getRequestDispatcher("/views/admin/movie/edit.jsp").forward(request, response);
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Ngày khởi chiếu không hợp lệ!");
            request.getRequestDispatcher("/views/admin/movie/edit.jsp").forward(request, response);
        }
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Movie movie = movieDAO.findById(id);

        if (movieDAO.delete(id)) {
            // Xóa file poster nếu có
            if (movie != null && movie.getAnhPoster() != null && !movie.getAnhPoster().isEmpty()) {
                try {
                    FileUploadUtil.deletePoster(
                        movie.getAnhPoster(),
                        getServletContext().getRealPath("/")
                    );
                } catch (Exception e) {
                    System.err.println("⚠ Warning: Could not delete poster file: " + e.getMessage());
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/movies?message=deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/movies?error=deletefailed");
        }
    }
}
