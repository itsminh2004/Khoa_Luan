<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<c:set var="isEdit" value="${banner.id != null && banner.id > 0}"/>
<c:set var="actionUrl"
       value="${isEdit ? pageContext.request.contextPath.concat('/admin/banners/edit/').concat(banner.id) : pageContext.request.contextPath.concat('/admin/banners/add')}"/>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1>${isEdit ? 'Chỉnh sửa banner' : 'Thêm banner mới'}</h1>
            </div>
            <div class="col-sm-6 text-right">
                <a href="${pageContext.request.contextPath}/admin/banners" class="btn btn-secondary">
                    <i class="fas fa-arrow-left mr-1"></i> Quay lại
                </a>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h3 class="card-title">${isEdit ? 'Cập nhật thông tin banner' : 'Tạo banner mới'}</h3>
            </div>

            <div class="card-body">
                <div class="row">
                    <div class="col-md-7">
                        <form id="bannerForm" action="${actionUrl}" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="image_url" id="imageUrlHidden" value="${banner.imageUrl != null ? banner.imageUrl : ''}"/>

                            <div class="form-group">
                                <label>Tiêu đề <span class="text-danger">*</span></label>
                                <input type="text" name="title" class="form-control" required
                                       value="${banner.title != null ? banner.title : ''}" placeholder="Nhập tiêu đề banner"/>
                            </div>

                            <div class="form-group mt-3">
                                <label>Vị trí (position) <span class="text-danger">*</span></label>
                                <select name="position" class="form-control" required>
                                    <option value="HOME_HERO" ${banner.position == 'HOME_HERO' ? 'selected' : ''}>HOME_HERO</option>
                                    <option value="HOME_SUB" ${banner.position == 'HOME_SUB' ? 'selected' : ''}>HOME_SUB</option>
                                    <option value="POPUP" ${banner.position == 'POPUP' ? 'selected' : ''}>POPUP</option>
                                </select>
                            </div>

                            <div class="form-group mt-3">
                                <label>Thứ tự hiển thị (sort_order)</label>
                                <input type="number" min="0" name="sortOrder" class="form-control"
                                       value="${banner.sortOrder}"/>
                            </div>

                            <div class="form-group mt-3">
                                <label>Sản phẩm liên kết</label>
                                <select name="productId" class="form-control">
                                    <option value="" ${empty banner.productId ? 'selected' : ''}>Không liên kết sản phẩm</option>
                                    <c:forEach var="p" items="${products}">
                                        <option value="${p.id}" ${banner.productId != null && p.id == banner.productId ? 'selected' : ''}>
                                                ${p.name}
                                        </option>
                                    </c:forEach>
                                </select>
                                <small class="text-muted">Để trống nếu banner không link sang sản phẩm.</small>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-6 form-group">
                                    <label>Thời gian bắt đầu</label>
                                    <input type="datetime-local" name="startDate" class="form-control"
                                           value="<fmt:formatDate value='${banner.startDate}' pattern='yyyy-MM-dd HH:mm'/>"/>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Thời gian kết thúc</label>
                                    <input type="datetime-local" name="endDate" class="form-control"
                                           value="<fmt:formatDate value='${banner.endDate}' pattern='yyyy-MM-dd HH:mm'/>"/>
                                </div>
                            </div>

                            <div class="form-group mt-3">
                                <div class="custom-control custom-switch">
                                    <input type="checkbox" class="custom-control-input" id="activeSwitch" name="active" value="true"
                                    ${banner.active ? 'checked' : ''}/>
                                    <label class="custom-control-label" for="activeSwitch">Kích hoạt banner</label>
                                </div>
                            </div>

                            <div id="clientError" class="alert alert-danger mt-3" style="display:none;"></div>

                            <button type="submit" class="btn btn-success mt-3 px-5">
                                <i class="fas fa-save mr-2"></i> ${isEdit ? 'Cập nhật' : 'Lưu'}
                            </button>
                    </div>

                    <div class="col-md-5">
                        <div class="form-group">
                            <label>Ảnh banner (image_url) <span class="text-danger">*</span></label>

                            <c:choose>
                                <c:when test="${not empty banner.imageUrl}">
                                    <img id="imagePreview"
                                         src="${pageContext.request.contextPath}${banner.imageUrl}"
                                         alt="Preview ảnh banner"
                                         class="img-thumbnail mb-3"
                                         style="max-width: 100%;"/>
                                </c:when>
                                <c:otherwise>
                                    <img id="imagePreview" alt="Preview ảnh banner" class="img-thumbnail mb-3" style="max-width:100%; display:none;"/>
                                </c:otherwise>
                            </c:choose>

                            <input type="file" name="imageFile" id="imageFile"
                                   class="form-control"
                                   accept=".jpg,.jpeg,.png,.webp"/>
                            <small class="form-text text-muted">
                                Chấp nhận jpg/png/webp, tối đa 5MB.
                            </small>
                        </div>
                    </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</section>

<script>
    (function () {
        const imageInput = document.getElementById('imageFile');
        const imagePreview = document.getElementById('imagePreview');
        const imageUrlHidden = document.getElementById('imageUrlHidden');
        const clientError = document.getElementById('clientError');
        const form = document.getElementById('bannerForm');

        const originalHiddenValue = (imageUrlHidden && imageUrlHidden.value) ? imageUrlHidden.value : '';
        const MAX_SIZE = 5 * 1024 * 1024;
        const allowedExt = ['jpg', 'jpeg', 'png', 'webp'];

        function showError(msg) {
            if (!clientError) return;
            clientError.textContent = msg;
            clientError.style.display = 'block';
        }

        function hideError() {
            if (!clientError) return;
            clientError.textContent = '';
            clientError.style.display = 'none';
        }

        function fileNameExtOk(fileName) {
            const dot = fileName.lastIndexOf('.');
            if (dot === -1) return false;
            const ext = fileName.substring(dot + 1).toLowerCase();
            return allowedExt.includes(ext);
        }

        if (imageInput) {
            imageInput.addEventListener('change', function () {
                hideError();
                const file = imageInput.files && imageInput.files.length ? imageInput.files[0] : null;
                if (!file) {
                    // Trường hợp người dùng bỏ chọn: quay về hidden cũ
                    if (imageUrlHidden) imageUrlHidden.value = originalHiddenValue;
                    if (imagePreview) {
                        if (originalHiddenValue) imagePreview.style.display = 'block';
                        else imagePreview.style.display = 'none';
                    }
                    return;
                }

                if (file.size > MAX_SIZE) {
                    alert('Dung lượng ảnh vượt quá 5MB.');
                    imageInput.value = '';
                    if (imageUrlHidden) imageUrlHidden.value = originalHiddenValue;
                    if (imagePreview) imagePreview.style.display = 'none';
                    return;
                }

                if (!fileNameExtOk(file.name)) {
                    alert('Chỉ hỗ trợ định dạng jpg, png, webp.');
                    imageInput.value = '';
                    if (imageUrlHidden) imageUrlHidden.value = originalHiddenValue;
                    if (imagePreview) imagePreview.style.display = 'none';
                    return;
                }

                // Preview nhanh
                if (imagePreview) {
                    imagePreview.src = URL.createObjectURL(file);
                    imagePreview.style.display = 'block';
                }

                // Thỏa mãn validate phía client: image_url "bắt buộc"
                // Server sẽ ưu tiên upload file thật nếu imageFile được chọn.
                if (imageUrlHidden) imageUrlHidden.value = file.name;
            });
        }

        if (form) {
            form.addEventListener('submit', function (e) {
                hideError();
                const file = imageInput.files && imageInput.files.length ? imageInput.files[0] : null;
                const hiddenVal = imageUrlHidden ? imageUrlHidden.value : '';

                if (!file && (!hiddenVal || !hiddenVal.trim())) {
                    e.preventDefault();
                    showError('Vui lòng chọn ảnh banner (image_url bắt buộc).');
                    return;
                }

                if (file) {
                    if (file.size > MAX_SIZE) {
                        e.preventDefault();
                        showError('Dung lượng ảnh vượt quá 5MB.');
                        return;
                    }
                    if (!fileNameExtOk(file.name)) {
                        e.preventDefault();
                        showError('Chỉ hỗ trợ định dạng jpg, png, webp.');
                        return;
                    }
                }
            });
        }
    })();
</script>

