package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.ICouponDao;
import khoaluantotnghiep.model.Coupon;
import khoaluantotnghiep.service.ICouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;

@Service
public class CouponService implements ICouponService {
    @Autowired
    private ICouponDao couponDao;

    @Override
    public Coupon save(Coupon coupon) {
        if (coupon.getId() > 0) {
            return couponDao.update(coupon);
        } else {
            return couponDao.insert(coupon);
        }
    }

    @Override
    public void delete(int id) {
        couponDao.delete(id);
    }

    @Override
    public List<Coupon> findAll() {
        return couponDao.findAll();
    }

    @Override
    public Coupon findOne(int id) {
        return couponDao.findOne(id);
    }

    @Override
    public Coupon findByCode(String code) {
        return couponDao.findByCode(code);
    }

    @Override
    public boolean isValid(String code, double orderAmount) {
        Coupon coupon = couponDao.findByCode(code);
        if (coupon == null || !coupon.isStatus()) return false;

        Date now = new Date();
        if (coupon.getStartDate() != null && now.before(coupon.getStartDate())) return false;
        if (coupon.getEndDate() != null && now.after(coupon.getEndDate())) return false;

        if (coupon.getUsageLimit() != null && coupon.getUsedCount() >= coupon.getUsageLimit()) return false;

        if (orderAmount < coupon.getMinOrderAmount()) return false;

        return true;
    }
}
