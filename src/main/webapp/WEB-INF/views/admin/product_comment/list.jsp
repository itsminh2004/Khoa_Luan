<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Bình luận và hỏi đáp</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Bình luận và hỏi đáp</li>
                </ol>
            </div>
        </div>
    </div>
</section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Bình luận và hỏi đáp</h3>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead >
                                <tr>
                                    <th>ID</th>
                                    <th>Sản phẩm</th>
                                    <th>Người dùng</th>
                                    <th>Nội dung</th>
                                    <th>Ngày</th>
                                    <th>Vai trò</th>
                                    <th class="text-right">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${comments}">
                                    <!-- Comment chính -->
                                    <tr class="${item.adminReply ? 'bg-light' : ''}">
                                        <td>${item.id}</td>
                                        <td>
                                            <strong>${item.productName}</strong><br>
                                            <small class="text-muted">ID: ${item.productId}</small>
                                        </td>
                                        <td><strong>${item.userName}</strong></td>
                                        <td>
                                            ${item.comment}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.adminReply}">
                                                    <span class="badge badge-primary">Admin</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-info">Khách hàng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-right">
                                            <c:if test="${!item.adminReply}">
                                                <!-- Nút hiển thị form trả lời -->
                                                <c:choose>
                                                    <c:when test="${param.replyTo == item.id}">
                                                        <!-- Nếu đang hiển thị form, hiển thị nút Hủy -->
                                                        <a href="<c:url value='/admin-product-comment-list'/>"
                                                            class="btn btn-sm btn-secondary">Hủy</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Nếu chưa hiển thị form, hiển thị nút Trả lời -->
                                                        <a href="<c:url value='/admin-product-comment-list?replyTo=${item.id}'/>"
                                                            class="btn btn-sm btn-success">Trả lời</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <a href="<c:url value='/admin-product-comment-delete/${item.id}'/>"
                                                class="btn btn-sm btn-danger btn-delete-policy" title="Xóa"
                                                onclick="return confirm('Bạn có chắc muốn xóa comment này?')">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>

                                    <!-- Form trả lời (hiển thị khi param.replyTo == item.id) -->
                                    <c:if test="${param.replyTo == item.id}">
                                        <tr class="bg-light">
                                            <td colspan="7">
                                                <div class="card">
                                                    <div class="card-header bg-primary text-white">
                                                        <strong>Trả lời bình luận #${item.id}</strong>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="alert alert-info">
                                                            <strong>Bình luận gốc:</strong><br>
                                                            <em>"${item.comment}"</em><br>
                                                            <small class="text-muted">- ${item.userName}</small>
                                                        </div>

                                                        <form action="<c:url value='/admin-product-comment-reply'/>"
                                                            method="post">
                                                            <input type="hidden" name="parentId" value="${item.id}">
                                                            <input type="hidden" name="productId"
                                                                value="${item.productId}">

                                                            <div class="form-group">
                                                                <label for="replyComment">Nội dung trả lời:</label>
                                                                <textarea name="comment" id="replyComment"
                                                                    class="form-control" rows="4"
                                                                    placeholder="Nhập nội dung trả lời..."
                                                                    required></textarea>
                                                            </div>

                                                            <div class="text-right">
                                                                <a href="<c:url value='/admin-product-comment-list'/>"
                                                                    class="btn btn-secondary">Hủy</a>
                                                                <button type="submit" class="btn btn-primary">
                                                                    <i class="fas fa-paper-plane"></i> Gửi trả lời
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:if>

                                    <!-- Hiển thị replies -->
                                    <c:if test="${not empty item.replies}">
                                        <c:forEach var="reply" items="${item.replies}">
                                            <tr class="bg-light">
                                                <td>${reply.id}</td>
                                                <td>
                                                    <strong>${item.productName}</strong><br>
                                                    <small class="text-muted">ID: ${item.productId}</small>
                                                </td>
                                                <td><strong>${reply.userName}</strong></td>
                                                <td>
                                                    <span class="badge badge-secondary">Phản hồi cho ID:
                                                        ${reply.parentId}</span><br>
                                                    ${reply.comment}
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${reply.createdAt}"
                                                        pattern="dd/MM/yyyy HH:mm" />
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${reply.adminReply}">
                                                            <span class="badge badge-primary">Admin</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-info">Khách hàng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-right">
                                                    <a href="<c:url value='/admin-product-comment-delete/${reply.id}'/>"
                                                        class="btn btn-sm btn-danger btn-delete-policy" title="Xóa"
                                                        onclick="return confirm('Bạn có chắc muốn xóa phản hồi này?')">
                                                        <i class="fas fa-trash"></i> Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${empty comments}">
                                    <tr>
                                        <td colspan="7" class="text-center py-5">Chưa có bình luận nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            </div>
        </section>