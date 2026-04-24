<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Lịch sử nhập kho</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang
                        chủ</a></li>
                    <li class="breadcrumb-item active">Lịch sử nhập kho</li>
                </ol>
            </div>
        </div>
    </div>
</section>
        <section class="content">
            <div class="container-fluid">

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Lịch sử nhập kho</h3>
                        <div class="card-tools">
                            <a href="${pageContext.request.contextPath}/admin-stock-entry" class="btn btn-primary ">
                                <i class="fas fa-plus"></i> Nhập hàng mới
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead >
                                <tr>
                                    <th>Ngày nhập</th>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Giá nhập</th>
                                    <th>Nhà cung cấp</th>
                                    <th>Ghi chú</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="item" items="${stockEntries}">
                                    <tr>
                                        <td>
                                            <fmt:formatDate value="${item.entryDate}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <strong>${item.productName}</strong>
                                            <c:if test="${not empty item.variantName}">
                                                <br><small class="text-muted">${item.variantName}</small>
                                            </c:if>
                                        </td>
                                        <td><span class="text-success font-weight-bold">+${item.quantity}</span></td>
                                        <td>
                                            <fmt:formatNumber value="${item.entryPrice}" type="number" /> ₫
                                        </td>
                                        <td>${item.supplier}</td>
                                        <td>${item.note}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty stockEntries}">
                                    <tr>
                                        <td colspan="6" class="text-center py-5 text-muted">Chưa có lịch sử nhập kho.
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