<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<!-- HEADER -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2 align-items-center">
            <div class="col-sm-6">
                <h1>Quản lý danh mục</h1>
            </div>
            <div class="col-sm-6 text-right">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item active">Danh mục</li>
                </ol>
            </div>
        </div>
    </div>
</section>
<div class="modal fade" id="importExcelModal" tabindex="-1" role="dialog" aria-labelledby="importExcelModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="importExcelModalLabel">
                    <i class="fas fa-file-excel mr-2"></i> Nhập danh mục từ file Excel
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-product-category-import" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group p-3">
                        <label for="fileExcel">Chọn file Excel (.xlsx)</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="fileExcel" name="fileExcel" accept=".xlsx" required>
                            <label class="custom-file-label" for="fileExcel">Chọn file...</label>
                        </div>
                        <p class="small text-muted mt-2">
                            Thứ tự cột: Tên, Mô tả, Hình ảnh, Alias, Root Category ID.
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
<!-- CONTENT -->
<section class="content">
    <div class="container-fluid">
        <!-- Import Alerts -->
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
                <h3 class="card-title">Danh sách danh mục</h3>
                <div class="card-tools d-flex" style="gap: 5px;">
                    <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#importExcelModal">
                        <i class="fas fa-file-import"></i> Nhập Excel
                    </button>
                    <a href="<c:url value='/admin-product-category-export'/>" class="btn btn-info btn-sm">
                        <i class="fas fa-file-export"></i> Xuất Excel
                    </a>
                    <a href="<c:url value='/admin-category-add'/>" class="btn btn-primary btn-sm">
                        <i class="fas fa-plus"></i> Thêm danh mục
                    </a>
                </div>
            </div>

            <div class="card-body p-0">

                <div class="table-responsive">
                    <table class="table table-bordered table-hover mb-0">
                        <thead >
                        <tr>
                            <th width="70" class="text-center">STT</th>
                            <th class="text-center">Tên danh mục</th>
                            <th width="180" class="text-center">Danh mục gốc</th>
                            <th class="text-center">Mô tả</th>
                            <th width="120" class="text-center">Hình ảnh</th>
                            <th width="150" class="text-center">Ngày tạo</th>
                            <th width="180" class="text-center">Chức năng</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="item" items="${listCategory}" varStatus="status">
                            <tr>

                                <td class="text-center">${status.index + 1}</td>

                                <td class="text-center">

                                    <strong>${item.name}</strong>
                                </td>

                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty item.rootCategoryName}">
                                            <span class="badge badge-info">
                                                    ${item.rootCategoryName}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Không có</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center">
                                    <span class="text-truncate d-inline-block"
                                          style="max-width:200px;"
                                          title="${item.description}">
                                            ${item.description}
                                    </span>
                                </td>

                                <!-- IMAGE -->
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty item.image}">
                                            <img src="${pageContext.request.contextPath}${item.image}"
                                                 style="width:70px;height:70px;object-fit:cover;border-radius:6px;"
                                                 onerror="this.src='${pageContext.request.contextPath}/template/admin/dist/img/no-image.png';">
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">
                                                <i class="fas fa-image"></i>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center">
                                    <fmt:formatDate value="${item.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>

                                <!-- ACTION -->
                                <td class="text-center">
                                    <div class="d-flex justify-content-center" style="gap:6px;">

                                        <a href="<c:url value='/admin-category-edit/${item.id}'/>"
                                           class="btn btn-sm btn-primary"
                                           title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>

                                        <a href="<c:url value='/admin-category-delete/${item.id}'/>"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Xóa danh mục này?')"
                                           title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </a>

                                    </div>
                                </td>

                            </tr>
                        </c:forEach>

                        <!-- EMPTY -->
                        <c:if test="${empty listCategory}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="fas fa-folder-open fa-2x mb-2 d-block"></i>
                                    Không có danh mục
                                </td>
                            </tr>
                        </c:if>

                        </tbody>
                    </table>
                </div>

                <!-- PAGINATION -->
                <c:if test="${totalPage >= 1 && totalItem > 0}">
                    <div class="p-3">
                        <ul class="pagination justify-content-center mb-0">

                            <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${page - 1}&limit=${limit}">
                                    Trước
                                </a>
                            </li>

                            <c:forEach var="i" begin="1" end="${totalPage}">
                                <li class="page-item ${i == page ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}&limit=${limit}">
                                            ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <li class="page-item ${page == totalPage ? 'disabled' : ''}">
                                <a class="page-link" href="?page=${page + 1}&limit=${limit}">
                                    Sau
                                </a>
                            </li>

                        </ul>
                    </div>
                </c:if>

            </div>
        </div>

    </div>
</section>