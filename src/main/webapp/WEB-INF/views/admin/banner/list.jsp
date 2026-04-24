<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý banner</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang
                        chủ</a></li>
                    <li class="breadcrumb-item active">Quản lý banner</li>
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
                <div class="d-flex justify-content-between align-items-center">
                    <h3 class="card-title">Danh sách banner</h3>

                    <form method="get" action="${pageContext.request.contextPath}/admin/banners" class="form-inline">
                        <div class="form-group mr-2">
                            <a href="${pageContext.request.contextPath}/admin/banners/add" class="btn btn-primary ">
                                <i class="fas fa-plus"></i> Thêm mới
                            </a>
                        </div>

                        <div class="form-group mr-2">
                            <select name="position" class="form-control">
                                <option value="" ${empty filterPosition ? 'selected' : ''}>Tất cả vị trí</option>
                                <option value="HOME_HERO" ${filterPosition == 'HOME_HERO' ? 'selected' : ''}>HOME_HERO</option>
                                <option value="HOME_SUB" ${filterPosition == 'HOME_SUB' ? 'selected' : ''}>HOME_SUB</option>
                                <option value="POPUP" ${filterPosition == 'POPUP' ? 'selected' : ''}>POPUP</option>
                            </select>
                        </div>

                        <div class="form-group mr-2">
                            <select name="active" class="form-control">
                                <option value="" ${empty filterActive ? 'selected' : ''}>Tất cả trạng thái</option>
                                <option value="1" ${filterActive == '1' || filterActive == 'true' ? 'selected' : ''}>Đang hoạt động</option>
                                <option value="0" ${filterActive == '0' || filterActive == 'false' ? 'selected' : ''}>Tắt</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-outline-secondary">
                            <i class="fas fa-filter"></i> Lọc
                        </button>
                    </form>
                </div>
            </div>

            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="bg-light">
                        <tr>
                            <th style="width: 90px;">Ảnh</th>
                            <th>Tiêu đề</th>
                            <th>Sản phẩm liên kết</th>
                            <th style="width: 120px;">Vị trí</th>
                            <th style="width: 90px;">Sort</th>
                            <th style="width: 260px;">Thời gian chạy</th>
                            <th style="width: 120px;">Trạng thái</th>
                            <th style="width: 240px;" class="text-right">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty banners}">
                                <c:forEach var="b" items="${banners}">
                                    <tr>
                                        <td class="text-center">
                                            <c:if test="${not empty b.imageUrl}">
                                                <img
                                                        src="${pageContext.request.contextPath}${b.imageUrl}"
                                                        style="width: 80px; height: 50px; object-fit: cover; border-radius: 6px; border: 1px solid #ddd;"
                                                        alt="${b.title}"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <strong>${b.title}</strong>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty b.productName}">
                                                    ${b.productName}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Không liên kết</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${b.position}</td>
                                        <td class="text-center">${b.sortOrder}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty b.startDate and empty b.endDate}">
                                                    <span class="text-success">Luôn hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${not empty b.startDate}">
                                                            <fmt:formatDate value="${b.startDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </c:when>
                                                        <c:otherwise>Bắt đầu: vô hạn</c:otherwise>
                                                    </c:choose>
                                                    -
                                                    <c:choose>
                                                        <c:when test="${not empty b.endDate}">
                                                            <fmt:formatDate value="${b.endDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </c:when>
                                                        <c:otherwise>Kết thúc: vô hạn</c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.active}">
                                                    <span class="badge badge-success">Đang hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">Tắt</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-right align-middle">
                                            <div class="d-flex justify-content-end align-items-center" style="gap: 6px;">
                                                <a href="${pageContext.request.contextPath}/admin/banners/edit/${b.id}"
                                                   class="btn btn-sm btn-info"
                                                   title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>

                                                <button type="button"
                                                        class="btn btn-sm ${b.active ? 'btn-success' : 'btn-outline-success'}"
                                                        data-id="${b.id}"
                                                        title="Bật/Tắt"
                                                        onclick="toggleBanner(this)">
                                                    <i class="fas fa-power-off"></i>
                                                </button>

                                                <form action="${pageContext.request.contextPath}/admin/banners/delete/${b.id}"
                                                      method="post"
                                                      style="margin: 0;"
                                                      onsubmit="return confirm('Xóa banner \"${b.title}\"?')">

                                                <button type="submit"
                                                        class="btn btn-sm btn-danger"
                                                        title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center py-5 text-muted">
                                        Chưa có banner nào.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    function toggleBanner(btn) {
        const id = btn.getAttribute('data-id');
        fetch(contextPath + '/admin/banners/toggle/' + id, {
            method: 'POST'
        })
            .then(res => res.json())
            .then(data => {
                if (!data || !data.success) {
                    alert(data && data.message ? data.message : 'Không thể thay đổi trạng thái!');
                    return;
                }
                window.location.reload();
            })
            .catch(() => alert('Có lỗi khi thay đổi trạng thái!'));
    }
</script>

