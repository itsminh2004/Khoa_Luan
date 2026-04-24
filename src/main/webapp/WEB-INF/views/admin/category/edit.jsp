<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<!-- Content Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Cập nhật danh mục</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-category">Danh mục</a>
                    </li>
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
                <h3>
                    <i class="fas fa-edit"></i>
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
                        <label>Tên danh mục *</label>
                        <form:input path="name" cssClass="form-control" id="name"
                                    placeholder="Nhập tên danh mục" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>

                    <!-- Danh mục gốc -->
                    <div class="form-group">
                        <label>Danh mục gốc</label>
                        <form:select path="rootCategoryId" cssClass="form-control">
                            <form:option value="">-- Chọn danh mục --</form:option>
                            <form:options items="${rootCategories}" itemValue="id" itemLabel="name" />
                        </form:select>

                    </div>

                    <!-- Mô tả -->
                    <div class="form-group">
                        <label>Mô tả</label>
                        <form:textarea path="description" cssClass="form-control" rows="5"
                                       placeholder="Nhập mô tả cho danh mục" />
                        <small>Mô tả ngắn gọn về danh mục này</small>
                    </div>

                    <!-- Ảnh hiện tại -->
                    <c:if test="${not empty categoryEdit.image}">
                        <div class="form-group">
                            <label>Ảnh hiện tại</label>
                            <div>
                                <img src="${pageContext.request.contextPath}${categoryEdit.image}"
                                     alt="Ảnh hiện tại" width="180"/>
                                <div>Ảnh đang sử dụng</div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Upload ảnh mới -->
                    <div class="form-group">
                        <label>Thay ảnh mới (tùy chọn)</label>
                        <input type="file" name="fileAnh" id="fileAnhEdit"
                               accept="image/*" onchange="previewImageEdit(event)" />
                        <div id="imagePreviewEdit" style="display:none;">
                            <img src="" id="previewEdit" width="200"/>
                        </div>
                        <small>Để trống nếu không muốn thay đổi ảnh</small>
                    </div>

                    <!-- Nút hành động -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin-category"
                           class="btn btn-secondary">
                            Quay lại
                        </a>
                        <button type="submit" class="btn btn-success" id="submitBtnEdit">
                            Cập nhật danh mục
                        </button>
                    </div>

                </form:form>
            </div>
        </div>
    </div>
</section>

<script>
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
            reader.onload = function (e) {
                $('#previewEdit').attr('src', e.target.result);
                $('#imagePreviewEdit').show();
            }
            reader.readAsDataURL(file);
        }
    }

    $('#categoryEditForm').on('submit', function (e) {
        const name = $('#name').val().trim();
        if (name === '') {
            alert('Vui lòng nhập tên danh mục!');
            $('#name').focus();
            e.preventDefault();
            return;
        }

        $('#submitBtnEdit').prop('disabled', true)
            .html('Đang lưu...');
    });
</script>