<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<style>
    /* Đảm bảo body có min-height và padding-bottom */
    body.hold-transition {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .content-wrapper {
        flex: 1;
        padding-bottom: 60px; /* Chiều cao footer + thêm margin */
        min-height: calc(100vh - 57px - 60px); /* Trừ header và footer */
    }

    .content-header {
        background: #ffffff;
        padding: 1.5rem 0;
        margin-bottom: 1.5rem;
        border-radius: 0 0 12px 12px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    .content-header h1 {
        color: #1a202c;
        font-weight: 600;
        font-size: 1.75rem;
        margin: 0;
    }

    .breadcrumb {
        background: transparent;
        margin: 0;
        padding: 0;
    }

    .breadcrumb-item a {
        color: #4a5568;
        text-decoration: none;
        transition: color 0.3s;
    }

    .breadcrumb-item a:hover {
        color: #2d3748;
    }

    .breadcrumb-item.active {
        color: #718096;
    }

    .breadcrumb-item + .breadcrumb-item::before {
        color: #a0aec0;
    }

    .content {
        padding-bottom: 4rem; /* Tăng padding-bottom */
    }

    .card {
        border: none;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        margin-bottom: 4rem; /* Tăng margin-bottom */
    }

    .card-header {
        background: white;
        border-bottom: 2px solid #e3e6f0;
        padding: 1.75rem 2rem; /* Tăng padding ngang */
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-radius: 16px 16px 0 0;
        gap: 2rem;
    }

    .card-title {
        color: #2d3748;
        font-weight: 600;
        font-size: 1.25rem;
        margin: 0;
        flex: 1;
    }


    .card-body {
        padding: 0;
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

    .category-name {
        font-weight: 600;
        color: #1a202c;
    }

    .parent-badge {
        background: #edf2f7;
        color: #4e73df;
        padding: 0.35rem 0.7rem;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 500;
        display: inline-block;
    }

    .no-parent {
        color: #a0aec0;
        font-style: italic;
    }

    .category-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        border: 2px solid #e2e8f0;
    }

    .no-image {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 80px;
        height: 80px;
        background: #f7fafc;
        border: 2px dashed #cbd5e0;
        border-radius: 8px;
        color: #a0aec0;
        font-size: 0.85rem;
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

    .btn-primary.btn-sm {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
    }

    .btn-primary.btn-sm:hover {
        background: linear-gradient(135deg, #2e59d9 0%, #1a3da8 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(78, 115, 223, 0.4);
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

    .description-cell {
        max-width: 250px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .description-cell:hover {
        white-space: normal;
        overflow: visible;
    }

    /* Fix footer luôn ở dưới cùng */
    .main-footer {
        margin-top: auto;
        position: relative;
        z-index: 1;
    }
    .pagination .page-item.active .page-link {
        background-color: #4e73df;
        border-color: #4e73df;
        color: white;
        box-shadow: 0 0 10px rgba(78,115,223,0.4);
    }

    .pagination .page-link {
        color: #4e73df;
    }

</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý danh mục</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý danh mục</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách danh mục</h3>
                <div class="card-tools">
                    <a href="<c:url value='/admin-category-add'/>" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Thêm danh mục
                    </a>
                </div>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                        <tr>
                            <th width="70">STT</th>
                            <th>Tên danh mục</th>
                            <th width="180">Danh mục cha</th>
                            <th>Mô tả</th>
                            <th width="120">Hình ảnh</th>
                            <th width="130">Ngày tạo</th>
                            <th width="160">Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${listCategory}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <span class="category-name">
                                        <i class="fas fa-folder text-warning"></i>
                                        ${item.name}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty item.parentName}">
                                            <span class="parent-badge">
                                                <i class="fas fa-folder-open"></i>
                                                ${item.parentName}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="no-parent">Không có</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="description-cell" title="${item.description}">
                                            ${item.description}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty item.image}">
                                            <img src="${pageContext.request.contextPath}${item.image}"
                                                 class="category-image"
                                                 alt="${item.name}" />
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-image">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="date-cell">
                                    <i class="far fa-calendar"></i>
                                        ${item.createdDate}
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="<c:url value='/admin-category-edit/${item.id}'/>"
                                           class="btn btn-sm btn-primary" title="Sửa">
                                            <i class="fas fa-edit"></i> Sửa
                                        </a>
                                        <a href="<c:url value='/admin-category-delete/${item.id}'/>"
                                           class="btn btn-sm btn-danger" title="Xóa"
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listCategory}">
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">
                                            <i class="fas fa-folder-open"></i>
                                        </div>
                                        <p class="empty-state-text">
                                            Không có danh mục nào
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                    <!-- Pagination -->
                    <c:if test="${totalPage >= 1 && totalItem > 0}">
                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-center">

                                <!-- Nút Previous -->
                                <li class="page-item <c:if test='${page == 1}'>disabled</c:if>'">
                                    <a class="page-link"
                                       href="?page=${page - 1}&limit=${limit}">
                                        Trước
                                    </a>
                                </li>

                                <!-- Danh sách số trang -->
                                <c:forEach var="i" begin="1" end="${totalPage}">
                                    <li class="page-item <c:if test='${i == page}'>active</c:if>'">
                                        <a class="page-link"
                                           href="?page=${i}&limit=${limit}">
                                                ${i}
                                        </a>
                                    </li>
                                </c:forEach>

                                <!-- Nút Next -->
                                <li class="page-item <c:if test='${page == totalPage}'>disabled</c:if>'">
                                    <a class="page-link"
                                       href="?page=${page + 1}&limit=${limit}">
                                        Sau
                                    </a>
                                </li>

                            </ul>
                        </nav>
                    </c:if>

                </div>
            </div>
        </div>
    </div>
</section>