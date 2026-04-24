<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Thêm mới danh mục</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-category">Danh mục</a>
                    </li>
                    <li class="breadcrumb-item active">Thêm mới</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-folder-plus"></i>
                    Thông tin danh mục
                </h3>
            </div>

            <div class="card-body">
                <form:form method="post"
                           action="${pageContext.request.contextPath}/admin-category-add/"
                           modelAttribute="category"
                           enctype="multipart/form-data"
                           id="categoryForm">

                    <!-- Tên danh mục -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-tag"></i>
                            Tên danh mục <span class="text-danger">*</span>
                        </label>
                        <form:input path="name"
                                    cssClass="form-control"
                                    placeholder="Nhập tên danh mục"
                                    id="name" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>

                    <!-- Danh mục gốc -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-folder-open"></i>
                            Danh mục gốc
                        </label>
                        <form:select path="rootCategoryId"
                                     cssClass="form-control"
                                     id="rootCategoryId">
                            <form:option value="">-- Chọn danh mục --</form:option>
                            <form:options items="${rootCategories}"
                                          itemValue="id"
                                          itemLabel="name" />
                        </form:select>

                    </div>

                    <!-- Mô tả -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-align-left"></i>
                            Mô tả
                        </label>
                        <form:textarea path="description"
                                       cssClass="form-control"
                                       placeholder="Nhập mô tả cho danh mục"
                                       rows="5" />
                        <form:errors path="description" cssClass="text-danger" />
                        <small class="text-muted">
                            Mô tả ngắn gọn về danh mục này
                        </small>
                    </div>

                    <!-- Hình ảnh -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-image"></i>
                            Hình ảnh
                        </label>
                        <input type="file"
                               name="fileAnh"
                               id="fileAnh"
                               class="form-control"
                               accept="image/*"
                               onchange="previewImage(event)" />

                        <div class="mt-3 text-center" id="imagePreview" style="display:none;">
                            <img src="" alt="Preview" id="preview" class="img-fluid" style="max-width:200px;" />
                        </div>
                    </div>

                    <!-- Nút -->
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/admin-category"
                           class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>

                        <button type="submit"
                                class="btn btn-success"
                                id="submitBtn">
                            <i class="fas fa-save"></i> Lưu danh mục
                        </button>
                    </div>

                </form:form>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function () {
        $('#categoryForm').on('submit', function (e) {
            let name = $('#name').val().trim();

            if (name === '') {
                alert('Vui lòng nhập tên danh mục!');
                $('#name').focus();
                e.preventDefault();
                return;
            }

            let fileInput = document.getElementById('fileAnh');
            if (fileInput.files.length > 0) {
                let fileSize = fileInput.files[0].size;
                if (fileSize > 5 * 1024 * 1024) {
                    alert('File không được lớn hơn 5MB!');
                    e.preventDefault();
                    return;
                }
            }

            $('#submitBtn').prop('disabled', true)
                .html('<i class="fas fa-spinner fa-spin"></i> Đang xử lý...');
        });
    });

    function previewImage(event) {
        const file = event.target.files[0];
        if (file) {
            const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                alert('Chỉ chấp nhận JPG, PNG, GIF');
                event.target.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result);
                $('#imagePreview').show();
            };
            reader.readAsDataURL(file);
        }
    }
</script>