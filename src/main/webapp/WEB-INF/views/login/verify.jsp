<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<html>
<head>
    <title>Xác thực OTP</title>
    <link href="<c:url value='/template/login/verify.css'/>" rel="stylesheet"/>
</head>
<body>
    <div class="verify-container">
        <h2>Xác thực OTP</h2>
        <p>Vui lòng nhập mã OTP đã được gửi đến email của bạn:</p>
        <form action="<c:url value='/verify'/>" method="post">
            <input type="text" name="code" placeholder="Nhập mã OTP" required />
            <button type="submit">Xác thực</button>
        </form>
        <c:if test="${not empty error}">
            <p class="message error">${error}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="message success">${message}</p>
        </c:if>
    </div>
</body>
</html>
