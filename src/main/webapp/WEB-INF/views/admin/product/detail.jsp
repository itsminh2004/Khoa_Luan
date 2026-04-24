<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<style>
    .product-detail-img {
        max-width: 100%;
        height: auto;
        border-radius: 8px;
        border: 1px solid #ddd;
    }

    .image-thumb {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border: 1px solid #eee;
        margin: 5px;
        border-radius: 5px;
    }

    .color-preview {
        display: inline-block;
        width: 25px;
        height: 25px;
        border: 1px solid #ccc;
        border-radius: 4px;
        vertical-align: middle;
        margin-right: 10px;
    }

    .info-label {
        font-weight: bold;
        color: #555;
        width: 150px;
        display: inline-block;
    }

    .price-original {
        text-decoration: line-through;
        color: #888;
        margin-right: 10px;
    }

    .price-sale {
        color: #d9534f;
        font-size: 1.5rem;
        font-weight: bold;
    }

    /* Description Collapse */
    .description-container {
        position: relative;
        max-height: 100px;
        overflow: hidden;
        transition: max-height 0.4s ease;
    }

    .description-container.expanded {
        max-height: 2000px; /* Large enough for most descriptions */
    }

    .description-overlay {
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 40px;
        background: linear-gradient(to bottom, transparent, #f8f9fa);
        pointer-events: none;
        transition: opacity 0.3s;
    }

    .description-container.expanded .description-overlay {
        opacity: 0;
    }

    .btn-toggle-desc {
        color: #4e73df;
        cursor: pointer;
        font-size: 0.85rem;
        font-weight: 600;
        margin-top: 5px;
        display: inline-flex;
        align-items: center;
        gap: 4px;
        transition: all 0.2s;
    }

    .btn-toggle-desc:hover {
        color: #2e59d9;
        text-decoration: underline;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var colorPreviews = document.querySelectorAll('.color-preview[data-color]');
        colorPreviews.forEach(function (preview) {
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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home"><i
                            class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-product">Sản
                        phẩm</a></li>
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
            </div>
        </div>
    </div>
    <!-- Chi tiết sản phẩm -->
    <section class="content">
        <div class="container-fluid">
            <div class="card card-outline card-primary">
                <div class="card-header">
                    <h3 class="card-title">Thông tin chi tiết sản phẩm</h3>
                    <div class="card-tools">
                        <a href="${pageContext.request.contextPath}/admin-product" class="btn btn-tool">
                            <i class="fas fa-times"></i>
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <div class="row">
                        <!-- CỘT TRÁI - Hình ảnh -->
                        <div class="col-md-5">
                            <div class="text-center mb-3">
                                <c:choose>
                                    <c:when test="${not empty product.image}">
                                        <img src="${pageContext.request.contextPath}${product.image}"
                                             class="product-detail-img shadow-sm" alt="Ảnh chính sản phẩm"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="p-5 bg-light border rounded">
                                            <i class="fas fa-image fa-3x text-muted"></i>
                                            <p class="text-muted mt-2">Không có ảnh chính</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <c:if test="${not empty product.images}">
                                <label><i class="fas fa-images"></i> Ảnh phụ:</label>
                                <div class="d-flex flex-wrap border rounded p-2 bg-light">
                                    <c:forEach var="img" items="${product.images}">
                                        <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                             class="image-thumb" alt="Ảnh sản phẩm"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

                        <!-- CỘT PHẢI - Thông tin -->
                        <div class="col-md-7">
                            <h2 class="text-primary font-weight-bold">${product.name}</h2>
                            <hr>

                            <ul class="list-group list-group-unbordered mb-3">
                                <li class="list-group-item">
                                    <b>Danh mục</b> <span class="float-right">${product.categoryName}</span>
                                </li>
                                <li class="list-group-item">
                                    <b>Thương hiệu</b>
                                    <span class="float-right">
                                                <c:choose>
                                                    <c:when test="${not empty product.brandName}">
                                                        ${product.brandName}
                                                        <c:if test="${not empty product.brandLogo}">
                                                            <img src="${pageContext.request.contextPath}${product.brandLogo}"
                                                                 style="height: 20px; margin-left:10px;">
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>N/A</c:otherwise>
                                                </c:choose>
                                            </span>
                                </li>
                                <li class="list-group-item">
                                    <b>Alias</b> <span class="float-right text-muted">${product.alias}</span>
                                </li>
                                <li class="list-group-item">
                                    <b>Trạng thái</b>
                                    <span class="float-right">
                                                <c:choose>
                                                    <c:when test="${product.active}">
                                                        <span class="badge badge-success">Đang hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">Ngừng kinh doanh</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                </li>
                                <li class="list-group-item">
                                    <b>Hàng trong kho</b> <span
                                        class="float-right text-success font-weight-bold">${product.stock}</span>
                                </li>
                                <li class="list-group-item">
                                    <b>Ngày tạo</b>
                                    <span class="float-right">
                                                <fmt:formatDate value="${product.createdDate}"
                                                                pattern="dd/MM/yyyy HH:mm" />
                                            </span>
                                </li>
                            </ul>

                            <div class="bg-light p-3 border rounded mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <h6 class="mb-0"><b><i class="fas fa-align-left"></i> Mô tả sản phẩm:</b></h6>
                                </div>
                                <div id="descWrapper" class="description-container">
                                    <div id="descContent" class="text-muted small">
                                        ${product.description}
                                    </div>
                                    <div class="description-overlay"></div>
                                </div>
                                <div id="btnDescToggle" class="btn-toggle-desc" style="display: none;">
                                    <span>Xem thêm</span>
                                    <i class="fas fa-chevron-down"></i>
                                </div>
                            </div>

                            <div class="p-3 border rounded border-danger bg-light">
                                <span class="text-muted d-block small">Giá bán lẻ:</span>
                                <span class="price-original">
                                            <fmt:formatNumber value="${product.price}" type="number" /> VNĐ
                                        </span>
                                <div class="price-sale">
                                    <fmt:formatNumber value="${product.priceSale}" type="number" /> VNĐ
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-footer text-right">
                    <a href="${pageContext.request.contextPath}/admin-product" class="btn btn-default">
                        <i class="fas fa-chevron-left"></i> Quay lại
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-product-edit/${product.id}"
                       class="btn btn-warning">
                        <i class="fas fa-edit"></i> Chỉnh sửa
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Chỉ giữ phần Variants nếu sản phẩm có biến thể -->
    <c:if test="${product.hasVariants}">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-random mr-2"></i>
                            Quản lý biến thể
                        </h3>
                    </div>
                    <div class="card-body">
                        <ul class="nav nav-tabs mb-3" id="variantTabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="variants-tab" data-toggle="tab" href="#variants"
                                   role="tab">Phiên bản</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="colors-tab" data-toggle="tab" href="#colors"
                                   role="tab">Màu sắc</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="ramrom-tab" data-toggle="tab" href="#ramrom"
                                   role="tab">RAM/ROM</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="specifications-tab" data-toggle="tab"
                                   href="#specifications" role="tab">Thông số kỹ thuật</a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <!-- Tab Phiên bản -->
                            <div class="tab-pane fade show active" id="variants">
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
                                        <tbody id="variantsTableBody">
                                        <c:choose>
                                            <c:when test="${not empty variantsNew}">
                                                <c:forEach var="v" items="${variantsNew}">
                                                    <tr>
                                                        <td>${v.color.colorName}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty v.ramRom}">
                                                                    ${v.ramRom.ram}/${v.ramRom.rom}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">—</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${v.price}"
                                                                              type="number" />
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${v.priceSale}"
                                                                              type="number" />
                                                        </td>
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
                                                    <td colspan="6" class="text-center text-muted">Chưa
                                                        có variant nào</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <hr>
                                <h6 class="mb-2"><i class="fas fa-plus-circle"></i> Thêm variant</h6>
                                <form id="variantForm"
                                      action="${pageContext.request.contextPath}/admin-product/${product.id}/variant-new"
                                      method="post">
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
                                        <label>RAM/ROM (Không bắt buộc)</label>
                                        <select name="ramRomId" class="form-control">
                                            <option value="">-- Mặc định (Không có cấu hình) --</option>
                                            <c:forEach var="rr" items="${ramRoms}">
                                                <option value="${rr.id}">${rr.ram}/${rr.rom}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá</label>
                                        <input type="number" name="price" class="form-control" min="0"
                                               step="0.01" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá KM</label>
                                        <input type="number" name="priceSale" class="form-control" min="0"
                                               step="0.01">
                                    </div>
                                    <div class="form-group">
                                        <label>Tồn kho</label>
                                        <input type="number" name="stock" class="form-control" min="0" required>
                                    </div>
                                    <button type="submit" class="btn btn-success btn-sm">
                                        <i class="fas fa-save"></i> Thêm
                                    </button>
                                </form>
                            </div>

                            <!-- Tab Màu sắc -->
                            <div class="tab-pane fade" id="colors">
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
                                        <tbody id="colorsTableBody">
                                        <c:choose>
                                            <c:when test="${not empty colors}">
                                                <c:forEach var="c" items="${colors}">
                                                    <tr>
                                                        <td>${c.colorName}</td>
                                                        <td>
                                                            <c:if test="${not empty c.colorCode}">
                                                                            <span class="color-preview"
                                                                                  data-color="<c:out value='${c.colorCode}'/>"></span>
                                                                <c:out value="${c.colorCode}" />
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <c:set var="hasColorImages" value="false" />
                                                            <c:forEach var="img" items="${product.images}">
                                                                <c:if test="${img.colorId == c.id}">
                                                                    <c:set var="hasColorImages"
                                                                           value="true" />
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:choose>
                                                                <c:when test="${hasColorImages}">
                                                                    <div
                                                                            style="display: flex; gap: 5px; flex-wrap: wrap;">
                                                                        <c:forEach var="img"
                                                                                   items="${product.images}">
                                                                            <c:if
                                                                                    test="${img.colorId == c.id}">
                                                                                <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                                                                     alt="${c.colorName}"
                                                                                     style="width: 40px; height: 40px; object-fit: cover; border-radius: 3px; border: 1px solid #ddd;" />
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                                <span class="text-muted">Chưa có
                                                                                    ảnh</span>
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
                                                    <td colspan="4" class="text-center text-muted">Chưa
                                                        có màu nào</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <hr>
                                <h6 class="mb-2"><i class="fas fa-plus-circle"></i> Thêm màu</h6>
                                <form id="colorForm"
                                      action="${pageContext.request.contextPath}/admin-product/${product.id}/color"
                                      method="post">
                                    <div class="form-group">
                                        <label>Tên màu</label>
                                        <input type="text" name="colorName" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Mã màu (hex)</label>
                                        <input type="text" name="colorCode" class="form-control"
                                               placeholder="#000000">
                                    </div>
                                    <button type="submit" class="btn btn-success btn-sm">
                                        <i class="fas fa-save"></i> Thêm
                                    </button>
                                </form>
                                <hr>
                                <h6 class="mb-2"><i class="fas fa-image"></i> Upload ảnh theo màu</h6>
                                <form id="colorImageForm" method="post" enctype="multipart/form-data">
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
                                        <input type="file" name="colorImages" class="form-control" multiple
                                               accept="image/*" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-sm">
                                        <i class="fas fa-upload"></i> Upload
                                    </button>
                                </form>
                            </div>

                            <!-- Tab RAM/ROM -->
                            <div class="tab-pane fade" id="ramrom">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                        <tr>
                                            <th>RAM</th>
                                            <th>ROM</th>
                                            <th class="text-center">Xóa</th>
                                        </tr>
                                        </thead>
                                        <tbody id="ramRomTableBody">
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
                                                    <td colspan="3" class="text-center text-muted">Chưa
                                                        có cấu hình nào</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <hr>
                                <h6 class="mb-2"><i class="fas fa-plus-circle"></i> Thêm cấu hình</h6>
                                <form id="ramRomForm"
                                      action="${pageContext.request.contextPath}/admin-product/${product.id}/ramrom"
                                      method="post">
                                    <div class="form-group">
                                        <label>RAM</label>
                                        <input type="text" name="ram" class="form-control"
                                               placeholder="Ví dụ: 8GB" required>
                                    </div>
                                    <div class="form-group">
                                        <label>ROM</label>
                                        <input type="text" name="rom" class="form-control"
                                               placeholder="Ví dụ: 128GB" required>
                                    </div>
                                    <button type="submit" class="btn btn-success btn-sm">
                                        <i class="fas fa-save"></i> Thêm
                                    </button>
                                </form>
                            </div>

                            <!-- Tab Thông số kỹ thuật -->
                            <div class="tab-pane fade" id="specifications">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                        <tr>
                                            <th style="width: 30%;">Tên thông số (Key)</th>
                                            <th>Giá trị (Value)</th>
                                            <th class="text-center" style="width: 100px;">Xóa</th>
                                        </tr>
                                        </thead>
                                        <tbody id="specsTableBody">
                                        <c:choose>
                                            <c:when test="${not empty specs}">
                                                <c:forEach var="s" items="${specs}">
                                                    <tr>
                                                        <td class="font-weight-bold">${s.attrKey}</td>
                                                        <td>${s.attrValue}</td>
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
                                                    <td colspan="3" class="text-center text-muted">Chưa
                                                        có thông số kỹ thuật nào</td>
                                                </tr>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6 class="mb-3"><i class="fas fa-plus-circle"></i> Thêm thông số
                                            mới</h6>
                                        <form
                                                action="${pageContext.request.contextPath}/admin-product/${product.id}/specification"
                                                method="post">
                                            <div class="form-group">
                                                <label>Tên thông số</label>
                                                <input type="text" name="specKey" class="form-control"
                                                       placeholder="Ví dụ: Chip xử lý, Pin, Màn hình..." required>
                                            </div>
                                            <div class="form-group">
                                                <label>Giá trị</label>
                                                <input type="text" name="specValue" class="form-control"
                                                       placeholder="Ví dụ: A17 Pro, 5000mAh..." required>
                                            </div>
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="fas fa-save"></i> Lưu thông số
                                            </button>
                                        </form>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="mb-3"><i class="fas fa-magic"></i> Thêm nhanh theo mẫu
                                        </h6>
                                        <div class="d-flex flex-wrap gap-2">
                                            <button type="button"
                                                    class="btn btn-outline-primary btn-sm mb-2 mr-2"
                                                    onclick="addSpecTemplate('Phone')">
                                                <i class="fas fa-mobile-alt"></i> Mẫu Điện thoại
                                            </button>
                                            <button type="button"
                                                    class="btn btn-outline-primary btn-sm mb-2 mr-2"
                                                    onclick="addSpecTemplate('Laptop')">
                                                <i class="fas fa-laptop"></i> Mẫu Laptop
                                            </button>
                                            <button type="button" class="btn btn-outline-primary btn-sm mb-2"
                                                    onclick="addSpecTemplate('Headphones')">
                                                <i class="fas fa-headphones"></i> Mẫu Tai nghe
                                            </button>
                                        </div>
                                        <form id="templateForm"
                                              action="${pageContext.request.contextPath}/admin-product/${product.id}/specifications"
                                              method="post" style="display: none;">
                                            <!-- Token bảo mật bắt buộc của Spring Security -->
                                            <input type="hidden" name="${_csrf.parameterName}"
                                                   value="${_csrf.token}" />
                                            <div id="templateFields" class="p-3 border rounded bg-light">
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-sm mt-3">
                                                <i class="fas fa-save"></i> Lưu tất cả theo mẫu
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    </div>
</section>

<script>
    // Đưa hàm ra ngoài global để onclick có thể gọi được
    window.addSpecTemplate = function (type) {
        const templateFields = document.getElementById('templateFields');
        const templateForm = document.getElementById('templateForm');

        if (!templateFields || !templateForm) {
            console.error("Không tìm thấy các phần tử form mẫu");
            return;
        }

        templateFields.innerHTML = '<h6 class="text-primary mb-3">Đang nhập theo mẫu: ' + type + '</h6>';
        templateForm.style.display = 'block';

        let keys = [];
        if (type === 'Phone') {
            keys = ['Màn hình', 'Hệ điều hành', 'Camera sau', 'Camera trước', 'Chip', 'RAM', 'Dung lượng lưu trữ', 'SIM', 'Pin, Sạc'];
        } else if (type === 'Laptop') {
            keys = ['CPU', 'RAM', 'Ổ cứng', 'Màn hình', 'Card màn hình', 'Cổng kết nối', 'Đặc biệt', 'Hệ điều hành', 'Thiết kế', 'Kích thước, khối lượng', 'Thời điểm ra mắt'];
        } else if (type === 'Headphones') {
            keys = ['Thời lượng pin', 'Thời gian sạc', 'Cổng sạc', 'Tương thích', 'Tiện ích', 'Kết nối cùng lúc', 'Phím điều khiển', 'Trọng lượng', 'Thương hiệu của'];
        }

        keys.forEach(key => {
            const group = document.createElement('div');
            group.className = 'form-group mb-3';
            group.innerHTML =
                '<label class="small mb-1 font-weight-bold text-dark">' + key + '</label>' +
                '<input type="text" name="' + key + '" class="form-control form-control-sm" placeholder="Nhập ' + key + '...">';
            templateFields.appendChild(group);
        });

        // Cuộn xuống form vừa hiện
        templateForm.scrollIntoView({ behavior: 'smooth' });
    };

    // Xử lý form upload ảnh
    var colorImageForm = document.getElementById("colorImageForm");
    if (colorImageForm) {
        colorImageForm.addEventListener("submit", function (e) {
            var colorId = document.getElementById("colorSelect").value;
            if (!colorId) {
                alert("Vui lòng chọn màu trước khi upload!");
                e.preventDefault();
                return;
            }
            this.action = "${pageContext.request.contextPath}/admin-product/${product.id}/color/" + colorId + "/images";
        });
    }

    // ================== AJAX thêm variant (không reload trang) ==================
    (function () {
        var variantForm = document.getElementById("variantForm");
        var variantsTableBody = document.getElementById("variantsTableBody");
        if (!variantForm || !variantsTableBody) {
            return;
        }

        var contextPath = "${pageContext.request.contextPath}";
        var productId = "${product.id}";
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfToken = "${_csrf.token}";

        function formatNumber(value) {
            if (value === null || value === undefined || value === "") {
                return "";
            }
            var num = Number(value);
            if (isNaN(num)) {
                return value;
            }
            return new Intl.NumberFormat('vi-VN').format(num);
        }

        function removeEmptyRow(tbody) {
            if (!tbody) return;
            var rows = Array.prototype.slice.call(tbody.querySelectorAll("tr"));
            rows.forEach(function (tr) {
                var td = tr.querySelector("td.text-center.text-muted");
                if (td) {
                    tbody.removeChild(tr);
                }
            });
        }

        function appendVariantRow(variant) {
            if (!variant || !variantsTableBody) return;

            removeEmptyRow(variantsTableBody);

            var tr = document.createElement("tr");

            var colorName = variant.color && variant.color.colorName ? variant.color.colorName : "";
            var ramRomText = "";
            if (variant.ramRom && variant.ramRom.ram && variant.ramRom.rom) {
                ramRomText = variant.ramRom.ram + "/" + variant.ramRom.rom;
            } else {
                ramRomText = '<span class="text-muted">—</span>';
            }

            var deleteUrl = contextPath + "/admin-product/" + productId + "/variant-new/" + variant.id + "/delete";

            tr.innerHTML =
                "<td>" + colorName + "</td>" +
                "<td>" + ramRomText + "</td>" +
                "<td>" + formatNumber(variant.price) + "</td>" +
                "<td>" + formatNumber(variant.priceSale) + "</td>" +
                "<td class=\"text-center\">" + (variant.stock != null ? variant.stock : 0) + "</td>" +
                "<td class=\"text-center\">" +
                "  <a href=\"" + deleteUrl + "\" class=\"btn btn-sm btn-danger\" onclick=\"return confirm('Xóa variant này?');\">" +
                "    <i class=\"fas fa-trash-alt\"></i>" +
                "  </a>" +
                "</td>";

            variantsTableBody.appendChild(tr);
        }

        variantForm.addEventListener("submit", function (e) {
            e.preventDefault();

            var formData = new FormData(variantForm);
            var colorId = formData.get("colorId");
            var ramRomId = formData.get("ramRomId");
            var price = formData.get("price");
            var priceSale = formData.get("priceSale");
            var stock = formData.get("stock");

            if (!colorId) {
                alert("Vui lòng chọn màu.");
                return;
            }
            if (!price) {
                alert("Vui lòng nhập giá.");
                return;
            }

            var payload = {
                colorId: parseInt(colorId, 10),
                ramRomId: ramRomId ? parseInt(ramRomId, 10) : null,
                price: price,
                priceSale: priceSale || null,
                stock: stock ? parseInt(stock, 10) : 0
            };

            fetch(contextPath + "/api/admin/product/" + productId + "/variant-new", {
                method: "POST",
                headers: (function () {
                    var h = {
                        "Content-Type": "application/json;charset=UTF-8"
                    };
                    if (csrfHeaderName && csrfToken) {
                        h[csrfHeaderName] = csrfToken;
                    }
                    return h;
                })(),
                body: JSON.stringify(payload)
            })
                .then(function (res) {
                    if (!res.ok) {
                        return res.json().then(function (err) {
                            throw new Error(err && err.message ? err.message : "Lỗi khi thêm variant");
                        }).catch(function () {
                            throw new Error("Lỗi khi thêm variant");
                        });
                    }
                    return res.json();
                })
                .then(function (data) {
                    appendVariantRow(data);
                    variantForm.reset();
                    alert("Thêm variant thành công (không cần tải lại trang).");
                })
                .catch(function (err) {
                    alert(err.message || "Có lỗi xảy ra, vui lòng thử lại.");
                });
        });
    })();

    // Description Toggle logic
    document.addEventListener('DOMContentLoaded', function() {
        const descWrapper = document.getElementById('descWrapper');
        const descContent = document.getElementById('descContent');
        const btnToggle = document.getElementById('btnDescToggle');

        if (descWrapper && descContent && btnToggle) {
            // Check if height exceeds 100px
            if (descContent.offsetHeight > 100) {
                btnToggle.style.display = 'inline-flex';

                btnToggle.addEventListener('click', function() {
                    const isExpanded = descWrapper.classList.toggle('expanded');
                    if (isExpanded) {
                        btnToggle.querySelector('span').textContent = 'Thu nhỏ';
                        btnToggle.querySelector('i').className = 'fas fa-chevron-up';
                    } else {
                        btnToggle.querySelector('span').textContent = 'Xem thêm';
                        btnToggle.querySelector('i').className = 'fas fa-chevron-down';
                        // Smooth scroll back up if needed
                        descWrapper.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                    }
                });
            } else {
                // If text is short, remove overlay and keep container height natural
                descWrapper.style.maxHeight = 'none';
                descWrapper.querySelector('.description-overlay').style.display = 'none';
            }
        }
    });

    // ================== AJAX thêm màu (không reload trang) ==================
    (function () {
        var colorForm = document.getElementById("colorForm");
        var colorsTableBody = document.getElementById("colorsTableBody");
        if (!colorForm || !colorsTableBody) {
            return;
        }

        var contextPath = "${pageContext.request.contextPath}";
        var productId = "${product.id}";
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfToken = "${_csrf.token}";

        function removeEmptyRow(tbody) {
            if (!tbody) return;
            var rows = Array.prototype.slice.call(tbody.querySelectorAll("tr"));
            rows.forEach(function (tr) {
                var td = tr.querySelector("td.text-center.text-muted");
                if (td) {
                    tbody.removeChild(tr);
                }
            });
        }

        function appendColorRow(color) {
            if (!color || !colorsTableBody) return;

            removeEmptyRow(colorsTableBody);

            var tr = document.createElement("tr");

            var colorCodeHtml = "";
            if (color.colorCode) {
                colorCodeHtml =
                    '<span class="color-preview" style="background-color:' + color.colorCode + ';"></span>' +
                    color.colorCode;
            }

            var imagesHtml = '<span class="text-muted">Chưa có ảnh</span>';
            var deleteUrl = contextPath + "/admin-product/" + productId + "/color/" + color.id + "/delete";

            tr.innerHTML =
                "<td>" + (color.colorName || "") + "</td>" +
                "<td>" + colorCodeHtml + "</td>" +
                "<td>" + imagesHtml + "</td>" +
                "<td class=\"text-center\">" +
                "  <a href=\"" + deleteUrl + "\" class=\"btn btn-sm btn-danger\" onclick=\"return confirm('Xóa màu này?');\">" +
                "    <i class=\"fas fa-trash-alt\"></i>" +
                "  </a>" +
                "</td>";

            colorsTableBody.appendChild(tr);
        }

        colorForm.addEventListener("submit", function (e) {
            e.preventDefault();

            var formData = new FormData(colorForm);
            var colorName = formData.get("colorName");
            var colorCode = formData.get("colorCode");

            if (!colorName || !colorName.trim()) {
                alert("Vui lòng nhập tên màu.");
                return;
            }

            var payload = {
                colorName: colorName.trim(),
                colorCode: colorCode ? colorCode.trim() : null
            };

            fetch(contextPath + "/api/admin/product/" + productId + "/color", {
                method: "POST",
                headers: (function () {
                    var h = {
                        "Content-Type": "application/json;charset=UTF-8"
                    };
                    if (csrfHeaderName && csrfToken) {
                        h[csrfHeaderName] = csrfToken;
                    }
                    return h;
                })(),
                body: JSON.stringify(payload)
            })
                .then(function (res) {
                    if (!res.ok) {
                        return res.json().then(function (err) {
                            throw new Error(err && err.message ? err.message : "Lỗi khi thêm màu");
                        }).catch(function () {
                            throw new Error("Lỗi khi thêm màu");
                        });
                    }
                    return res.json();
                })
                .then(function (data) {
                    appendColorRow(data);
                    colorForm.reset();
                    alert("Thêm màu thành công.");
                })
                .catch(function (err) {
                    alert(err.message || "Có lỗi xảy ra, vui lòng thử lại.");
                });
        });
    })();

    // ================== AJAX thêm RAM/ROM (không reload trang) ==================
    (function () {
        var ramRomForm = document.getElementById("ramRomForm");
        var ramRomTableBody = document.getElementById("ramRomTableBody");
        if (!ramRomForm || !ramRomTableBody) {
            return;
        }

        var contextPath = "${pageContext.request.contextPath}";
        var productId = "${product.id}";
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfToken = "${_csrf.token}";

        function removeEmptyRow(tbody) {
            if (!tbody) return;
            var rows = Array.prototype.slice.call(tbody.querySelectorAll("tr"));
            rows.forEach(function (tr) {
                var td = tr.querySelector("td.text-center.text-muted");
                if (td) {
                    tbody.removeChild(tr);
                }
            });
        }

        function appendRamRomRow(ramRom) {
            if (!ramRom || !ramRomTableBody) return;

            removeEmptyRow(ramRomTableBody);

            var tr = document.createElement("tr");
            var deleteUrl = contextPath + "/admin-product/" + productId + "/ramrom/" + ramRom.id + "/delete";

            tr.innerHTML =
                "<td>" + (ramRom.ram || "") + "</td>" +
                "<td>" + (ramRom.rom || "") + "</td>" +
                "<td class=\"text-center\">" +
                "  <a href=\"" + deleteUrl + "\" class=\"btn btn-sm btn-danger\" onclick=\"return confirm('Xóa cấu hình này?');\">" +
                "    <i class=\"fas fa-trash-alt\"></i>" +
                "  </a>" +
                "</td>";

            ramRomTableBody.appendChild(tr);
        }

        ramRomForm.addEventListener("submit", function (e) {
            e.preventDefault();

            var formData = new FormData(ramRomForm);
            var ram = formData.get("ram");
            var rom = formData.get("rom");

            if (!ram || !ram.trim()) {
                alert("Vui lòng nhập RAM.");
                return;
            }
            if (!rom || !rom.trim()) {
                alert("Vui lòng nhập ROM.");
                return;
            }

            var payload = {
                ram: ram.trim(),
                rom: rom.trim()
            };

            fetch(contextPath + "/api/admin/product/" + productId + "/ramrom", {
                method: "POST",
                headers: (function () {
                    var h = {
                        "Content-Type": "application/json;charset=UTF-8"
                    };
                    if (csrfHeaderName && csrfToken) {
                        h[csrfHeaderName] = csrfToken;
                    }
                    return h;
                })(),
                body: JSON.stringify(payload)
            })
                .then(function (res) {
                    if (!res.ok) {
                        return res.json().then(function (err) {
                            throw new Error(err && err.message ? err.message : "Lỗi khi thêm cấu hình RAM/ROM");
                        }).catch(function () {
                            throw new Error("Lỗi khi thêm cấu hình RAM/ROM");
                        });
                    }
                    return res.json();
                })
                .then(function (data) {
                    appendRamRomRow(data);
                    ramRomForm.reset();
                    alert("Thêm cấu hình RAM/ROM thành công.");
                })
                .catch(function (err) {
                    alert(err.message || "Có lỗi xảy ra, vui lòng thử lại.");
                });
        });
    })();

    // ================== AJAX thêm thông số kỹ thuật (không reload trang) ==================
    (function () {
        var specForm = document.querySelector("form[action$='/admin-product/${product.id}/specification']");
        var specsTableBody = document.getElementById("specsTableBody");
        if (!specForm || !specsTableBody) {
            return;
        }

        var contextPath = "${pageContext.request.contextPath}";
        var productId = "${product.id}";
        var csrfHeaderName = "${_csrf.headerName}";
        var csrfToken = "${_csrf.token}";

        function removeEmptyRow(tbody) {
            if (!tbody) return;
            var rows = Array.prototype.slice.call(tbody.querySelectorAll("tr"));
            rows.forEach(function (tr) {
                var td = tr.querySelector("td.text-center.text-muted");
                if (td) {
                    tbody.removeChild(tr);
                }
            });
        }

        function appendSpecRow(spec) {
            if (!spec || !specsTableBody) return;

            removeEmptyRow(specsTableBody);

            var tr = document.createElement("tr");
            var key = spec.attrKey || spec.key || "";
            var value = spec.attrValue || spec.value || "";
            var deleteUrl = contextPath + "/admin-product/" + productId + "/specification/" + spec.id + "/delete";

            tr.innerHTML =
                "<td class=\"font-weight-bold\">" + key + "</td>" +
                "<td>" + value + "</td>" +
                "<td class=\"text-center\">" +
                "  <a href=\"" + deleteUrl + "\" class=\"btn btn-sm btn-danger\" onclick=\"return confirm('Xóa thông số này?');\">" +
                "    <i class=\"fas fa-trash-alt\"></i>" +
                "  </a>" +
                "</td>";

            specsTableBody.appendChild(tr);
        }

        specForm.addEventListener("submit", function (e) {
            e.preventDefault();

            var formData = new FormData(specForm);
            var specKey = formData.get("specKey");
            var specValue = formData.get("specValue");

            if (!specKey || !specKey.trim()) {
                alert("Vui lòng nhập tên thông số.");
                return;
            }
            if (!specValue || !specValue.trim()) {
                alert("Vui lòng nhập giá trị thông số.");
                return;
            }

            var payload = {
                attrKey: specKey.trim(),
                attrValue: specValue.trim()
            };

            fetch(contextPath + "/api/admin/product/" + productId + "/specification", {
                method: "POST",
                headers: (function () {
                    var h = {
                        "Content-Type": "application/json;charset=UTF-8"
                    };
                    if (csrfHeaderName && csrfToken) {
                        h[csrfHeaderName] = csrfToken;
                    }
                    return h;
                })(),
                body: JSON.stringify(payload)
            })
                .then(function (res) {
                    if (!res.ok) {
                        return res.json().then(function (err) {
                            throw new Error(err && err.message ? err.message : "Lỗi khi thêm thông số");
                        }).catch(function () {
                            throw new Error("Lỗi khi thêm thông số");
                        });
                    }
                    return res.json();
                })
                .then(function (data) {
                    appendSpecRow(data);
                    specForm.reset();
                    alert("Thêm thông số kỹ thuật thành công.");
                })
                .catch(function (err) {
                    alert(err.message || "Có lỗi xảy ra, vui lòng thử lại.");
                });
        });
    })();
</script>