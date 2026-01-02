<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    /* Tổng thể & Header */
    .content-header {
        padding: 1.5rem 0;
        background: #fff;
        border-bottom: 1px solid #f1f5f9;
        margin-bottom: 2rem;
    }
    .content-header h1 {
        font-size: 1.4rem;
        font-weight: 700;
        color: #0f172a;
        margin: 0;
    }

    /* Card & Table */
    .card {
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        background: #fff;
        overflow: hidden;
    }
    .card-header {
        background: #fff;
        padding: 1.25rem 1.5rem;
        border-bottom: 1px solid #f1f5f9;
    }
    .card-title {
        font-weight: 600;
        color: #334155;
        font-size: 1.1rem;
        margin: 0;
    }

    .table {
        margin-bottom: 0;
    }
    .table thead th {
        background: #f8fafc;
        color: #64748b;
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        font-weight: 600;
        border-top: none;
        border-bottom: 1px solid #e2e8f0;
        padding: 1rem 1.5rem;
    }
    .table tbody td {
        padding: 1rem 1.5rem;
        vertical-align: middle;
        border-bottom: 1px solid #f1f5f9;
        color: #475569;
    }

    /* Soft Badges */
    .badge-soft {
        padding: 0.5em 0.8em;
        font-weight: 500;
        border-radius: 6px;
        font-size: 0.75rem;
    }
    .bg-info-soft { background-color: #e0f2fe; color: #0369a1; }
    .bg-success-soft { background-color: #dcfce7; color: #15803d; }
    .bg-danger-soft { background-color: #fee2e2; color: #b91c1c; }
    .bg-secondary-soft { background-color: #f1f5f9; color: #475569; }

    /* Buttons */
    .btn-action {
        padding: 0.4rem 0.8rem;
        font-size: 0.85rem;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.2s;
    }
    .btn-role {
        background-color: #fff;
        border: 1px solid #e2e8f0;
        color: #2563eb;
    }
    .btn-role:hover {
        background-color: #eff6ff;
        border-color: #bfdbfe;
    }
    .btn-del {
        color: #ef4444;
    }
    .btn-del:hover {
        background-color: #fef2f2;
    }

    /* Loại bỏ trang trí mặc định của link */
    a.btn-action { text-decoration: none; }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1>Quản lý tài khoản</h1>
            </div>
            <div class="col-sm-6 text-right d-none d-sm-block">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                        <li class="breadcrumb-item"><a href="admin-home" class="text-muted">Home</a></li>
                        <li class="breadcrumb-item active">Tài khoản</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title">Danh sách người dùng hệ thống</h3>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                        <tr>
                            <th style="width: 80px;" class="text-center">STT</th>
                            <th>Username / Email</th>
                            <th>Quyền hạn</th>
                            <th>Trạng thái</th>
                            <th class="text-right">Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${listAccount}" varStatus="status">
                            <tr>
                                <td class="text-center text-muted">${status.index + 1}</td>
                                <td>
                                    <div class="font-weight-bold text-dark">${item.email}</div>
                                    <div class="small text-muted">ID: #${item.id}</div>
                                </td>
                                <td>
                                    <c:forEach var="role" items="${item.roles}">
                                            <span class="badge-soft bg-info-soft mr-1">
                                                <i class="fas fa-user-shield mr-1 small"></i>${role}
                                            </span>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.enabled}">
                                                <span class="badge-soft bg-success-soft">
                                                    <i class="fas fa-check-circle mr-1"></i>Đang hoạt động
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="badge-soft bg-danger-soft">
                                                    <i class="fas fa-lock mr-1"></i>Đã khóa
                                                </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-right">
                                    <a href="<c:url value='/admin-account-updateRole/${item.id}'/>"
                                       class="btn-action btn-role mr-2">
                                        <i class="fas fa-user-tag mr-1"></i> Phân quyền
                                    </a>
                                    <a href="<c:url value='/admin-account-delete/${item.id}'/>"
                                       class="btn-action btn-del"
                                       onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listAccount}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="fas fa-users-slash fa-2x mb-3 d-block" style="opacity: 0.3;"></i>
                                    Không tìm thấy tài khoản nào
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