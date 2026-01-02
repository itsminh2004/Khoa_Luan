<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
    /* Đồng bộ 100% với trang Quản lý Danh mục */
    .content-header {
        background: #ffffff;
        padding: 2.5rem 0;
        margin-bottom: 2rem;
        border-radius: 0 0 20px 20px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .content-header h1 {
        color: #1a202c;
        font-weight: 600;
        margin: 0;
        font-size: 1.75rem;
    }
    .breadcrumb-item a {
        color: #4a5568; text-decoration: none;
    }
    .breadcrumb-item a:hover {
        color: #2d3748;
    }
    .breadcrumb-item.active {
        color: #718096;
    }

    .content-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        overflow: hidden;
        margin-bottom: 3rem;
    }
    .content-header-card {
        background: white;
        padding: 1.75rem 2rem;
        border-bottom: 2px solid #e3e6f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .content-header-card h3 {
        color: #2d3748;
        font-weight: 600;
        font-size: 1.25rem;
        margin: 0;
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

    .series-name {
        font-weight: 600;
        color: #1a202c;
    }
    .category-badge {
        background: #edf2f7;
        color: #4e73df;
        padding: 0.35rem 0.7rem;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 500;
        display: inline-block;
    }
    .no-category {
        color: #a0aec0;
        font-style: italic;
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
        box-shadow: 0 2px 4px rgba(78, 115, 223, 0.3);
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
    }
    .btn-danger {
        background: linear-gradient(135deg, #e74a3b 0%, #be2617 100%);
        color: white;
    }
    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(231, 74, 59, 0.4);
        background: linear-gradient(135deg, #d52a1a 0%, #a02114 100%);
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
    }
    .btn-sm {
        padding: 0.45rem 0.85rem;
        border-radius: 6px;
        font-size: 0.875rem;
    }

    .empty-state {
        padding: 3rem 2rem;
        text-align: center;
        color: #a0aec0;
    }
    .empty-state-icon {
        font-size: 4rem;
        color: #cbd5e0;
        margin-bottom: 1rem;
    }
</style>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <h1>Quản lý Series</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Series</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Content -->
<section class="content">
    <div class="container-fluid">
        <div class="content-card">
            <div class="content-header-card">
                <h3>Danh sách Series</h3>
                <a href="${pageContext.request.contextPath}/admin-series-add" class="btn btn-success">
                    <i class="fas fa-plus"></i> Thêm mới
                </a>
            </div>

            <div class="p-0">
                <div class="table-responsive">
                    <table class="table mb-0">
                        <thead>
                        <tr>
                            <th width="70">ID</th>
                            <th>Tên Series</th>
                            <th width="180">Danh mục</th>
                            <th width="160">Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${seriesList}" varStatus="status">
                            <tr>
                                <td>${s.id}</td>
                                <td>
                                        <span class="series-name">
                                            <i class="fas fa-layer-group text-success"></i>
                                            ${s.name}
                                        </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty s.categoryId && s.categoryId != 0}">
                                                <span class="category-badge">
                                                    <i class="fas fa-folder"></i> ID: ${s.categoryId}
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="no-category">Chưa chọn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin-series/edit/${s.id}"
                                           class="btn btn-sm btn-primary" title="Sửa">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin-series/delete/${s.id}"
                                           class="btn btn-sm btn-danger" title="Xóa"
                                           onclick="return confirm('Bạn có chắc muốn xóa Series \"${s.name}\" không?')">
                                        <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty seriesList}">
                            <tr>
                                <td colspan="4">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">
                                            <i class="fas fa-layer-group"></i>
                                        </div>
                                        <p class="empty-state-text">
                                            Không có Series nào
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>