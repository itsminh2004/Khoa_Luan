<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<!-- Header -->
<section class="content-header">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <h1>Quản lý Series</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin-home">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item active">Series</li>
                </ol>
            </div>
        </div>
    </div>
</section>
<!-- Import Excel Modal -->
<div class="modal fade" id="importExcelModal" tabindex="-1" role="dialog" aria-labelledby="importExcelModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="importExcelModalLabel">
                    <i class="fas fa-file-excel mr-2"></i> Nhập Series từ file Excel
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-series-import" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group p-3">
                        <label for="fileExcel">Chọn file Excel (.xlsx)</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="fileExcel" name="fileExcel" accept=".xlsx" required>
                            <label class="custom-file-label" for="fileExcel">Chọn file...</label>
                        </div>
                        <p class="small text-muted mt-2">
                            Thứ tự cột: Tên, Danh mục ID.
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

<!-- Content -->
<section class="content">
    <div class="container-fluid">
        <div class="card">
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

            <div class="card-header">
                <h3 class="card-title">Danh sách mã danh mục</h3>
                <div class="card-tools d-flex" style="gap: 5px;">
                    <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#importExcelModal" style="background: #28a745; border: none; color: white;">
                        <i class="fas fa-file-import"></i> Nhập Excel
                    </button>
                    <a href="${pageContext.request.contextPath}/admin-series-export" class="btn btn-info btn-sm" style="background: #17a2b8; border: none; color: white;">
                        <i class="fas fa-file-export"></i> Xuất Excel
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-series-add" class="btn btn-primary btn-sm" style="background: #007bff; border: none; color: white;">
                        <i class="fas fa-plus"></i> Thêm mới
                    </a>
                </div>
            </div>

            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover mb-0">
                        <thead >
                        <tr>
                            <th width="70" class="text-center">STT</th>
                            <th class="text-center">Tên Series</th>
                            <th width="180" class="text-center">Danh mục</th>
                            <th width="160" class="text-center">Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${seriesList}" varStatus="status">
                            <tr>
                                <td class="text-center">${status.index + 1}</td>

                                <td class="text-center">
                                    <strong>
                                            ${s.name}
                                    </strong>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${not empty s.categoryName}">
                                            <span class="badge badge-info">
                                                <i class="fas fa-folder"></i> ${s.categoryName}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa chọn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center" style="gap:6px;">
                                        <a href="${pageContext.request.contextPath}/admin-series/edit/${s.id}"
                                           class="btn btn-sm btn-primary">
                                            <i class="fas fa-edit"></i>
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin-series/delete/${s.id}"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa Series \"${s.name}\" không?')">
                                        <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty seriesList}">
                            <tr>
                                <td colspan="4" class="text-center py-4 text-muted">
                                    <i class="fas fa-layer-group fa-2x mb-2"></i><br>
                                    Không có Series nào
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