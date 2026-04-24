<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Sửa danh mục Blog</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="<c:url value='/admin-blog-category'/>">Danh mục Blog</a></li>
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
                <form action="${pageContext.request.contextPath}/admin-blog-category/edit" method="post">
                    <input type="hidden" name="id" value="${category.id}" />

                    <div class="form-group">
                        <label>Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" name="name" value="${category.name}" class="form-control" required="required" maxlength="100" />
                    </div>

                    <div class="form-group">
                        <label>Slug</label>
                        <input type="text" name="slug" value="${category.slug}" class="form-control" />
                    </div>

                    <div class="form-group">
                        <label>Mô tả</label>
                        <textarea name="description" rows="5" class="form-control">${category.description}</textarea>
                    </div>

                    <div class="form-actions mt-3">
                        <button type="submit" class="btn btn-success">Cập nhật</button>
                        <a href="<c:url value='/admin-blog-category'/>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>