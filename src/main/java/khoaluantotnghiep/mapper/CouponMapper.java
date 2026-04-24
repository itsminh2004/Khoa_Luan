package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Coupon;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CouponMapper implements RowMapper<Coupon> {
    @Override
    public Coupon mapRow(ResultSet rs, int rowNum) throws SQLException {
        Coupon c = new Coupon();
        c.setId(rs.getInt("id"));
        c.setCode(rs.getString("code"));
        c.setDiscountValue(rs.getDouble("discount_value"));
        c.setDiscountType(rs.getString("discount_type"));
        c.setMinOrderAmount(rs.getDouble("min_order_amount"));
        c.setMaxDiscountAmount(rs.getObject("max_discount_amount") != null ? rs.getDouble("max_discount_amount") : null);
        c.setStartDate(rs.getTimestamp("start_date"));
        c.setEndDate(rs.getTimestamp("end_date"));
        c.setUsageLimit(rs.getObject("usage_limit") != null ? rs.getInt("usage_limit") : null);
        c.setUsedCount(rs.getInt("used_count"));
        c.setStatus(rs.getBoolean("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}
