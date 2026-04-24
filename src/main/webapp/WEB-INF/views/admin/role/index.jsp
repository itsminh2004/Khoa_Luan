<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/common/taglib.jsp" %>

        <style>
            .content-header {
                padding: 1.5rem 0;
                background: #fff;
                border-bottom: 1px solid #f1f5f9;
                margin-bottom: 2rem;
            }

            .content-header h1 {
                font-size: 1.4rem;
                font-weight: 700;
                color: #0f172a;
                margin: 0;
            }

            .card {
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
                background: #fff;
                overflow: hidden;
                margin-bottom: 1.5rem;
            }

            .card-header {
                background: #fff;
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid #f1f5f9;
            }

            .card-title {
                font-weight: 600;
                color: #334155;
                font-size: 1.1rem;
                margin: 0;
            }

            .card-body {
                padding: 1.5rem;
            }

            .role-badge {
                display: inline-block;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                font-weight: 600;
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }

            .role-admin {
                background: #fee2e2;
                color: #b91c1c;
            }

            .role-sales {
                background: #dbeafe;
                color: #1e40af;
            }

            .role-warehouse {
                background: #d1fae5;
                color: #065f46;
            }

            .role-content {
                background: #fef3c7;
                color: #92400e;
            }

            .role-employee {
                background: #f3f4f6;
                color: #374151;
            }

            .permission-table {
                width: 100%;
                margin-top: 1rem;
            }

            .permission-table th {
                background: #f8fafc;
                color: #64748b;
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                font-weight: 600;
                padding: 0.75rem;
                border: 1px solid #e2e8f0;
            }

            .permission-table td {
                padding: 0.75rem;
                border: 1px solid #e2e8f0;
                text-align: center;
            }

            .permission-yes {
                color: #15803d;
                font-weight: 600;
            }

            .permission-no {
                color: #cbd5e1;
            }
        </style>

        <section class="content-header">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <h1>Quản lý phân quyền</h1>
                    </div>
                    <div class="col-sm-6 text-right d-none d-sm-block">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb float-sm-right mb-0 bg-transparent">
                                <li class="breadcrumb-item"><a href="admin-home" class="text-muted">Home</a></li>
                                <li class="breadcrumb-item active">Phân quyền</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>

        <section class="content">
            <div class="container-fluid">
                <!-- Danh sách roles -->
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Danh sách vai trò trong hệ thống</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <c:forEach items="${availableRoles}" var="role">
                                <div class="col-md-6 mb-3">
                                    <div style="padding: 1rem; border: 1px solid #e2e8f0; border-radius: 8px;">
                                        <span class="role-badge role-${fn:toLowerCase(role.key)}">${role.key}</span>
                                        <p class="mb-0 mt-2 text-muted">${role.value}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Ma trận quyền -->
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Ma trận phân quyền</h3>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="permission-table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left;">Chức năng</th>
                                        <th>ADMIN</th>
                                        <th>SALES_STAFF</th>
                                        <th>WAREHOUSE_MANAGER</th>
                                        <th>CONTENT_MANAGER</th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Dashboard</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>

                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Báo cáo doanh thu</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Quản lý sản phẩm</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Quản lý kho</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>

                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Quản lý đơn hàng</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>

                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Mã giảm giá</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>

                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Quản lý Blog</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>

                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Chính sách</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Đánh giá & Bình luận</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left; font-weight: 500;">Quản lý tài khoản</td>
                                        <td class="permission-yes"><i class="fas fa-check"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                        <td class="permission-no"><i class="fas fa-times"></i></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>