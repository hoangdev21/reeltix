package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.RoomDAO;
import com.example.reeltix.model.Room;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/rooms", "/admin/rooms/*"})
public class AdminRoomServlet extends HttpServlet {

    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị danh sách phòng
            listRooms(request, response);
        } else if (pathInfo.equals("/add")) {
            // Form thêm phòng mới
            request.getRequestDispatcher("/views/admin/room/add.jsp").forward(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Form chỉnh sửa phòng
            editRoom(request, response);
        } else if (pathInfo.equals("/seat-config")) {
            // Cấu hình ghế
            seatConfig(request, response);
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
            // Xử lý thêm phòng mới
            addRoom(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Xử lý cập nhật phòng
            updateRoom(request, response);
        } else if (pathInfo.equals("/delete")) {
            // Xử lý xóa phòng
            deleteRoom(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy message từ session và chuyển sang request attribute
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

        List<Room> rooms = roomDAO.findAll();
        request.setAttribute("rooms", rooms);
        request.getRequestDispatcher("/views/admin/room/list.jsp").forward(request, response);
    }

    private void editRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Room room = roomDAO.findById(id);
                if (room != null) {
                    request.setAttribute("room", room);
                    request.getRequestDispatcher("/views/admin/room/edit.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void seatConfig(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Room room = roomDAO.findById(id);
                if (room != null) {
                    request.setAttribute("room", room);
                    request.getRequestDispatcher("/views/admin/room/seat-config.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void addRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenPhong = request.getParameter("tenPhong");
        String soLuongGheStr = request.getParameter("soLuongGhe");
        String trangThai = request.getParameter("trangThai");

        try {
            int soLuongGhe = Integer.parseInt(soLuongGheStr);

            Room room = new Room();
            room.setTenPhong(tenPhong);
            room.setSoLuongGhe(soLuongGhe);
            room.setTrangThai(trangThai != null ? trangThai : "HoatDong");

            if (roomDAO.insert(room)) {
                request.getSession().setAttribute("message", "Thêm phòng chiếu thành công!");
            } else {
                request.getSession().setAttribute("error", "Không thể thêm phòng chiếu!");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Số lượng ghế không hợp lệ!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String tenPhong = request.getParameter("tenPhong");
        String soLuongGheStr = request.getParameter("soLuongGhe");
        String trangThai = request.getParameter("trangThai");

        try {
            int id = Integer.parseInt(idParam);
            int soLuongGhe = Integer.parseInt(soLuongGheStr);

            Room room = new Room();
            room.setMaPhong(id);
            room.setTenPhong(tenPhong);
            room.setSoLuongGhe(soLuongGhe);
            room.setTrangThai(trangThai);

            if (roomDAO.update(room)) {
                request.getSession().setAttribute("message", "Cập nhật phòng chiếu thành công!");
            } else {
                request.getSession().setAttribute("error", "Không thể cập nhật phòng chiếu!");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        try {
            int id = Integer.parseInt(idParam);

            if (roomDAO.delete(id)) {
                request.getSession().setAttribute("message", "Xóa phòng chiếu thành công!");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa phòng chiếu! Phòng có thể đang được sử dụng.");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "ID phòng không hợp lệ!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }
}
