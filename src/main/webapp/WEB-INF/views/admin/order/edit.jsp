<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    /* Tổng thể Card tối giản */
    .card-edit {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        overflow: hidden;
        max-width: 800px;
        margin: 0 auto; /* Căn giữa trang cho chuyên nghiệp */
    }

    .card-header-edit {
        background: #fff;
        padding: 1.5rem 2rem;
        border-bottom: 1px solid #f1f5f9;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .card-header-edit h5 {
        font-weight: 700;
        color: #0f172a;
        margin: 0;
        font-size: 1.25rem;
    }

    .card-body-edit {
        padding: 2rem;
    }

    /* Định dạng Form */
    .form-group-custom {
        margin-bottom: 1.5rem;
    }

    .label-custom {
        display: block;
        font-size: 0.8rem;
        font-weight: 600;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 0.025em;
        margin-bottom: 0.5rem;
    }

    .form-control-custom {
        width: 100%;
        padding: 0.6rem 1rem;
        font-size: 1rem;
        color: #1e293b;
        background-color: #fff;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        transition: all 0.2s;
    }

    .form-control-custom:focus {
        outline: none;
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    /* Dropdown select */
    .form-select-custom {
        appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%2364748b' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 0.7rem center;
        background-size: 1.5em 1.5em;
        padding-right: 2.5rem;
    }

    /* Nút bấm */
    .btn-save {
        background: #2563eb;
        color: white;
        border: none;
        padding: 0.6rem 2rem;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.2s;
    }

    .btn-save:hover {
        background: #1d4ed8;
    }

    .btn-cancel {
        color: #64748b;
        background: #f1f5f9;
        border: none;
        padding: 0.6rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s;
    }

    .btn-cancel:hover {
        background: #e2e8f0;
        color: #1e293b;
    }

    .btn-delete-link {
        color: #ef4444;
        font-size: 0.9rem;
        font-weight: 500;
        text-decoration: none;
        padding: 0.6rem;
    }

    .btn-delete-link:hover {
        text-decoration: underline;
    }
</style>

<div class="card-edit">
    <div class="card-header-edit">
        <h5>Sửa đơn hàng #${order.id}</h5>
        <a href="${pageContext.request.contextPath}/admin-orders" class="btn-cancel">
            <i class="fas fa-chevron-left mr-1"></i> Trở về
        </a>
    </div>

    <div class="card-body-edit">
        <form method="post" action="${pageContext.request.contextPath}/admin-orders/edit/${order.id}">

            <div class="form-group-custom">
                <label class="label-custom">Tên khách hàng</label>
                <input type="text" class="form-control-custom" name="customerName" value="${order.customerName}" required>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group-custom">
                        <label class="label-custom">Số điện thoại</label>
                        <input type="text" class="form-control-custom" name="phone" value="${order.phone}" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group-custom">
                        <label class="label-custom">Trạng thái xử lý</label>
                        <select class="form-control-custom form-select-custom" name="status" required>
                            <c:forEach var="status" items="${statuses}">
                                <option value="${status}" <c:if test="${status == order.status}">selected</c:if>>
                                    <c:choose>
                                        <c:when test="${status eq 'PENDING'}">Chờ xác nhận</c:when>
                                        <c:when test="${status eq 'CONFIRMED'}">Đã xác nhận</c:when>
                                        <c:when test="${status eq 'SHIPPING'}">Đang giao hàng</c:when>
                                        <c:when test="${status eq 'DELIVERED'}">Giao thành công</c:when>
                                        <c:when test="${status eq 'CANCELLED'}">Đã hủy bỏ</c:when>
                                        <c:otherwise>${status}</c:otherwise>
                                    </c:choose>
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group-custom">
                <label class="label-custom">Địa chỉ nhận hàng</label>
                <textarea class="form-control-custom" rows="3" name="shippingAddress" required>${order.shippingAddress}</textarea>
            </div>

            <hr class="my-4" style="border-color: #f1f5f9;">

            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <button type="submit" class="btn-save">
                        Cập nhật đơn hàng
                    </button>
                </div>
                <a href="${pageContext.request.contextPath}/admin-orders/delete/${order.id}"
                   class="btn-delete-link"
                   onclick="return confirm('Xóa vĩnh viễn đơn hàng #${order.id}?');">
                    <i class="fas fa-trash-alt mr-1"></i> Xóa đơn hàng
                </a>
            </div>
        </form>
    </div>
</div>