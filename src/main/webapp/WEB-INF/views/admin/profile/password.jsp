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
                    <li class="breadcrumb-item"><a href="<c:url value='/admin-home'/>" class="text-muted">Home</a></li>
                    <li class="breadcrumb-item"><a href="<c:url value='/admin-profile'/>" class="text-muted">Profile</a></li>
                    <li class="breadcrumb-item active">Đổi mật khẩu</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                    ${message}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>

        <c:if test="${profile == null}">
            <div class="p-5 text-center text-muted">
                <i class="fas fa-user-slash fa-3x mb-3"></i>
                <div>Không tìm thấy tài khoản.</div>
            </div>
        </c:if>

        <c:if test="${profile != null}">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white p-0 border-bottom">
                            <ul class="nav nav-tabs nav-fill" id="passTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active font-weight-bold" id="change-tab" data-toggle="tab" href="#change" role="tab">
                                        <i class="fas fa-lock mr-2"></i>Đổi mật khẩu
                                    </a>
                                </li>
                                <sec:authorize access="hasRole('ADMIN')">
                                    <li class="nav-item">
                                        <a class="nav-link font-weight-bold text-danger" id="reset-tab" data-toggle="tab" href="#reset" role="tab">
                                            <i class="fas fa-shield-alt mr-2"></i>Reset mật khẩu (Admin)
                                        </a>
                                    </li>
                                </sec:authorize>
                            </ul>
                        </div>

                        <div class="card-body py-4">
                            <div class="tab-content" id="passTabContent">
                                    <%-- reset mật khẩu  --%>
                                <div class="tab-pane fade show active" id="change" role="tabpanel">
                                    <form action="<c:url value='/admin-profile-password'/>" method="post" class="auth-form">
                                        <input type="hidden" name="userId" value="${profile.userId}"/>

                                        <div class="form-group mb-4">
                                            <label class="font-weight-bold">Mật khẩu cũ <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text bg-light border-right-0"><i class="fas fa-key"></i></span>
                                                </div>
                                                <input type="password" class="form-control border-left-0" name="oldPassword" required>
                                            </div>
                                        </div>

                                        <div class="form-group mb-3">
                                            <label class="font-weight-bold">Mật khẩu mới <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control new-pass" name="newPassword" required minlength="6">
                                        </div>

                                        <div class="form-group mb-4">
                                            <label class="font-weight-bold">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control confirm-pass" name="confirmPassword" required>
                                            <div class="invalid-feedback">Xác nhận mật khẩu không khớp!</div>
                                        </div>

                                        <div class="d-flex justify-content-between mt-4">
                                            <a href="<c:url value='/admin-profile-detail/${profile.userId}'/>" class="btn btn-light">Quay lại</a>
                                            <button type="submit" class="btn btn-primary px-4">Đổi mật khẩu</button>
                                        </div>
                                    </form>
                                </div>

                                    <%-- reset mật khẩu admin--%>
                                <sec:authorize access="hasRole('ADMIN')">
                                    <div class="tab-pane fade" id="reset" role="tabpanel">
                                        <div class="alert alert-warning mb-4">
                                            <i class="fas fa-exclamation-triangle mr-2"></i>
                                            <strong>Chú ý:</strong> Chế độ này cho phép Admin đặt lại mật khẩu mà không cần mật khẩu cũ. Hãy cẩn thận!
                                        </div>
                                        <form action="<c:url value='/admin-profile-reset'/>" method="post" class="auth-form">
                                            <input type="hidden" name="userId" value="${profile.userId}"/>

                                            <div class="form-group mb-3">
                                                <label class="font-weight-bold text-dark">Mật khẩu mới <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control new-pass" name="newPassword" required minlength="6">
                                            </div>

                                            <div class="form-group mb-4">
                                                <label class="font-weight-bold text-dark">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control confirm-pass" name="confirmPassword" required>
                                                <div class="invalid-feedback">Xác nhận mật khẩu không khớp!</div>
                                            </div>

                                            <div class="d-flex justify-content-between mt-4">
                                                <a href="<c:url value='/admin-profile-detail/${profile.userId}'/>" class="btn btn-light">Quay lại</a>
                                                <button type="submit" class="btn btn-danger px-4">Reset trực tiếp</button>
                                            </div>
                                        </form>
                                    </div>
                                </sec:authorize>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</section>

<script>
    document.querySelectorAll('.auth-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const pass = this.querySelector('.new-pass').value;
            const confirm = this.querySelector('.confirm-pass').value;
            const confirmInput = this.querySelector('.confirm-pass');

            if (pass !== confirm) {
                e.preventDefault();
                confirmInput.classList.add('is-invalid');
            } else {
                confirmInput.classList.remove('is-invalid');
            }
        });
    });
</script>
