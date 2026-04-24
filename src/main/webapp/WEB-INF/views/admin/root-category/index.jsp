<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1>Quản lý danh mục gốc</h1>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin-home">Trang
                        chủ</a></li>
                    <li class="breadcrumb-item active">Danh mục gốc</li>
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
                    <i class="fas fa-file-excel mr-2"></i> Nhập danh mục gốc từ file Excel
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="${pageContext.request.contextPath}/admin-root-category-import" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="fileExcel">Chọn file Excel (.xlsx)</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="fileExcel" name="fileExcel" accept=".xlsx" required>
                            <label class="custom-file-label" for="fileExcel">Chọn file...</label>
                        </div>
                        <p class="small text-muted mt-2">
                            Thứ tự cột: Tên, Mô tả, Hình ảnh, Alias.
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
                <h3 class="card-title">Danh sách danh mục gốc</h3>
                <div class="card-tools d-flex" style="gap: 5px;">
                    <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#importExcelModal">
                        <i class="fas fa-file-import"></i> Nhập Excel
                    </button>
                    <a href="<c:url value='/admin-root-category-export'/>" class="btn btn-info btn-sm">
                        <i class="fas fa-file-export"></i> Xuất Excel
                    </a>
                    <a href="<c:url value='/admin-root-category-add'/>" class="btn btn-primary btn-sm">
                        <i class="fas fa-plus"></i> Thêm mới
                    </a>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Tên</th>
                        <th>Mô tả</th>
                        <th>Hình ảnh</th>
                        <th>Chức năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${listRootCategory}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${item.name}</td>
                            <td>${item.description}</td>
                            <td>
                                <c:if test="${not empty item.image}">
                                    <img src="${pageContext.request.contextPath}${item.image}"
                                         width="100" />
                                </c:if>
                            </td>
                            <td>
                                <a href="<c:url value='/admin-root-category-edit/${item.id}'/>"
                                   class="btn btn-sm btn-info"><i class="fas fa-edit"></i></a>
                                <a href="<c:url value='/admin-root-category-delete/${item.id}'/>"
                                   class="btn btn-sm btn-danger" onclick="return confirm('Xóa?')"><i
                                        class="fas fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
