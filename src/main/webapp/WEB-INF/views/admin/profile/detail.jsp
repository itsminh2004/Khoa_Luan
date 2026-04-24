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
                    <li class="breadcrumb-item active">Chi tiết</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">

        <c:if test="${profile == null}">
            <div class="p-5 text-center text-muted">
                <i class="fas fa-user-slash fa-3x mb-3"></i>
                <div>Không tìm thấy tài khoản.</div>
            </div>
        </c:if>

        <c:if test="${profile != null}">
            <div class="row justify-content-center">
                <div class="col-lg-8">

                        <%-- ===== Card avatar + tên ===== --%>
                    <div class="card shadow-sm mb-4">
                        <div class="card-body text-center py-4">
                            <div class="mb-3">
                                <span style="
                                    display: inline-flex;
                                    align-items: center;
                                    justify-content: center;
                                    width: 90px; height: 90px;
                                    border-radius: 50%;
                                    background: linear-gradient(135deg, #667eea, #764ba2);
                                    color: #fff;
                                    font-size: 2.2rem;
                                    font-weight: 700;
                                    letter-spacing: 1px;
                                    box-shadow: 0 4px 16px rgba(102,126,234,.35);
                                ">
                                    <c:choose>
                                        <c:when test="${not empty profile.username}">
                                            ${fn:toUpperCase(fn:substring(profile.username, 0, 1))}
                                        </c:when>
                                        <c:otherwise>?</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <h4 class="mb-1 font-weight-bold text-dark">${profile.username}</h4>
                            <span class="badge badge-pill badge-info px-3 py-1" style="font-size:.85rem;">
                                    ${profile.role}
                            </span>
                            <div class="text-muted small mt-1">ID: #${profile.userId}</div>
                        </div>
                    </div>

                        <%-- ===== Card thông tin liên hệ ===== --%>
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-white border-bottom">
                            <h6 class="mb-0 font-weight-bold text-dark">
                                <i class="fas fa-address-card mr-2 text-primary"></i>Thông tin liên hệ
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-borderless mb-0">
                                <tbody>
                                <tr>
                                    <td class="text-muted" style="width:40%;">
                                        <i class="fas fa-user mr-1"></i> Tên tài khoản
                                    </td>
                                    <td class="font-weight-semibold text-dark">${profile.username}</td>
                                </tr>
                                <tr class="bg-light">
                                    <td class="text-muted">
                                        <i class="fas fa-envelope mr-1"></i> Email
                                    </td>
                                    <td class="text-dark">${profile.email}</td>
                                </tr>
                                <tr>
                                    <td class="text-muted">
                                        <i class="fas fa-phone mr-1"></i> Số điện thoại
                                    </td>
                                    <td class="text-dark">${profile.phone}</td>
                                </tr>
                                <tr class="bg-light">
                                    <td class="text-muted">
                                        <i class="fas fa-shield-alt mr-1"></i> Vai trò
                                    </td>
                                    <td>
                                        <span class="badge badge-info">${profile.role}</span>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                        <%-- ===== Card địa chỉ ===== --%>
                    <div class="card shadow-sm mb-4">
                        <div class="card-header bg-white border-bottom">
                            <h6 class="mb-0 font-weight-bold text-dark">
                                <i class="fas fa-map-marker-alt mr-2 text-danger"></i>Địa chỉ mặc định
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <table class="table table-borderless mb-0">
                                <tbody>
                                <tr>
                                    <td class="text-muted" style="width:40%;">
                                        <i class="fas fa-city mr-1"></i> Tỉnh / Thành phố
                                    </td>
                                    <td class="text-dark">
                                        <c:choose>
                                            <c:when test="${not empty profile.province}">${profile.province}</c:when>
                                            <c:otherwise><span class="text-muted fst-italic">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr class="bg-light">
                                    <td class="text-muted">
                                        <i class="fas fa-map mr-1"></i> Quận / Huyện
                                    </td>
                                    <td class="text-dark">
                                        <c:choose>
                                            <c:when test="${not empty profile.district}">${profile.district}</c:when>
                                            <c:otherwise><span class="text-muted fst-italic">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-muted">
                                        <i class="fas fa-location-arrow mr-1"></i> Phường / Xã
                                    </td>
                                    <td class="text-dark">
                                        <c:choose>
                                            <c:when test="${not empty profile.ward}">${profile.ward}</c:when>
                                            <c:otherwise><span class="text-muted fst-italic">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr class="bg-light">
                                    <td class="text-muted">
                                        <i class="fas fa-home mr-1"></i> Địa chỉ cụ thể
                                    </td>
                                    <td class="text-dark">
                                        <c:choose>
                                            <c:when test="${not empty profile.specificAddress}">${profile.specificAddress}</c:when>
                                            <c:otherwise><span class="text-muted fst-italic">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                        <%-- ===== Nút hành động ===== --%>
                    <div class="d-flex justify-content-end mb-4">
                        <a href="<c:url value='/admin-profile'/>" class="btn btn-light mr-2">
                            <i class="fas fa-arrow-left mr-1"></i> Quay lại
                        </a>
                        <a href="<c:url value='/admin-profile-update/${profile.userId}'/>" class="btn btn-primary">
                            <i class="fas fa-edit mr-1"></i> Chỉnh sửa
                        </a>
                        <a href="<c:url value='/admin-profile-password/${profile.userId}'/>" class="btn btn-warning text-white">
                            <i class="fas fa-key mr-1"></i> Đổi mật khẩu
                        </a>
                    </div>

                </div>
            </div>
        </c:if>

    </div>
</section>
