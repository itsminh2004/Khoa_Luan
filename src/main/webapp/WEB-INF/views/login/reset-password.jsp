<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<html>
<head>
    <title>Đặt lại mật khẩu</title>
    <link href="<c:url value='/template/login/register.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="register-container">
    <h2>Đặt lại mật khẩu</h2>
    <p>Nhập mã xác nhận và mật khẩu mới của bạn</p>
    <form action="<c:url value='/reset-password'/>" method="post">
        <div class="form-group">
            <label>Mã xác nhận:</label>
            <input type="text" name="code" placeholder="Nhập mã 6 chữ số" required maxlength="6" pattern="[0-9]{6}"/>
        </div>
        <div class="form-group">
            <label>Mật khẩu mới:</label>
            <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới" required minlength="6"/>
        </div>
        <div class="form-group">
            <label>Xác nhận mật khẩu mới:</label>
            <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required minlength="6"/>
        </div>

        <button type="submit">Đặt lại mật khẩu</button>
    </form>

    <c:if test="${not empty error}">
        <p class="message error">${error}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p class="message success">${message}</p>
    </c:if>

    <p><a href="<c:url value='/forgot-password'/>">Gửi lại mã</a> | <a href="<c:url value='/login'/>">Quay lại đăng nhập</a></p>
</div>
</body>
</html>
