<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Sửa bài viết Blog</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="<c:url value='/admin-blog-post'/>">Bài viết Blog</a></li>
                    <li class="breadcrumb-item active">Sửa</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin-blog-post/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${post.id}" />

                    <div class="form-group">
                        <label>Tiêu đề <span class="text-danger">*</span></label>
                        <input type="text" name="title" value="${post.title}" class="form-control" required="required" />
                    </div>

                    <div class="form-group">
                        <label>Slug (URL thân thiện)</label>
                        <input type="text" name="slug" value="${post.slug}" class="form-control" placeholder="tu-dong-tao-neu-de-trong" />
                        <small class="form-text text-muted">Để trống để tự động tạo từ tiêu đề</small>
                    </div>

                    <div class="form-group">
                        <label>Nội dung <span class="text-danger">*</span></label>
                        <textarea name="content" class="form-control editor" rows="15">${post.content}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Ảnh thumbnail hiện tại</label>
                        <c:if test="${not empty post.thumbnail}">
                            <div>
                                <img src="${pageContext.request.contextPath}${post.thumbnail}" alt="Thumbnail" width="220" />
                            </div>
                        </c:if>
                        <c:if test="${empty post.thumbnail}">
                            <div class="text-muted">Chưa có thumbnail</div>
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label>Thay thumbnail</label>
                        <input type="file" name="thumbnailFile" class="form-control" id="thumbnailFileInput" accept="image/*" />
                        <small class="form-text text-muted">Chọn ảnh mới để upload làm thumbnail.</small>
                        <div class="mt-2 d-none" id="thumbnailPreview">
                            <img src="" alt="Preview" id="previewImage" width="220" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Danh mục <span class="text-danger">*</span></label>
                        <select name="categoryId" class="form-control" required="required">
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}" ${post.categoryId == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Trạng thái</label>
                        <select name="status" class="form-control">
                            <option value="DRAFT" ${post.status != 'PUBLISHED' ? 'selected' : ''}>Chưa phát hành</option>
                            <option value="PUBLISHED" ${post.status == 'PUBLISHED' ? 'selected' : ''}>Phát hành</option>
                        </select>
                    </div>

                    <div class="form-actions mt-3">
                        <button type="submit" class="btn btn-success">Cập nhật</button>
                        <a href="<c:url value='/admin-blog-post'/>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

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

    const thumbnailPreview = document.getElementById('thumbnailPreview');
    const previewImage = document.getElementById('previewImage');
    const thumbnailFileInput = document.getElementById('thumbnailFileInput');

    function showPreview(src) {
        if (!thumbnailPreview || !previewImage) return;
        previewImage.src = src;
        thumbnailPreview.classList.remove('d-none');
    }

    function hidePreview() {
        if (!thumbnailPreview) return;
        thumbnailPreview.classList.add('d-none');
    }

    if (thumbnailFileInput) {
        thumbnailFileInput.addEventListener('change', function () {
            const file = this.files && this.files[0];
            if (file) {
                const objectUrl = URL.createObjectURL(file);
                showPreview(objectUrl);
            }
        });
    }

    if (previewImage) {
        previewImage.addEventListener('error', hidePreview);
    }
</script>