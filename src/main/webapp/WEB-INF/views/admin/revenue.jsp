<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    /* Tổng thể tối giản */
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

    /* Card thiết kế phẳng */
    .card {
        background: #ffffff;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        margin-bottom: 24px;
        overflow: hidden;
    }

    /* Filter Section: Bỏ màu tím, dùng màu trung tính */
    .filter-section {
        background: #ffffff;
        padding: 1.5rem;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        margin-bottom: 25px;
    }

    .filter-section h3 {
        font-size: 1.1rem;
        font-weight: 600;
        color: #1e293b;
        margin-bottom: 1.2rem;
    }

    .filter-group label {
        color: #64748b;
        font-size: 0.85rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .filter-group select {
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        padding: 0.6rem;
        color: #1e293b;
    }

    /* Nút bấm chuyên nghiệp */
    .btn-filter {
        background: #2563eb;
        color: white;
        padding: 0.6rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        border: none;
        transition: background 0.2s;
    }

    .btn-filter:hover {
        background: #1d4ed8;
    }

    /* Revenue Showcase: Tập trung vào con số, bỏ Gradient xanh lá */
    .revenue-showcase {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        padding: 2.5rem;
        text-align: center;
        border-radius: 12px;
        margin-bottom: 25px;
    }

    .revenue-label {
        color: #64748b;
        font-size: 1rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        margin-bottom: 0.5rem;
    }

    .revenue-amount {
        color: #0f172a;
        font-size: 3rem;
        font-weight: 800;
    }

    .revenue-period {
        color: #2563eb;
        font-weight: 600;
        font-size: 1.1rem;
    }

    /* Bảng dữ liệu sạch sẽ */
    .table thead th {
        background: #f8fafc;
        color: #64748b;
        font-weight: 600;
        border-bottom: 1px solid #e2e8f0;
        padding: 1rem;
    }

    .table tbody td {
        padding: 1.2rem 1rem;
        border-bottom: 1px solid #f1f5f9;
        vertical-align: middle;
    }

    .table tbody tr:hover {
        background-color: #f8fafc; /* Chỉ đổi màu nền nhẹ khi hover */
    }

    /* Badge tối giản */
    .badge {
        padding: 0.4em 0.8em;
        font-weight: 500;
        border-radius: 6px;
    }

    .badge-success {
        background-color: #dcfce7;
        color: #166534;
    }

    .badge-info {
        background-color: #e0f2fe;
        color: #075985;
    }

    .badge-secondary {
        background-color: #f1f5f9;
        color: #475569;
    }

    /* Loại bỏ text-shadow và các hiệu ứng thừa */
    .revenue-text, .total-revenue {
        color: #1e293b;
        font-weight: 700;
    }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1>Doanh thu theo tháng</h1>
            </div>
            <div class="col-sm-6 text-right">
                <small class="text-muted">Home / Doanh thu</small>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="filter-section">
            <h3><i class="fas fa-search-dollar mr-2 text-primary"></i>Bộ lọc dữ liệu</h3>
            <form method="get" action="<c:url value='/admin-revenue'/>" class="form-row align-items-end">
                <div class="col-md-4 filter-group">
                    <label>Chọn năm</label>
                    <select name="year" id="year" class="form-control">
                        <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear}">
                            <option value="${y}" ${y == selectedYear ? 'selected' : ''}>Năm ${y}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4 filter-group">
                    <label>Chọn tháng</label>
                    <select name="month" id="month" class="form-control">
                        <c:forEach var="m" begin="1" end="12">
                            <option value="${m}" ${m == selectedMonth ? 'selected' : ''}>Tháng ${m}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn-filter btn-block">
                        Áp dụng
                    </button>
                </div>
            </form>
        </div>

        <div class="revenue-showcase">
            <div class="revenue-label">Báo cáo doanh thu</div>
            <div class="revenue-period">Tháng ${selectedMonth}/${selectedYear}</div>
            <div class="revenue-amount">
                <fmt:formatNumber value="${monthlyRevenue}" type="number" maxFractionDigits="0" groupingUsed="true"/> ₫
            </div>
        </div>

        <div class="card">
            <div class="card-header bg-white">
                <h3 class="card-title" style="font-size: 1.1rem; font-weight: 600;">
                    <i class="fas fa-list-ul mr-2 text-primary"></i>Lịch sử 6 tháng gần nhất
                </h3>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table mb-0">
                        <thead>
                        <tr>
                            <th>Thời gian</th>
                            <th>Doanh thu</th>
                            <th class="text-center">Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty recentMonths}">
                                <c:forEach var="monthData" items="${recentMonths}">
                                    <tr>
                                        <td>
                                            <strong>Tháng ${monthData.month}/${monthData.year}</strong>
                                            <c:if test="${monthData.year == currentYear && monthData.month == currentMonth}">
                                                <span class="badge badge-info ml-2">Hiện tại</span>
                                            </c:if>
                                        </td>
                                        <td class="revenue-text">
                                            <fmt:formatNumber value="${monthData.revenue}" type="number" maxFractionDigits="0" groupingUsed="true"/> ₫
                                        </td>
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${monthData.revenue > 0}">
                                                    <span class="badge badge-success">Hoạt động</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">Không có dữ liệu</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="3" class="text-center py-5 text-muted">
                                        Chưa có dữ liệu thống kê.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>