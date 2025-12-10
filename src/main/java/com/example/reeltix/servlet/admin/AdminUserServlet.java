package com.example.reeltix.servlet.admin;

import com.example.reeltix.dao.UserDAO;
import com.example.reeltix.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/users", "/admin/users/detail", "/admin/users/lock", "/admin/users/unlock"})
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/users/detail".equals(path)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.findById(id);
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/admin/user/detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=notfound");
            }
        } else {
            // Dsach ng dùng
            String search = request.getParameter("search");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            List<User> users;
            if ((search != null && !search.isEmpty()) || (role != null && !role.isEmpty()) || (status != null && !status.isEmpty())) {
                users = userDAO.findByRoleAndStatus(role, status, search);
            } else {
                users = userDAO.findAll();
            }
            request.setAttribute("users", users);
            request.getRequestDispatcher("/views/admin/user/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/users/lock".equals(path)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (userDAO.updateStatus(id, "BiKhoa")) {
                response.sendRedirect(request.getContextPath() + "/admin/users?message=locked");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=lockfailed");
            }
        } else if ("/admin/users/unlock".equals(path)) {
            int id = Integer.parseInt(request.getParameter("id"));
            if (userDAO.updateStatus(id, "HoatDong")) {
                response.sendRedirect(request.getContextPath() + "/admin/users?message=unlocked");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=unlockfailed");
            }
        }
    }
}
