<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý bài viết Blog</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item active">Bài viết Blog</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách bài viết</h3>
                <div class="card-tools">
                    <a href="<c:url value='/admin-blog-post/add'/>" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Viết bài mới
                    </a>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tiêu đề</th>
                        <th>Danh mục</th>
                        <th>Tác giả</th>
                        <th>Trạng thái</th>
                        <th>Ngày tạo</th>
                        <th>Chức năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${posts}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <div><strong>${p.title}</strong></div>
                                <c:if test="${not empty p.slug}">
                                    <small class="text-muted">/${p.slug}</small>
                                </c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty p.categoryName}">
                                        ${p.categoryName}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Chưa có</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${p.authorName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.status == 'PUBLISHED'}">
                                        <span class="badge badge-success">PUBLISHED</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-secondary">DRAFT</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td class="text-right align-middle">
                                <div class="d-flex justify-content-end align-items-center" style="gap: 6px; flex-wrap: nowrap;">
                                    <a href="<c:url value='/admin-blog-post/edit/${p.id}'/>"
                                       class="btn btn-sm btn-info"
                                       title="Sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>

                                    <a href="<c:url value='/admin-blog-post/toggle-status/${p.id}'/>"
                                       class="btn btn-sm btn-success btn-toggle-fixed"
                                       title="Đổi trạng thái">
                                        <i class="fas fa-power-off"></i>
                                    </a>

                                    <a href="<c:url value='/admin-blog-post/delete/${p.id}'/>"
                                       class="btn btn-sm btn-danger"
                                       title="Xóa"
                                       onclick="return confirm('Xóa bài viết [${p.title}]?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>