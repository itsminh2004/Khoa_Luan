<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
    body {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* Đồng bộ với các trang khác */
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

    .product-form-wrapper {
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

    /* Layout 2 cột chính */
    .form-main-layout {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 2rem;
    }

    .form-left-column,
    .form-right-column {
        display: flex;
        flex-direction: column;
        gap: 1.2rem;
    }

    .form-group {
        margin-bottom: 0;
    }

    .form-group label {
        color: #2d3748;
        font-weight: 600;
        font-size: 0.9rem;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.4rem;
    }

    .form-group label .text-danger {
        color: #e74c3c;
        margin-left: 2px;
    }

    .form-group small {
        color: #718096;
        font-size: 0.8rem;
        margin-top: 0.3rem;
        display: block;
    }

    .form-control,
    select.form-control {
        height: 48px;
        padding: 0.75rem 1rem;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-size: 0.95rem;
        transition: all 0.3s;
        background: white;
    }

    .form-control:focus,
    select.form-control:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 3px rgba(78,115,223,0.1);
        outline: none;
    }

    textarea.form-control {
        min-height: 120px;
        resize: vertical;
        padding: 0.85rem;
        height: auto;
    }

    select.form-control {
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%234e73df'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 14px;
        padding-right: 3rem;
        appearance: none;
        -webkit-appearance: none;
        -moz-appearance: none;
    }

    /* Các input row trong cột trái */
    .input-pair {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
    }

    /* Cột phải - Hình ảnh */
    .images-section {
        height: 100%;
        display: flex;
        flex-direction: column;
        gap: 1.2rem;
    }

    /* Hình ảnh hiện tại */
    .current-images-wrapper {
        background: #f8f9fc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 1.5rem;
    }

    .current-images-title {
        font-weight: 600;
        color: #2d3748;
        margin-bottom: 1rem;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .image-selection {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 1rem;
    }

    .image-item {
        position: relative;
    }

    .radio-label {
        display: flex;
        flex-direction: column;
        align-items: center;
        cursor: pointer;
        padding: 0.75rem;
        border: 3px solid #e2e8f0;
        border-radius: 10px;
        transition: all 0.3s ease;
        background: white;
    }

    .radio-label:hover {
        border-color: #4e73df;
        box-shadow: 0 4px 12px rgba(78,115,223,0.2);
    }

    .radio-label input[type="radio"] {
        position: absolute;
        opacity: 0;
    }

    .radio-label input[type="radio"]:checked + .image-wrapper {
        border-color: #1cc88a;
    }

    .radio-label input[type="radio"]:checked ~ .image-label {
        background: #1cc88a;
        color: white;
    }

    .image-wrapper {
        width: 100%;
        height: 100px;
        border: 2px solid transparent;
        border-radius: 8px;
        overflow: hidden;
        transition: all 0.3s ease;
        position: relative;
    }

    .image-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .image-label {
        margin-top: 0.5rem;
        padding: 0.25rem 0.75rem;
        background: #e2e8f0;
        border-radius: 6px;
        font-size: 0.75rem;
        color: #2d3748;
        transition: all 0.3s ease;
        text-align: center;
    }

    .no-images-message {
        text-align: center;
        padding: 2rem;
        color: #718096;
        font-style: italic;
    }

    .delete-badge {
        position: absolute;
        top: 5px;
        right: 5px;
        background: rgba(231, 76, 60, 0.9);
        color: white;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s ease;
        z-index: 1;
    }

    .delete-badge:hover {
        background: #c0392b;
        transform: scale(1.1);
    }

    /* Upload ảnh mới */
    .file-upload-wrapper {
        position: relative;
        border: 2px dashed #4e73df;
        border-radius: 12px;
        padding: 2rem 1.5rem;
        text-align: center;
        background: #f8f9fc;
        transition: all 0.3s;
        cursor: pointer;
        min-height: 200px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .file-upload-wrapper:hover {
        border-color: #2d68c4;
        background: #edf2f7;
        transform: translateY(-2px);
    }

    .file-upload-wrapper input[type="file"] {
        position: absolute;
        inset: 0;
        opacity: 0;
        cursor: pointer;
    }

    .upload-icon {
        font-size: 3rem;
        margin-bottom: 0.8rem;
    }

    .upload-text {
        font-size: 1rem;
        font-weight: 600;
        color: #2d3748;
        margin-bottom: 0.4rem;
    }

    .upload-hint {
        color: #718096;
        font-size: 0.85rem;
    }

    /* Nút hành động */
    .form-actions {
        grid-column: 1 / -1;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 1rem;
        padding-top: 1.5rem;
        margin-top: 1.5rem;
        border-top: 2px solid #e3e6f0;
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

    .btn-success {
        background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(28,200,138,0.3);
    }

    .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(28,200,138,0.4);
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
        .form-main-layout {
            grid-template-columns: 1fr;
        }

        .image-selection {
            grid-template-columns: repeat(4, 1fr);
        }

        .file-upload-wrapper {
            min-height: 180px;
        }

        .input-pair {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .card-body {
            padding: 1.5rem;
        }

        .image-selection {
            grid-template-columns: repeat(3, 1fr);
        }

        .form-actions {
            flex-direction: column;
        }

        .btn {
            width: 100%;
        }
    }

    @media (max-width: 576px) {
        .image-selection {
            grid-template-columns: repeat(2, 1fr);
        }
    }
</style>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-edit mr-2"></i>Cập nhật sản phẩm</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home"><i class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-product">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Form Cập nhật sản phẩm -->
<section class="content">
    <div class="container-fluid">
        <div class="product-form-wrapper">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>
                        Chỉnh sửa thông tin sản phẩm
                    </h3>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin-product-edit/${product.id}" method="post" enctype="multipart/form-data">

                        <!-- ID ẩn -->
                        <input type="hidden" name="id" value="${product.id}" />

                        <div class="form-main-layout">
                            <!-- CỘT TRÁI - Thông tin sản phẩm -->
                            <div class="form-left-column">
                                <!-- Danh mục & Series -->
                                <div class="input-pair">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-folder-open"></i>
                                            Danh mục
                                            <span class="text-danger">*</span>
                                        </label>
                                        <select name="categoryId" id="categorySelect" class="form-control" required>
                                            <option value="">-- Chọn danh mục --</option>
                                            <c:forEach var="cate" items="${productCategories}">
                                                <option value="${cate.id}" <c:if test="${cate.id == selectedCategoryId}">selected</c:if>>
                                                        ${cate.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-layer-group"></i>
                                            Series
                                            <span class="text-danger">*</span>
                                        </label>
                                        <select name="seriesId" id="seriesSelect" class="form-control" required>
                                            <option value="">-- Chọn series --</option>
                                            <c:forEach var="seri" items="${seriesList}">
                                                <option value="${seri.id}" <c:if test="${seri.id == product.seriesId}">selected</c:if>>
                                                        ${seri.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <!-- Tên sản phẩm -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-tag"></i>
                                        Tên sản phẩm
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" name="name" class="form-control" value="${product.name}" placeholder="Nhập tên sản phẩm..." required />
                                </div>

                                <!-- Mô tả -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-align-left"></i>
                                        Mô tả sản phẩm
                                    </label>
                                    <textarea name="description" class="form-control" placeholder="Mô tả chi tiết về sản phẩm (tùy chọn)...">${product.description}</textarea>
                                    <small><i class="fas fa-info-circle"></i> Giới thiệu tính năng, thông số kỹ thuật...</small>
                                </div>

                                <!-- Giá gốc & Giá KM -->
                                <div class="input-pair">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-dollar-sign"></i>
                                            Giá gốc (VNĐ)
                                            <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" name="price" class="form-control" value="${product.price}" placeholder="0" min="0" step="0.01" required />
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-percentage"></i>
                                            Giá khuyến mãi
                                        </label>
                                        <input type="number" name="priceSale" class="form-control" value="${product.priceSale}" placeholder="0" min="0" step="0.01" />
                                    </div>
                                </div>

                                <!-- Số lượng & Trạng thái -->
                                <div class="input-pair">
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-boxes"></i>
                                            Số lượng
                                            <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" name="stock" class="form-control" value="${product.stock}" placeholder="0" min="1" required />
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-toggle-on"></i>
                                            Trạng thái
                                        </label>
                                        <select name="active" class="form-control">
                                            <option value="true" <c:if test="${product.active}">selected</c:if>>✓ Hiển thị</option>
                                            <option value="false" <c:if test="${!product.active}">selected</c:if>>✗ Ẩn</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Variants Settings -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-random"></i>
                                        Có nhiều phiên bản (Variants)
                                    </label>
                                    <div class="form-check">
                                        <input type="checkbox" name="hasVariants" id="hasVariants" class="form-check-input" value="true" <c:if test="${product.hasVariants}">checked</c:if> />
                                        <label class="form-check-label" for="hasVariants">
                                            Sản phẩm có nhiều màu sắc và cấu hình (RAM/ROM)
                                        </label>
                                    </div>
                                    <small><i class="fas fa-info-circle"></i> Nếu bật, bạn sẽ quản lý màu sắc và RAM/ROM riêng ở trang chi tiết</small>
                                </div>

                                <!-- Default RAM/ROM (khi không có variants) -->
                                <div id="defaultRamRomSection" style="display: ${product.hasVariants ? 'none' : 'block'};">
                                    <div class="input-pair">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-memory"></i>
                                                RAM mặc định
                                            </label>
                                            <input type="text" name="defaultRam" class="form-control" value="${product.defaultRam}" placeholder="Ví dụ: 8GB" />
                                        </div>

                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-hdd"></i>
                                                ROM mặc định
                                            </label>
                                            <input type="text" name="defaultRom" class="form-control" value="${product.defaultRom}" placeholder="Ví dụ: 128GB" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- CỘT PHẢI - Hình ảnh -->
                            <div class="form-right-column">
                                <div class="images-section">
                                    <!-- Hình ảnh hiện tại -->
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-images"></i>
                                            Hình ảnh hiện tại
                                        </label>
                                        <div class="current-images-wrapper">
                                            <div class="current-images-title">
                                                <i class="fas fa-info-circle"></i>
                                                Chọn ảnh đại diện hoặc xóa ảnh
                                            </div>
                                            <c:choose>
                                                <c:when test="${not empty productImages}">
                                                    <div class="image-selection">
                                                        <c:forEach var="img" items="${productImages}">
                                                            <div class="image-item">
                                                                <label class="radio-label">
                                                                    <input type="radio"
                                                                           name="selectedImageId"
                                                                           value="${img.id}"
                                                                           <c:if test="${img.imageUrl == product.image}">checked</c:if> />
                                                                    <div class="image-wrapper">
                                                                        <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                                                             alt="Ảnh sản phẩm"
                                                                             onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                                                        <span class="delete-badge" onclick="deleteImage(event, ${img.id})" title="Xóa ảnh">×</span>
                                                                    </div>
                                                                    <span class="image-label">Ảnh ${img.id}</span>
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-images-message">
                                                        <p>📷 Chưa có hình ảnh</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <!-- Upload ảnh mới -->
                                    <div class="form-group">
                                        <label>
                                            <i class="fas fa-cloud-upload-alt"></i>
                                            Thêm hình ảnh mới
                                        </label>
                                        <div class="file-upload-wrapper">
                                            <input type="file" name="fileAnh" multiple accept="image/*" />
                                            <div class="upload-icon">📷</div>
                                            <div class="upload-text">Kéo thả hoặc click để chọn ảnh</div>
                                            <div class="upload-hint">
                                                Hỗ trợ JPG, PNG, WebP • Tối đa 5MB/ảnh<br>
                                                <strong>Ảnh cũ sẽ được giữ lại</strong>
                                            </div>
                                        </div>
                                        <small style="margin-top: 0.5rem;">
                                            <i class="fas fa-lightbulb"></i>
                                            Ảnh mới sẽ được thêm vào bộ sưu tập hiện tại
                                        </small>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút hành động -->
                            <div class="form-actions">
                                <a href="${pageContext.request.contextPath}/admin-product" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i>
                                    Quay lại
                                </a>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i>
                                    Cập nhật sản phẩm
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    // Load series khi chọn category
    document.getElementById("categorySelect").addEventListener("change", function(e) {
        var categoryId = this.value;
        var seriesSelect = document.getElementById("seriesSelect");

        console.log('Category ID selected:', categoryId);

        if (!categoryId || categoryId === '') {
            console.log('Category ID rỗng');
            seriesSelect.innerHTML = '<option value="">-- Chọn series --</option>';
            return;
        }

        seriesSelect.innerHTML = '<option value="">Đang tải...</option>';

        var url = '/ProjectTest/api/series/byCategory/' + categoryId;
        console.log('URL sẽ gọi:', url);

        fetch(url)
            .then(function(res) {
                console.log('Status:', res.status);
                if (!res.ok) throw new Error('HTTP ' + res.status);
                return res.json();
            })
            .then(function(data) {
                console.log('Dữ liệu nhận được:', data);

                seriesSelect.innerHTML = '<option value="">-- Chọn series --</option>';

                if (data && data.length > 0) {
                    data.forEach(function(seri) {
                        seriesSelect.innerHTML += '<option value="' + seri.id + '">' + seri.name + '</option>';
                    });
                } else {
                    seriesSelect.innerHTML = '<option value="">Không có series nào</option>';
                }
            })
            .catch(function(err) {
                console.error('Lỗi:', err);
                seriesSelect.innerHTML = '<option value="">Lỗi tải series</option>';
            });
    });

    // Function xóa ảnh
    function deleteImage(event, imageId) {
        event.preventDefault();
        event.stopPropagation();

        if (!confirm('Bạn có chắc chắn muốn xóa ảnh này?')) {
            return;
        }

        // Gọi API xóa ảnh
        fetch('/ProjectTest/api/product-images/' + imageId, {
            method: 'DELETE'
        })
            .then(function(response) {
                if (!response.ok) throw new Error('Không thể xóa ảnh');
                return response.json();
            })
            .then(function(data) {
                // Xóa element khỏi DOM
                var imageItem = event.target.closest('.image-item');
                if (imageItem) {
                    imageItem.style.opacity = '0';
                    setTimeout(function() {
                        imageItem.remove();

                        // Kiểm tra nếu không còn ảnh nào
                        var imageSelection = document.querySelector('.image-selection');
                        if (imageSelection && imageSelection.children.length === 0) {
                            imageSelection.parentElement.innerHTML = '<div class="no-images-message"><p>📷 Chưa có hình ảnh</p></div>';
                        }
                    }, 300);
                }

                alert('Đã xóa ảnh thành công!');
            })
            .catch(function(error) {
                console.error('Lỗi:', error);
                alert('Lỗi khi xóa ảnh: ' + error.message);
            });
    }

    // Preview file upload
    var fileInput = document.querySelector('input[type="file"]');
    if (fileInput) {
        fileInput.addEventListener('change', function(e) {
            var files = e.target.files;
            if (files.length > 0) {
                var uploadText = document.querySelector('.upload-text');
                if (uploadText) {
                    uploadText.innerHTML = '<i class="fas fa-check-circle" style="color: #1cc88a;"></i> Đã chọn ' + files.length + ' file';
                }
            }
        });
    }

    // Toggle default RAM/ROM section
    var hasVariantsCheckbox = document.getElementById('hasVariants');
    var defaultRamRomSection = document.getElementById('defaultRamRomSection');
    if (hasVariantsCheckbox) {
        hasVariantsCheckbox.addEventListener('change', function() {
            if (this.checked) {
                defaultRamRomSection.style.display = 'none';
            } else {
                defaultRamRomSection.style.display = 'block';
            }
        });
    }

    // Validate form
    document.querySelector('form').addEventListener('submit', function(e) {
        var price = parseFloat(document.querySelector('input[name="price"]').value);
        var priceSale = document.querySelector('input[name="priceSale"]').value;

        if (priceSale && parseFloat(priceSale) >= price) {
            e.preventDefault();
            alert('⚠️ Giá khuyến mãi phải nhỏ hơn giá gốc!');
            return false;
        }

        var stock = parseInt(document.querySelector('input[name="stock"]').value);
        if (stock < 1) {
            e.preventDefault();
            alert('⚠️ Số lượng phải lớn hơn 0!');
            return false;
        }
    });
</script>