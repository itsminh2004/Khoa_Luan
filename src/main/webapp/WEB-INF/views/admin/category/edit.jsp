<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<style>
    /* Dùng chung với form thêm mới – bạn có thể copy nguyên style này vào file CSS chung luôn */
    body.hold-transition {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    .content-wrapper {
        flex: 1; padding-bottom: 80px;
        min-height: calc(100vh - 57px - 80px);
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
        margin: 0; padding: 0;
    }
    .breadcrumb-item a {
        color: #4a5568;
        text-decoration: none;
    }
    .breadcrumb-item a:hover {
        color: #2d3748;
    }
    .breadcrumb-item.active {
        color: #718096;
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
    .card-header { background: white;
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
        color: #2d3748; }
    .form-control:focus { border-color: #4e73df; box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1); outline: none; }
    textarea.form-control { resize: vertical; min-height: 120px; }
    .text-danger { color: #e74a3b; font-size: 0.875rem; margin-top: 0.25rem; display: block; }

    .input-icon { position: relative; }
    .input-icon i { position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #a0aec0; }
    .input-icon .form-control { padding-left: 2.75rem; }

    .file-upload-wrapper { position: relative; border: 2px dashed #cbd5e0; border-radius: 10px; padding: 2rem; text-align: center; transition: all 0.3s; background: #f7fafc; }
    .file-upload-wrapper:hover { border-color: #4e73df; background: #edf2f7; }
    .file-upload-wrapper input[type="file"] { position: absolute; width: 100%; height: 100%; top: 0; left: 0; opacity: 0; cursor: pointer; }
    .file-upload-label { display: flex; flex-direction: column; align-items: center; gap: 0.5rem; color: #718096; }
    .file-upload-label i { font-size: 3rem; color: #cbd5e0; }

    .image-preview { margin-top: 1rem; display: none; text-align: center; }
    .image-preview img { max-width: 200px; max-height: 200px; border-radius: 8px; border: 2px solid #e2e8f0; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

    .current-image { margin-top: 1rem; text-align: center; }
    .current-image img { max-width: 180px; border-radius: 12px; border: 3px solid #e2e8f0; }

    .form-actions { display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2.5rem; padding-top: 2rem; border-top: 2px solid #e3e6f0; }

    .btn { padding: 0.75rem 2rem; border-radius: 8px; font-weight: 500; transition: all 0.3s; border: none; cursor: pointer; }
    .btn-success { background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%); color: white; }
    .btn-success:hover { transform: translateY(-2px); box-shadow: 0 4px 12px rgba(28, 200, 138, 0.5); }
    .btn-secondary { background: #6c757d; color: white; }
    .btn-secondary:hover { background: #5a6268; transform: translateY(-2px); }

    .form-helper-text { font-size: 0.85rem; color: #718096; margin-top: 0.35rem; }
</style>

<!-- Content Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Cập nhật danh mục</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-category">Danh mục</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
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
                    <i class="fas fa-edit text-primary"></i>
                    Chỉnh sửa thông tin danh mục
                </h3>
            </div>

            <div class="card-body">
                <form:form method="post"
                           action="${pageContext.request.contextPath}/admin-category-edit/${categoryEdit.id}"
                           modelAttribute="categoryEdit"
                           enctype="multipart/form-data"
                           id="categoryEditForm">

                    <!-- Tên danh mục -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-tag text-primary"></i>
                            Tên danh mục <span class="text-danger">*</span>
                        </label>
                        <div class="input-icon">
                            <i class="fas fa-pen"></i>
                            <form:input path="name" cssClass="form-control" placeholder="Nhập tên danh mục"/>
                        </div>
                        <form:errors path="name" cssClass="text-danger"/>
                    </div>

                    <!-- Danh mục cha -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-folder-open text-warning"></i>
                            Danh mục cha
                        </label>
                        <form:select path="parentId" cssClass="form-control">
                            <form:option value="">-- Không có (là danh mục cha) --</form:option>
                            <form:options items="${parentCategory}" itemValue="id" itemLabel="name"/>
                        </form:select>
                        <small class="form-helper-text">
                            Để trống nếu đây là danh mục cấp cao nhất
                        </small>
                    </div>

                    <!-- Mô tả -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-align-left text-info"></i>
                            Mô tả
                        </label>
                        <form:textarea path="description" cssClass="form-control" rows="5"
                                       placeholder="Nhập mô tả cho danh mục"/>
                        <small class="form-helper-text">
                            Mô tả ngắn gọn về danh mục này
                        </small>
                    </div>

                    <!-- Ảnh hiện tại -->
                    <c:if test="${not empty categoryEdit.image}">
                        <div class="form-group">
                            <label>
                                <i class="fas fa-image text-success"></i>
                                Ảnh hiện tại
                            </label>
                            <div class="current-image">
                                <img src="${pageContext.request.contextPath}${categoryEdit.image}"
                                     alt="Ảnh hiện tại" class="img-thumbnail"/>
                                <div class="mt-2 text-muted small">Ảnh đang sử dụng</div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Upload ảnh mới -->
                    <div class="form-group">
                        <label>
                            <i class="fas fa-cloud-upload-alt text-success"></i>
                            Thay ảnh mới (tùy chọn)
                        </label>
                        <div class="file-upload-wrapper">
                            <input type="file" name="fileAnh" id="fileAnhEdit" accept="image/*"
                                   onchange="previewImageEdit(event)"/>
                            <div class="file-upload-label">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <span>Kéo thả ảnh vào đây hoặc click để chọn</span>
                                <small>JPG, PNG, GIF (tối đa 5MB)</small>
                            </div>
                        </div>
                        <div class="image-preview text-center" id="imagePreviewEdit">
                            <img src="" alt="Preview" id="previewEdit"/>
                        </div>
                        <small class="form-helper-text text-muted">
                            Để trống nếu không muốn thay đổi ảnh
                        </small>
                    </div>

                    <!-- Nút hành động -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin-category"
                           class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-success" id="submitBtnEdit">
                            <i class="fas fa-save"></i> Cập nhật danh mục
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>

<script>
    // Preview ảnh khi chọn file mới
    function previewImageEdit(event) {
        const file = event.target.files[0];
        if (file) {
            const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                alert('Chỉ chấp nhận file JPG, PNG, GIF');
                event.target.value = '';
                return;
            }
            if (file.size > 5 * 1024 * 1024) {
                alert('File không được lớn hơn 5MB');
                event.target.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                $('#previewEdit').attr('src', e.target.result);
                $('#imagePreviewEdit').fadeIn();
            }
            reader.readAsDataURL(file);
        }
    }

    // Validation trước khi submit
    $('#categoryEditForm').on('submit', function(e) {
        const name = $('#name').val().trim();
        if (name === '') {
            alert('Vui lòng nhập tên danh mục!');
            $('#name').focus();
            e.preventDefault();
            return;
        }

        $('#submitBtnEdit').prop('disabled', true)
            .html('<i class="fas fa-spinner fa-spin"></i> Đang lưu...');
    });
</script>