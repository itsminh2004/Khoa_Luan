<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="<c:url value=" /admin-home" /> " class="nav-link">Home</a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="#" class="nav-link">Contact</a>
        </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        <!-- Navbar Search -->
        <li class="nav-item">
            <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                <i class="fas fa-expand-arrows-alt"></i>
            </a>
        </li>
        <!-- User dropdown -->
        <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#">
                <i class="fas fa-user-circle"></i>
                <span class="ml-1">
                            <sec:authorize access="isAuthenticated()">
                                <sec:authentication property="principal.user.fullName" />
                                <sec:authentication property="principal.user.roles" var="roles" />
                                <sec:authentication property="principal.user.id" var="currentUserId" />
                                <c:forEach var="role" items="${roles}">
                                    <span class="badge badge-info ml-1" style="font-size: 10px; font-weight: 500;">
                                            ${role.replace('ROLE_', '')}
                                    </span>
                                </c:forEach>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated()">
                                Guest
                            </sec:authorize>
                        </span>
            </a>

            <div class="dropdown-menu dropdown-menu-right">
                        <span class="dropdown-item dropdown-header">
                            <sec:authorize access="isAuthenticated()">
                                <div class="font-weight-bold"><sec:authentication property="principal.user.fullName" /></div>
                                <div class="text-muted small">
                                    <c:forEach var="role" items="${roles}" varStatus="status">
                                        ${role.replace('ROLE_', '')}${!status.last ? ', ' : ''}
                                    </c:forEach>
                                </div>
                            </sec:authorize>
                        </span>

                <div class="dropdown-divider"></div>

                <a href="${pageContext.request.contextPath}/admin-profile-detail/${currentUserId}" class="dropdown-item">
                    <i class="fas fa-user mr-2"></i> Hồ sơ
                </a>

                <div class="dropdown-divider"></div>

                <a href="<c:url value='/logout'/>" class="dropdown-item text-danger">
                    <i class="fas fa-sign-out-alt mr-2"></i> Đăng xuất
                </a>
            </div>
        </li>
    </ul>
</nav>