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
                    <li class="breadcrumb-item"><a href="<c:url value='/admin-profile'/>" class="text-muted">Profile</a></li>
                    <li class="breadcrumb-item active">Update</li>
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

        <c:if test="${profile == null}">
            <div class="p-5 text-center text-muted">
                Không tìm thấy tài khoản.
            </div>
        </c:if>

        <c:if test="${profile != null}">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0 font-weight-bold text-dark">Cập nhật profile</h5>
                    <div class="small text-muted">User ID: ${profile.userId}</div>
                </div>

                <div class="card-body">
                    <form action="<c:url value='/admin-profile-update'/>" method="post">
                        <input type="hidden" name="userId" value="${profile.userId}"/>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" class="form-control" name="fullName"
                                           value="${profile.username}" required/>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" class="form-control" name="email"
                                           value="${profile.email}" required/>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Số điện thoại</label>
                                    <input type="text" class="form-control" name="phone"
                                           value="${profile.phone}" required/>
                                </div>
                            </div>
                        </div>

                        <hr/>

                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Tỉnh/Thành phố</label>
                                    <input type="text" class="form-control" name="province"
                                           value="${profile.province}" required/>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Quận/Huyện</label>
                                    <input type="text" class="form-control" name="district"
                                           value="${profile.district}" required/>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Phường/Xã</label>
                                    <input type="text" class="form-control" name="ward"
                                           value="${profile.ward}" required/>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Địa chỉ cụ thể</label>
                                    <input type="text" class="form-control" name="specificAddress"
                                           value="${profile.specificAddress}" required/>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <a href="<c:url value='/admin-profile'/>" class="btn btn-light mr-2">
                                Hủy
                            </a>
                            <a href="<c:url value='/admin-profile-password/${profile.userId}'/>" class="btn btn-warning text-white mr-2">
                                <i class="fas fa-key mr-1"></i> Đổi mật khẩu
                            </a>
                            <button type="submit" class="btn btn-primary">
                                Cập nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>
    </div>
</section>

