    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ include file="/common/taglib.jsp"%>

    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>${coupon.id > 0 ? 'Sửa mã giảm giá' : 'Thêm mã giảm giá mới'}</h1>
                </div>
                <div class="col-sm-6 text-right">
                    <a href="<c:url value='/admin-coupon-list'/>" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-body">

                    <form id="couponForm" method="post">
                        <input type="hidden" name="id" value="${coupon.id}"/>

                        <div class="row">
                            <div class="col-md-6 form-group">
                                <label>Mã code <span class="text-danger">*</span></label>
                                <input type="text" name="code" class="form-control"
                                       value="${coupon.code}" required placeholder="VD: GIAM20K"/>
                            </div>

                            <div class="col-md-6 form-group">
                                <label>Loại giảm giá</label>
                                <select name="discountType" class="form-control">
                                    <option value="AMOUNT" ${coupon.discountType == 'AMOUNT' ? 'selected' : ''}>
                                        Số tiền cố định (₫)
                                    </option>
                                    <option value="PERCENT" ${coupon.discountType == 'PERCENT' ? 'selected' : ''}>
                                        Phần trăm (%)
                                    </option>
                                </select>
                            </div>

                            <div class="col-md-6 form-group">
                                <label>Giá trị giảm <span class="text-danger">*</span></label>
                                <input type="number" name="discountValue" class="form-control"
                                       value="${coupon.discountValue}" required/>
                            </div>

                            <div class="col-md-6 form-group">
                                <label>Đơn tối thiểu</label>
                                <input type="number" name="minOrderAmount" class="form-control"
                                       value="${coupon.minOrderAmount}"/>
                            </div>

                            <div class="col-md-6 form-group">
                                <label>Giới hạn sử dụng</label>
                                <input type="number" name="usageLimit" class="form-control"
                                       value="${coupon.usageLimit}" placeholder="Bỏ trống nếu không giới hạn"/>
                            </div>

                            <div class="col-md-6 form-group">
                                <label>Ngày hết hạn</label>
                                <input type="date" name="endDate" class="form-control"
                                       value="<fmt:formatDate value='${coupon.endDate}' pattern='yyyy-MM-dd'/>"/>
                            </div>

                            <div class="col-md-6 form-group">
                                <label>Trạng thái</label>
                                <div class="custom-control custom-switch">
                                    <input type="checkbox"
                                           class="custom-control-input"
                                           id="statusSwitch"
                                           name="status"
                                    ${coupon.status || coupon.id == 0 ? 'checked' : ''}/>
                                    <label class="custom-control-label" for="statusSwitch">Kích hoạt</label>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary px-5">Lưu lại</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>


