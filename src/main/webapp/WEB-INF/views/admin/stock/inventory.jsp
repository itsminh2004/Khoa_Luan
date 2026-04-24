<!-- Đường dẫn: e:\1\Khoa_Luan\src\main\webapp\WEB-INF\views\admin\stock\inventory.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý tồn kho</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang
                        chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý tồn kho</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách Sản phẩm trong Kho</h3>
                <div class="card-tools">
                    <a href="<c:url value='/admin-stock-list'/>" class="btn btn-primary">
                        <i class="fas fa-history mr-1"></i> Xem Lịch sử nhập kho
                    </a>
                </div>
            </div>
            <div class="card-body ">
                <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th style="width: 80px;">Ảnh</th>
                        <th>Tên Sản phẩm</th>
                        <th>Phân loại/Biến thể</th>
                        <th style="width: 150px;">Tồn kho</th>
                        <th style="width: 150px;">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${products}">
                        <!-- Nếu sản phẩm không có biến thể -->
                        <c:if test="${not p.hasVariants}">
                            <tr>
                                <td class="text-center">
                                    <c:if test="${not empty p.image}">
                                    <img src="${pageContext.request.contextPath}${p.image}" width="50" height="50" style="object-fit: cover; border-radius: 5px; border: 1px solid #ddd;"/>
                                    </c:if>
                                </td>
                                <td><strong>${p.name}</strong></td>
                                <td class="text-center">Không có phiên bản màu sắc và cấu hình</td>
                                <td class="text-center">
                                        <span class="badge ${p.stock < 10 ? 'badge-danger' : 'badge-success'}" style="font-size: 1rem;">
                                                ${p.stock}
                                        </span>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin-stock-entry?productId=${p.id}'/>" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus-circle"></i> Nhập kho
                                    </a>
                                </td>
                            </tr>
                        </c:if>

                        <!-- Nếu sản phẩm có biến thể (Màu sắc, RAM/ROM) -->
                        <c:if test="${p.hasVariants}">
                            <c:forEach var="v" items="${p.variants}" varStatus="loop">
                                <tr>
                                    <!-- Chỉ hiển thị ảnh và tên SP ở dòng đầu tiên của cụm biến thể -->
                                    <c:if test="${loop.first}">
                                        <td rowspan="${fn:length(p.variants)}" class="text-center align-middle">
                                            <c:if test="${not empty p.image}">
                                                <img src="${pageContext.request.contextPath}${p.image}" width="50" height="50" style="object-fit: cover; border-radius: 5px; border: 1px solid #ddd;"/>
                                            </c:if>
                                        </td>
                                        <td rowspan="${fn:length(p.variants)}" class="align-middle">
                                            <strong>${p.name}</strong>
                                        </td>
                                    </c:if>
                                    <td>
                                            ${v.color.colorName}
                                        <c:if test="${not empty v.ramRom}"> - ${v.ramRom.ram}/${v.ramRom.rom}</c:if>
                                    </td>
                                    <td class="text-center font-weight-bold">
                                            <span class="badge ${v.stock < 10 ? 'badge-danger' : 'badge-warning'}">
                                                    ${v.stock}
                                            </span>
                                    </td>
                                    <td class="text-center">
                                        <a href="<c:url value='/admin-stock-entry?productId=${p.id}&variantId=${v.id}'/>" class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-edit"></i> Cập nhật
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </div>
</section>
