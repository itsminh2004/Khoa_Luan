package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IOrderDao;
import khoaluantotnghiep.mapper.OrderItemMapper;
import khoaluantotnghiep.mapper.OrderMapper;
import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.model.OrderItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class OrderDao implements IOrderDao {

    private static final String BASE_SELECT = "SELECT " +
            "o.id AS order_id, " +
            "o.user_id AS order_user_id, " +
            "o.customer_name AS order_customer_name, " +
            "o.total_amount AS order_total_amount, " +
            "o.status AS order_status, " +
            "o.shipping_address AS order_shipping_address, " +
            "o.phone AS order_phone, " +
            "o.created_at AS order_created_at, " +
            "o.updated_at AS order_updated_at " +
            "FROM tb_order o ";

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Order findById(int id) {
        String sql = BASE_SELECT + "WHERE o.id = ?";
        try {
            Order order = jdbcTemplate.queryForObject(sql, new OrderMapper(), id);
            if (order != null) {
                order.setItems(findItemsByOrderId(id));
            }
            return order;
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Order> findByUserId(int userId) {
        String sql = BASE_SELECT + "WHERE o.user_id = ? ORDER BY o.created_at DESC";
        List<Order> orders = jdbcTemplate.query(sql, new OrderMapper(), userId);
        for (Order order : orders) {
            order.setItems(findItemsByOrderId(order.getId()));
        }
        return orders;
    }

    @Override
    public List<Order> findAll() {
        String sql = BASE_SELECT + "ORDER BY o.created_at DESC";
        List<Order> orders = jdbcTemplate.query(sql, new OrderMapper());
        for (Order order : orders) {
            order.setItems(findItemsByOrderId(order.getId()));
        }
        return orders;
    }

    @Override
    public Order insert(Order order) {
        String sql = "INSERT INTO tb_order (user_id, customer_name, total_amount, status, shipping_address, phone) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getCustomerName());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus() != null ? order.getStatus() : "PENDING");
            ps.setString(5, order.getShippingAddress());
            ps.setString(6, order.getPhone());
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            order.setId(keyHolder.getKey().intValue());
        }
        return findById(order.getId());
    }

    @Override
    public void update(Order order) {
        String sql = "UPDATE tb_order SET customer_name = ?, shipping_address = ?, phone = ?, status = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                order.getCustomerName(),
                order.getShippingAddress(),
                order.getPhone(),
                order.getStatus(),
                order.getId());
    }

    @Override
    public void updateStatus(int orderId, String status) {
        String sql = "UPDATE tb_order SET status = ? WHERE id = ?";
        jdbcTemplate.update(sql, status, orderId);
    }

    @Override
    public void delete(int id) {
        deleteItemsByOrderId(id);
        jdbcTemplate.update("DELETE FROM tb_order WHERE id = ?", id);
    }

    @Override
    public List<OrderItem> findItemsByOrderId(int orderId) {
        String sql = "SELECT " +
                "oi.id AS order_item_id, " +
                "oi.order_id AS order_item_order_id, " +
                "oi.product_id AS order_item_product_id, " +
                "oi.quantity AS order_item_quantity, " +
                "oi.price AS order_item_price, " +
                "oi.created_at AS order_item_created_at, " +
                "p.Id AS product_id, " +
                "p.Name AS product_name, " +
                "p.Description AS product_description, " +
                "p.Price AS product_price, " +
                "p.PriceSale AS product_price_sale, " +
                "p.Stock AS product_stock, " +
                "p.CreatedDate AS product_created_date, " +
                "p.Active AS product_active, " +
                "p.CategoryId AS product_category_id, " +
                "pc.Name AS product_category_name, " +
                "p.SeriesId AS product_series_id, " +
                "s.Name AS product_series_name, " +
                "p.Alias AS product_alias, " +
                "p.Image AS product_image " +
                "FROM tb_order_item oi " +
                "JOIN tb_product p ON oi.product_id = p.Id " +
                "LEFT JOIN tb_productcategory pc ON p.CategoryId = pc.Id " +
                "LEFT JOIN tb_series s ON p.SeriesId = s.Id " +
                "WHERE oi.order_id = ?";
        return jdbcTemplate.query(sql, new OrderItemMapper(), orderId);
    }

    @Override
    public OrderItem insertItem(OrderItem item) {
        String sql = "INSERT INTO tb_order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getPrice());
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            item.setId(keyHolder.getKey().intValue());
        }
        return item;
    }

    @Override
    public void deleteItemsByOrderId(int orderId) {
        jdbcTemplate.update("DELETE FROM tb_order_item WHERE order_id = ?", orderId);
    }

    @Override
    public long getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM tb_order";
        Long count = jdbcTemplate.queryForObject(sql, Long.class);
        return count != null ? count : 0;
    }

    @Override
    public double getMonthlyRevenue(int year, int month) {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM tb_order " +
                "WHERE YEAR(created_at) = ? AND MONTH(created_at) = ?";
        Double revenue = jdbcTemplate.queryForObject(sql, Double.class, year, month);
        return revenue != null ? revenue : 0.0;
    }
}

