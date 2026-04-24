package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Coupon;
import java.util.List;

public interface ICouponDao {
    Coupon insert(Coupon coupon);
    Coupon update(Coupon coupon);
    void delete(int id);
    List<Coupon> findAll();
    Coupon findOne(int id);
    Coupon findByCode(String code);
    void incrementUsedCount(int id);
}
