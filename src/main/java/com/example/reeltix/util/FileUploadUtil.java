package com.example.reeltix.util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class FileUploadUtil {

    private static final String UPLOADS_DIR = "uploads" + File.separator + "posters" + File.separator;
    
    /**
     * Lấy đường dẫn upload directory ngoài webapp
     * Sử dụng thư mục user.home/reeltix-uploads để lưu ảnh vĩnh viễn
     */
    public static String getExternalUploadPath() {
        String userHome = System.getProperty("user.home");
        String externalUploadPath = userHome + File.separator + "reeltix-uploads" + File.separator + "posters";
        
        File uploadDir = new File(externalUploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        return externalUploadPath;
    }

    /**
     * Upload file poster và trả về tên file đã lưu
     * File được lưu vào external directory ngoài webapp để tồn tại sau compile
     */
    public static String uploadPoster(Part filePart, String uploadBasePath) throws IOException {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = UUID.randomUUID() + "_" + getFileName(filePart);
        
        // Lưu vào external directory (ngoài webapp)
        String externalUploadPath = getExternalUploadPath();
        File externalUploadedFile = new File(externalUploadPath + File.separator + fileName);
        
        try {
            filePart.write(externalUploadedFile.getAbsolutePath());
            System.out.println("✓ File saved to external location: " + externalUploadedFile.getAbsolutePath());
        } catch (IOException e) {
            System.err.println("❌ Error uploading file to external location: " + e.getMessage());
            throw new IOException("Failed to save file: " + e.getMessage());
        }

        // Cũng lưu vào webapp/uploads/posters để phục vụ trong lúc dev
        if (uploadBasePath != null && !uploadBasePath.isEmpty()) {
            String webappUploadPath = uploadBasePath + File.separator + UPLOADS_DIR;
            File webappUploadDir = new File(webappUploadPath);
            if (!webappUploadDir.exists()) {
                webappUploadDir.mkdirs();
            }
            
            File webappUploadedFile = new File(webappUploadPath + fileName);
            try {
                Files.copy(externalUploadedFile.toPath(), webappUploadedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                System.out.println("✓ File also copied to webapp: " + webappUploadedFile.getAbsolutePath());
            } catch (IOException e) {
                System.err.println("⚠ Warning: Could not copy file to webapp: " + e.getMessage());
                // File đã lưu vào external, vậy không cần throw exception
            }
        }

        return fileName;
    }

    /**
     * Xóa file poster từ cả external location và webapp
     */
    public static void deletePoster(String fileName, String uploadBasePath) {
        if (fileName == null || fileName.isEmpty()) {
            return;
        }

        // Xóa file từ external location
        String externalUploadPath = getExternalUploadPath();
        File externalUploadedFile = new File(externalUploadPath + File.separator + fileName);
        if (externalUploadedFile.exists()) {
            if (externalUploadedFile.delete()) {
                System.out.println("✓ File deleted from external location: " + externalUploadedFile.getAbsolutePath());
            } else {
                System.err.println("❌ Failed to delete external file: " + externalUploadedFile.getAbsolutePath());
            }
        }

        // Xóa file từ webapp
        if (uploadBasePath != null && !uploadBasePath.isEmpty()) {
            String webappUploadPath = uploadBasePath + File.separator + UPLOADS_DIR;
            File webappUploadedFile = new File(webappUploadPath + fileName);
            if (webappUploadedFile.exists()) {
                if (webappUploadedFile.delete()) {
                    System.out.println("✓ File deleted from webapp: " + webappUploadedFile.getAbsolutePath());
                } else {
                    System.err.println("❌ Failed to delete webapp file: " + webappUploadedFile.getAbsolutePath());
                }
            }
        }
    }

    /**
     * Lấy tên file từ Part header
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String token : contentDisposition.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "unknown";
    }

    /**
     * Lấy đường dẫn upload - sử dụng servlet context real path
     */
    public static String getUploadBasePath(String servletContextRealPath) {
        if (servletContextRealPath != null && !servletContextRealPath.isEmpty()) {
            return servletContextRealPath;
        }
        return null;
    }
}
