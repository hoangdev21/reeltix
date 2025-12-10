package com.example.reeltix.servlet;

import com.example.reeltix.util.FileUploadUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;


@WebServlet(urlPatterns = {"/uploads/posters/*"})
public class PosterServlet extends HttpServlet {

    private static final int BUFFER_SIZE = 4096;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        // Loại bỏ dấu "/" đầu tiên
        String fileName = pathInfo.substring(1);
        
        // Ngăn chặn path traversal
        if (fileName.contains("..") || fileName.contains("\\")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Thử tìm từ external directory trước
        String externalUploadPath = FileUploadUtil.getExternalUploadPath();
        File file = new File(externalUploadPath + File.separator + fileName);

        // Nếu không tìm thấy, thử trong webapp
        if (!file.exists()) {
            String webappPath = request.getServletContext().getRealPath("/uploads/posters/" + fileName);
            if (webappPath != null) {
                file = new File(webappPath);
            }
        }

        if (!file.exists()) {
            System.err.println("⚠ Poster file not found: " + fileName);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Kiểm tra file có nằm trong uploads directory không
        try {
            if (!file.getCanonicalPath().startsWith(new File(externalUploadPath).getCanonicalPath()) &&
                !file.getCanonicalPath().startsWith(request.getServletContext().getRealPath("/uploads/posters/"))) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // Đặt response headers
        response.setContentType(getContentType(fileName));
        response.setContentLength((int) file.length());
        response.setHeader("Cache-Control", "public, max-age=31536000");

        // Ghi file vào response
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            byte[] buffer = new byte[BUFFER_SIZE];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            System.err.println("Lỗi: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Xác định content type dựa trên tên file
     */
    private String getContentType(String fileName) {
        if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (fileName.endsWith(".png")) {
            return "image/png";
        } else if (fileName.endsWith(".gif")) {
            return "image/gif";
        } else if (fileName.endsWith(".webp")) {
            return "image/webp";
        }
        return "application/octet-stream";
    }
}
