<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Thêm mới danh mục gốc</h1>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body">
                <form:form method="post" action="${pageContext.request.contextPath}/admin-root-category-add"
                           modelAttribute="rootCategory" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>Tên</label>
                        <form:input path="name" cssClass="form-control" required="required" />
                    </div>
                    <div class="form-group">
                        <label>Mô tả</label>
                        <form:textarea path="description" cssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Alias</label>
                        <form:input path="alias" cssClass="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Hình ảnh</label>
                        <input type="file" name="fileAnh" class="form-control" />
                    </div>
                    <div class="form-actions mt-3">
                        <button type="submit" class="btn btn-success">Lưu</button>
                        <a href="<c:url value='/admin-root-category'/>" class="btn btn-secondary">Hủy</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>