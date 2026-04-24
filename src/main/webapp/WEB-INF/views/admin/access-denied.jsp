<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<style>
    .access-denied-container {
        min-height: 60vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 2rem;
    }

    .access-denied-card {
        max-width: 500px;
        text-align: center;
        background: #fff;
        border-radius: 16px;
        padding: 3rem 2rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    .access-denied-icon {
        font-size: 4rem;
        color: #ef4444;
        margin-bottom: 1.5rem;
    }

    .access-denied-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 1rem;
    }

    .access-denied-message {
        color: #64748b;
        margin-bottom: 2rem;
        line-height: 1.6;
    }

    .btn-back-home {
        display: inline-block;
        padding: 0.75rem 2rem;
        background: #0f172a;
        color: white;
        border-radius: 10px;
        text-decoration: none;
        font-weight: 600;
        transition: opacity 0.2s;
    }

    .btn-back-home:hover {
        opacity: 0.9;
        color: white;
        text-decoration: none;
    }
</style>

<div class="access-denied-container">
    <div class="access-denied-card">
        <div class="access-denied-icon">
            <i class="fas fa-lock"></i>
        </div>
        <h1 class="access-denied-title">Truy cập bị từ chối</h1>
        <p class="access-denied-message">
            Xin lỗi, bạn không có quyền truy cập vào trang này.
            Vui lòng liên hệ quản trị viên nếu bạn cho rằng đây là lỗi.
        </p>
        <a href="<c:url value='/admin-home'/>" class="btn-back-home">
            <i class="fas fa-home mr-2"></i>Quay về Dashboard
        </a>
    </div>
</div>