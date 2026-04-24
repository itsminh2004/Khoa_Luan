<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Sửa danh mục gốc</h1>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body">
                <form:form method="post"
                           action="${pageContext.request.contextPath}/admin-root-category-edit/${rootCategoryEdit.id}"
                           modelAttribute="rootCategoryEdit" enctype="multipart/form-data">
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
                        <label>Hình ảnh hiện tại</label>
                        <div>
                            <c:if test="${not empty rootCategoryEdit.image}">
                                <img src="${pageContext.request.contextPath}${rootCategoryEdit.image}"
                                     width="150" class="mb-2" />
                            </c:if>
                        </div>
                        <label>Thay ảnh mới</label>
                        <input type="file" name="fileAnh" class="form-control" />
                    </div>
                    <div class="form-actions mt-3">
                        <button type="submit" class="btn btn-success">Cập nhật</button>
                        <a href="<c:url value='/admin-root-category'/>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>