package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Order;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderMapper implements RowMapper<Order> {

    @Override
    public Order mapRow(ResultSet rs, int rowNum) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("order_user_id"));
        order.setCustomerName(rs.getString("order_customer_name"));
        order.setTotalAmount(rs.getDouble("order_total_amount"));
        order.setStatus(rs.getString("order_status"));
        order.setShippingAddress(rs.getString("order_shipping_address"));
        order.setPhone(rs.getString("order_phone"));
        order.setCreatedAt(rs.getTimestamp("order_created_at"));
        order.setUpdatedAt(rs.getTimestamp("order_updated_at"));
        return order;
    }
}

