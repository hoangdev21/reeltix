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
            // Lấy error từ session và chuyển sang request attribute
            String error = (String) request.getSession().getAttribute("error");
            if (error != null) {
                request.setAttribute("error", error);
                request.getSession().removeAttribute("error");
            }
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

    // Hiển thị danh sách phòng
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

    // Hiển thị form chỉnh sửa phòng
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
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    // Hiển thị form cấu hình ghế
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
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/rooms");
    }

    // Xử lý thêm phòng mới
    private void addRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenPhong = request.getParameter("tenPhong");
        String soHangStr = request.getParameter("soHang");
        String soCotStr = request.getParameter("soCot");
        String trangThai = request.getParameter("trangThai");

        try {
            int soHang = Integer.parseInt(soHangStr);
            int soCot = Integer.parseInt(soCotStr);
            int soLuongGhe = soHang * soCot;

            if (soLuongGhe <= 0) {
                request.getSession().setAttribute("error", "Số lượng ghế phải lớn hơn 0!");
                response.sendRedirect(request.getContextPath() + "/admin/rooms/add");
                return;
            }

            Room room = new Room();
            room.setTenPhong(tenPhong);
            room.setSoLuongGhe(soLuongGhe);
            room.setTrangThai(trangThai != null ? trangThai : "HoatDong");

            if (roomDAO.insert(room)) {
                request.getSession().setAttribute("message", "Thêm phòng chiếu thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/rooms");
            } else {
                request.getSession().setAttribute("error", "Không thể thêm phòng chiếu!");
                response.sendRedirect(request.getContextPath() + "/admin/rooms/add");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu số hàng và số cột không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/rooms/add");
        }
    }

    // Xử lý cập nhật phòng
    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("maPhong");
        String tenPhong = request.getParameter("tenPhong");
        String soHangStr = request.getParameter("soHang");
        String soCotStr = request.getParameter("soCot");
        String trangThai = request.getParameter("trangThai");

        int id = 0;
        try {
            id = Integer.parseInt(idParam);
            int soHang = Integer.parseInt(soHangStr);
            int soCot = Integer.parseInt(soCotStr);
            int soLuongGhe = soHang * soCot;

            if (soLuongGhe <= 0) {
                request.getSession().setAttribute("error", "Số lượng ghế phải lớn hơn 0!");
                response.sendRedirect(request.getContextPath() + "/admin/rooms/edit?id=" + id);
                return;
            }

            Room room = new Room();
            room.setMaPhong(id);
            room.setTenPhong(tenPhong);
            room.setSoLuongGhe(soLuongGhe);
            room.setTrangThai(trangThai);

            if (roomDAO.update(room)) {
                request.getSession().setAttribute("message", "Cập nhật phòng chiếu thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/rooms");
            } else {
                request.getSession().setAttribute("error", "Không thể cập nhật phòng chiếu!");
                response.sendRedirect(request.getContextPath() + "/admin/rooms/edit?id=" + id);
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/rooms/edit?id=" + id);
        }
    }

    // Xử lý xóa phòng
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
