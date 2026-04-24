<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>${policy.id > 0 ? 'Sửa chính sách' : 'Thêm chính sách mới'}</h1>
            </div>
            <div class="col-sm-6 text-right">
                <a href="<c:url value='/admin-policy-list'/>" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body">
                <form id="policyForm" method="post">
                    <input type="hidden" name="id" value="${policy.id}">
                    <div class="row">
                        <div class="col-md-8 form-group">
                            <label>Tiêu đề</label>
                            <input type="text" name="title" id="title" class="form-control"
                                   value="${policy.title}" required onkeyup="generateSlug(this.value)">
                        </div>
                        <div class="col-md-4 form-group">
                            <label>Loại</label>
                            <select name="type" class="form-control">
                                <option value="WARRANTY" ${policy.type=='WARRANTY' ? 'selected' : '' }>Bảo hành
                                </option>
                                <option value="RETURN" ${policy.type=='RETURN' ? 'selected' : '' }>Đổi trả
                                </option>
                                <option value="SHIPPING" ${policy.type=='SHIPPING' ? 'selected' : '' }>Giao hàng
                                </option>
                                <option value="PRIVACY" ${policy.type=='PRIVACY' ? 'selected' : '' }>Bảo mật
                                </option>
                                <option value="TERMS" ${policy.type=='TERMS' ? 'selected' : '' }>Điều khoản
                                </option>
                            </select>
                        </div>
                        <div class="col-md-12 form-group">
                            <label>Slug</label>
                            <input type="text" name="slug" id="slug" class="form-control" value="${policy.slug}"
                                   required>
                        </div>
                        <div class="col-md-12 form-group">
                            <label>Nội dung</label>
                            <textarea name="content" id="policyContent" class="form-control editor"
                                      rows="15">${policy.content}</textarea>
                        </div>
                    </div>
                    <div class="mt-4">
                        <button type="submit" class="btn btn-primary px-5">Lưu chính sách</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    function generateSlug(text) {
        var slug = text.toLowerCase()
            .replace(/[áàảãạăắằẳẵặâấầẩẫậ]/g, 'a')
            .replace(/[éèẻẽẹêếềểễệ]/g, 'e')
            .replace(/[iíìỉĩị]/g, 'i')
            .replace(/[óòỏõọôốồổỗộơớờởỡợ]/g, 'o')
            .replace(/[úùủũụưứừửữự]/g, 'u')
            .replace(/[ýỳỷỹỵ]/g, 'y')
            .replace(/đ/g, 'd')
            .replace(/[^a-z0-9]/g, '-')
            .replace(/-+/g, '-')
            .replace(/^-|-$/g, '');
        $('#slug').val(slug);
    }

    $('#policyForm').on('submit', function (e) {
        e.preventDefault();
        var formData = {};
        $(this).serializeArray().forEach(function (item) {
            formData[item.name] = item.value;
        });

        $.ajax({
            url: '<c:url value="/api/admin/policy"/>',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function () {
                alert('Lưu thành công!');
                window.location.href = '<c:url value="/admin-policy-list"/>';
            }
        });
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