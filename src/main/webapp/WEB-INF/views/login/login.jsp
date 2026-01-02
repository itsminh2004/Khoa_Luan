<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<html>
<head>
    <title>Đăng nhập</title>
    <link href="<c:url value='/template/login/login.css'/>" rel="stylesheet"/>
</head>
<body>
<div class="loginclass">
    <form action="<c:url value='/login'/>" method="post">
        <h2>Đăng nhập</h2>

        <label>Email:</label>
        <input type="email" name="email" required placeholder="Nhập email của bạn"/><br/>

        <label>Mật khẩu:</label>
        <input type="password" name="password" required placeholder="Nhập mật khẩu"/><br/>

        <button type="submit">Đăng nhập</button>

        <c:if test="${param.error eq 'true'}">
            <p style="color:red">Sai email hoặc mật khẩu!</p>
        </c:if>
        <c:if test="${param.logout eq 'true'}">
            <p style="color:green">Bạn đã đăng xuất!</p>
        </c:if>
    </form>
    <a  class="dang_ky" href="<c:url value='/register'/>">Tạo tài khoản</a>
    <br/>
    <br/>
    <a class="quen_mat_khau" href="<c:url value='forgot-password'/>">Quên mật khẩu?</a>
</div>

</body>
</html>
