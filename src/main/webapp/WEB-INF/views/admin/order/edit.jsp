<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<!-- HEADER -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center mb-2">
            <div class="col-sm-6">
                <h1>Sửa đơn hàng #${order.id}</h1>
            </div>
            <div class="col-sm-6 text-right">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-orders">Đơn hàng</a>
                    </li>
                    <li class="breadcrumb-item active">Chỉnh sửa</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- CONTENT -->
<section class="content">
    <div class="container-fluid">

        <div class="row justify-content-center">
            <div class="col-md-8">

                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center w-100">
                            <h3 class="card-title mb-0">Thông tin đơn hàng</h3>

                            <a href="${pageContext.request.contextPath}/admin-orders"
                               class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-arrow-left mr-1"></i> Quay lại
                            </a>
                        </div>
                    </div>

                    <div class="card-body">

                        <form method="post"
                              action="${pageContext.request.contextPath}/admin-orders/edit/${order.id}">

                            <!-- Customer -->
                            <div class="form-group">
                                <label>Tên khách hàng</label>
                                <input type="text" class="form-control"
                                       name="customerName"
                                       value="${order.customerName}" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Số điện thoại</label>
                                        <input type="text" class="form-control"
                                               name="phone"
                                               value="${order.phone}" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Trạng thái</label>
                                        <select class="form-control" name="status" required>
                                            <c:forEach var="status" items="${statuses}">
                                                <option value="${status}"
                                                        <c:if test="${status == order.status}">selected</c:if>>
                                                    <c:choose>
                                                        <c:when test="${status eq 'PENDING'}">Chờ xác nhận</c:when>
                                                        <c:when test="${status eq 'CONFIRMED'}">Đã xác nhận</c:when>
                                                        <c:when test="${status eq 'SHIPPING'}">Đang giao</c:when>
                                                        <c:when test="${status eq 'DELIVERED'}">Đã giao</c:when>
                                                        <c:when test="${status eq 'CANCELLED'}">Đã hủy</c:when>
                                                        <c:otherwise>${status}</c:otherwise>
                                                    </c:choose>
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Address -->
                            <div class="form-group">
                                <label>Địa chỉ giao hàng</label>
                                <textarea class="form-control"
                                          rows="2"
                                          name="shippingAddress"
                                          required>${order.shippingAddress}</textarea>
                            </div>

                            <!-- PRODUCTS -->
                            <div class="mt-4">
                                <h6 class="text-muted text-uppercase mb-3">
                                    <i class="fas fa-shopping-bag mr-1"></i> Sản phẩm
                                </h6>

                                <div class="border rounded p-3">

                                    <c:forEach var="item" items="${order.items}">
                                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">

                                            <!-- LEFT -->
                                            <div class="d-flex align-items-center">

                                                <c:if test="${not empty item.product.image}">
                                                    <img src="${pageContext.request.contextPath}${item.product.image}"
                                                         class="mr-3 rounded"
                                                         style="width:60px;height:60px;object-fit:cover;"
                                                         onerror="this.src='${pageContext.request.contextPath}/template/admin/dist/img/no-image.png';">
                                                </c:if>

                                                <div>
                                                    <div class="font-weight-bold">
                                                            ${item.product.name}
                                                    </div>

                                                    <small class="text-muted">
                                                        <c:if test="${not empty item.variant}">
                                                            ${not empty item.variant.color ? item.variant.color.colorName : 'N/A'}
                                                            -
                                                            ${not empty item.variant.ramRom ? item.variant.ramRom.ram.concat("/").concat(item.variant.ramRom.rom) : 'N/A'}
                                                        </c:if>
                                                    </small>
                                                </div>

                                            </div>

                                            <!-- RIGHT -->
                                            <div class="text-right">
                                                <div class="font-weight-bold">
                                                    <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> ₫
                                                </div>
                                                <small class="text-muted">
                                                    SL: ${item.quantity}
                                                </small>
                                            </div>

                                        </div>
                                    </c:forEach>

                                    <!-- TOTAL -->
                                    <div class="d-flex justify-content-between mt-3 pt-2">
                                        <strong>Tổng cộng:</strong>
                                        <strong class="text-danger">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫
                                        </strong>
                                    </div>

                                </div>
                            </div>

                            <!-- ACTION -->
                            <div class="d-flex justify-content-between align-items-center mt-4">

                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Cập nhật
                                </button>

                                <a href="${pageContext.request.contextPath}/admin-orders/delete/${order.id}"
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Xóa đơn hàng #${order.id}?');">
                                    <i class="fas fa-trash"></i> Xóa
                                </a>

                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </div>

    </div>
</section>