<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<!-- HEADER -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center mb-2">
            <div class="col-sm-6">
                <h1>Quản lý đơn hàng</h1>
            </div>
            <div class="col-sm-6 text-right">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item active">Đơn hàng</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<!-- CONTENT -->
<section class="content">
    <div class="container-fluid">

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="card-title mb-0">${pageTitle}</h3>

                    <small class="text-muted">   Quản lý trạng thái và vận chuyển đơn hàng</small>
                </div>
            </div>

            <div class="card-body p-0">

                <!-- ALERT -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success m-3">
                            ${message}
                    </div>
                </c:if>

                <!-- EMPTY -->
                <c:if test="${empty orders}">
                    <div class="p-5 text-center text-muted">
                        <i class="fas fa-inbox fa-3x mb-3"></i>
                        <p>Chưa có đơn hàng nào trong hệ thống.</p>
                    </div>
                </c:if>

                <!-- TABLE -->
                <c:if test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover mb-0">
                            <thead class="thead-light">
                            <tr>
                                <th class="text-center">ID</th>
                                <th>Khách hàng</th>
                                <th>SĐT</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th class="text-right">Thao tác</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="text-center">
                                        <strong>#${order.id}</strong>
                                    </td>

                                    <td>${order.customerName}</td>

                                    <td>${order.phone}</td>

                                    <td>
                                        <strong>
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" /> ₫
                                        </strong>
                                    </td>

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

                                    <td>
                                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>

                                    <!-- ACTION -->
                                    <td class="text-right">
                                        <div class="d-flex justify-content-end" style="gap: 6px;">

                                            <a href="${pageContext.request.contextPath}/admin-orders/detail/${order.id}"
                                               class="btn btn-sm btn-info"
                                               title="Xem">
                                                <i class="fas fa-eye"></i>
                                            </a>

                                            <a href="${pageContext.request.contextPath}/admin-orders/edit/${order.id}"
                                               class="btn btn-sm btn-primary"
                                               title="Sửa">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <a href="${pageContext.request.contextPath}/admin-orders/delete/${order.id}"
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Xóa đơn hàng #${order.id}?');"
                                               title="Xóa">
                                                <i class="fas fa-trash"></i>
                                            </a>

                                        </div>
                                    </td>

                                </tr>
                            </c:forEach>
                            </tbody>

                        </table>
                    </div>
                </c:if>

            </div>
        </div>

    </div>
</section>