<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="${pageContext.request.contextPath}/admin" class="brand-link">
        <img src="<c:url value='/template/admin/dist/img/AdminLTELogo.png'/>" alt="AdminLTE Logo"
             class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">AdminPage</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- User Info -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="info">
                <a href="#" class="d-block text-white font-weight-bold">
                    <sec:authorize access="isAuthenticated()">
                        <sec:authentication property="principal.user.fullName" />
                    </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                        Guest
                    </sec:authorize>
                </a>
                <small class="text-muted">Chào mừng bạn trở lại!</small>
            </div>
        </div>

        <!-- Sidebar Search -->
        <div class="form-inline mt-2">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Tìm kiếm..."
                       aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-3">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                data-accordion="false">

                <!-- Dashboard - tất cả users -->
                <li class="nav-header text-uppercase text-muted small font-weight-bold">Tổng quan</li>
                <li class="nav-item">
                    <a href="<c:url value='/admin-home'/>"
                       class="nav-link ${pageContext.request.requestURI.contains('admin-home') ? 'active' : ''}">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

                <!-- Doanh thu - chỉ ADMIN -->
                <sec:authorize access="hasRole('ADMIN')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-revenue'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-revenue') ? 'active' : ''}">
                            <i class="nav-icon fas fa-chart-line"></i>
                            <p>Doanh thu</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Quản lý sản phẩm - ADMIN và WAREHOUSE_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'WAREHOUSE_MANAGER')">
                    <li
                            class="nav-item has-treeview ${pageContext.request.requestURI.contains('admin-product') || pageContext.request.requestURI.contains('admin-series') || pageContext.request.requestURI.contains('admin-category') || pageContext.request.requestURI.contains('admin-root-category') ? 'menu-open' : ''}">
                        <a href="#"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-product') || pageContext.request.requestURI.contains('admin-series') || pageContext.request.requestURI.contains('admin-category') || pageContext.request.requestURI.contains('admin-root-category') ? 'active' : ''}">
                            <i class="nav-icon fas fa-box-open"></i>
                            <p>
                                Quản lý sản phẩm
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="<c:url value='/admin-root-category'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('admin-root-category') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Danh mục gốc </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/admin-category'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('admin-category') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Danh mục sản phẩm</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/admin-series'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('admin-series') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Mã danh mục sản phẩm</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/admin-brand'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('admin-brand') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Thương hiệu </p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/admin-product'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('admin-product') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Sản phẩm</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                </sec:authorize>

                <!-- Kho hàng - ADMIN và WAREHOUSE_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'WAREHOUSE_MANAGER')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-inventory'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-inventory') ? 'active' : ''}">
                            <i class="nav-icon fas fa-warehouse"></i>
                            <p>Quản lý tồn kho</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<c:url value='/admin-stock-list'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-stock') ? 'active' : ''}">
                            <i class="nav-icon fas fa-warehouse"></i>
                            <p>Quản lý nhập kho</p>
                        </a>
                    </li>

                </sec:authorize>

                <!-- Blog Management - ADMIN và CONTENT_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'CONTENT_MANAGER')">
                    <li class="nav-header text-uppercase text-muted small font-weight-bold mt-3">Blog & Nội
                        dung</li>
                    <li
                            class="nav-item has-treeview ${pageContext.request.requestURI.contains('blog-category') || pageContext.request.requestURI.contains('blog-post') || pageContext.request.requestURI.contains('blog-comment') ? 'menu-open' : ''}">
                        <a href="#"
                           class="nav-link ${pageContext.request.requestURI.contains('blog-') ? 'active' : ''}">
                            <i class="nav-icon fas fa-blog text-success"></i>
                            <p>
                                Quản lý Blog
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="<c:url value='/admin-blog-category'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('blog-category') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Danh mục Blog</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/admin-blog-post'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('blog-post') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Bài viết Blog</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<c:url value='/admin-blog-comment'/>"
                                   class="nav-link ${pageContext.request.requestURI.contains('blog-comment') ? 'active' : ''}">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Bình luận Blog</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                </sec:authorize>

                <!-- Banner Management - ADMIN và CONTENT_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'CONTENT_MANAGER')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin/banners'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin/banners') ? 'active' : ''}">
                            <i class="nav-icon fas fa-bullhorn text-warning"></i>
                            <p>Quản lý banners</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Mã giảm giá - ADMIN,SALES_STAFF, CONTENT_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'SALES_STAFF', 'CONTENT_MANAGER')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-coupon-list'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-coupon') ? 'active' : ''}">
                            <i class="nav-icon fas fa-ticket-alt"></i>
                            <p>Quản lý mã giảm giá</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Chính sách - ADMIN và CONTENT_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'CONTENT_MANAGER')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-policy-list'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-policy') ? 'active' : ''}">
                            <i class="nav-icon fas fa-file-contract"></i>
                            <p>Chính sách cửa hàng</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Tài khoản & Đơn hàng -->
                <li class="nav-header text-uppercase text-muted small font-weight-bold mt-3">Khách hàng &
                    Bán hàng</li>

                <!-- Quản lý tài khoản - chỉ ADMIN -->
                <sec:authorize access="hasRole('ADMIN')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-account'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-account') ? 'active' : ''}">
                            <i class="nav-icon fas fa-users"></i>
                            <p>Quản lý tài khoản</p>
                        </a>
                    </li>

                    <li class="nav-item">
                        <a href="<c:url value='/admin-profile'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-profile') ? 'active' : ''}">
                            <i class="nav-icon fas fa-user-circle"></i>
                            <p>Quản lý thông tin tài khoản</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Quản lý đơn hàng - ADMIN và SALES_STAFF -->
                <sec:authorize access="hasAnyRole('ADMIN', 'SALES_STAFF')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-orders'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-orders') ? 'active' : ''}">
                            <i class="nav-icon fas fa-shopping-cart"></i>
                            <p>Quản lý đơn hàng</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Đánh giá sản phẩm - ADMIN, SALES_STAFF, CONTENT_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'SALES_STAFF', 'CONTENT_MANAGER')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-review-list'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-review') ? 'active' : ''}">
                            <i class="nav-icon fas fa-star"></i>
                            <p>Quản lý đánh giá sản phẩm</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Bình luận & Hỏi đáp - ADMIN, SALES_STAFF, CONTENT_MANAGER -->
                <sec:authorize access="hasAnyRole('ADMIN', 'SALES_STAFF', 'CONTENT_MANAGER')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-product-comment-list'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-product-comment') ? 'active' : ''}">
                            <i class="nav-icon fas fa-comments"></i>
                            <p>Quản lý bình luận & Hỏi đáp</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Quản lý phân quyền - chỉ ADMIN -->
                <sec:authorize access="hasRole('ADMIN')">
                    <li class="nav-item">
                        <a href="<c:url value='/admin-roles'/>"
                           class="nav-link ${pageContext.request.requestURI.contains('admin-roles') ? 'active' : ''}">
                            <i class="nav-icon fas fa-user-shield"></i>
                            <p>Danh sách phân quyền</p>
                        </a>
                    </li>
                </sec:authorize>

            </ul>
        </nav>
    </div>
</aside>