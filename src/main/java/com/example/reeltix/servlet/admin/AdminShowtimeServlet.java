package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.ShowtimeDAO;
import com.example.reeltix.dao.MovieDAO;
import com.example.reeltix.dao.RoomDAO;
import com.example.reeltix.dao.BookingDetailDAO;
import com.example.reeltix.model.Showtime;
import com.example.reeltix.model.Movie;
import com.example.reeltix.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/showtimes", "/admin/showtimes/*"})
public class AdminShowtimeServlet extends HttpServlet {

    private ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị danh sách suất chiếu
            listShowtimes(request, response);
        } else if (pathInfo.equals("/add")) {
            // Form thêm suất chiếu mới
            showAddForm(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Form chỉnh sửa suất chiếu
            editShowtime(request, response);
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
        } else if (pathInfo.equals("/add")) {
            // Xử lý thêm suất chiếu mới
            addShowtime(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Xử lý cập nhật suất chiếu
            updateShowtime(request, response);
        } else if (pathInfo.equals("/delete")) {
            // Xử lý xóa suất chiếu
            deleteShowtime(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listShowtimes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy message từ session
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

        // Lấy danh sách suất chiếu
        List<Showtime> showtimes = showtimeDAO.findAll();

        // Lấy danh sách phim và phòng cho bộ lọc
        List<Movie> movies = movieDAO.findAll();
        List<Room> rooms = roomDAO.findAll();

        request.setAttribute("showtimes", showtimes);
        request.setAttribute("movies", movies);
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/views/admin/showtime/list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách phim và phòng cho form
        List<Movie> movies = movieDAO.findAll();
        List<Room> rooms = roomDAO.findAll();

        request.setAttribute("movies", movies);
        request.setAttribute("rooms", rooms);
        request.setAttribute("today", LocalDate.now());
        request.getRequestDispatcher("/views/admin/showtime/add.jsp").forward(request, response);
    }

    private void editShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Showtime showtime = showtimeDAO.findById(id);
                if (showtime != null) {
                    // Lấy danh sách phim và phòng cho form
                    List<Movie> movies = movieDAO.findAll();
                    List<Room> rooms = roomDAO.findAll();

                    // Lấy số vé đã bán cho suất chiếu này
                    int ticketsSold = bookingDetailDAO.countByShowtimeId(id);

                    request.setAttribute("showtime", showtime);
                    request.setAttribute("movies", movies);
                    request.setAttribute("rooms", rooms);
                    request.setAttribute("ticketsSold", ticketsSold);
                    request.getRequestDispatcher("/views/admin/showtime/edit.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/showtimes");
    }

    private void addShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String maPhimStr = request.getParameter("maPhim");
            String maPhongStr = request.getParameter("maPhong");
            String ngayChieuStr = request.getParameter("ngayChieu");
            String gioChieuStr = request.getParameter("gioChieu");
            String giaVeStr = request.getParameter("giaVe");
            String trangThai = request.getParameter("trangThai");

            // Validate dữ liệu
            if (maPhimStr == null || maPhimStr.isEmpty() ||
                maPhongStr == null || maPhongStr.isEmpty() ||
                ngayChieuStr == null || ngayChieuStr.isEmpty() ||
                gioChieuStr == null || gioChieuStr.isEmpty() ||
                giaVeStr == null || giaVeStr.isEmpty()) {

                request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes/add");
                return;
            }

            // Parse dữ liệu
            int maPhim = Integer.parseInt(maPhimStr);
            int maPhong = Integer.parseInt(maPhongStr);
            LocalDate ngayChieu = LocalDate.parse(ngayChieuStr);
            LocalTime gioChieu = LocalTime.parse(gioChieuStr);
            double giaVe = Double.parseDouble(giaVeStr);

            // Validate giá vé
            if (giaVe < 10000) {
                request.getSession().setAttribute("error", "Giá vé tối thiểu là 10.000 đ!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes/add");
                return;
            }

            // Validate ngày chiếu không được trong quá khứ
            if (ngayChieu.isBefore(LocalDate.now())) {
                request.getSession().setAttribute("error", "Ngày chiếu không được trong quá khứ!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes/add");
                return;
            }

            // Tạo object Showtime
            Showtime showtime = new Showtime();
            showtime.setMaPhim(maPhim);
            showtime.setMaPhong(maPhong);
            showtime.setNgayChieu(ngayChieu);
            showtime.setGioChieu(gioChieu);
            showtime.setGiaVe(giaVe);
            showtime.setTrangThai(trangThai != null ? trangThai : "MoCua");

            // Lưu vào database
            if (showtimeDAO.insert(showtime)) {
                request.getSession().setAttribute("message", "Thêm suất chiếu thành công!");
            } else {
                request.getSession().setAttribute("error", "Lỗi khi thêm suất chiếu!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/showtimes/add");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/showtimes/add");
        }
    }

    private void updateShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String maSuatChieuStr = request.getParameter("maSuatChieu");
            String maPhimStr = request.getParameter("maPhim");
            String maPhongStr = request.getParameter("maPhong");
            String ngayChieuStr = request.getParameter("ngayChieu");
            String gioChieuStr = request.getParameter("gioChieu");
            String giaVeStr = request.getParameter("giaVe");
            String trangThai = request.getParameter("trangThai");

            // Validate dữ liệu
            if (maSuatChieuStr == null || maSuatChieuStr.isEmpty() ||
                maPhimStr == null || maPhimStr.isEmpty() ||
                maPhongStr == null || maPhongStr.isEmpty() ||
                ngayChieuStr == null || ngayChieuStr.isEmpty() ||
                gioChieuStr == null || gioChieuStr.isEmpty() ||
                giaVeStr == null || giaVeStr.isEmpty()) {

                request.getSession().setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes");
                return;
            }

            // Parse dữ liệu
            int maSuatChieu = Integer.parseInt(maSuatChieuStr);
            int maPhim = Integer.parseInt(maPhimStr);
            int maPhong = Integer.parseInt(maPhongStr);
            LocalDate ngayChieu = LocalDate.parse(ngayChieuStr);
            LocalTime gioChieu = LocalTime.parse(gioChieuStr);
            double giaVe = Double.parseDouble(giaVeStr);

            // Validate giá vé
            if (giaVe < 10000) {
                request.getSession().setAttribute("error", "Giá vé tối thiểu là 10.000 đ!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes");
                return;
            }

            // Tạo object Showtime
            Showtime showtime = new Showtime();
            showtime.setMaSuatChieu(maSuatChieu);
            showtime.setMaPhim(maPhim);
            showtime.setMaPhong(maPhong);
            showtime.setNgayChieu(ngayChieu);
            showtime.setGioChieu(gioChieu);
            showtime.setGiaVe(giaVe);
            showtime.setTrangThai(trangThai != null ? trangThai : "MoCua");

            // Cập nhật vào database
            if (showtimeDAO.update(showtime)) {
                request.getSession().setAttribute("message", "Cập nhật suất chiếu thành công!");
            } else {
                request.getSession().setAttribute("error", "Lỗi khi cập nhật suất chiếu!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        }
    }

    private void deleteShowtime(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                request.getSession().setAttribute("error", "ID suất chiếu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes");
                return;
            }

            int id = Integer.parseInt(idParam);

            // Kiểm tra xem suất chiếu có vé được đặt không
            int ticketCount = bookingDetailDAO.countByShowtimeId(id);
            if (ticketCount > 0) {
                request.getSession().setAttribute("error", "Không thể xóa suất chiếu này vì đã có " + ticketCount + " vé được đặt!");
                response.sendRedirect(request.getContextPath() + "/admin/showtimes");
                return;
            }

            // Xóa suất chiếu
            if (showtimeDAO.delete(id)) {
                request.getSession().setAttribute("message", "Xóa suất chiếu thành công!");
            } else {
                request.getSession().setAttribute("error", "Lỗi khi xóa suất chiếu!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID suất chiếu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/showtimes");
        }
    }
}
