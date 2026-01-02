<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
    body {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    .content-header {
        background: #ffffff;
        padding: 2.5rem 0 2rem;
        margin-bottom: 10px;
        border-radius: 0 0 20px 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    .content-header h1 {
        color: #1a202c;
        font-weight: 600;
        font-size: 1.8rem;
        margin: 0;
    }
    .breadcrumb-item a {
        color: #4a5568;
        text-decoration: none;
        transition: color 0.2s;
    }
    .breadcrumb-item a:hover { color: #2d3748; }
    .breadcrumb-item.active { color: #718096; }

    .content-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 25px rgba(0,0,0,0.08);
        overflow: hidden;
        margin-bottom: 5rem;
    }
    .card-header-custom {
        background: white;
        padding: 1.5rem 2rem;
        border-bottom: 2px solid #e3e6f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 1rem;
    }
    .card-header-custom h3 {
        margin: 0;
        color: #2d3748;
        font-weight: 600;
        font-size: 1.3rem;
    }

    /* Search box đẹp hơn */
    .search-container {
        padding: 1rem 2rem;
        background: #f8f9fc;
        border-bottom: 1px solid #e3e6f0;
    }
    .search-form {
        display: flex;
        max-width: 500px;
        position: relative;
    }
    .search-form input {
        flex: 1;
        padding: 0.85rem 1.2rem;
        padding-right: 3rem;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        font-size: 0.95rem;
        transition: all 0.3s;
        background: white;
    }
    .search-form input:focus {
        outline: none;
        border-color: #4e73df;
        box-shadow: 0 0 0 4px rgba(78,115,223,0.1);
    }
    .search-form button {
        position: absolute;
        right: 4px;
        top: 50%;
        transform: translateY(-50%);
        padding: 0.6rem 1.5rem;
        background: #4e73df;
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s;
    }
    .search-form button:hover {
        background: #2d68c4;
    }
    .search-form button i {
        margin-right: 0.3rem;
    }

    /* Bảng responsive tốt hơn */
    .table-container {
        overflow-x: auto;
        padding: 0;
    }
    .table {
        margin-bottom: 0;
        min-width: 1400px;
    }
    .table thead th {
        background: #f8f9fc;
        color: #4a5568;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.6px;
        border: none;
        padding: 0.95rem 0.8rem;
        white-space: nowrap;
        position: sticky;
        top: 0;
        z-index: 10;
    }
    .table tbody tr {
        transition: all 0.2s;
        border-bottom: 1px solid #f0f0f0;
    }
    .table tbody tr:hover {
        background: #f8f9fc;
        transform: translateX(2px);
        box-shadow: -3px 0 0 0 #4e73df;
    }
    .table tbody td {
        padding: 0.85rem 0.8rem;
        vertical-align: middle;
        color: #2d3748;
        font-size: 0.94rem;
    }

    /* Hình ảnh sản phẩm */
    .product-img-wrapper {
        position: relative;
        display: inline-block;
    }
    .product-img {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 10px;
        border: 2px solid #e2e8f0;
        transition: all 0.3s;
    }

    /* Mô tả */
    .description-cell {
        max-width: 200px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        color: #718096;
        font-size: 0.9rem;
    }

    /* Trạng thái */
    .status-badge {
        display: inline-block;
        padding: 0.35rem 0.75rem;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        white-space: nowrap;
    }
    .status-active {
        background: #d4edda;
        color: #155724;
    }
    .status-inactive {
        background: #f8d7da;
        color: #721c24;
    }

    /* Giá */
    .price-cell {
        font-weight: 600;
        color: #2d3748;
        white-space: nowrap;
    }
    .price-sale {
        color: #e74a3b;
    }

    /* Nút chức năng */
    .action-buttons {
        display: flex;
        gap: 0.4rem;
        flex-wrap: nowrap;
        justify-content: center;
    }
    .btn-sm {
        padding: 0.45rem 0.8rem;
        border-radius: 8px;
        font-size: 0.82rem;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s;
        white-space: nowrap;
        display: inline-flex;
        align-items: center;
        gap: 0.3rem;
    }
    .btn-edit {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
    }
    .btn-edit:hover {
        background: linear-gradient(135deg, #2e59d9 0%, #1a3da8 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(78, 115, 223, 0.4);
    }
    .btn-detail {
        background: #d1ecf1;
        color: #0c5460;
        border: 1px solid #bee5eb;
    }
    .btn-detail:hover {
        background: #bee5eb;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(12,84,96,0.2);
    }
    .btn-delete {
        background: linear-gradient(135deg, #e74a3b 0%, #be2617 100%);
        color: white;
    }
    .btn-delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(231, 74, 59, 0.4);
        background: linear-gradient(135deg, #d52a1a 0%, #a02114 100%);
        color: white;
    }

    /* Nút thêm mới */
    .btn-add-new {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
        padding: 0.75rem 2rem;
        border-radius: 12px;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        box-shadow: 0 4px 8px rgba(78, 115, 223, 0.4);
        transition: all 0.3s;
    }
    .btn-add-new:hover {
        background: linear-gradient(135deg, #2e59d9 0%, #1a3da8 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(78, 115, 223, 0.4);
    }
    .btn-add-new i {
        font-size: 1.1rem;
    }

    /* Trạng thái trống */
    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: #a0aec0;
    }
    .empty-state i {
        font-size: 4.5rem;
        color: #cbd5e0;
        margin-bottom: 1rem;
    }
    .empty-state h5 {
        color: #4a5568;
        margin: 1rem 0 0.5rem;
    }
    .empty-state p {
        margin-bottom: 1.5rem;
    }

    /* Alias code */
    .alias-code {
        background: #f7fafc;
        padding: 0.4rem 0.8rem;
        border-radius: 6px;
        font-family: 'Courier New', monospace;
        font-size: 0.85rem;
        color: #4a5568;
        border: 1px solid #e2e8f0;
        display: inline-block;
        max-width: 150px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        vertical-align: middle;
    }

    /* Stats summary (tùy chọn thêm) */
    .stats-summary {
        display: flex;
        gap: 1rem;
        padding: 1rem 2rem;
        background: #f8f9fc;
        border-bottom: 1px solid #e3e6f0;
    }
    .stat-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        background: white;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
    }
    .stat-item i {
        font-size: 1.2rem;
        color: #4e73df;
    }
    .stat-item .stat-value {
        font-weight: 600;
        color: #2d3748;
    }
    .stat-item .stat-label {
        font-size: 0.85rem;
        color: #718096;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .card-header-custom {
            flex-direction: column;
            align-items: flex-start;
        }
        .search-form {
            max-width: 100%;
        }
        .table-container {
            margin: 0 -1rem;
        }
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

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-box-open mr-2"></i>Danh sách sản phẩm</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home"><i class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item active">Sản phẩm</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Content -->
<section class="content">
    <div class="container-fluid">
        <div class="content-card">
            <div class="card-header-custom">
                <h3><i class="fas fa-list mr-2"></i>Danh sách sản phẩm</h3>
                <a href="${pageContext.request.contextPath}/admin-product-add" class="btn-add-new">
                    <i class="fas fa-plus"></i>
                    Thêm sản phẩm mới
                </a>
            </div>

            <!-- Search -->
            <div class="search-container">
                <form method="get" action="" class="search-form">
                    <input type="text"
                           name="Name"
                           placeholder="🔍 Tìm kiếm tên sản phẩm..."
                           value="${param.Name}"
                           autocomplete="off"/>
                    <button type="submit">
                        <i class="fas fa-search"></i>
                        Tìm
                    </button>
                </form>
            </div>

            <!-- Table -->
            <div class="table-container">
                <table class="table">
                    <thead>
                    <tr>
                        <th width="60" class="text-center">STT</th>
                        <th width="200">Tên sản phẩm</th>
                        <th width="120">Danh mục</th>
                        <th width="120">Series</th>
                        <th width="180">Mô tả</th>
                        <th width="80" class="text-center">Số lượng</th>
                        <th width="90" class="text-center">Hình ảnh</th>
                        <th width="110" class="text-right">Giá gốc</th>
                        <th width="110" class="text-right">Giá KM</th>
                        <th width="110" class="text-center">Ngày tạo</th>
                        <th width="120">Alias</th>
                        <th width="90" class="text-center">Trạng thái</th>
                        <th width="200" class="text-center">Chức năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="item" items="${products}" varStatus="status">
                                <tr>
                                    <td class="text-center">
                                        <strong>${status.index + 1}</strong>
                                    </td>
                                    <td>
                                        <strong>${item.name}</strong>
                                    </td>
                                    <td>${item.categoryName}</td>
                                    <td>${item.seriesName}</td>
                                    <td>
                                        <div class="description-cell" title="${item.description}">
                                                ${item.description}
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <strong>${item.stock}</strong>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty item.image}">
                                                <div class="product-img-wrapper">
                                                    <img src="${pageContext.request.contextPath}${item.image}"
                                                         class="product-img"
                                                         alt="${item.name}"/>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <small class="text-muted">
                                                    <i class="fas fa-image"></i> Không có
                                                </small>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-right price-cell">
                                        <fmt:formatNumber value="${item.price}" type="number"/> đ
                                    </td>
                                    <td class="text-right price-cell price-sale">
                                        <fmt:formatNumber value="${item.priceSale}" type="number"/> đ
                                    </td>
                                    <td class="text-center">
                                        <small>
                                            <i class="far fa-calendar-alt"></i>
                                            <fmt:formatDate value="${item.createdDate}" pattern="dd/MM/yyyy"/>
                                        </small>
                                    </td>
                                    <td>
                                        <code class="alias-code">${item.alias}</code>
                                    </td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${item.active}">
                                                    <span class="status-badge status-active">
                                                        <i class="fas fa-eye"></i> Hiển thị
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                    <span class="status-badge status-inactive">
                                                        <i class="fas fa-eye-slash"></i> Ẩn
                                                    </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin-product-edit/${item.id}"
                                               class="btn-sm btn-edit"
                                               title="Chỉnh sửa sản phẩm">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin-product-detail/${item.id}"
                                               class="btn-sm btn-detail"
                                               title="Xem chi tiết">
                                                <i class="fas fa-info-circle"></i> Chi tiết
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin-product/delete/${item.id}"
                                               class="btn-sm btn-delete"
                                               onclick="return confirm('⚠️ Bạn có chắc chắn muốn xóa sản phẩm \"${item.name}\" không?\n\nHành động này không thể hoàn tác!')"
                                            title="Xóa sản phẩm">
                                            <i class="fas fa-trash-alt"></i> Xóa
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="13">
                                    <div class="empty-state">
                                        <i class="fas fa-box-open"></i>
                                        <h5>Không tìm thấy sản phẩm nào</h5>
                                        <p>
                                            <c:choose>
                                                <c:when test="${not empty param.Name}">
                                                    Không có sản phẩm nào khớp với từ khóa "<strong>${param.Name}</strong>"
                                                </c:when>
                                                <c:otherwise>
                                                    Hiện chưa có sản phẩm nào trong hệ thống
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <a href="${pageContext.request.contextPath}/admin-product-add" class="btn-add-new">
                                            <i class="fas fa-plus"></i>
                                            Thêm sản phẩm đầu tiên
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
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
</section>

<script>
    // Optional: Thêm hiệu ứng zoom ảnh khi click
    document.addEventListener('DOMContentLoaded', function() {
        const productImages = document.querySelectorAll('.product-img');

        productImages.forEach(img => {
            img.addEventListener('click', function(e) {
                e.preventDefault();
                // Có thể thêm modal để xem ảnh lớn hơn ở đây
                console.log('Image clicked:', this.src);
            });
        });
    });
</script>