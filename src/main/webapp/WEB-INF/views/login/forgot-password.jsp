<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<html>
<head>
    <title>Quên mật khẩu</title>
    <link href="<c:url value='/template/login/register.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="register-container">
    <h2>Quên mật khẩu</h2>
    <p>Nhập email của bạn để nhận mã đặt lại mật khẩu</p>
    <form action="<c:url value='/forgot-password'/>" method="post">
        <div class="form-group">
            <label>Email:</label>
            <input type="email" name="email" required placeholder="Nhập email của bạn"/>
        </div>

        <button type="submit">Gửi mã đặt lại mật khẩu</button>
    </form>

    <!-- Hiển thị lỗi -->
    <c:if test="${not empty error}">
        <p class="message error">${error}</p>
    </c:if>

    <!-- Hiển thị thông báo thành công -->
    <c:if test="${not empty message}">
        <p class="message success">${message}</p>
    </c:if>

    <p>Bạn đã nhớ mật khẩu? <a href="<c:url value='/login'/>">Đăng nhập</a></p>
</div>
</body>
</html>
