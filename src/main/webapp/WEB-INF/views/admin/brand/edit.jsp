<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<style>
    body.hold-transition {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }
    .content-wrapper { flex: 1; padding-bottom: 60px; }
    .card {
        border: none;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        max-width: 800px;
        margin: 2rem auto;
    }
    .form-group label { font-weight: 600; color: #2d3748; margin-bottom: 0.5rem; }
    .form-control { border-radius: 10px; padding: 0.75rem 1rem; border: 2px solid #e2e8f0; }
    .form-control:focus { border-color: #4e73df; box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1); }
    .image-preview { margin-top: 1rem; text-align: center; }
    .image-preview img { max-width: 200px; border-radius: 8px; border: 2px solid #e2e8f0; }
    .btn { padding: 0.75rem 2rem; border-radius: 8px; font-weight: 500; }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Chỉnh sửa thương hiệu</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-brand">Thương hiệu</a></li>
                    <li class="breadcrumb-item active">Chỉnh sửa</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body p-5">
                <form:form method="post" action="${pageContext.request.contextPath}/admin-brand-edit/${brandEdit.id}"
                           modelAttribute="brandEdit" enctype="multipart/form-data" id="brandForm">

                    <div class="form-group">
                        <label><i class="fas fa-tag text-primary mr-2"></i> Tên thương hiệu <span class="text-danger">*</span></label>
                        <form:input path="name" cssClass="form-control" placeholder="Nhập tên thương hiệu" id="name" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-link text-info mr-2"></i> Alias (URL)</label>
                        <form:input path="alias" cssClass="form-control" readonly="true" />
                        <small class="text-muted">Tự động sinh ra từ tên thương hiệu</small>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-image text-success mr-2"></i> Logo thương hiệu</label>
                        <div class="custom-file">
                            <input type="file" name="fileAnh" class="custom-file-input" id="fileAnh" accept="image/*" onchange="previewImage(event)">
                            <label class="custom-file-label" for="fileAnh">Chọn ảnh mới để thay đổi...</label>
                        </div>
                        <div class="image-preview" id="imagePreview">
                            <c:choose>
                                <c:when test="${not empty brandEdit.logo}">
                                    <img src="${pageContext.request.contextPath}${brandEdit.logo}" id="preview" />
                                </c:when>
                                <c:otherwise>
                                    <img src="" id="preview" style="display:none;" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="custom-control custom-switch">
                            <form:checkbox path="active" cssClass="custom-control-input" id="active" />
                            <label class="custom-control-label" for="active">Cho phép hoạt động</label>
                        </div>
                    </div>

                    <div class="mt-5 d-flex justify-content-end gap-3">
                        <a href="${pageContext.request.contextPath}/admin-brand" class="btn btn-secondary mr-2">Hủy</a>
                        <button type="submit" class="btn btn-primary" id="submitBtn">
                            <i class="fas fa-save mr-2"></i> Cập nhật thương hiệu
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>

<script>
    function previewImage(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#preview').attr('src', e.target.result).show();
            };
            reader.readAsDataURL(file);
            $('.custom-file-label').text(file.name);
        }
    }

    $(document).ready(function() {
        $('#brandForm').on('submit', function(e) {
            if ($('#name').val().trim() === '') {
                alert('Vui lòng nhập tên thương hiệu');
                e.preventDefault();
            }
        });
    });
</script>
