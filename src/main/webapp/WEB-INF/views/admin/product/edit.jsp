<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-edit mr-2"></i>Cập nhật sản phẩm</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home"><i
                            class="fas fa-home"></i> Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-product">Sản
                        phẩm</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Form Cập nhật sản phẩm -->
<section class="content">
    <div class="container-fluid">
        <div class="mb-5">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-box mr-2"></i>
                        Chỉnh sửa thông tin sản phẩm
                    </h3>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin-product-edit/${product.id}"
                          method="post" enctype="multipart/form-data">

                        <!-- ID ẩn -->
                        <input type="hidden" name="id" value="${product.id}" />

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
                                            <select name="categoryId" id="categorySelect" class="form-control"
                                                    required>
                                                <option value="">-- Chọn danh mục --</option>
                                                <c:forEach var="cate" items="${productCategories}">
                                                    <option value="${cate.id}" <c:if
                                                            test="${cate.id == selectedCategoryId}">selected</c:if>>
                                                            ${cate.name}
                                                    </option>
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
                                                <c:forEach var="seri" items="${seriesList}">
                                                    <option value="${seri.id}" <c:if
                                                            test="${seri.id == product.seriesId}">selected</c:if>>
                                                            ${seri.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-copyright"></i>
                                        Thương hiệu (Brand)
                                    </label>
                                    <select name="brandId" class="form-control">
                                        <option value="">-- Chọn thương hiệu --</option>
                                        <c:forEach var="brand" items="${brands}">
                                            <option value="${brand.id}" <c:if
                                                    test="${brand.id == product.brandId}">selected</c:if>>
                                                    ${brand.name}
                                            </option>
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
                                    <input type="text" name="name" class="form-control" value="${product.name}"
                                           placeholder="Nhập tên sản phẩm..." required />
                                </div>

                                <!-- Mô tả -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-align-left"></i>
                                        Mô tả sản phẩm
                                    </label>
                                    <textarea name="description" class="form-control editor"
                                              rows="15">${product.description}</textarea>
                                    <small><i class="fas fa-info-circle"></i> Giới thiệu tính năng, thông số kỹ
                                        thuật...</small>
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
                                                   value="${product.price}" placeholder="0" min="0" step="0.01"
                                                   required />
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-percentage"></i>
                                                Giá khuyến mãi
                                            </label>
                                            <input type="number" name="priceSale" class="form-control"
                                                   value="${product.priceSale}" placeholder="0" min="0" step="0.01" />
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
                                                   value="${product.stock}" placeholder="0" min="1" required />
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>
                                                <i class="fas fa-toggle-on"></i>
                                                Trạng thái
                                            </label>
                                            <select name="active" class="form-control">
                                                <option value="true" <c:if test="${product.active}">selected</c:if>
                                                >✓ Hiển thị</option>
                                                <option value="false" <c:if test="${!product.active}">selected
                                                </c:if>>✗ Ẩn</option>
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
                                               class="form-check-input" value="true" <c:if
                                                       test="${product.hasVariants}">checked</c:if> />
                                        <label class="form-check-label" for="hasVariants">
                                            Sản phẩm có nhiều màu sắc và cấu hình (RAM/ROM)
                                        </label>
                                    </div>
                                    <small><i class="fas fa-info-circle"></i> Nếu bật, bạn sẽ quản lý màu sắc và
                                        RAM/ROM riêng ở trang chi tiết</small>
                                </div>

                                <!-- Default RAM/ROM (khi không có variants) -->
                                <div id="defaultRamRomSection"
                                     style="display: ${product.hasVariants ? 'none' : 'block'};">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    <i class="fas fa-memory"></i>
                                                    RAM mặc định
                                                </label>
                                                <input type="text" name="defaultRam" class="form-control"
                                                       value="${product.defaultRam}" placeholder="Ví dụ: 8GB" />
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>
                                                    <i class="fas fa-hdd"></i>
                                                    ROM mặc định
                                                </label>
                                                <input type="text" name="defaultRom" class="form-control"
                                                       value="${product.defaultRom}" placeholder="Ví dụ: 128GB" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- CỘT PHẢI - Hình ảnh -->
                            <div class="col-md-6">
                                <!-- Hình ảnh hiện tại -->
                                <div class="form-group">
                                    <label>
                                        <i class="fas fa-images"></i>
                                        Hình ảnh hiện tại
                                    </label>
                                    <div class="border rounded p-3 bg-light">
                                        <div class="mb-2 font-weight-bold small">
                                            <i class="fas fa-info-circle"></i>
                                            Chọn ảnh đại diện hoặc xóa ảnh
                                        </div>
                                        <c:choose>
                                            <c:when test="${not empty productImages}">
                                                <div class="row" id="imageSelectionGrid">
                                                    <c:forEach var="img" items="${productImages}">
                                                        <div class="col-4 mb-3 image-item">
                                                            <label class="d-block border rounded p-2 text-center" style="cursor:pointer;">
                                                                <input type="radio" name="selectedImageId"
                                                                       value="${img.id}" <c:if
                                                                               test="${img.imageUrl == product.image}">checked
                                                                </c:if> class="d-block mx-auto mb-1" />
                                                                <div class="position-relative">
                                                                    <img src="${pageContext.request.contextPath}${img.imageUrl}"
                                                                         alt="Ảnh sản phẩm"
                                                                         class="img-fluid rounded"
                                                                         style="height:90px; object-fit:cover; width:100%;"
                                                                         onerror="this.src='${pageContext.request.contextPath}/assets/images/products/default-product.jpg'" />
                                                                    <span class="badge badge-danger"
                                                                          style="position:absolute;top:4px;right:4px;cursor:pointer;"
                                                                          onclick="deleteImage(event, ${img.id})"
                                                                          title="Xóa ảnh">×</span>
                                                                </div>
                                                                <small class="d-block mt-1 text-muted">Ảnh ${img.id}</small>
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="text-center text-muted py-3" id="noImagesMsg">
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
                                    <div class="border border-primary rounded p-4 text-center bg-light">
                                        <div class="position-relative">
                                            <input type="file" name="fileAnh" multiple accept="image/*"
                                                   class="position-absolute w-100 h-100" style="opacity:0;top:0;left:0;cursor:pointer;" />
                                            <div class="mb-2" style="font-size:2.5rem;">📷</div>
                                            <div class="font-weight-bold" id="uploadText">Kéo thả hoặc click để chọn ảnh</div>
                                            <div class="text-muted small mt-1">
                                                Hỗ trợ JPG, PNG, WebP • Tối đa 5MB/ảnh<br>
                                                <strong>Ảnh cũ sẽ được giữ lại</strong>
                                            </div>
                                        </div>
                                    </div>
                                    <small class="mt-1 d-block">
                                        <i class="fas fa-lightbulb"></i>
                                        Ảnh mới sẽ được thêm vào bộ sưu tập hiện tại
                                    </small>
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
                                <i class="fas fa-save"></i>
                                Cập nhật sản phẩm
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
            .then(function (response) {
                if (!response.ok) throw new Error('Không thể xóa ảnh');
                return response.json();
            })
            .then(function (data) {
                // Xóa element khỏi DOM
                var imageItem = event.target.closest('.image-item');
                if (imageItem) {
                    imageItem.style.opacity = '0';
                    setTimeout(function () {
                        imageItem.remove();

                        // Kiểm tra nếu không còn ảnh nào
                        var imageSelection = document.querySelector('#imageSelectionGrid');
                        if (imageSelection && imageSelection.children.length === 0) {
                            imageSelection.parentElement.innerHTML = '<div class="text-center text-muted py-3"><p>📷 Chưa có hình ảnh</p></div>';
                        }
                    }, 300);
                }

                alert('Đã xóa ảnh thành công!');
            })
            .catch(function (error) {
                console.error('Lỗi:', error);
                alert('Lỗi khi xóa ảnh: ' + error.message);
            });
    }

    // Preview file upload
    var fileInput = document.querySelector('input[type="file"]');
    if (fileInput) {
        fileInput.addEventListener('change', function (e) {
            var files = e.target.files;
            if (files.length > 0) {
                var uploadText = document.getElementById('uploadText');
                if (uploadText) {
                    uploadText.innerHTML = '<i class="fas fa-check-circle text-success"></i> Đã chọn ' + files.length + ' file';
                }
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