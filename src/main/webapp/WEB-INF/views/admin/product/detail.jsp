<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
    body {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* Header đồng bộ */
    .content-header {
        background: #ffffff;
        padding: 2rem 0 1.5rem;
        margin-bottom: 1.5rem;
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

    .product-detail-wrapper {
        margin-bottom: 5rem;
    }

    .card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 25px rgba(0,0,0,0.08);
        border: none;
        overflow: hidden;
    }

    .card-header {
        background: white;
        padding: 1.5rem 2rem;
        border-bottom: 2px solid #e3e6f0;
    }

    .card-title {
        color: #2d3748;
        font-size: 1.3rem;
        font-weight: 600;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .card-body {
        padding: 2rem;
    }

    /* Layout chính - 2 cột */
    .detail-main-layout {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 2rem;
    }

    /* Cột trái - Hình ảnh */
    .images-column {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .main-image-wrapper {
        background: #f8f9fc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 1.5rem;
        text-align: center;
    }

    .main-image-wrapper img {
        max-width: 100%;
        height: auto;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .additional-images {
        background: #f8f9fc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 1.5rem;
    }

    .additional-images-title {
        font-weight: 600;
        color: #2d3748;
        margin-bottom: 1rem;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .images-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1rem;
    }

    .image-item {
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        overflow: hidden;
        transition: all 0.3s;
        background: white;
    }

    .image-item:hover {
        border-color: #4e73df;
        box-shadow: 0 4px 12px rgba(78,115,223,0.2);
        transform: translateY(-2px);
    }

    .image-item img {
        width: 100%;
        height: 100px;
        object-fit: cover;
        display: block;
    }

    .no-images {
        text-align: center;
        padding: 2rem;
        color: #718096;
        font-style: italic;
    }

    /* Cột phải - Thông tin */
    .info-column {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .info-section {
        background: #f8f9fc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 1.5rem;
    }

    .info-section-title {
        font-weight: 600;
        color: #2d3748;
        margin-bottom: 1rem;
        font-size: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding-bottom: 0.75rem;
        border-bottom: 2px solid #e2e8f0;
    }

    .product-name {
        font-size: 1.5rem;
        font-weight: 700;
        color: #2d3748;
        margin-bottom: 1rem;
        line-height: 1.3;
    }

    .info-row {
        display: flex;
        align-items: flex-start;
        padding: 0.75rem 0;
        border-bottom: 1px solid #e2e8f0;
    }

    .info-row:last-child {
        border-bottom: none;
    }

    .info-label {
        min-width: 130px;
        font-weight: 600;
        color: #4a5568;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .info-value {
        flex: 1;
        color: #2d3748;
        font-size: 0.95rem;
    }

    .badge {
        padding: 0.4rem 0.8rem;
        border-radius: 6px;
        font-weight: 600;
        font-size: 0.85rem;
    }

    .badge-success {
        background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
        color: white;
    }

    .badge-danger {
        background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        color: white;
    }

    /* Giá sản phẩm */
    .price-section {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        padding: 1.5rem;
        border-radius: 12px;
        color: white;
    }

    .price-label {
        font-size: 0.9rem;
        opacity: 0.9;
        margin-bottom: 0.5rem;
    }

    .price-original {
        font-size: 1.1rem;
        text-decoration: line-through;
        opacity: 0.7;
        margin-bottom: 0.25rem;
    }

    .price-sale {
        font-size: 2rem;
        font-weight: 700;
        display: flex;
        align-items: baseline;
        gap: 0.5rem;
    }

    .price-currency {
        font-size: 1.2rem;
        font-weight: 600;
    }

    .description-text {
        color: #4a5568;
        line-height: 1.6;
        font-size: 0.95rem;
        margin: 0;
    }

    /* Card footer - Nút hành động */
    .card-footer {
        background: white;
        padding: 1.5rem 2rem;
        border-top: 2px solid #e3e6f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .btn {
        padding: 0.75rem 2rem;
        border-radius: 10px;
        font-weight: 600;
        font-size: 0.95rem;
        min-width: 130px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        transition: all 0.3s;
        text-decoration: none;
        border: none;
        cursor: pointer;
    }

    .btn-warning {
        background: linear-gradient(135deg, #f6c23e 0%, #dda20a 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(246,194,62,0.3);
    }

    .btn-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(246,194,62,0.4);
        color: white;
    }

    .btn-secondary {
        background: #e2e8f0;
        color: #4a5568;
        border: 2px solid #cbd5e0;
    }

    .btn-secondary:hover {
        background: #cbd5e0;
        transform: translateY(-2px);
        color: #2d3748;
    }

    /* Responsive */
    @media (max-width: 992px) {
        .detail-main-layout {
            grid-template-columns: 1fr;
        }

        .images-grid {
            grid-template-columns: repeat(4, 1fr);
        }
    }

    @media (max-width: 768px) {
        .card-body {
            padding: 1.5rem;
        }

        .images-grid {
            grid-template-columns: repeat(3, 1fr);
        }

        .card-footer {
            flex-direction: column;
            gap: 1rem;
        }

        .btn {
            width: 100%;
        }

        .price-sale {
            font-size: 1.5rem;
        }
    }

    @media (max-width: 576px) {
        .images-grid {
            grid-template-columns: repeat(2, 1fr);
        }

        .info-row {
            flex-direction: column;
            gap: 0.5rem;
        }

        .info-label {
            min-width: auto;
        }
    }

    /* Styles cho form thông số */
    .spec-row {
        display: flex;
        align-items: flex-start;
        gap: 1rem;
        margin-bottom: 1rem;
        padding: 1rem;
        background: #f8f9fc;
        border-radius: 8px;
        border: 1px solid #e2e8f0;
        position: relative;
    }

    .spec-row .remove-btn {
        position: absolute;
        top: 5px;
        right: 5px;
        background: #e74c3c;
        color: white;
        border: none;
        border-radius: 50%;
        width: 25px;
        height: 25px;
        cursor: pointer;
        font-size: 18px;
        line-height: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: background 0.3s;
    }

    .spec-row .remove-btn:hover {
        background: #c0392b;
    }

    .spec-row .input-pair {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
        flex: 1;
        padding-right: 35px;
    }

    @media (max-width: 768px) {
        .spec-row .input-pair {
            grid-template-columns: 1fr;
        }
    }

    /* Color preview */
    .color-preview {
        display: inline-block;
        width: 30px;
        height: 30px;
        border: 1px solid #ddd;
        border-radius: 4px;
        vertical-align: middle;
        margin-right: 5px;
    }
</style>

<script>
    // Set background color cho color preview
    document.addEventListener('DOMContentLoaded', function() {
        var colorPreviews = document.querySelectorAll('.color-preview[data-color]');
        colorPreviews.forEach(function(preview) {
            var color = preview.getAttribute('data-color');
            if (color) {
                preview.style.backgroundColor = color;
            }
        });
    });
</script>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-info-circle mr-2"></i>Chi tiết sản phẩm</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home"><i class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-product">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Chi tiết sản phẩm -->
<section class="content">
    <div class="container-fluid">
        <div class="product-detail-wrapper">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>
                        Thông tin chi tiết sản phẩm
                    </h3>
                </div>

                <div class="card-body">
                    <div class="detail-main-layout">
                        <!-- CỘT TRÁI - Hình ảnh -->
                        <div class="images-column">
                            <!-- Ảnh chính -->
                            <div class="main-image-wrapper">
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <img src="${pageContext.request.contextPath}${product.image}"
                                             alt="Ảnh chính sản phẩm"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-images">
                                            <i class="fas fa-image" style="font-size: 3rem; color: #cbd5e0; margin-bottom: 1rem;"></i>
                                            <p>Không có ảnh chính</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Các ảnh phụ -->
                            <div class="additional-images">
                                <div class="additional-images-title">
                                    <i class="fas fa-images"></i>
                                    Ảnh sản phẩm khác
                                </div>
                                <c:choose>
                                    <c:when test="${not empty product.images}">
                                        <div class="images-grid">
                                            <c:forEach var="img" items="${product.images}">
                                                <div class="image-item">
                                                    <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                                         alt="Ảnh sản phẩm"
                                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-images">
                                            <p>Không có ảnh phụ</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- CỘT PHẢI - Thông tin -->
                        <div class="info-column">
                            <!-- Thông tin cơ bản -->
                            <div class="info-section">
                                <div class="product-name">${product.name}</div>

                                <div class="info-row">
                                    <div class="info-label">
                                        <i class="fas fa-folder-open"></i>
                                        Danh mục
                                    </div>
                                    <div class="info-value">${product.categoryName}</div>
                                </div>

                                <div class="info-row">
                                    <div class="info-label">
                                        <i class="fas fa-tag"></i>
                                        Alias
                                    </div>
                                    <div class="info-value">${product.alias}</div>
                                </div>

                                <div class="info-row">
                                    <div class="info-label">
                                        <i class="fas fa-toggle-on"></i>
                                        Trạng thái
                                    </div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${product.active}">
                                                <span class="badge badge-success">
                                                    <i class="fas fa-check-circle"></i> Đang hoạt động
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">
                                                    <i class="fas fa-times-circle"></i> Ngừng kinh doanh
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="info-row">
                                    <div class="info-label">
                                        <i class="fas fa-boxes"></i>
                                        Tồn kho
                                    </div>
                                    <div class="info-value">
                                        <strong style="color: #1cc88a; font-size: 1.1rem;">${product.stock}</strong> sản phẩm
                                    </div>
                                </div>

                                <div class="info-row">
                                    <div class="info-label">
                                        <i class="fas fa-calendar-alt"></i>
                                        Ngày tạo
                                    </div>
                                    <div class="info-value">
                                        <fmt:formatDate value="${product.createdDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </div>
                                </div>
                            </div>

                            <!-- Mô tả -->
                            <div class="info-section">
                                <div class="info-section-title">
                                    <i class="fas fa-align-left"></i>
                                    Mô tả sản phẩm
                                </div>
                                <c:choose>
                                    <c:when test="${not empty product.description}">
                                        <p class="description-text">${product.description}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="description-text" style="font-style: italic; color: #95a5a6;">
                                            Chưa có mô tả cho sản phẩm này
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Giá sản phẩm -->
                            <div class="price-section">
                                <div class="price-label">
                                    <i class="fas fa-tag"></i> Giá sản phẩm
                                </div>
                                <div class="price-original">
                                    <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> VNĐ
                                </div>
                                <div class="price-sale">
                                    <span><fmt:formatNumber value="${product.priceSale}" type="number" groupingUsed="true" /></span>
                                    <span class="price-currency">VNĐ</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <a href="${pageContext.request.contextPath}/admin-product" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-product/edit/${product.id}" class="btn btn-warning">
                        <i class="fas fa-edit"></i>
                        Chỉnh sửa sản phẩm
                    </a>
                </div>
            </div>
        </div>

        <!-- Variants & Specifications -->
        <div class="row">
            <!-- New Variant Structure -->
            <c:if test="${product.hasVariants}">
                <!-- Colors -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-palette mr-2"></i>
                                Màu sắc
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Tên màu</th>
                                        <th>Mã màu</th>
                                        <th>Ảnh</th>
                                        <th class="text-center">Xóa</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty colors}">
                                            <c:forEach var="c" items="${colors}">
                                                <tr>
                                                    <td>${c.colorName}</td>
                                                    <td>
                                                        <c:if test="${not empty c.colorCode}">
                                                            <span class="color-preview" data-color="<c:out value='${c.colorCode}'/>"></span>
                                                            <c:out value="${c.colorCode}"/>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:set var="colorImages" value="${product.images}" />
                                                        <c:set var="hasColorImages" value="false" />
                                                        <c:forEach var="img" items="${product.images}">
                                                            <c:if test="${img.colorId != null && img.colorId == c.id}">
                                                                <c:set var="hasColorImages" value="true" />
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:choose>
                                                            <c:when test="${hasColorImages}">
                                                                <div style="display: flex; gap: 5px; flex-wrap: wrap;">
                                                                    <c:forEach var="img" items="${product.images}">
                                                                        <c:if test="${img.colorId != null && img.colorId == c.id}">
                                                                            <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                                                                 alt="${c.colorName}"
                                                                                 style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd;"
                                                                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có ảnh</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <a href="${pageContext.request.contextPath}/admin-product/${product.id}/color/${c.id}/delete"
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Xóa màu này?');">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4" class="text-center text-muted">Chưa có màu nào</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <hr>
                            <h6 class="mb-3"><i class="fas fa-plus-circle"></i> Thêm màu</h6>
                            <form action="${pageContext.request.contextPath}/admin-product/${product.id}/color" method="post">
                                <div class="form-group">
                                    <label>Tên màu</label>
                                    <input type="text" name="colorName" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Mã màu (hex)</label>
                                    <input type="text" name="colorCode" class="form-control" placeholder="#000000">
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-save"></i> Thêm màu
                                </button>
                            </form>
                            <hr>
                            <hr>
                            <h6 class="mb-3"><i class="fas fa-image"></i> Upload ảnh theo màu</h6>

                            <form id="colorImageForm"
                                  method="post"
                                  enctype="multipart/form-data"
                                  class="p-3"
                                  style="border: 1px solid #e2e8f0; border-radius: 8px; background: #f8f9fc;">

                                <div class="form-group">
                                    <label>Màu sắc <span class="text-danger">*</span></label>
                                    <select id="colorSelect" class="form-control" required>
                                        <option value="">-- Chọn màu --</option>
                                        <c:forEach var="c" items="${colors}">
                                            <option value="${c.id}">${c.colorName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label>Ảnh sản phẩm</label>
                                    <input type="file"
                                           name="colorImages"
                                           class="form-control"
                                           multiple
                                           accept="image/*"
                                           required>
                                </div>

                                <button type="submit" class="btn btn-primary btn-sm">
                                    <i class="fas fa-upload"></i> Upload ảnh
                                </button>
                            </form>


                        </div>
                    </div>
                </div>

                <!-- RAM/ROM -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-memory mr-2"></i>
                                RAM/ROM
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>RAM</th>
                                        <th>ROM</th>
                                        <th class="text-center">Xóa</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty ramRoms}">
                                            <c:forEach var="rr" items="${ramRoms}">
                                                <tr>
                                                    <td>${rr.ram}</td>
                                                    <td>${rr.rom}</td>
                                                    <td class="text-center">
                                                        <a href="${pageContext.request.contextPath}/admin-product/${product.id}/ramrom/${rr.id}/delete"
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Xóa cấu hình này?');">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3" class="text-center text-muted">Chưa có cấu hình nào</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <hr>
                            <h6 class="mb-3"><i class="fas fa-plus-circle"></i> Thêm cấu hình</h6>
                            <form action="${pageContext.request.contextPath}/admin-product/${product.id}/ramrom" method="post">
                                <div class="form-group">
                                    <label>RAM</label>
                                    <input type="text" name="ram" class="form-control" placeholder="Ví dụ: 8GB" required>
                                </div>
                                <div class="form-group">
                                    <label>ROM</label>
                                    <input type="text" name="rom" class="form-control" placeholder="Ví dụ: 128GB" required>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-save"></i> Thêm cấu hình
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Variants New -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fas fa-random mr-2"></i>
                                Phiên bản
                            </h3>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Màu</th>
                                        <th>RAM/ROM</th>
                                        <th>Giá</th>
                                        <th>Giá KM</th>
                                        <th>Tồn</th>
                                        <th class="text-center">Xóa</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty variantsNew}">
                                            <c:forEach var="v" items="${variantsNew}">
                                                <tr>
                                                    <td>${v.color.colorName}</td>
                                                    <td>${v.ramRom.ram}/${v.ramRom.rom}</td>
                                                    <td><fmt:formatNumber value="${v.price}" type="number"/></td>
                                                    <td><fmt:formatNumber value="${v.priceSale}" type="number"/></td>
                                                    <td class="text-center">${v.stock}</td>
                                                    <td class="text-center">
                                                        <a href="${pageContext.request.contextPath}/admin-product/${product.id}/variant-new/${v.id}/delete"
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Xóa variant này?');">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="text-center text-muted">Chưa có variant nào</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <hr>
                            <h6 class="mb-3"><i class="fas fa-plus-circle"></i> Thêm variant</h6>
                            <form action="${pageContext.request.contextPath}/admin-product/${product.id}/variant-new" method="post">
                                <div class="form-group">
                                    <label>Màu sắc</label>
                                    <select name="colorId" class="form-control" required>
                                        <option value="">-- Chọn màu --</option>
                                        <c:forEach var="c" items="${colors}">
                                            <option value="${c.id}">${c.colorName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>RAM/ROM</label>
                                    <select name="ramRomId" class="form-control" required>
                                        <option value="">-- Chọn cấu hình --</option>
                                        <c:forEach var="rr" items="${ramRoms}">
                                            <option value="${rr.id}">${rr.ram}/${rr.rom}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Giá</label>
                                    <input type="number" name="price" class="form-control" min="0" step="0.01" required>
                                </div>
                                <div class="form-group">
                                    <label>Giá KM</label>
                                    <input type="number" name="priceSale" class="form-control" min="0" step="0.01">
                                </div>
                                <div class="form-group">
                                    <label>Tồn kho</label>
                                    <input type="number" name="stock" class="form-control" min="0" required>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-save"></i> Thêm variant
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Specifications -->
            <div class="col-md-${product.hasVariants ? '12' : '5'}">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-list-alt mr-2"></i>
                            Thông số kỹ thuật
                        </h3>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>Thuộc tính</th>
                                    <th>Giá trị</th>
                                    <th class="text-center">Xóa</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty specs}">
                                        <c:forEach var="s" items="${specs}">
                                            <tr>
                                                <td>${s.key}</td>
                                                <td>${s.value}</td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/admin-product/${product.id}/specification/${s.id}/delete"
                                                       class="btn btn-sm btn-danger"
                                                       onclick="return confirm('Xóa thông số này?');">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="3" class="text-center text-muted">Chưa có thông số nào</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <hr>
                        <h6 class="mb-3">
                            <i class="fas fa-list-alt"></i> Thông số kỹ thuật (1 dòng)
                        </h6>

                        <form action="${pageContext.request.contextPath}/admin-product/${product.id}/specifications"
                              method="post">

                            <div class="row">
                                <div class="col-md-4">
                                    <label>Màn hình</label>
                                    <input type="text" name="specs[Màn hình]" class="form-control" placeholder="6.7 inch LTPO">
                                </div>

                                <div class="col-md-4">
                                    <label>Chip</label>
                                    <input type="text" name="specs[Chip]" class="form-control" placeholder="Snapdragon 8 Gen 2">
                                </div>

                                <div class="col-md-4">
                                    <label>RAM</label>
                                    <input type="text" name="specs[RAM]" class="form-control" placeholder="8GB">
                                </div>

                                <div class="col-md-4 mt-2">
                                    <label>ROM</label>
                                    <input type="text" name="specs[ROM]" class="form-control" placeholder="256GB">
                                </div>

                                <div class="col-md-4 mt-2">
                                    <label>Pin</label>
                                    <input type="text" name="specs[Pin]" class="form-control" placeholder="5000mAh">
                                </div>

                                <div class="col-md-4 mt-2">
                                    <label>Camera</label>
                                    <input type="text" name="specs[Camera]" class="form-control" placeholder="50MP">
                                </div>
                            </div>

                            <button type="submit" class="btn btn-success mt-3">
                                <i class="fas fa-save"></i> Lưu toàn bộ thông số
                            </button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    // Biến đếm để tạo ID duy nhất cho các dòng thông số
    var specCounter = 0;

    // Thêm dòng thông số mới
    function addSpecRow() {
        specCounter++;
        var container = document.getElementById('specsContainer');
        var html = `
            <div class="spec-row" id="spec-row-${specCounter}">
                <button type="button" class="remove-btn" onclick="removeSpecRow(${specCounter})" title="Xóa dòng này">×</button>
                <div class="input-pair">
                    <div class="form-group">
                        <label>Tên thông số <span class="text-danger">*</span></label>
                        <input type="text" name="specs[${specCounter}].key" class="form-control" placeholder="Ví dụ: Màn hình" required />
                    </div>
                    <div class="form-group">
                        <label>Giá trị <span class="text-danger">*</span></label>
                        <input type="text" name="specs[${specCounter}].value" class="form-control" placeholder="Ví dụ: 6.7 inch LTPO" required />
                    </div>
                </div>
            </div>
        `;
        container.insertAdjacentHTML('beforeend', html);
    }

    // Xóa dòng thông số
    function removeSpecRow(id) {
        var row = document.getElementById('spec-row-' + id);
        if (row) {
            row.remove();
        }
    }

    // Tự động thêm một dòng khi trang load
    document.addEventListener('DOMContentLoaded', function() {
        addSpecRow();
    });
    document.getElementById("colorImageForm").addEventListener("submit", function (e) {
        var colorId = document.getElementById("colorSelect").value;

        if (!colorId) {
            alert("Vui lòng chọn màu trước khi upload!");
            e.preventDefault();
            return;
        }

        this.action =
            "${pageContext.request.contextPath}/admin-product/${product.id}/color/" +
            colorId +
            "/images";
    });
</script>