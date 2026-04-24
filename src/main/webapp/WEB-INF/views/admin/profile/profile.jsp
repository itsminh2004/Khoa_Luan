<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1 class="m-0 text-dark">${pageTitle}</h1>
            </div>
            <div class="col-sm-6 text-right d-none d-sm-block">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                    <li class="breadcrumb-item"><a href="admin-home" class="text-muted">Home</a></li>
                    <li class="breadcrumb-item active">Profile</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h5 class="mb-0 font-weight-bold text-dark">Tìm kiếm & lọc</h5>
            </div>
            <div class="card-body">
                <form method="get" action="<c:url value='/admin-profile'/>">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Tìm theo username/email/phone</label>
                                <input type="text" class="form-control" name="keyword"
                                       value="${keyword}" placeholder="Nhập từ khóa..."/>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Lọc theo role</label>
                                <select class="form-control" name="role">
                                    <option value="" <c:if test="${empty selectedRole}">selected</c:if>>
                                        Tất cả roles
                                    </option>
                                    <c:forEach var="r" items="${rolesFilter}">
                                        <option value="${r}" <c:if test="${r eq selectedRole}">selected</c:if>>
                                                ${r}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-2 d-flex align-items-end">
                            <div>
                                <button type="submit" class="btn btn-primary btn-block">Lọc</button>
                                <a class="btn btn-light btn-block mt-2" href="<c:url value='/admin-profile'/>">
                                    Xóa lọc
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <c:if test="${empty profiles}">
            <div class="p-5 text-center text-muted">
                <i class="fas fa-user-circle fa-3x mb-3"></i>
                <div>Không có tài khoản nào để hiển thị.</div>
            </div>
        </c:if>

        <c:if test="${not empty profiles}">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Danh sách tài khoản</h3>
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th style="width: 70px;">STT</th>
                            <th>Tài khoản</th>
                            <th>Số điện thoại</th>
                            <th>Role</th>
                            <th>Địa chỉ mặc định</th>
                            <th class="text-center">Chức năng</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="profile" items="${profiles}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <div class="font-weight-bold text-dark">${profile.username}</div>
                                    <div class="text-muted small">Email: ${profile.email}</div>
                                </td>
                                <td>${profile.phone}</td>
                                <td>${profile.role}</td>
                                <td>
                                    <span title="${profile.defaultAddressText}">
                                            ${profile.defaultAddressText}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin-profile-detail/${profile.userId}'/>"
                                       class="btn btn-sm btn-warning text-white" title="Xem thông tin">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="<c:url value='/admin-profile-update/${profile.userId}'/>"
                                       class="btn btn-sm btn-primary" title="Chỉnh sửa">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="<c:url value='/admin-profile-password/${profile.userId}'/>"
                                       class="btn btn-sm btn-dark" title="Đổi mật khẩu">
                                        <i class="fas fa-key"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
</section>

