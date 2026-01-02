<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<style>
    .blog-post-form-section {
        background: #f8f9fc;
        min-height: 100vh;
        padding-bottom: 2rem;
    }

    .page-header {
        background: #ffffff; /* trắng hoàn toàn */
        padding: 2.5rem 0;
        margin-bottom: 2rem;
        border-radius: 0 0 20px 20px;

        /* Shadow nhẹ để tạo chiều sâu */
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .page-header h1 {
        color: black;
        font-weight: 600;
        margin: 0;
        font-size: 1.75rem;
    }

    .breadcrumb {
        background: transparent;
        padding: 0.5rem 0 0 0;
        margin: 0;
    }

    .breadcrumb-item a {
        color: black;
        text-decoration: none;
        transition: color 0.3s;
    }

    .breadcrumb-item a:hover {
        color: black;
    }

    .breadcrumb-item.active {
        color: black;
    }

    .breadcrumb-item + .breadcrumb-item::before {
        color: black;
    }

    .form-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        overflow: hidden;
    }

    .form-card-body {
        padding: 2rem;
    }

    .form-group {
        margin-bottom: 1.75rem;
    }

    .form-group label {
        color: #2d3748;
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 0.5rem;
        display: block;
    }

    .text-danger {
        color: #e74a3b;
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

    .form-control::placeholder {
        color: #a0aec0;
        font-style: italic;
    }

    textarea.form-control {
        resize: vertical;
        min-height: 400px;
    }

    .sidebar-card {
        background: white;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        overflow: hidden;
        margin-bottom: 1.5rem;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        transition: all 0.3s;
    }

    .sidebar-card:hover {
        border-color: #4e73df;
        box-shadow: 0 4px 12px rgba(78, 115, 223, 0.15);
    }

    .sidebar-card-header {
        background: linear-gradient(135deg, #f8f9fc 0%, #e9ecef 100%);
        padding: 1rem 1.25rem;
        border-bottom: 2px solid #e2e8f0;
    }

    .sidebar-card-header strong {
        color: #2d3748;
        font-size: 0.95rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .sidebar-card-body {
        padding: 1.25rem;
    }

    .text-muted {
        color: #718096 !important;
        font-size: 0.85rem;
        display: block;
        margin-top: 0.5rem;
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

    .btn {
        padding: 0.75rem 2rem;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
    }

    .btn-primary {
        background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
        color: white;
        box-shadow: 0 4px 12px rgba(78, 115, 223, 0.3);
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(78, 115, 223, 0.5);
        background: linear-gradient(135deg, #2e59d9 0%, #1a3da8 100%);
        color: white;
    }

    .btn-lg {
        width: 100%;
        padding: 1rem 2rem;
        font-size: 1.05rem;
    }

    .editor-wrapper {
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        overflow: hidden;
        transition: all 0.3s;
    }

    .editor-wrapper:focus-within {
        border-color: #4e73df;
        box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
    }

    .thumbnail-preview {
        margin-top: 1rem;
        border-radius: 8px;
        overflow: hidden;
        display: none;
    }

    .thumbnail-preview img {
        width: 100%;
        height: auto;
        display: block;
    }

    .status-option {
        padding: 0.75rem;
        border-radius: 8px;
        margin-bottom: 0.5rem;
        cursor: pointer;
        transition: all 0.3s;
    }

    .main-content-col {
        padding-right: 1.5rem;
    }

    .sidebar-col {
        padding-left: 1.5rem;
    }

    select.form-control {
        cursor: pointer;
    }

    .form-helper-text {
        font-size: 0.85rem;
        color: #718096;
        margin-top: 0.35rem;
        display: block;
    }
</style>

<section class="blog-post-form-section">
    <div class="page-header">
        <div class="container-fluid">
            <h1>${post.id != null ? 'Sửa bài viết Blog' : 'Viết bài mới'}</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-blog-post">Bài viết Blog</a></li>
                    <li class="breadcrumb-item active">${post.id != null ? 'Sửa bài viết' : 'Viết bài mới'}</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container-fluid">
        <div class="form-card">
            <div class="form-card-body">
                <form action="${pageContext.request.contextPath}/admin-blog-post/${post.id != null ? 'edit' : 'add'}" method="post">
                    <input type="hidden" name="id" value="${post.id}">

                    <div class="row">
                        <div class="col-md-8 main-content-col">
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-heading text-primary"></i>
                                    Tiêu đề bài viết <span class="text-danger">*</span>
                                </label>
                                <div class="input-icon">
                                    <i class="fas fa-pen"></i>
                                    <input type="text" name="title" value="${post.title}" class="form-control"
                                           required placeholder="Nhập tiêu đề bài viết">
                                </div>
                            </div>

                            <div class="form-group">
                                <label>
                                    <i class="fas fa-link text-info"></i>
                                    Slug (URL thân thiện)
                                </label>
                                <div class="input-icon">
                                    <i class="fas fa-globe"></i>
                                    <input type="text" name="slug" value="${post.slug}" class="form-control"
                                           placeholder="tu-dong-tao-neu-de-trong">
                                </div>
                                <small class="form-helper-text">
                                    <i class="fas fa-info-circle"></i> Để trống để tự động tạo từ tiêu đề
                                </small>
                            </div>

                            <div class="form-group">
                                <label>
                                    <i class="fas fa-align-left text-success"></i>
                                    Nội dung <span class="text-danger">*</span>
                                </label>
                                <div class="editor-wrapper">
                                    <textarea name="content" class="form-control editor" rows="15">${post.content}</textarea>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4 sidebar-col">
                            <div class="sidebar-card">
                                <div class="sidebar-card-header">
                                    <strong>
                                        <i class="fas fa-image text-primary"></i>
                                        Ảnh thumbnail
                                    </strong>
                                </div>
                                <div class="sidebar-card-body">
                                    <input type="text" name="thumbnail" value="${post.thumbnail}"
                                           class="form-control" placeholder="https://example.com/image.jpg"
                                           id="thumbnailInput">
                                    <small class="text-muted">
                                        <i class="fas fa-info-circle"></i> Nhập URL ảnh thumbnail
                                    </small>
                                    <div class="thumbnail-preview" id="thumbnailPreview">
                                        <img src="" alt="Preview" id="previewImage">
                                    </div>
                                </div>
                            </div>

                            <div class="sidebar-card">
                                <div class="sidebar-card-header">
                                    <strong>
                                        <i class="fas fa-folder text-warning"></i>
                                        Danh mục
                                    </strong>
                                </div>
                                <div class="sidebar-card-body">
                                    <select name="categoryId" class="form-control" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}" ${post.categoryId == cat.id ? 'selected' : ''}>
                                                    ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="sidebar-card">
                                <div class="sidebar-card-header">
                                    <strong>
                                        <i class="fas fa-toggle-on text-success"></i>
                                        Trạng thái
                                    </strong>
                                </div>
                                <div class="sidebar-card-body">
                                    <select name="status" class="form-control">
                                        <option value="DRAFT" ${post.status != 'PUBLISHED' ? 'selected' : ''}>
                                            📝 Bản nháp
                                        </option>
                                        <option value="PUBLISHED" ${post.status == 'PUBLISHED' ? 'selected' : ''}>
                                            ✅ Xuất bản ngay
                                        </option>
                                    </select>
                                </div>
                            </div>

                            <div class="mt-4">
                                <button type="submit" class="btn btn-lg btn-primary">
                                    <i class="fas fa-save"></i>
                                    ${post.id != null ? 'Cập nhật bài viết' : 'Lưu bài viết'}
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Thêm CKEditor -->
<script src="https://cdn.ckeditor.com/ckeditor5/41.0.0/classic/ckeditor.js"></script>
<script>
    // Initialize CKEditor
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
        language: 'vi',
        image: {
            toolbar: [
                'imageTextAlternative', 'imageStyle:full', 'imageStyle:side'
            ]
        },
        table: {
            contentToolbar: [
                'tableColumn', 'tableRow', 'mergeTableCells'
            ]
        }
    }).catch(error => console.error(error));

    // Thumbnail preview
    const thumbnailInput = document.getElementById('thumbnailInput');
    const thumbnailPreview = document.getElementById('thumbnailPreview');
    const previewImage = document.getElementById('previewImage');

    if (thumbnailInput && thumbnailPreview && previewImage) {
        // Show preview if there's an initial value
        if (thumbnailInput.value) {
            previewImage.src = thumbnailInput.value;
            thumbnailPreview.style.display = 'block';
        }

        thumbnailInput.addEventListener('input', function() {
            if (this.value) {
                previewImage.src = this.value;
                thumbnailPreview.style.display = 'block';
            } else {
                thumbnailPreview.style.display = 'none';
            }
        });

        previewImage.addEventListener('error', function() {
            thumbnailPreview.style.display = 'none';
        });
    }
</script>