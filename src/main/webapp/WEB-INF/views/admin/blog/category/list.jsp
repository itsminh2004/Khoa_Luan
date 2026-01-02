<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<style>
    .blog-category-section {
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
        margin-bottom: 2rem;
    }

    .content-header {
        background: white;
        padding: 1.75rem 2rem;
        border-bottom: 2px solid #e3e6f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .content-header h5 {
        color: #2d3748;
        font-weight: 600;
        font-size: 1.25rem;
        margin: 0;
    }

    .btn-primary {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        border: none;
        border-radius: 8px;
        padding: 0.6rem 1.5rem;
        font-weight: 500;
        color: white;
        transition: all 0.3s;
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

    .table tbody td code {
        background: #edf2f7;
        color: #4e73df;
        padding: 0.25rem 0.6rem;
        border-radius: 6px;
        font-size: 0.875rem;
        font-weight: 500;
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

    .text-muted {
        color: #a0aec0 !important;
        font-style: italic;
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
        justify-content: center;
    }
</style>

<section class="blog-category-section">
    <div class="page-header">
        <div class="container-fluid">
            <h1>Quản lý danh mục Blog</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Danh mục Blog</li>
                </ol>
            </nav>
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
            <div class="content-header">
                <h5>Danh sách danh mục</h5>
                <a href="${pageContext.request.contextPath}/admin/blog-category/add" class="tn btn-primary">
                    <i class="fas fa-plus"></i> Thêm danh mục
                </a>
            </div>
            <div class="p-0">
                <div class="table-responsive">
                    <table class="table mb-0" id="dataTable">
                        <thead>
                        <tr>
                            <th width="80">ID</th>
                            <th>Tên danh mục</th>
                            <th>Slug</th>
                            <th>Mô tả</th>
                            <th width="150">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="cat" items="${categories}">
                            <tr>
                                <td>${cat.id}</td>
                                <td><strong>${cat.name}</strong></td>
                                <td><code>${cat.slug}</code></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty cat.description}">
                                            ${cat.description}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Không có mô tả</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/blog-category/edit/${cat.id}"
                                           class="btn btn-sm btn-warning" title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/blog-category/delete/${cat.id}"
                                           class="btn btn-sm btn-danger" title="Xóa"
                                           onclick="return confirm('Xóa danh mục [${cat.name}]?')">
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