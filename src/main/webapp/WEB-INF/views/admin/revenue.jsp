<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>

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
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .content-header h1 {
        color: #1a202c;
        font-weight: 600;
        font-size: 1.8rem;
        margin: 0;
    }

    .card {
        background: #ffffff;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        margin-bottom: 24px;
        overflow: hidden;
    }

    .filter-section {
        background: #ffffff;
        padding: 1.5rem;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        margin-bottom: 25px;
    }

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
        color: white;
    }

    .btn-export {
        background: #10b981;
        color: white;
        padding: 0.6rem 1.5rem;
        border-radius: 8px;
        font-weight: 500;
        border: none;
        transition: background 0.2s;
    }

    .btn-export:hover {
        background: #059669;
        color: white;
    }

    .revenue-showcase {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        padding: 2rem;
        text-align: center;
        border-radius: 12px;
        margin-bottom: 25px;
    }

    .revenue-amount {
        color: #0f172a;
        font-size: 2.5rem;
        font-weight: 800;
    }

    .revenue-period {
        color: #2563eb;
        font-weight: 600;
        font-size: 1.1rem;
    }

    .table thead th {
        background: #f1f5f9;
        color: #475569;
        font-weight: 600;
        border-bottom: 1px solid #e2e8f0;
    }

    .chart-container {
        position: relative;
        height: 300px;
        width: 100%;
    }

    .badge-top {
        background: #fef3c7;
        color: #92400e;
        font-weight: 700;
        padding: 0.2rem 0.6rem;
        border-radius: 4px;
    }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1>Báo cáo doanh số</h1>
            </div>
            <div class="col-sm-6 text-right">
                <a href="<c:url value='/api/admin/statistics/export-excel?year=${selectedYear}&month=${selectedMonth}'/>"
                   class="btn btn-export">
                    <i class="fas fa-file-excel mr-2"></i>Xuất Excel
                </a>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="container-fluid">
        <div class="row">
            <!-- Filter -->
            <div class="col-md-12">
                <div class="filter-section">
                    <form method="get" action="<c:url value='/admin-revenue'/>"
                          class="form-row align-items-end">
                        <div class="col-md-4">
                            <label>Năm</label>
                            <select name="year" class="form-control">
                                <c:forEach var="y" begin="${currentYear - 5}" end="${currentYear}">
                                    <option value="${y}" ${y==selectedYear ? 'selected' : '' }>${y}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label>Tháng</label>
                            <select name="month" class="form-control">
                                <c:forEach var="m" begin="1" end="12">
                                    <option value="${m}" ${m==selectedMonth ? 'selected' : '' }>Tháng ${m}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button type="submit" class="btn-filter btn-block">
                                <i class="fas fa-sync-alt mr-2"></i>Cập nhật số liệu
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Revenue Chart -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-chart-line mr-2 text-primary"></i>Biểu đồ doanh
                            thu ngày (Tháng ${selectedMonth}/${selectedYear})</h3>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Total Revenue Summary -->
            <div class="col-md-4">
                <div class="revenue-showcase">
                    <div class="revenue-period">Doanh thu tháng chọn</div>
                    <div class="revenue-amount">
                        <fmt:formatNumber value="${monthlyRevenue}" type="number" maxFractionDigits="0"
                                          groupingUsed="true" /> ₫
                    </div>
                    <div class="mt-3">
                                <span class="text-muted"><i class="fas fa-calendar-alt mr-1"></i>Tháng ${selectedMonth},
                                    Năm ${selectedYear}</span>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-crown mr-2 text-warning"></i>Sản phẩm bán chạy
                            nhất</h3>
                    </div>
                    <div class="card-body p-0">
                        <table class="table mb-0">
                            <tbody>
                            <c:forEach var="top" items="${topSelling}" varStatus="status">
                                <tr>
                                    <td width="40"><span class="badge-top">${status.index + 1}</span></td>
                                    <td>${top.Name}</td>
                                    <td class="text-right"><strong>${top.total_sold}</strong></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty topSelling}">
                                <tr>
                                    <td colspan="3" class="text-center py-3 text-muted">Chưa có dữ liệu</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Detailed Table -->
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-box-open mr-2 text-success"></i>Chi tiết sản
                            phẩm bán ra trong tháng</h3>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Số lượng bán</th>
                                    <th class="text-right">Doanh thu tạm tính</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="sale" items="${productSales}">
                                    <tr>
                                        <td>${sale.Id}</td>
                                        <td><strong>${sale.Name}</strong></td>
                                        <td class="text-center">${sale.total_sold}</td>
                                        <td class="text-right">
                                            <fmt:formatNumber value="${sale.total_revenue}" type="number"
                                                              groupingUsed="true" /> ₫
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty productSales}">
                                    <tr>
                                        <td colspan="4" class="text-center py-5 text-muted">Không có sản
                                            phẩm nào được bán trong tháng này.</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Fetch data for chart
        const year = ${ selectedYear };
        const month = ${ selectedMonth };
        const ctxPath = '${pageContext.request.contextPath}';

        fetch(ctxPath + '/api/admin/statistics/daily-revenue-month?year=' + year + '&month=' + month)
            .then(response => response.json())
            .then(data => {
                const labels = [];
                const values = [];

                // Xử lý để hiển thị đầy đủ các ngày trong tháng (từ ngày 1 đến ngày cuối cùng của tháng)
                const daysInMonth = new Date(year, month, 0).getDate();

                // Khởi tạo mảng chứa doanh thu 0 cho tất cả các ngày
                const dailyData = new Array(daysInMonth).fill(0);

                // Điền dữ liệu thực tế từ API vào mảng
                data.forEach(item => {
                    // JDBC có thể trả về key là chữ hoa hoặc chữ thường tuỳ database
                    const d = item.day || item.DAY || item.Day;
                    if (d) {
                        dailyData[d - 1] = item.revenue;
                    }
                });

                // Hàm phụ trợ thêm số 0 ở đầu (ví dụ: 1 -> 01)
                const padZero = (num) => num < 10 ? '0' + num : num;
                const formattedMonth = padZero(month);

                // Tạo labels và values cho biểu đồ
                for (let i = 0; i < daysInMonth; i++) {
                    const formattedDay = padZero(i + 1);
                    labels.push(formattedDay + "/" + formattedMonth);
                    values.push(dailyData[i]);
                }

                const ctx = document.getElementById('revenueChart').getContext('2d');
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Doanh thu (₫)',
                            data: values,
                            backgroundColor: 'rgba(37, 99, 235, 0.1)',
                            borderColor: 'rgba(37, 99, 235, 1)',
                            borderWidth: 2,
                            pointBackgroundColor: 'rgba(37, 99, 235, 1)',
                            tension: 0.3,
                            fill: true
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true,
                                    callback: function (value) {
                                        return value.toLocaleString() + ' ₫';
                                    }
                                }
                            }]
                        },
                        tooltips: {
                            callbacks: {
                                label: function (tooltipItem, data) {
                                    return tooltipItem.yLabel.toLocaleString() + ' ₫';
                                }
                            }
                        }
                    }
                });
            });
    });
</script>