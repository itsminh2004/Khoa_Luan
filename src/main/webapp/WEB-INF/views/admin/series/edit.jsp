<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-plus-circle mr-2"></i>Cập nhật series</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-series">Series sản phẩm</a>
                    </li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- Form cập nhật series -->
<section class="content">
    <div class="container-fluid">
        <div class="card">


                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-layer-group mr-2"></i>
                        Chỉnh sửa thông tin series
                    </h3>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin-series/edit/${series.id}" method="post">
                        <input type="hidden" name="id" value="${series.id}" />

                        <div class="form-column">
                            <div class="form-group">
                                <label>
                                    <i class="fas fa-tag"></i>
                                    Tên series
                                    <span class="text-danger">*</span>
                                </label>
                                <input type="text" name="name" class="form-control"
                                       value="${series.name}" required placeholder="Nhập tên series">
                            </div>

                            <div class="form-group">
                                <label>
                                    <i class="fas fa-folder-open"></i>
                                    Danh mục sản phẩm
                                    <span class="text-danger">*</span>
                                </label>
                                <select name="categoryId" class="form-control" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <c:forEach var="cate" items="${productCategories}">
                                        <option value="${cate.id}" <c:if test="${cate.id == series.categoryId}">selected</c:if>>
                                                ${cate.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="d-flex justify-content-between mt-4">
                                <a href="${pageContext.request.contextPath}/admin-series" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i>
                                    Quay lại
                                </a>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save"></i>
                                    Cập nhật series
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
</section>


