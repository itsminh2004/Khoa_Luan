<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1>Quản lý tài khoản</h1>
            </div>
            <div class="col-sm-6 text-right d-none d-sm-block">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                        <li class="breadcrumb-item">
                            <a href="admin-home" class="text-muted">Home</a>
                        </li>
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
                    <table class="table table-bordered table-hover mb-0">
                        <thead>
                        <tr>
                            <th style="width: 80px;" class="text-center">STT</th>
                            <th>Username / Email</th>
                            <th>Quyền hạn</th>
                            <th class="text-center">Trạng thái</th>
                            <th class="text-center">Chức năng</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="item" items="${listAccount}" varStatus="status">
                            <tr>
                                <td class="text-center">${status.index + 1}</td>

                                <td>
                                    <div class="font-weight-bold">${item.email}</div>
                                    <small class="text-muted">ID: #${item.id}</small>
                                </td>

                                <td>
                                    <c:forEach var="role" items="${item.roles}">
                                        <span class="badge badge-info mr-1">
                                            <i class="fas fa-user-shield mr-1"></i>${role}
                                        </span>
                                    </c:forEach>
                                </td>

                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${item.enabled}">
                                            <span class="badge badge-success">
                                                <i class="fas fa-check-circle mr-1"></i>Đang hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger">
                                                <i class="fas fa-lock mr-1"></i>Đã khóa
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center">
                                    <a href="<c:url value='/admin-account-updateRole/${item.id}'/>"
                                       class="btn btn-sm btn-outline-primary ">
                                        <i class="fas fa-user-tag"></i>
                                    </a>

                                    <a href="<c:url value='/admin-account-delete/${item.id}'/>"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty listAccount}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="fas fa-users-slash fa-2x mb-3 d-block"></i>
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