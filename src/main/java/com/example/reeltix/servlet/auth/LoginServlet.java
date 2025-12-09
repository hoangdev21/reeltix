package com.example.reeltix.servlet.auth;

import com.example.reeltix.dao.UserDAO;
import com.example.reeltix.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            // Kiểm tra vai trò và redirect phù hợp
            if ("Admin".equalsIgnoreCase(user.getVaiTro())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
            return;
        }
        request.getRequestDispatcher("/views/auth/auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");

        User user = userDAO.authenticate(tenDangNhap, matKhau);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Kiểm tra vai trò và redirect phù hợp
            if ("Admin".equalsIgnoreCase(user.getVaiTro())) {
                // Lưu thêm session attribute "admin" để AdminAuthFilter nhận diện
                session.setAttribute("admin", user);
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/views/auth/auth.jsp").forward(request, response);
        }
    }
}
