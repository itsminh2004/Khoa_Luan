<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<html>
<head>
    <title>Đăng ký tài khoản</title>
    <link href="<c:url value='/template/login/register.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="register-container">
    <h2>Đăng ký</h2>
    <form action="<c:url value='/register'/>" method="post">
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" required placeholder="Nhập email của bạn"/>
        </div>
        <div class="form-group">
            <label>Họ và tên</label>
            <input type="text" name="fullName" required placeholder="Nhập họ và tên của bạn"/>
        </div>
        <div class="form-group">
            <label>Mật khẩu:</label>
            <input type="password" name="password" required placeholder="Nhập mật khẩu"/>
        </div>

        <button type="submit">Đăng ký</button>
    </form>

    <!-- Hiển thị lỗi -->
    <c:if test="${not empty error}">
        <p class="message error">${error}</p>
    </c:if>

    <!-- Hiển thị thông báo thành công (ví dụ đã gửi OTP) -->
    <c:if test="${not empty message}">
        <p class="message success">${message}</p>
    </c:if>

    <p>Bạn đã có tài khoản? <a href="<c:url value='/login'/>">Đăng nhập</a></p>
</div>
</body>
</html>
