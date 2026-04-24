<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý thương hiệu</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a></li>
                    <li class="breadcrumb-item active">Thương hiệu</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <c:if test="${not empty param.importSuccess}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle mr-2"></i> Nhập dữ liệu từ Excel thành công!
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        <c:if test="${not empty param.importError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle mr-2"></i> Lỗi khi nhập Excel: ${param.importError}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách thương hiệu</h3>
                <div class="card-tools d-flex" style="gap: 5px;">
                    <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#importExcelModal">
                        <i class="fas fa-file-import"></i> Nhập Excel
                    </button>
                    <a href="<c:url value='/admin-brand-export'/>" class="btn btn-info btn-sm">
                        <i class="fas fa-file-export"></i> Xuất Excel
                    </a>
                    <a href="<c:url value='/admin-brand-add'/>" class="btn btn-primary btn-sm">
                        <i class="fas fa-plus"></i> Thêm thương hiệu
                    </a>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th width="70" class="text-center">STT</th>
                            <th class="text-center">Tên thương hiệu</th>
                            <th width="120" class="text-center">Logo</th>
                            <th width="120" class="text-center">Trạng thái</th>
                            <th width="160" class="text-center">Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${listBrand}" varStatus="status">
                            <tr>
                                <td class="text-center" >${(page-1)*limit + status.index + 1}</td>
                                <td class="text-center"><strong>${item.name}</strong></td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty item.logo}">
                                            <img src="${pageContext.request.contextPath}${item.logo}" class="brand-logo" alt="${item.name}" width="100"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-muted small">No Logo</div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${item.active}">
                                            <span class="status-badge status-active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center" style="gap:6px;">
                                        <a href="<c:url value='/admin-brand-edit/${item.id}'/>" class="btn btn-sm btn-primary">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="<c:url value='/admin-brand-delete/${item.id}'/>"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa thương hiệu này?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listBrand}">
                            <tr>
                                <td colspan="6" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="fas fa-box-open fa-3x mb-3"></i>
                                        <p>Chưa có thương hiệu nào</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPage > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <li class="page-item <c:if test='${page == 1}'>disabled</c:if>">
                                <a class="page-link" href="?page=${page - 1}&limit=${limit}">Trước</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPage}">
                                <li class="page-item <c:if test='${i == page}'>active</c:if>">
                                    <a class="page-link" href="?page=${i}&limit=${limit}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item <c:if test='${page == totalPage}'>disabled</c:if>">
                                <a class="page-link" href="?page=${page + 1}&limit=${limit}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>
    </div>
</section>
<div class="modal fade" id="importExcelModal" tabindex="-1" role="dialog" aria-labelledby="importExcelModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="importExcelModalLabel">
                    <i class="fas fa-file-excel mr-2"></i> Nhập thương hiệu từ file Excel
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-brand-import" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group p-3">
                        <label for="fileExcel">Chọn file Excel (.xlsx)</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="fileExcel" name="fileExcel" accept=".xlsx" required>
                            <label class="custom-file-label" for="fileExcel">Chọn file...</label>
                        </div>
                        <p class="small text-muted mt-2">
                            Thứ tự cột: Tên, Alias, Logo, Active (1/0).
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Tải lên</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).on('change', '.custom-file-input', function() {
        let fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').addClass("selected").html(fileName);
    });
</script>
