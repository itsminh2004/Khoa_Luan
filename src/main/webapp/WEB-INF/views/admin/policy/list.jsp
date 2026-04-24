<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Chính sách cửa hàng</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang
                        chủ</a></li>
                    <li class="breadcrumb-item active">Chính sách cửa hàng</li>
                </ol>
            </div>
        </div>
    </div>
</section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Chính sách cửa hàng</h3>
                        <div class="card-tools">
                            <a href="${pageContext.request.contextPath}/admin-policy-edit" class="btn btn-primary ">
                                <i class="fas fa-plus"></i> Thêm mới
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="bg-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Tiêu đề</th>
                                    <th>Đường dẫn (Slug)</th>
                                    <th>Loại</th>
                                    <th>Cập nhật cuối</th>
                                    <th class="text-right">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${policies}">
                                    <tr>
                                        <td>${item.id}</td>
                                        <td><strong>${item.title}</strong></td>
                                        <td><small>`${item.slug}`</small></td>
                                        <td><span class="badge badge-info">${item.type}</span></td>
                                        <td>
                                            <fmt:formatDate value="${item.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td class="text-right">
                                            <a href="<c:url value='/admin-policy-edit?id=${item.id}'/>"
                                                class="btn btn-sm btn-info">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                             <a href="<c:url value='/admin-policy-delete/${item.id}'/>"
                                                class="btn btn-sm btn-danger btn-delete-policy" title="Xóa"
                                                onclick="return confirm('Bạn có chắc muốn xóa chính sách này?')">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty policies}">
                                    <tr>
                                        <td colspan="6" class="text-center py-5">Chưa có chính sách nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            </div>
        </section>

