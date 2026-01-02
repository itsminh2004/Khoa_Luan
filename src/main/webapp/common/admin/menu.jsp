<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="${pageContext.request.contextPath}/admin" class="brand-link">
        <img src="<c:url value='/template/admin/dist/img/AdminLTELogo.png'/>"
             alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">AdminPage</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- User Info -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="info">
                <a href="#" class="d-block text-white font-weight-bold">
                    Thế giới công nghệ
                </a>
                <small class="text-muted">Chào mừng bạn trở lại!</small>
            </div>
        </div>

        <!-- Sidebar Search -->
        <div class="form-inline mt-2">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Tìm kiếm..." aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-3">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

                <!-- Dashboard -->
                <li class="nav-header text-uppercase text-muted small font-weight-bold">Tổng quan</li>
                <li class="nav-item">
                    <a href="<c:url value='/admin-home'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-home') ? 'active' : ''}">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<c:url value='/admin-revenue'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-revenue') ? 'active' : ''}">
                        <i class="nav-icon fas fa-chart-line"></i>
                        <p>Doanh thu</p>
                    </a>
                </li>

                <!-- Quản lý sản phẩm -->
                <li class="nav-item has-treeview ${pageContext.request.requestURI.contains('admin-product') || pageContext.request.requestURI.contains('admin-series') || pageContext.request.requestURI.contains('admin-category') ? 'menu-open' : ''}">
                    <a href="#" class="nav-link ${pageContext.request.requestURI.contains('admin-product') || pageContext.request.requestURI.contains('admin-series') || pageContext.request.requestURI.contains('admin-category') ? 'active' : ''}">
                        <i class="nav-icon fas fa-box-open"></i>
                        <p>
                            Quản lý sản phẩm
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value='/admin-category'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-category') ? 'active' : ''}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh mục sản phẩm</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/admin-series'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-series') ? 'active' : ''}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Mã sản phẩm (Series)</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/admin-product'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-product') ? 'active' : ''}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Sản phẩm</p>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- Blog Management - MỚI -->
                <li class="nav-header text-uppercase text-muted small font-weight-bold mt-3">Blog & Nội dung</li>
                <li class="nav-item has-treeview ${pageContext.request.requestURI.contains('blog-category') || pageContext.request.requestURI.contains('blog-post') || pageContext.request.requestURI.contains('blog-comment') ? 'menu-open' : ''}">
                    <a href="#" class="nav-link ${pageContext.request.requestURI.contains('blog-') ? 'active' : ''}">
                        <i class="nav-icon fas fa-blog text-success"></i>
                        <p>
                            Quản lý Blog
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="<c:url value='/admin-blog-category'/>" class="nav-link ${pageContext.request.requestURI.contains('blog-category') ? 'active' : ''}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Danh mục Blog</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/admin-blog-post'/>" class="nav-link ${pageContext.request.requestURI.contains('blog-post') ? 'active' : ''}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Bài viết Blog</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="<c:url value='/admin-blog-comment'/>" class="nav-link ${pageContext.request.requestURI.contains('blog-comment') ? 'active' : ''}">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Bình luận Blog</p>
                            </a>
                        </li>
                    </ul>
                </li>

                <!-- Tài khoản & Đơn hàng -->
                <li class="nav-header text-uppercase text-muted small font-weight-bold mt-3">Khách hàng & Bán hàng</li>
                <li class="nav-item">
                    <a href="<c:url value='/admin-account'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-account') ? 'active' : ''}">
                        <i class="nav-icon fas fa-users"></i>
                        <p>Quản lý tài khoản</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="<c:url value='/admin-orders'/>" class="nav-link ${pageContext.request.requestURI.contains('admin-orders') ? 'active' : ''}">
                        <i class="nav-icon fas fa-shopping-cart"></i>
                        <p>Quản lý đơn hàng</p>
                    </a>
                </li>



            </ul>
        </nav>
    </div>
</aside>