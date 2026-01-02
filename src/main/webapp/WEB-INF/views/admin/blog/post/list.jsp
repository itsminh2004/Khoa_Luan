<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<style>
    .blog-post-section {
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

    .page-header-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .page-header h1 {
        color: black;
        font-weight: 600;
        margin: 0;
        font-size: 1.75rem;
    }

    .alert {
        border: none;
        border-radius: 12px;
        padding: 1rem 1.25rem;
        box-shadow: 0 2px 4px rgba(0,0,0,0.08);
    }

    .alert-success {
        background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
        color: white;
    }

    .alert-danger {
        background: linear-gradient(135deg, #e74a3b 0%, #be2617 100%);
        color: white;
    }

    .content-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        overflow: hidden;
    }

    .btn {
        padding: 0.6rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
    }

    .btn-success {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
        box-shadow: 0 2px 4px rgba(78, 115, 223, 0.3);
    }

    .btn-success:hover {
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
        font-size: 0.95rem;
    }

    .text-muted {
        color: #a0aec0 !important;
        font-size: 0.85rem;
    }

    .badge {
        padding: 0.4rem 0.75rem;
        border-radius: 6px;
        font-weight: 500;
        font-size: 0.8rem;
    }

    .badge-success {
        background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
        color: white;
    }

    .badge-secondary {
        background: linear-gradient(135deg, #858796 0%, #60616f 100%);
        color: white;
    }

    .btn-sm {
        padding: 0.45rem 0.85rem;
        border-radius: 6px;
        font-size: 0.875rem;
        transition: all 0.2s;
        border: none;
    }

    .btn-warning {
        background: linear-gradient(135deg, #f6c23e 0%, #dda20a 100%);
        color: white;
    }

    .btn-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(246, 194, 62, 0.4);
        color: white;
        background: linear-gradient(135deg, #f4b619 0%, #c8960b 100%);
    }

    .btn-info {
        background: linear-gradient(135deg, #36b9cc 0%, #258391 100%);
        color: white;
    }

    .btn-info:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(54, 185, 204, 0.4);
        color: white;
        background: linear-gradient(135deg, #2c9faf 0%, #1e6b75 100%);
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

    .action-buttons {
        display: flex;
        gap: 0.5rem;
        justify-content: center;
    }

    .post-title-cell {
        max-width: 300px;
    }

    .post-slug {
        display: block;
        margin-top: 0.25rem;
        font-style: italic;
    }

    .category-badge {
        background: #edf2f7;
        color: #4e73df;
        padding: 0.35rem 0.7rem;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 500;
    }

    .author-name {
        color: #4a5568;
        font-weight: 500;
    }

    .date-cell {
        color: #718096;
        font-size: 0.875rem;
    }
</style>

<section class="blog-post-section">
    <div class="page-header">
        <div class="container-fluid">
            <div class="page-header-content">
                <h1>Quản lý bài viết Blog</h1>
                <a href="${pageContext.request.contextPath}/admin-blog-post/add" class="btn btn-success">
                    <i class="fas fa-plus"></i> Viết bài mới
                </a>
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <!-- Flash Message -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle"></i> ${success}
                <button type="button" class="close" data-dismiss="alert" style="color: white; opacity: 0.8;">&times;</button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="close" data-dismiss="alert" style="color: white; opacity: 0.8;">&times;</button>
            </div>
        </c:if>

        <div class="content-card">
            <div class="p-0">
                <div class="table-responsive">
                    <table class="table mb-0" id="dataTable">
                        <thead>
                        <tr>
                            <th width="80">ID</th>
                            <th>Tiêu đề</th>
                            <th width="150">Danh mục</th>
                            <th width="140">Tác giả</th>
                            <th width="130">Trạng thái</th>
                            <th width="140">Ngày tạo</th>
                            <th width="180">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${posts}">
                            <tr>
                                <td>${p.id}</td>
                                <td class="post-title-cell">
                                    <strong>${p.title}</strong>
                                    <small class="text-muted post-slug">/${p.slug}</small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty p.categoryName}">
                                            <span class="category-badge">${p.categoryName}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="author-name">${p.authorName}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 'PUBLISHED'}">
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle"></i> Đã xuất bản
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">
                                                <i class="fas fa-file"></i> Bản nháp
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="date-cell">
                                    <i class="far fa-calendar"></i>
                                    <fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy"/>
                                    <br>
                                    <small><fmt:formatDate value="${p.createdAt}" pattern="HH:mm"/></small>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/blog-post/edit/${p.id}"
                                           class="btn btn-sm btn-warning" title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/blog-post/toggle-status/${p.id}"
                                           class="btn btn-sm btn-info" title="Đổi trạng thái">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/blog-post/delete/${p.id}"
                                           class="btn btn-sm btn-danger" title="Xóa"
                                           onclick="return confirm('Xóa bài viết [${p.title}]?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
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