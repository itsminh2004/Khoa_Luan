<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<!-- HEADER -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center mb-2">
            <div class="col-sm-6">
                <h1>Chi tiết đơn hàng #${order.id}</h1>
            </div>
            <div class="col-sm-6 text-right">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-orders">Đơn hàng</a>
                    </li>
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- CONTENT -->
<section class="content">
    <div class="container-fluid">

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

                <!-- INFO -->
                <div class="row">

                    <!-- Khách hàng -->
                    <div class="col-md-6 mb-4">
                        <h6 class="text-muted text-uppercase">Thông tin khách hàng</h6>
                        <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width:150px;">Họ tên:</th>
                                <td>${order.customerName}</td>
                            </tr>
                            <tr>
                                <th>SĐT:</th>
                                <td>${order.phone}</td>
                            </tr>
                            <tr>
                                <th>Địa chỉ:</th>
                                <td>${order.shippingAddress}</td>
                            </tr>
                        </table>
                    </div>

                    <!-- Đơn hàng -->
                    <div class="col-md-6 mb-4">
                        <h6 class="text-muted text-uppercase">Thông tin đơn hàng</h6>
                        <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width:150px;">Ngày tạo:</th>
                                <td>
                                    <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                            </tr>
                            <tr>
                                <th>Trạng thái:</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status eq 'PENDING'}">
                                            <span class="badge badge-warning">Chờ xác nhận</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'CONFIRMED'}">
                                            <span class="badge badge-info">Đã xác nhận</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'SHIPPING'}">
                                            <span class="badge badge-primary">Đang giao</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'DELIVERED'}">
                                            <span class="badge badge-success">Đã giao</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'CANCELLED'}">
                                            <span class="badge badge-danger">Đã hủy</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>Thanh toán:</th>
                                <td>${order.paymentMethod}</td>
                            </tr>
                        </table>
                    </div>

                </div>

                <!-- PRODUCTS -->
                <h6 class="text-muted text-uppercase mb-3">Danh sách sản phẩm</h6>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light">
                        <tr>
                            <th class="text-center" style="width:50px;">#</th>
                            <th>Sản phẩm</th>
                            <th class="text-center">SL</th>
                            <th class="text-right">Đơn giá</th>
                            <th class="text-right">Thành tiền</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="item" items="${order.items}" varStatus="status">
                            <tr>
                                <td class="text-center">${status.index + 1}</td>

                                <td>
                                    <div class="font-weight-bold">
                                            ${item.product != null ? item.product.name : 'Sản phẩm #' += item.productId}
                                    </div>

                                    <c:if test="${not empty item.variant}">
                                        <small class="text-muted">
                                                ${not empty item.variant.color ? item.variant.color.colorName : 'N/A'}
                                            -
                                                ${not empty item.variant.ramRom ? item.variant.ramRom.ram.concat("/").concat(item.variant.ramRom.rom) : 'N/A'}
                                        </small>
                                    </c:if>
                                </td>

                                <td class="text-center">${item.quantity}</td>

                                <td class="text-right">
                                    <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> ₫
                                </td>

                                <td class="text-right">
                                    <fmt:formatNumber value="${item.price * item.quantity}" type="number" groupingUsed="true"/> ₫
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>

                        <tfoot>
                        <tr>
                            <th colspan="4" class="text-right">Tổng:</th>
                            <th class="text-right text-danger">
                                <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫
                            </th>
                        </tr>
                        </tfoot>
                    </table>
                </div>

                <!-- ACTION -->
                <div class="mt-3 text-right">
                    <a href="${pageContext.request.contextPath}/admin-orders/edit/${order.id}"
                       class="btn btn-primary">
                        <i class="fas fa-edit"></i> Chỉnh sửa
                    </a>
                </div>

            </div>
        </div>

    </div>
</section>