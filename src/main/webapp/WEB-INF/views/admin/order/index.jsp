<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    /* Tổng thể tinh tế */
    .card {
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        background: #fff;
    }

    .card-header {
        background: #fff;
        border-bottom: 1px solid #f1f5f9;
        padding: 1.5rem;
    }

    /* Bảng tối giản */
    .table {
        margin-bottom: 0;
    }

    .table thead th {
        background: #f8fafc;
        color: #64748b;
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        font-weight: 600;
        border-top: none;
        border-bottom: 1px solid #e2e8f0;
        padding: 1rem;
    }

    .table tbody td {
        padding: 1.2rem 1rem;
        vertical-align: middle;
        border-bottom: 1px solid #f1f5f9;
        color: #334155;
    }

    /* Dòng chi tiết sản phẩm */
    .order-details-row {
        background-color: #fcfdfe;
    }

    .details-container {
        padding: 1rem 1.5rem;
        border-radius: 8px;
        background: #f8fafc;
        margin: 0.5rem 1rem 1rem 1rem;
        border: 1px solid #edf2f7;
    }

    /* Badge phong cách Soft UI */
    .badge {
        padding: 0.5em 0.8em;
        font-weight: 500;
        border-radius: 6px;
        font-size: 0.75rem;
    }
    .bg-warning-soft { background: #fef3c7; color: #92400e; }
    .bg-info-soft { background: #e0f2fe; color: #075985; }
    .bg-primary-soft { background: #e0e7ff; color: #3730a3; }
    .bg-success-soft { background: #dcfce7; color: #166534; }
    .bg-danger-soft { background: #fee2e2; color: #991b1b; }

    /* Nút thao tác gọn gàng */
    .btn-action {
        padding: 0.4rem 0.8rem;
        font-size: 0.8rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.2s;
    }

    .text-amount {
        color: #0f172a;
        font-weight: 700;
        font-family: 'Inter', sans-serif;
    }
</style>

<div class="card">
    <div class="card-header">
        <h5 class="mb-1 font-weight-bold text-dark">${pageTitle}</h5>
        <p class="mb-0 text-muted small">Quản lý trạng thái và thông tin vận chuyển đơn hàng.</p>
    </div>

    <div class="card-body p-0">
        <c:if test="${not empty message}">
            <div class="alert alert-success m-3 border-0" style="background: #dcfce7; color: #166534;">${message}</div>
        </c:if>

        <c:if test="${empty orders}">
            <div class="p-5 text-center text-muted">
                <i class="fas fa-inbox fa-3x mb-3" style="opacity: 0.2;"></i>
                <p>Chưa có đơn hàng nào trong hệ thống.</p>
            </div>
        </c:if>

        <c:if test="${not empty orders}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                    <tr>
                        <th class="text-center">ID</th>
                        <th>Khách hàng</th>
                        <th>Địa chỉ giao hàng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th class="text-right">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td class="text-center"><strong>#${order.id}</strong></td>
                            <td>
                                <div class="font-weight-bold">${order.customerName}</div>
                                <div class="small text-muted">${order.phone}</div>
                            </td>
                            <td>
                                <div class="small text-truncate" style="max-width: 200px;" title="${order.shippingAddress}">
                                        ${order.shippingAddress}
                                </div>
                            </td>
                            <td>
                                    <span class="text-amount">
                                        <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> ₫
                                    </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status eq 'PENDING'}">
                                        <span class="badge bg-warning-soft">Chờ xác nhận</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'CONFIRMED'}">
                                        <span class="badge bg-info-soft">Đã xác nhận</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'SHIPPING'}">
                                        <span class="badge bg-primary-soft">Đang giao</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'DELIVERED'}">
                                        <span class="badge bg-success-soft">Đã giao</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'CANCELLED'}">
                                        <span class="badge bg-danger-soft">Đã hủy</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light text-muted">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="small">${order.createdAt}</div>
                            </td>
                            <td class="text-right">
                                <a href="${pageContext.request.contextPath}/admin-orders/edit/${order.id}"
                                   class="btn-action btn btn-light border text-primary mr-1">
                                    <i class="fas fa-edit mr-1"></i> Sửa
                                </a>
                                <a href="${pageContext.request.contextPath}/admin-orders/delete/${order.id}"
                                   class="btn-action btn btn-light border text-danger"
                                   onclick="return confirm('Xóa đơn hàng #${order.id}?');">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <tr class="order-details-row">
                            <td colspan="7" class="p-0 border-0">
                                <div class="details-container">
                                    <div class="d-flex align-items-center mb-2">
                                        <span class="badge bg-white border text-muted mr-2">Sản phẩm (${fn:length(order.items)})</span>
                                    </div>
                                    <div class="row">
                                        <c:forEach var="item" items="${order.items}">
                                            <div class="col-md-4 mb-1">
                                                <div class="small d-flex justify-content-between bg-white p-2 rounded border-sm">
                                                        <span class="text-truncate mr-2" style="max-width: 150px;">
                                                                ${item.product != null ? item.product.name : 'Sản phẩm #'.concat(item.productId)}
                                                        </span>
                                                    <span class="text-muted">x${item.quantity}</span>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
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