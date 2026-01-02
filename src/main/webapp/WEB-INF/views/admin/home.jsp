<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    /* Reset & Base */
    body {
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .content-header {
        background: #ffffff;
        padding: 2.5rem 0 2rem;
        margin-bottom: 10px;
        border-radius: 0 0 20px 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    .content-header h1 {
        color: #1a202c;
        font-weight: 600;
        font-size: 1.8rem;
        margin: 0;
    }
    .breadcrumb {
        background: transparent;
        padding: 0;
        margin: 0;
        font-size: 0.9rem;
    }

    /* Dashboard Cards - Thiết kế phẳng hiện đại */
    .stat-card {
        background: #ffffff;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        padding: 1.5rem;
        position: relative;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.05);
    }

    /* Icon box: Tạo điểm nhấn màu sắc vừa đủ */
    .icon-box {
        width: 56px;
        height: 56px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        margin-right: 1.2rem;
    }

    /* Định nghĩa các tông màu nhẹ (Soft Colors) */
    .bg-soft-blue { background-color: #e0f2fe; color: #0369a1; }
    .bg-soft-green { background-color: #dcfce7; color: #15803d; }
    .bg-soft-purple { background-color: #f3e8ff; color: #7e22ce; }

    .stat-content h3 {
        font-size: 1.6rem;
        font-weight: 700;
        margin: 0;
        color: #0f172a;
    }
    .stat-content p {
        font-size: 0.875rem;
        color: #64748b;
        margin: 0;
        text-transform: uppercase;
        letter-spacing: 0.025em;
        font-weight: 600;
    }

    /* Link xem chi tiết tinh tế hơn */
    .stat-link {
        position: absolute;
        top: 1rem;
        right: 1rem;
        color: #94a3b8;
        font-size: 0.9rem;
        transition: color 0.2s;
    }
    .stat-link:hover {
        color: #2563eb;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .stat-card { padding: 1.2rem; }
        .stat-content h3 { font-size: 1.4rem; }
    }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1><i class="fas fa-grid-2 mr-2 text-primary"></i>Tổng quan hệ thống</h1>
            </div>
            <div class="col-sm-6 text-right d-none d-sm-block">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#" class="text-muted">Admin</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-4 col-md-6 col-12">
                <div class="stat-card">
                    <div class="icon-box bg-soft-blue">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="stat-content">
                        <p>Đơn hàng</p>
                        <h3>${totalOrders}</h3>
                    </div>
                    <a href="<c:url value='/admin-orders'/>" class="stat-link" title="Xem chi tiết">
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                </div>
            </div>

            <div class="col-lg-4 col-md-6 col-12">
                <div class="stat-card">
                    <div class="icon-box bg-soft-green">
                        <i class="fas fa-wallet"></i>
                    </div>
                    <div class="stat-content">
                        <p>Doanh thu tháng ${currentMonth}</p>
                        <h3><fmt:formatNumber value="${monthlyRevenue}" type="number" maxFractionDigits="0" groupingUsed="true"/> ₫</h3>
                    </div>
                    <a href="<c:url value='/admin-revenue'/>" class="stat-link" title="Xem báo cáo">
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                </div>
            </div>

            <div class="col-lg-4 col-md-6 col-12">
                <div class="stat-card">
                    <div class="icon-box bg-soft-purple">
                        <i class="fas fa-box-open"></i>
                    </div>
                    <div class="stat-content">
                        <p>Sản phẩm kho</p>
                        <h3>${totalProducts}</h3>
                    </div>
                    <a href="<c:url value='/admin-product'/>" class="stat-link" title="Quản lý kho">
                        <i class="fas fa-external-link-alt"></i>
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>