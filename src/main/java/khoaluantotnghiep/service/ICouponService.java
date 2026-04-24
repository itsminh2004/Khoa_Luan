package khoaluantotnghiep.service;

import khoaluantotnghiep.model.Coupon;
import java.util.List;

public interface ICouponService {
    Coupon save(Coupon coupon);
    void delete(int id);
    List<Coupon> findAll();
    Coupon findOne(int id);
    Coupon findByCode(String code);
    boolean isValid(String code, double orderAmount);
}
