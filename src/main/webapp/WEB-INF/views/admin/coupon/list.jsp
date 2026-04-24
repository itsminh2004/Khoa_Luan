<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý mã giảm giá</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang
                        chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý mã giảm giá</li>
                </ol>
            </div>
        </div>
    </div>
</section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class ="card-header">
                        <h3 class="card-title">Quản lý mã giảm giá</h3>
                        <div class="card-tools">
                            <a href="${pageContext.request.contextPath}/admin-coupon-edit" class="btn btn-primary ">
                                <i class="fas fa-plus"></i> Thêm mới
                            </a>
                        </div>
                    </div>
                    <div class="card-body ">
                        <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead >
                                <tr>
                                    <th>ID</th>
                                    <th>Mã code</th>
                                    <th>Giảm giá</th>
                                    <th>Đơn tối thiểu</th>
                                    <th>Hết hạn</th>
                                    <th>Đã dùng</th>
                                    <th>Trạng thái</th>
                                    <th class="text-right">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${coupons}">
                                    <tr>
                                        <td>${item.id}</td>
                                        <td><span class="badge badge-info p-2">${item.code}</span></td>
                                        <td>
                                            <strong>
                                                <fmt:formatNumber value="${item.discountValue}" type="number" />
                                                <c:choose>
                                                    <c:when test="${item.discountType == 'PERCENT'}">%</c:when>
                                                    <c:otherwise>₫</c:otherwise>
                                                </c:choose>
                                            </strong>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${item.minOrderAmount}" type="number" /> ₫
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${item.endDate}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td>${item.usedCount} / ${item.usageLimit != null ? item.usageLimit : '∞'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.status}">
                                                    <span class="badge badge-success">Kích hoạt</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">Tắt</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-right">
                                            <a href="<c:url value='/admin-coupon-edit?id=${item.id}'/>"
                                                class="btn btn-sm btn-info">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<c:url value='/admin-coupon-delete/${item.id}'/>"
                                                class="btn btn-sm btn-danger btn-delete-coupon" title="Xóa"
                                                onclick="return confirm('Bạn có chắc muốn xóa danh mục này?')">
                                                <i class="fas fa-trash"></i>
                                            </a>

                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty coupons}">
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">Chưa có mã giảm giá nào.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    </div>
                </div>
            </div>
        </section>
