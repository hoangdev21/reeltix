package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.UserDAO;
import com.example.reeltix.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    // Hiển thị trang đăng nhập admin
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập thì chuyển đến dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        request.getRequestDispatcher("/views/admin/login.jsp").forward(request, response);
    }

    // Xử lý đăng nhập admin
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");

        User user = userDAO.authenticate(tenDangNhap, matKhau);

        if (user != null && "Admin".equals(user.getVaiTro())) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", user);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/views/admin/login.jsp").forward(request, response);
        }
    }
}
