<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

        <!-- Select2 CSS -->
        <link rel="stylesheet" href="<c:url value='/template/admin/plugins/select2/css/select2.min.css'/>" />
        <link rel="stylesheet"
            href="<c:url value='/template/admin/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css'/>" />

        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Nhập hàng vào kho</h1>
                    </div>
                    <div class="col-sm-6 text-right">
                        <a href="<c:url value='/admin-stock-list'/>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </div>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-body">
                        <!-- Form chọn sản phẩm để lấy phiên bản -->
                        <form action="<c:url value='/admin-stock-entry'/>" method="get" class="mb-4">
                            <div class="row align-items-end">
                                <div class="col-md-6 form-group">
                                    <label>Chọn sản phẩm <span class="text-danger">*</span></label>
                                    <select name="productId" class="form-control" required>
                                        <option value="">-- Chọn sản phẩm --</option>
                                        <c:forEach var="p" items="${products}">
                                            <option value="${p.id}" ${p.id==selectedProductId ? 'selected' : '' }>
                                                ${p.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2 form-group">
                                    <button type="submit" class="btn btn-primary btn-block">
                                        <i class="fas fa-sync"></i> Lấy phiên bản
                                    </button>
                                </div>
                            </div>
                        </form>

                        <hr />

                        <!-- Form nhập kho chính -->
                        <form action="<c:url value='/admin-stock-entry'/>" method="post">
                            <input type="hidden" name="productId" value="${selectedProductId}">

                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Chọn phiên bản (nếu có)</label>
                                    <select name="variantId" class="form-control" ${empty variants ? 'disabled' : '' }>
                                        <option value="">-- Cấu hình mặc định --</option>
                                        <c:forEach var="v" items="${variants}">
                                            <option value="${v.id}">
                                                ${v.color.colorName} | ${v.ramRom.ram}/${v.ramRom.rom}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <c:if test="${empty variants && not empty selectedProductId}">
                                        <small class="text-muted">Sản phẩm này không có phiên bản riêng.</small>
                                    </c:if>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Số lượng nhập <span class="text-danger">*</span></label>
                                    <input type="number" name="quantity" class="form-control" required min="1">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Giá nhập (mỗi đơn vị) <span class="text-danger">*</span></label>
                                    <input type="number" name="entryPrice" class="form-control" required min="0"
                                        step="any">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Nhà cung cấp</label>
                                    <input type="text" name="supplier" class="form-control">
                                </div>
                                <div class="col-md-12 form-group">
                                    <label>Ghi chú</label>
                                    <textarea name="note" class="form-control" rows="3"></textarea>
                                </div>
                            </div>

                            <div class="mt-4">
                                <button type="submit" class="btn btn-success px-5" ${empty selectedProductId
                                    ? 'disabled' : '' }>
                                    Xác nhận nhập kho
                                </button>
                                <c:if test="${empty selectedProductId}">
                                    <p class="text-danger mt-2 small">Vui lòng chọn sản phẩm và nhấn "Lấy phiên bản"
                                        trước.</p>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>