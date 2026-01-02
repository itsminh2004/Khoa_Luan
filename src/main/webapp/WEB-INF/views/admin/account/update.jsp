<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>

<style>
    /* Layout tập trung */
    .role-container {
        max-width: 600px;
        margin: 2rem auto;
    }

    .card-modern {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        overflow: hidden;
    }

    .card-header-modern {
        padding: 1.5rem 2rem;
        background: #fff;
        border-bottom: 1px solid #f1f5f9;
    }

    .card-header-modern h3 {
        font-size: 1.25rem;
        font-weight: 700;
        color: #0f172a;
        margin: 0;
    }

    .card-body-modern {
        padding: 2rem;
    }

    /* Form styling */
    .form-group-modern {
        margin-bottom: 1.5rem;
    }

    .label-modern {
        display: block;
        font-size: 0.8rem;
        font-weight: 600;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        margin-bottom: 0.5rem;
    }

    .input-readonly {
        background-color: #f8fafc !important;
        border: 1px solid #e2e8f0;
        color: #64748b;
        font-weight: 500;
        cursor: not-allowed;
    }

    .select-modern {
        appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%2364748b' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 0.75rem center;
        background-size: 1.2em;
        padding-right: 2.5rem;
    }

    .form-control-modern {
        width: 100%;
        padding: 0.75rem 1rem;
        border-radius: 10px;
        border: 1px solid #cbd5e1;
        transition: all 0.2s;
        font-size: 0.95rem;
    }

    .form-control-modern:focus {
        outline: none;
        border-color: #3b82f6;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
    }

    /* Buttons */
    .btn-group-modern {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }

    .btn-save-modern {
        flex: 1;
        background: #0f172a;
        color: white;
        border: none;
        padding: 0.75rem;
        border-radius: 10px;
        font-weight: 600;
        transition: opacity 0.2s;
    }

    .btn-save-modern:hover {
        opacity: 0.9;
    }

    .btn-back-modern {
        flex: 1;
        background: #f1f5f9;
        color: #475569;
        border: none;
        padding: 0.75rem;
        border-radius: 10px;
        font-weight: 600;
        text-align: center;
        text-decoration: none;
    }

    .btn-back-modern:hover {
        background: #e2e8f0;
        color: #1e293b;
    }
</style>

<section class="content-header">
    <div class="container-fluid">
        <div class="row align-items-center">
            <div class="col-sm-6">
                <h1 style="font-size: 1.4rem; font-weight: 700;">Thiết lập quyền truy cập</h1>
            </div>
            <div class="col-sm-6 text-right d-none d-sm-block">
                <ol class="breadcrumb float-sm-right mb-0 bg-transparent" style="font-size: 0.85rem;">
                    <li class="breadcrumb-item"><a href="admin-home" class="text-muted">Home</a></li>
                    <li class="breadcrumb-item"><a href="admin-account" class="text-muted">Tài khoản</a></li>
                    <li class="breadcrumb-item active">Phân quyền</li>
                </ol>
            </div>
        </div>
    </div>
</section>

<section class="content">
    <div class="role-container">
        <div class="card-modern">
            <div class="card-header-modern">
                <h3>Phân quyền cho người dùng</h3>
            </div>
            <div class="card-body-modern">
                <form action="<c:url value='/admin-account-updateRole/${AccountId.id}'/>" method="post">
                    <input type="hidden" name="userId" value="${AccountId.id}" />

                    <div class="form-group-modern">
                        <label class="label-modern">Tài khoản người dùng</label>
                        <input type="text" class="form-control-modern input-readonly" value="${AccountId.email}" readonly />
                    </div>

                    <div class="form-group-modern">
                        <label class="label-modern">Vai trò hệ thống (Role)</label>
                        <select name="role" class="form-control-modern select-modern">
                            <option value="USER" ${AccountId.roles[0] == 'USER' ? 'selected' : ''}>
                                <i class="fas fa-user"></i> USER - Người dùng cơ bản
                            </option>
                            <option value="ADMIN" ${AccountId.roles[0] == 'ADMIN' ? 'selected' : ''}>
                                <i class="fas fa-user-shield"></i> ADMIN - Quản trị viên hệ thống
                            </option>
                        </select>
                        <small class="text-muted mt-2 d-block">
                            * Quyền ADMIN có thể truy cập toàn bộ các chức năng quản lý.
                        </small>
                    </div>

                    <div class="btn-group-modern">
                        <a href="<c:url value='/admin-account'/>" class="btn-back-modern">
                            Hủy bỏ
                        </a>
                        <button type="submit" class="btn-save-modern">
                            Xác nhận cấp quyền
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>