<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>${pageTitle}</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý bình luận</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách bình luận</h3>
                <div class="card-tools">
                    <form class="form-inline" method="get" action="${pageContext.request.contextPath}/admin-blog-comment">
                        <div class="input-group input-group-sm" style="width: 520px;">
                            <select name="postId" class="form-control">
                                <option value="">Tất cả bài viết</option>
                                <c:forEach items="${posts}" var="post">
                                    <option value="${post.id}" ${selectedPostId == post.id ? 'selected' : ''}>${post.title}</option>
                                </c:forEach>
                            </select>
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Bình luận</th>
                        <th>Bài viết</th>
                        <th>Người bình luận</th>
                        <th>Thời gian</th>
                        <th>Chức năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty comments}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">Chưa có bình luận nào</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${comments}" var="c">
                        <tr>
                            <td>${c.id}</td>
                            <td>${c.comment}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty c.postTitle}">
                                        ${c.postTitle}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Không xác định</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${c.commenterName != null ? c.commenterName : 'Ẩn danh'}</td>
                            <td><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td class="text-center">
                                <c:url var="deleteUrl" value="/admin-blog-comment/delete/${c.id}">
                                    <c:if test="${not empty selectedPostId}">
                                        <c:param name="postId" value="${selectedPostId}"/>
                                    </c:if>
                                </c:url>
                                <a href="${deleteUrl}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Xóa bình luận này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>