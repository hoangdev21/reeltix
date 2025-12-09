HƯỚNG DẪN SETUP VÀ KHẮC PHỤC LỖI UPLOAD ẢNH POSTER
================================================

## VẤN ĐỀ ĐƯỢC GIẢI QUYẾT
Trước đây, ảnh poster được upload nhưng không lưu vĩnh viễn sau khi compile lại dự án.
Lý do: Thư mục `target` bị xóa khi compile, nên ảnh cũng mất theo.

## GIẢI PHÁP
Ảnh poster hiện được lưu vào một **external directory** ngoài webapp:
- **Windows**: `C:\Users\[YourUsername]\reeltix-uploads\posters\`
- **Linux/Mac**: `/home/[username]/reeltix-uploads/posters/`

Thư mục này sẽ được tạo tự động khi upload ảnh lần đầu tiên.

## HƯỚNG DẪN SETUP TOMCAT

### Bước 1: Tìm file context.xml của Tomcat
Nếu dùng IntelliJ IDEA:
- Đi tới `Run` → `Edit Configurations`
- Chọn Tomcat Server configuration
- Nhấp vào `Fix` hoặc nhìn trong `Deployment` tab

Nếu dùng Tomcat standalone:
- Tìm file: `TOMCAT_HOME/conf/Catalina/localhost/reeltix.xml`
  (nếu không có thì tạo mới)

### Bước 2: Thêm context cho poster directory
Thêm dòng này vào file context hoặc tạo file mới `reeltix.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context docBase="[PATH_TO_REELTIX]/target/reeltix-1.0-SNAPSHOT" path="/reeltix_war_exploded">
    <!-- External uploads directory -->
    <Resources>
        <PreResources className="org.apache.catalina.webresources.DirResourceSet"
                     web="uploads/posters/" 
                     base="[USER_HOME]/reeltix-uploads/posters"
                     internalseparator="/" />
    </Resources>
</Context>
```

**Thay thế:**
- `[PATH_TO_REELTIX]` = đường dẫn đến folder dự án (ví dụ: `D:\Workspace\ltweb\final\reeltix`)
- `[USER_HOME]` = thư mục home của user (ví dụ: `C:\Users\Admin`)

### Bước 3 (Cách khác - Đơn giản hơn): Cấu hình trong Tomcat Manager
Nếu bạn dùng Embedded Tomcat trong IDE:
1. Mở IDE Settings/Preferences
2. Tìm Tomcat config
3. Thêm Virtual Directory Mapping:
   - URL: `/uploads/posters/`
   - Path: `C:\Users\[YourUsername]\reeltix-uploads\posters`

## KIỂM TRA SETUP
1. **Upload ảnh** từ admin panel (Add Movie hoặc Edit Movie)
2. **Kiểm tra file** có được lưu trong `reeltix-uploads/posters/`
3. **Xem ảnh** - nếu hiển thị bình thường, setup thành công
4. **Compile lại** - ảnh vẫn còn

## SERVLET PHỤC VỤ ẢNH
Hiện có servlet `PosterServlet` xử lý:
- URL pattern: `/uploads/posters/*`
- Nó sẽ tìm ảnh từ external directory
- Hỗ trợ các format: JPG, PNG, GIF, WebP

## LỖI THƯỜNG GẶP VÀ CÁCH KHẮC PHỤC

### Lỗi 404: Không tìm thấy ảnh
**Nguyên nhân**: Tomcat chưa được config đúng
**Cách khắc phục**:
1. Kiểm tra file đã được lưu trong `reeltix-uploads/posters/` chưa
2. Kiểm tra path trong file context.xml
3. Restart Tomcat

### Lỗi Upload thất bại
**Nguyên nhân**: Quyền folder không đủ hoặc folder không tồn tại
**Cách khắc phục**:
1. Đảm bảo thư mục tồn tại: `C:\Users\[Username]\reeltix-uploads\posters`
2. Kiểm tra quyền ghi của folder
3. Xem console log để tìm thông báo lỗi

### Ảnh hiển thị nhưng 404 sau compile
**Nguyên nhân**: Không setup external directory
**Cách khắc phục**: Làm theo Bước 1-3 phía trên

## FILE LIÊN QUAN
- `FileUploadUtil.java` - Xử lý upload ảnh
- `PosterServlet.java` - Phục vụ ảnh
- `AdminMovieServlet.java` - Xử lý add/edit movie
- `pom.xml` - Cấu hình Maven

## TESTING QUICK
Sau khi setup:
1. Login vào admin panel
2. Thêm movie mới với poster
3. Check trong `C:\Users\[Username]\reeltix-uploads\posters\` 
4. Xem ảnh hiển thị trên trang

Nếu cần hỗ trợ, check console log (console của Tomcat) để tìm lỗi chi tiết.
