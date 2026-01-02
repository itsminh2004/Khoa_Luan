<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<style>
    .blog-comment-section {
        background: #f8f9fc;
        min-height: 100vh;
        padding-bottom: 2rem;
    }

    .page-header {
        background: #ffffff; /* trắng hoàn toàn */
        padding: 2.5rem 0;
        margin-bottom: 2rem;
        border-radius: 0 0 20px 20px;

        /* Shadow nhẹ để tạo chiều sâu */
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .page-header h1 {
        color: black;
        font-weight: 600;
        margin: 0;
        font-size: 1.75rem;
    }

    .breadcrumb {
        background: transparent;
        padding: 0.5rem 0 0 0;
        margin: 0;
    }

    .breadcrumb-item a {
        color: black;
        text-decoration: none;
        transition: color 0.3s;
    }

    .breadcrumb-item a:hover {
        color: black;
    }

    .breadcrumb-item.active {
        color: black;
    }

    .breadcrumb-item + .breadcrumb-item::before {
        color: black;
    }

    .content-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        overflow: hidden;
    }

    .filter-section {
        background: linear-gradient(135deg, #f8f9fc 0%, #e9ecef 100%);
        padding: 1.5rem;
        border-bottom: 2px solid #e2e8f0;
        display: flex;
        align-items: center;
        gap: 1rem;
        flex-wrap: wrap;
    }

    .filter-label {
        color: #2d3748;
        font-weight: 600;
        font-size: 0.95rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin: 0;
    }

    .form-control {
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        padding: 0.6rem 1rem;
        font-size: 0.95rem;
        transition: all 0.3s;
        color: #2d3748;
        min-width: 250px;
    }

    .form-control:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
        outline: none;
    }

    .btn {
        padding: 0.6rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
    }

    .btn-primary {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
        box-shadow: 0 2px 4px rgba(78, 115, 223, 0.3);
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(78, 115, 223, 0.5);
        background: linear-gradient(135deg, #2e59d9 0%, #1a3da8 100%);
        color: white;
    }

    .table {
        margin: 0;
    }

    .table thead th {
        background: #f8f9fc;
        color: #4a5568;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.5px;
        border: none;
        padding: 1.25rem 1rem;
    }

    .table tbody tr {
        transition: all 0.3s;
        border-bottom: 1px solid #e2e8f0;
    }

    .table tbody tr:hover {
        background: #f7fafc;
        transform: scale(1.001);
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .table tbody td {
        padding: 1.25rem 1rem;
        vertical-align: middle;
        color: #2d3748;
    }

    .table tbody td strong {
        color: #1a202c;
        font-weight: 600;
    }

    .comment-text {
        max-width: 300px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        display: block;
    }

    .comment-text:hover {
        white-space: normal;
        overflow: visible;
    }

    .post-title-badge {
        background: #edf2f7;
        color: #4e73df;
        padding: 0.35rem 0.7rem;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 500;
        display: inline-block;
    }

    .commenter-name {
        color: #4a5568;
        font-weight: 500;
    }

    .date-cell {
        color: #718096;
        font-size: 0.875rem;
    }

    .btn-sm {
        padding: 0.45rem 0.85rem;
        border-radius: 6px;
        font-size: 0.875rem;
        transition: all 0.2s;
        border: none;
    }

    .btn-danger {
        background: linear-gradient(135deg, #e74a3b 0%, #be2617 100%);
        color: white;
    }

    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(231, 74, 59, 0.4);
        background: linear-gradient(135deg, #d52a1a 0%, #a02114 100%);
        color: white;
    }

    .empty-state {
        padding: 3rem 2rem;
        text-align: center;
    }

    .empty-state-icon {
        font-size: 4rem;
        color: #cbd5e0;
        margin-bottom: 1rem;
    }

    .empty-state-text {
        color: #a0aec0;
        font-size: 1.1rem;
        margin: 0;
    }

    .text-muted {
        color: #a0aec0 !important;
    }
</style>

<section class="blog-comment-section">
    <div class="page-header">
        <div class="container-fluid">
            <h1>${pageTitle}</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý bình luận</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container-fluid">
        <div class="content-card">
            <form class="filter-section" method="get" action="${pageContext.request.contextPath}/admin/blog-comment">
                <label class="filter-label" for="postFilter">
                    <i class="fas fa-filter text-primary"></i>
                    Lọc theo bài viết:
                </label>
                <select id="postFilter" name="postId" class="form-control">
                    <option value="">Tất cả bài viết</option>
                    <c:forEach items="${posts}" var="post">
                        <option value="${post.id}" ${selectedPostId == post.id ? 'selected' : ''}>
                                ${post.title}
                        </option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Lọc
                </button>
            </form>

            <div class="p-0">
                <div class="table-responsive">
                    <table class="table mb-0">
                        <thead>
                        <tr>
                            <th width="70">ID</th>
                            <th>Bình luận</th>
                            <th width="200">Bài viết</th>
                            <th width="150">Người bình luận</th>
                            <th width="140">Thời gian</th>
                            <th width="120">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty comments}">
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">
                                            <i class="far fa-comments"></i>
                                        </div>
                                        <p class="empty-state-text">
                                            Chưa có bình luận nào
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach items="${comments}" var="c">
                            <tr>
                                <td>${c.id}</td>
                                <td>
                                    <span class="comment-text" title="${c.comment}">
                                        <i class="fas fa-comment-dots text-info"></i>
                                        ${c.comment}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty c.postTitle}">
                                            <span class="post-title-badge">${c.postTitle}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Không xác định</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="commenter-name">
                                    <i class="fas fa-user text-secondary"></i>
                                        ${c.commenterName != null ? c.commenterName : 'Ẩn danh'}
                                </td>
                                <td class="date-cell">
                                    <i class="far fa-calendar"></i>
                                    <fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy"/>
                                    <br>
                                    <small><fmt:formatDate value="${c.createdAt}" pattern="HH:mm"/></small>
                                </td>
                                <td class="text-center">
                                    <c:url var="deleteUrl" value="/admin/blog-comment/delete/${c.id}">
                                        <c:if test="${not empty selectedPostId}">
                                            <c:param name="postId" value="${selectedPostId}"/>
                                        </c:if>
                                    </c:url>
                                    <a href="${deleteUrl}" class="btn btn-sm btn-danger" title="Xóa bình luận"
                                       onclick="return confirm('Xóa bình luận này?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>