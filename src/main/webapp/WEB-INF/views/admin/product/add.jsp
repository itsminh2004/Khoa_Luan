<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-plus-circle mr-2"></i>Thêm sản phẩm mới</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home"><i
                            class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-product">Sản
                        phẩm</a></li>
                    <li class="breadcrumb-item active">Thêm mới</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Form Thêm sản phẩm -->
<section class="content">
    <div class="container-fluid">
        <div class="mb-5">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>
                        Thêm sản phẩm mới vào hệ thống
                    </h3>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin-product-add/"
                          method="post" enctype="multipart/form-data">

                        <div class="row">
                            <!-- CỘT TRÁI - Thông tin sản phẩm -->
                            <div class="col-md-6">

                                <!-- Danh mục & Series -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-folder-open"></i>
                                                Danh mục
                                                <span class="text-danger">*</span>
                                            </label>
                                            <select name="categoryId" id="categorySelect" class="form-control" required>
                                                <option value="">-- Chọn danh mục --</option>
                                                <c:forEach var="cate" items="${productCategories}">
                                                    <option value="${cate.id}">${cate.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-layer-group"></i>
                                                Series
                                                <span class="text-danger">*</span>
                                            </label>
                                            <select name="seriesId" id="seriesSelect" class="form-control" required>
                                                <option value="">-- Chọn series --</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Brand -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-copyright"></i>
                                        Thương hiệu (Brand)
                                    </label>
                                    <select name="brandId" class="form-control">
                                        <option value="">-- Chọn thương hiệu --</option>
                                        <c:forEach var="brand" items="${brands}">
                                            <option value="${brand.id}">${brand.name}</option>
                                        </c:forEach>
                                    </select>
                                    <small><i class="fas fa-info-circle"></i> Giúp người dùng lọc sản phẩm theo hãng</small>
                                </div>

                                <!-- Tên sản phẩm -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-tag"></i>
                                        Tên sản phẩm
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" name="name" class="form-control"
                                           placeholder="Ví dụ: iPhone 15 Pro Max 256GB" required />
                                </div>

                                <!-- Mô tả -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-align-left"></i>
                                        Mô tả sản phẩm
                                    </label>
                                    <textarea name="description" class="form-control editor" rows="15"></textarea>
                                    <small><i class="fas fa-info-circle"></i> Giới thiệu tính năng, thông số kỹ thuật...</small>
                                </div>

                                <!-- Giá gốc & Giá KM -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-dollar-sign"></i>
                                                Giá gốc (VNĐ)
                                                <span class="text-danger">*</span>
                                            </label>
                                            <input type="number" name="price" class="form-control"
                                                   placeholder="29990000" min="0" step="0.01" required />
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-percentage"></i>
                                                Giá khuyến mãi
                                            </label>
                                            <input type="number" name="priceSale" class="form-control"
                                                   placeholder="24990000" min="0" step="0.01" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Số lượng & Trạng thái -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-boxes"></i>
                                                Số lượng
                                                <span class="text-danger">*</span>
                                            </label>
                                            <input type="number" name="stock" class="form-control"
                                                   value="1" min="1" required />
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-toggle-on"></i>
                                                Trạng thái
                                            </label>
                                            <select name="active" class="form-control">
                                                <option value="true" selected>✓ Hiển thị</option>
                                                <option value="false">✗ Ẩn</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Variants Settings -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-random"></i>
                                        Có nhiều phiên bản (Variants)
                                    </label>
                                    <div class="form-check">
                                        <input type="checkbox" name="hasVariants" id="hasVariants"
                                               class="form-check-input" value="true" />
                                        <label class="form-check-label" for="hasVariants">
                                            Sản phẩm có nhiều màu sắc và cấu hình (RAM/ROM)
                                        </label>
                                    </div>
                                    <small><i class="fas fa-info-circle"></i> Nếu bật, bạn sẽ quản lý màu sắc và RAM/ROM riêng ở trang chi tiết</small>
                                </div>

                                <!-- Default RAM/ROM (khi không có variants) -->
                                <div id="defaultRamRomSection" style="display: block;">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    <i class="fas fa-memory"></i>
                                                    RAM mặc định
                                                </label>
                                                <input type="text" name="defaultRam" class="form-control"
                                                       placeholder="Ví dụ: 8GB" />
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    <i class="fas fa-hdd"></i>
                                                    ROM mặc định
                                                </label>
                                                <input type="text" name="defaultRom" class="form-control"
                                                       placeholder="Ví dụ: 128GB" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- CỘT PHẢI - Hình ảnh -->
                            <div class="col-md-6">

                                <!-- Upload ảnh mới -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-images"></i>
                                        Hình ảnh sản phẩm
                                        <span class="text-danger">*</span>
                                    </label>
                                    <div class="border border-primary rounded p-4 text-center bg-light">
                                        <div class="position-relative">
                                            <input type="file" name="fileAnh" multiple accept="image/*"
                                                   class="position-absolute w-100 h-100"
                                                   style="opacity:0;top:0;left:0;cursor:pointer;" required />
                                            <div class="mb-2" style="font-size:2.5rem;">📷</div>
                                            <div class="font-weight-bold" id="uploadText">Kéo thả hoặc click để chọn ảnh</div>
                                            <div class="text-muted small mt-1">
                                                Hỗ trợ JPG, PNG, WebP • Tối đa 5MB/ảnh<br>
                                                <strong>Có thể chọn nhiều ảnh cùng lúc</strong>
                                            </div>
                                        </div>
                                    </div>
                                    <small class="mt-1 d-block">
                                        <i class="fas fa-lightbulb"></i>
                                        Ảnh đầu tiên sẽ được chọn làm ảnh đại diện
                                    </small>
                                </div>

                                <!-- Preview ảnh đã chọn -->
                                <div class="form-group" id="previewSection" style="display:none;">
                                    <label>
                                        <i class="fas fa-eye"></i>
                                        Xem trước ảnh đã chọn
                                    </label>
                                    <div class="border rounded p-3 bg-light">
                                        <div class="mb-2 font-weight-bold small">
                                            <i class="fas fa-info-circle"></i>
                                            Ảnh đầu tiên sẽ là ảnh đại diện
                                        </div>
                                        <div class="row" id="imagePreviewGrid"></div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- Nút hành động -->
                        <div class="d-flex justify-content-between align-items-center border-top pt-3 mt-3">
                            <a href="${pageContext.request.contextPath}/admin-product"
                               class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Quay lại
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-plus-circle"></i>
                                Thêm sản phẩm
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    // Load series khi chọn category
    document.getElementById("categorySelect").addEventListener("change", function (e) {
        var categoryId = this.value;
        var seriesSelect = document.getElementById("seriesSelect");

        console.log('Category ID selected:', categoryId);

        if (!categoryId || categoryId === '') {
            console.log('Category ID rỗng');
            seriesSelect.innerHTML = '<option value="">-- Chọn series --</option>';
            return;
        }

        seriesSelect.innerHTML = '<option value="">Đang tải...</option>';

        var url = '/ProjectTest/api/menu/series/' + categoryId;
        console.log('URL sẽ gọi:', url);

        fetch(url)
            .then(function (res) {
                console.log('Status:', res.status);
                if (!res.ok) throw new Error('HTTP ' + res.status);
                return res.json();
            })
            .then(function (data) {
                console.log('Dữ liệu nhận được:', data);
                seriesSelect.innerHTML = '<option value="">-- Chọn series --</option>';
                if (data && data.length > 0) {
                    data.forEach(function (seri) {
                        seriesSelect.innerHTML += '<option value="' + seri.id + '">' + seri.name + '</option>';
                    });
                } else {
                    seriesSelect.innerHTML = '<option value="">Không có series nào</option>';
                }
            })
            .catch(function (err) {
                console.error('Lỗi:', err);
                seriesSelect.innerHTML = '<option value="">Lỗi tải series</option>';
            });
    });

    // Preview file upload
    var fileInput = document.querySelector('input[type="file"]');
    if (fileInput) {
        fileInput.addEventListener('change', function (e) {
            var files = e.target.files;
            var uploadText = document.getElementById('uploadText');
            var previewSection = document.getElementById('previewSection');
            var imagePreviewGrid = document.getElementById('imagePreviewGrid');

            if (files.length > 0) {
                if (uploadText) {
                    uploadText.innerHTML = '<i class="fas fa-check-circle text-success"></i> Đã chọn ' + files.length + ' file';
                }

                // Hiển thị preview
                previewSection.style.display = 'block';
                imagePreviewGrid.innerHTML = '';

                Array.from(files).forEach(function (file, index) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var col = document.createElement('div');
                        col.className = 'col-4 mb-3';
                        col.innerHTML =
                            '<div class="border rounded p-2 text-center">' +
                            '<img src="' + e.target.result + '" class="img-fluid rounded" style="height:90px;object-fit:cover;width:100%;" />' +
                            '<small class="d-block mt-1 text-muted">' +
                            (index === 0
                                ? '<span class="badge badge-primary">Ảnh đại diện</span>'
                                : 'Ảnh ' + (index + 1)) +
                            '</small>' +
                            '</div>';
                        imagePreviewGrid.appendChild(col);
                    };
                    reader.readAsDataURL(file);
                });
            }
        });
    }

    // Toggle default RAM/ROM section
    var hasVariantsCheckbox = document.getElementById('hasVariants');
    var defaultRamRomSection = document.getElementById('defaultRamRomSection');
    if (hasVariantsCheckbox) {
        hasVariantsCheckbox.addEventListener('change', function () {
            if (this.checked) {
                defaultRamRomSection.style.display = 'none';
            } else {
                defaultRamRomSection.style.display = 'block';
            }
        });
    }

    // Validate form
    document.querySelector('form').addEventListener('submit', function (e) {
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

        var files = fileInput.files;
        if (files.length === 0) {
            e.preventDefault();
            alert('⚠️ Vui lòng chọn ít nhất một hình ảnh!');
            return false;
        }
    });
</script>

<script src="https://cdn.ckeditor.com/ckeditor5/41.0.0/classic/ckeditor.js"></script>
<script>
    ClassicEditor.create(document.querySelector('.editor'), {
        ckfinder: { uploadUrl: '${pageContext.request.contextPath}/admin/upload' },
        toolbar: {
            items: [
                'heading', '|',
                'bold', 'italic', 'link', 'bulletedList', 'numberedList', '|',
                'outdent', 'indent', '|',
                'imageUpload', 'blockQuote', 'insertTable', 'mediaEmbed', '|',
                'undo', 'redo'
            ]
        },
        language: 'vi'
    }).catch(error => console.error(error));
</script>
