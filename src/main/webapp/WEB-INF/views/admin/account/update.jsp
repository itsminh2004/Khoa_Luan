<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1>Thiết lập quyền truy cập</h1>
            </div>
            <div class="col-sm-6 text-right d-none d-sm-block">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                    <li class="breadcrumb-item"><a href="admin-home" class="text-muted">Home</a></li>
                    <li class="breadcrumb-item"><a href="admin-account" class="text-muted">Tài khoản</a></li>
                    <li class="breadcrumb-item active">Phân quyền</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-6">

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Phân quyền cho người dùng</h3>
                    </div>

                    <div class="card-body">
                        <form action="<c:url value='/admin-account-updateRole/${AccountId.id}'/>" method="post">
                            <input type="hidden" name="userId" value="${AccountId.id}" />

                            <!-- Email -->
                            <div class="form-group">
                                <label>Tài khoản người dùng</label>
                                <input type="text" class="form-control" value="${AccountId.email}" readonly />
                            </div>

                            <!-- Roles -->
                            <div class="form-group">
                                <label>Vai trò hệ thống (Roles)</label>

                                <div class="border rounded p-3">
                                    <c:forEach items="${availableRoles}" var="role">
                                        <div class="custom-control custom-checkbox mb-2">
                                            <input type="checkbox"
                                                   class="custom-control-input"
                                                   id="role_${role.key}"
                                                   name="roles"
                                                   value="${role.key}"
                                                   <c:if test="${userRoles.contains(role.key)}">checked</c:if>>

                                            <label class="custom-control-label" for="role_${role.key}">
                                                <strong>${role.key}</strong> - ${role.value}
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>

                                <small class="form-text text-muted">
                                    * Có thể chọn nhiều role. Nếu không chọn, hệ thống sẽ tự gán USER.
                                </small>
                            </div>

                            <!-- Buttons -->
                            <div class="d-flex justify-content-between mt-4">
                                <a href="<c:url value='/admin-account'/>"
                                   class="btn btn-outline-secondary">
                                    Hủy bỏ
                                </a>

                                <button type="submit" class="btn btn-primary">
                                    Xác nhận cấp quyền
                                </button>
                            </div>

                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>