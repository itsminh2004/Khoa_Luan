<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

        <section class="content-header">
            <div class="container-fluid">
                <h1>Quản lý Đánh giá</h1>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <div class="card">
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Sản phẩm</th>
                                    <th>Người dùng</th>
                                    <th>Đánh giá</th>
                                    <th>Bình luận</th>
                                    <th>Ngày gửi</th>
                                    <th class="text-right">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${reviews}">
                                    <tr>
                                        <td>${item.id}</td>
                                        <td><strong>${item.productName}</strong></td>
                                        <td>${item.userName}</td>
                                        <td>
                                            <c:forEach begin="1" end="${item.rating}">
                                                <i class="fas fa-star text-warning"></i>
                                            </c:forEach>
                                        </td>
                                        <td>${item.comment}</td>
                                        <td>
                                            <fmt:formatDate value="${item.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                        <td class="text-right">
                                            <a href="<c:url value='/admin-review-delete/${item.id}'/>"
                                                class="btn btn-sm btn-danger btn-delete-policy" title="Xóa"
                                                onclick="return confirm('Bạn có chắc muốn xóa đánh giá này?')">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reviews}">
                                    <tr>
                                        <td colspan="7" class="text-center py-5">Chưa có đánh giá nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

        <script>
            $(document).on('click', '.btn-delete-review', function () {
                var id = $(this).data('id');
                if (confirm('Xóa đánh giá này?')) {
                    $.ajax({
                        url: '<c:url value="/api/admin/review/"/>' + id,
                        type: 'DELETE',
                        success: function () {
                            location.reload();
                        }
                    });
                }
            });
        </script>