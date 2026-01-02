<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
    /* Đảm bảo body có min-height và padding-bottom */
    body.hold-transition {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .content-wrapper {
        flex: 1;
        padding-bottom: 60px;
        min-height: calc(100vh - 57px - 60px);
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
        padding-bottom: 4rem;
    }

    .card {
        border: none;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        margin-bottom: 4rem;
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
    }

    .card-header {
        background: white;
        border-bottom: 2px solid #e3e6f0;
        padding: 1.5rem 2rem;
        border-radius: 16px 16px 0 0;
    }

    .card-title {
        color: #2d3748;
        font-weight: 600;
        font-size: 1.25rem;
        margin: 0;
    }

    .card-body {
        padding: 2.5rem;
    }

    .form-group {
        margin-bottom: 1.75rem;
    }

    .form-group label {
        color: #2d3748;
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .form-control {
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        padding: 0.75rem 1rem;
        font-size: 0.95rem;
        transition: all 0.3s;
        color: #2d3748;
    }

    .form-control:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
        outline: none;
    }

    select.form-control {
        cursor: pointer;
        background-color: white;
    }

    textarea.form-control {
        resize: vertical;
        min-height: 120px;
    }

    .text-danger {
        color: #e74a3b;
        font-size: 0.875rem;
        margin-top: 0.25rem;
        display: block;
    }

    .input-icon {
        position: relative;
    }

    .input-icon i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #a0aec0;
    }

    .input-icon .form-control {
        padding-left: 2.75rem;
    }

    .file-upload-wrapper {
        position: relative;
        border: 2px dashed #cbd5e0;
        border-radius: 10px;
        padding: 2rem;
        text-align: center;
        transition: all 0.3s;
        background: #f7fafc;
    }

    .file-upload-wrapper:hover {
        border-color: #4e73df;
        background: #edf2f7;
    }

    .file-upload-wrapper input[type="file"] {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        opacity: 0;
        cursor: pointer;
    }

    .file-upload-label {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
        color: #718096;
    }

    .file-upload-label i {
        font-size: 3rem;
        color: #cbd5e0;
    }

    .image-preview {
        margin-top: 1rem;
        display: none;
    }

    .image-preview img {
        max-width: 200px;
        max-height: 200px;
        border-radius: 8px;
        border: 2px solid #e2e8f0;
    }

    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
        margin-top: 2.5rem;
        padding-top: 2rem;
        border-top: 2px solid #e3e6f0;
    }

    .btn {
        padding: 0.75rem 2rem;
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
    }

    .btn-success {
        background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
        color: white;
        box-shadow: 0 2px 4px rgba(28, 200, 138, 0.3);
    }

    .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(28, 200, 138, 0.5);
        background: linear-gradient(135deg, #17a673 0%, #0e6b47 100%);
        color: white;
    }

    .btn-danger {
        background: #6c757d;
        color: white;
        box-shadow: 0 2px 4px rgba(108, 117, 125, 0.3);
    }

    .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(108, 117, 125, 0.4);
        background: #5a6268;
        color: white;
    }

    .form-helper-text {
        font-size: 0.85rem;
        color: #718096;
        margin-top: 0.35rem;
        display: block;
    }

    .main-footer {
        margin-top: auto;
        position: relative;
        z-index: 1;
    }

    .select-icon {
        position: relative;
    }

    .select-icon::after {
        content: '\f107';
        font-family: 'Font Awesome 5 Free';
        font-weight: 900;
        position: absolute;
        right: 1rem;
        top: 50%;
        transform: translateY(-50%);
        pointer-events: none;
        color: #a0aec0;
    }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Thêm mới danh mục</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-category">Danh mục</a></li>
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
                    <i class="fas fa-folder-plus text-primary"></i>
                    Thông tin danh mục
                </h3>
            </div>
            <div class="card-body">
                <form:form method="post"
                           action="${pageContext.request.contextPath}/admin-category-add/"
                           modelAttribute="category"
                           enctype="multipart/form-data"
                           id="categoryForm">

                    <div class="form-group">
                        <label>
                            <i class="fas fa-tag text-primary"></i>
                            Tên danh mục <span class="text-danger">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-pen"></i>
                            <form:input path="name" cssClass="form-control"
                                        placeholder="Nhập tên danh mục" id="name"/>
                        </div>
                        <form:errors path="name" cssClass="text-danger"/>
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-folder-open text-warning"></i>
                            Danh mục cha
                        </label>
                        <form:select path="parentId" cssClass="form-control" id="parentId">
                            <form:option value="">-- Không có (là danh mục cha) --</form:option>
                            <form:options items="${parentCategories}" itemValue="id" itemLabel="name"/>
                        </form:select>
                        <small class="form-helper-text">
                            <i class="fas fa-info-circle"></i>
                            Để trống nếu đây là danh mục cấp cao nhất
                        </small>
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-align-left text-info"></i>
                            Mô tả
                        </label>
                        <form:textarea path="description" cssClass="form-control"
                                       placeholder="Nhập mô tả cho danh mục" rows="5"/>
                        <form:errors path="description" cssClass="text-danger"/>
                        <small class="form-helper-text">
                            <i class="fas fa-info-circle"></i>
                            Mô tả ngắn gọn về danh mục này
                        </small>
                    </div>

                    <div class="form-group">
                        <label>
                            <i class="fas fa-image text-success"></i>
                            Hình ảnh
                        </label>
                        <div class="file-upload-wrapper">
                            <input type="file" name="fileAnh" id="fileAnh"
                                   accept="image/*" onchange="previewImage(event)"/>
                            <div class="file-upload-label">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <span>Kéo thả ảnh vào đây hoặc click để chọn</span>
                                <small>JPG, PNG, GIF (tối đa 5MB)</small>
                            </div>
                        </div>
                        <div class="image-preview text-center" id="imagePreview">
                            <img src="" alt="Preview" id="preview"/>
                        </div>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin-category"
                           class="btn btn-danger">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                        <button type="submit" class="btn btn-success" id="submitBtn">
                            <i class="fas fa-save"></i> Lưu danh mục
                        </button>
                    </div>

                </form:form>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function() {
        // Form validation
        $('#categoryForm').on('submit', function(e) {
            let isValid = true;
            let categoryName = $('#name').val().trim();

            if (categoryName === '') {
                alert('Vui lòng nhập tên danh mục!');
                $('#name').focus();
                isValid = false;
            }

            // Validate file size (5MB)
            let fileInput = document.getElementById('fileAnh');
            if (fileInput.files.length > 0) {
                let fileSize = fileInput.files[0].size;
                let maxSize = 5 * 1024 * 1024; // 5MB

                if (fileSize > maxSize) {
                    alert('Kích thước file không được vượt quá 5MB!');
                    isValid = false;
                }
            }

            if (!isValid) {
                e.preventDefault();
            } else {
                // Disable submit button to prevent double submission
                $('#submitBtn').prop('disabled', true)
                    .html('<i class="fas fa-spinner fa-spin"></i> Đang xử lý...');
            }
        });
    });

    // Preview image function
    function previewImage(event) {
        const file = event.target.files[0];
        if (file) {
            // Validate file type
            const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                alert('Vui lòng chọn file ảnh (JPG, PNG, GIF)');
                event.target.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                $('#preview').attr('src', e.target.result);
                $('#imagePreview').fadeIn();
            };
            reader.readAsDataURL(file);
        } else {
            $('#imagePreview').fadeOut();
        }
    }
</script>