package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.ICouponDao;
import khoaluantotnghiep.mapper.CouponMapper;
import khoaluantotnghiep.model.Coupon;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CouponDao implements ICouponDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Coupon insert(Coupon coupon) {
        String sql = "INSERT INTO tb_coupons (code, discount_value, discount_type, min_order_amount, max_discount_amount, start_date, end_date, usage_limit, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, coupon.getCode(), coupon.getDiscountValue(), coupon.getDiscountType(), coupon.getMinOrderAmount(), coupon.getMaxDiscountAmount(), coupon.getStartDate(), coupon.getEndDate(), coupon.getUsageLimit(), coupon.isStatus());
        return findByCode(coupon.getCode());
    }

    @Override
    public Coupon update(Coupon coupon) {
        String sql = "UPDATE tb_coupons SET code=?, discount_value=?, discount_type=?, min_order_amount=?, max_discount_amount=?, start_date=?, end_date=?, usage_limit=?, status=? WHERE id=?";
        jdbcTemplate.update(sql, coupon.getCode(), coupon.getDiscountValue(), coupon.getDiscountType(), coupon.getMinOrderAmount(), coupon.getMaxDiscountAmount(), coupon.getStartDate(), coupon.getEndDate(), coupon.getUsageLimit(), coupon.isStatus(), coupon.getId());
        return coupon;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_coupons WHERE id=?", id);
    }

    @Override
    public List<Coupon> findAll() {
        return jdbcTemplate.query("SELECT * FROM tb_coupons ORDER BY id DESC", new CouponMapper());
    }

    @Override
    public Coupon findOne(int id) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM tb_coupons WHERE id=?", new CouponMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Coupon findByCode(String code) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM tb_coupons WHERE code=?", new CouponMapper(), code);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public void incrementUsedCount(int id) {
        jdbcTemplate.update("UPDATE tb_coupons SET used_count = used_count + 1 WHERE id = ?", id);
    }
}
