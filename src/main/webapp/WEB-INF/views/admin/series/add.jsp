<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-plus-circle mr-2"></i>Thêm series mới</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home"><i class="fas fa-home"></i> Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-series">Series sản phẩm</a>
                    </li>
                    <li class="breadcrumb-item active">Thêm mới</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Form thêm series -->
<section class="content">
    <div class="container-fluid">
        <div class="admin-form-wrapper">
            <div class="admin-card">
                <div class="admin-card-header">
                    <h3 class="admin-card-title">
                        <i class="fas fa-layer-group mr-2"></i>
                        Thông tin series sản phẩm
                    </h3>
                </div>
                <div class="admin-card-body">
                    <form action="${pageContext.request.contextPath}/admin-series-add" method="post">
                        <div class="admin-form-column">
                            <div class="admin-form-group">
                                <label>
                                    <i class="fas fa-tag"></i>
                                    Tên series
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="name" class="admin-form-control" placeholder="Ví dụ: iPhone 15 Series" required />
                            </div>

                            <div class="admin-form-group">
                                <label>
                                    <i class="fas fa-folder-open"></i>
                                    Danh mục sản phẩm
                                    <span class="text-danger">*</span>
                                </label>
                                <select name="categoryId" class="admin-form-control" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="cate" items="${productCategories}">
                                        <option value="${cate.id}">${cate.name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="admin-form-actions">
                                <a href="${pageContext.request.contextPath}/admin-series" class="admin-btn admin-btn-secondary">
                                    <i class="fas fa-arrow-left"></i>
                                    Quay lại
                                </a>
                                <button type="submit" class="admin-btn admin-btn-primary">
                                    <i class="fas fa-plus-circle"></i>
                                    Thêm series
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
