package com.example.reeltix.servlet.customer;

import com.example.reeltix.dao.UserDAO;
import com.example.reeltix.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/customer/profile"})
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Chuyển đến trang profile
        request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        try {
            User currentUser = (User) session.getAttribute("user");
            int userId = currentUser.getMaNguoiDung();

            // Lấy dữ liệu từ form
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            String soDienThoai = request.getParameter("soDienThoai");
            String matKhauHienTai = request.getParameter("matKhauHienTai");
            String matKhauMoi = request.getParameter("matKhauMoi");
            String xacNhanMatKhau = request.getParameter("xacNhanMatKhau");

            // Xác thực
            if (hoTen == null || hoTen.trim().isEmpty()) {
                request.setAttribute("error", "Họ tên không được để trống");
                request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("error", "Email không được để trống");
                request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                return;
            }

            // Xác thực định dạng email
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                request.setAttribute("error", "Email không hợp lệ");
                request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                return;
            }

            // Tìm người dùng hiện tại
            User user = userDAO.findById(userId);
            if (user == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng");
                request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                return;
            }

            // Cập nhật thông tin người dùng
            user.setHoTen(hoTen);
            user.setEmail(email);
            user.setSoDienThoai(soDienThoai != null ? soDienThoai : "");

            if (matKhauMoi != null && !matKhauMoi.trim().isEmpty()) {
                if (matKhauHienTai == null || matKhauHienTai.trim().isEmpty()) {
                    request.setAttribute("error", "Vui lòng nhập mật khẩu hiện tại");
                    request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                    return;
                }

                if (!xacNhanMatKhau.equals(matKhauMoi)) {
                    request.setAttribute("error", "Xác nhận mật khẩu không trùng khớp");
                    request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                    return;
                }

                if (!user.getMatKhau().equals(matKhauHienTai)) {
                    request.setAttribute("error", "Mật khẩu hiện tại không chính xác");
                    request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                    return;
                }
                if (matKhauMoi.length() < 6) {
                    request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự");
                    request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
                    return;
                }
                user.setMatKhau(matKhauMoi);
            }

            // Cập nhật người dùng trong database
            if (userDAO.update(user)) {
                session.setAttribute("user", user);
                request.setAttribute("success", "Cập nhật thông tin thành công");
            } else {
                request.setAttribute("error", "Cập nhật thông tin thất bại");
            }

            request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
        }
    }
}

