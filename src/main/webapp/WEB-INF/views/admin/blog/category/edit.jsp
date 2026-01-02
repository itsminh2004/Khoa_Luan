<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>

<style>
    .blog-category-edit-section {
        background: #f8f9fc;
        min-height: 100vh;
        padding-bottom: 2rem;
    }

    .page-header {
        background: #ffffff; /* trắng hoàn toàn */
        padding: 2.5rem 0;
        margin-bottom: 2rem;
        border-radius: 0 0 20px 20px;

        /* Shadow nhẹ để tạo chiều sâu */
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .page-header h1 {
        color: black;
        font-weight: 600;
        margin: 0;
        font-size: 1.75rem;
    }

    .breadcrumb {
        background: transparent;
        padding: 0.5rem 0 0 0;
        margin: 0;
    }

    .breadcrumb-item a {
        color: black;
        text-decoration: none;
        transition: color 0.3s;
    }

    .breadcrumb-item a:hover {
        color: black;
    }

    .breadcrumb-item.active {
        color: black;
    }

    .breadcrumb-item + .breadcrumb-item::before {
        color: black;
    }

    .form-card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 0 20px rgba(0,0,0,0.08);
        overflow: hidden;
        max-width: 800px;
        margin: 0 auto;
    }

    .form-card-body {
        padding: 2.5rem;
    }

    .form-group {
        margin-bottom: 1.75rem;
    }

    .form-group label {
        color: #2d3748;
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 0.5rem;
        display: block;
    }

    .text-danger {
        color: #e74a3b;
    }

    .form-control {
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        padding: 0.75rem 1rem;
        font-size: 0.95rem;
        transition: all 0.3s;
        color: #2d3748;
    }

    .form-control:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
        outline: none;
    }

    .form-control::placeholder {
        color: #a0aec0;
        font-style: italic;
    }

    textarea.form-control {
        resize: vertical;
        min-height: 120px;
    }

    .form-actions {
        display: flex;
        justify-content: flex-end;
        gap: 1rem;
        margin-top: 2.5rem;
        padding-top: 2rem;
        border-top: 2px solid #e3e6f0;
    }

    .btn {
        padding: 0.65rem 1.75rem;
        border-radius: 8px;
        font-weight: 500;
        font-size: 0.95rem;
        transition: all 0.3s;
        border: none;
        cursor: pointer;
    }

    .btn-success {
        background: linear-gradient(135deg, #1cc88a 0%, #13855c 100%);
        color: white;
        box-shadow: 0 2px 4px rgba(28, 200, 138, 0.3);
    }

    .btn-success:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(28, 200, 138, 0.5);
        background: linear-gradient(135deg, #17a673 0%, #0e6b47 100%);
        color: white;
    }

    .btn-secondary {
        background: #6c757d;
        color: white;
        box-shadow: 0 2px 4px rgba(108, 117, 125, 0.3);
    }

    .btn-secondary:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(108, 117, 125, 0.4);
        background: #5a6268;
        color: white;
    }

    .form-helper-text {
        font-size: 0.85rem;
        color: #718096;
        margin-top: 0.35rem;
        display: block;
    }

    .input-icon {
        position: relative;
    }

    .input-icon i {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #a0aec0;
    }

    .input-icon .form-control {
        padding-left: 2.75rem;
    }

    .category-id-badge {
        display: inline-block;
        background: linear-gradient(135deg, #e3e6f0 0%, #d1d5db 100%);
        color: #4a5568;
        padding: 0.4rem 0.9rem;
        border-radius: 8px;
        font-size: 0.85rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
    }
</style>

<section class="blog-category-edit-section">
    <div class="page-header">
        <div class="container-fluid">
            <h1>Sửa danh mục Blog</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/blog-category">Danh mục Blog</a></li>
                    <li class="breadcrumb-item active">Sửa danh mục</li>
                </ol>
            </nav>
        </div>
    </div>

    <div class="container-fluid">
        <div class="form-card">
            <div class="form-card-body">
                <div class="category-id-badge">
                    <i class="fas fa-hashtag"></i> ID: ${category.id}
                </div>

                <form action="${pageContext.request.contextPath}/admin/blog-category/edit" method="post">
                    <input type="hidden" name="id" value="${category.id}">

                    <div class="form-group">
                        <label>Tên danh mục <span class="text-danger">*</span></label>
                        <div class="input-icon">
                            <i class="fas fa-tag"></i>
                            <input type="text" name="name" value="${category.name}" class="form-control" required maxlength="100"
                                   placeholder="Nhập tên danh mục">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Slug (URL thân thiện)</label>
                        <div class="input-icon">
                            <i class="fas fa-link"></i>
                            <input type="text" name="slug" value="${category.slug}" class="form-control"
                                   placeholder="vd: cong-nghe-moi">
                        </div>
                        <small class="form-helper-text">
                            <i class="fas fa-info-circle"></i> URL thân thiện cho SEO
                        </small>
                    </div>

                    <div class="form-group">
                        <label>Mô tả</label>
                        <textarea name="description" rows="5" class="form-control"
                                  placeholder="Nhập mô tả cho danh mục...">${category.description}</textarea>
                        <small class="form-helper-text">
                            <i class="fas fa-info-circle"></i> Mô tả ngắn gọn về danh mục này
                        </small>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/blog-category" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check"></i> Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>