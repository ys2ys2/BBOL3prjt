<%@ page import="java.io.File, java.io.InputStream, java.nio.file.Files, java.nio.file.Paths" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    String content = request.getParameter("content");
    String imagePath = "";

    // 파일 업로드 처리 (이미지 저장)
    if (request.getPart("image") != null) {
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        imagePath = uploadPath + File.separator + fileName;
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(imagePath));
        }
    }

    // DB 연결 및 데이터 삽입
    Connection conn = null;
    PreparedStatement pstmt = null;
    String insertQuery = "INSERT INTO posts (content, image_path) VALUES (?, ?)";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "username", "password");
        pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, content);
        pstmt.setString(2, imagePath);
        int result = pstmt.executeUpdate();

        // 성공 응답 반환
        response.setContentType("application/json");
        response.getWriter().write("{\"username\":\"사용자 이름\", \"content\":\"" + content + "\", \"comments\":0, \"likes\":0}");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
