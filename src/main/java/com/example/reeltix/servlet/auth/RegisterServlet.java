package com.example.reeltix.servlet.auth;

import com.example.reeltix.dao.UserDAO;
import com.example.reeltix.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");
        String xacNhanMatKhau = request.getParameter("xacNhanMatKhau");
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String soDienThoai = request.getParameter("soDienThoai");

        // Validate
        if (!matKhau.equals(xacNhanMatKhau)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        // Check username exists
        if (userDAO.findByUsername(tenDangNhap) != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        // Create user
        User user = new User();
        user.setTenDangNhap(tenDangNhap);
        user.setMatKhau(matKhau);
        user.setHoTen(hoTen);
        user.setEmail(email);
        user.setSoDienThoai(soDienThoai);
        user.setVaiTro("KhachHang");
        user.setTrangThai("HoatDong");

        if (userDAO.insert(user)) {
            response.sendRedirect(request.getContextPath() + "/auth/login?success=1");
        } else {
            request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}

