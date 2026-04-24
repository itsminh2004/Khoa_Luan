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
            "o.updated_at AS order_updated_at, " +
            "o.coupon_id AS order_coupon_id, " +
            "o.discount_amount AS order_discount_amount, " +
            "o.payment_method AS order_payment_method " +
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
        String sql = "INSERT INTO tb_order (user_id, customer_name, total_amount, status, shipping_address, phone, coupon_id, discount_amount, payment_method) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getCustomerName());
            ps.setDouble(3, order.getTotalAmount());
            ps.setString(4, order.getStatus() != null ? order.getStatus() : "PENDING");
            ps.setString(5, order.getShippingAddress());
            ps.setString(6, order.getPhone());
            if (order.getCouponId() != null) {
                ps.setInt(7, order.getCouponId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            ps.setDouble(8, order.getDiscountAmount());
            ps.setString(9, order.getPaymentMethod() != null ? order.getPaymentMethod() : "COD");
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            order.setId(keyHolder.getKey().intValue());
        }
        return findById(order.getId());
    }

    @Override
    public void update(Order order) {
        String sql = "UPDATE tb_order SET customer_name = ?, shipping_address = ?, phone = ?, status = ?, payment_method = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                order.getCustomerName(),
                order.getShippingAddress(),
                order.getPhone(),
                order.getStatus(),
                order.getPaymentMethod(),
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
                "oi.variant_id AS order_item_variant_id, " + // Added variant_id
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
                "p.Image AS product_image, " +
                "v.id AS variant_id, " + // Join variant info
                "v.price AS variant_price, " +
                "v.price_sale AS variant_price_sale, " +
                "v.color_id AS variant_color_id, " +
                "v.ram_rom_id AS variant_ram_rom_id, " +
                "vc.color_name AS variant_color_name, " +
                "vc.color_code AS variant_color_code, " +
                "vr.ram AS variant_ram, " +
                "vr.rom AS variant_rom " +
                "FROM tb_order_item oi " +
                "JOIN tb_product p ON oi.product_id = p.Id " +
                "LEFT JOIN tb_productcategory pc ON p.CategoryId = pc.Id " +
                "LEFT JOIN tb_series s ON p.SeriesId = s.Id " +
                "LEFT JOIN tb_product_variants_new v ON oi.variant_id = v.id " +
                "LEFT JOIN tb_product_colors vc ON v.color_id = vc.id " +
                "LEFT JOIN tb_product_ram_roms vr ON v.ram_rom_id = vr.id " +
                "WHERE oi.order_id = ?";
        return jdbcTemplate.query(sql, new OrderItemMapper(), orderId);
    }

    @Override
    public OrderItem insertItem(OrderItem item) {
        String sql = "INSERT INTO tb_order_item (order_id, product_id, variant_id, quantity, price) VALUES (?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getProductId());
            if (item.getVariantId() != null) {
                ps.setInt(3, item.getVariantId());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            ps.setInt(4, item.getQuantity());
            ps.setDouble(5, item.getPrice());
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
                "WHERE YEAR(created_at) = ? AND MONTH(created_at) = ? AND status IN ('CONFIRMED', 'SHIPPING', 'DELIVERED')";
        Double revenue = jdbcTemplate.queryForObject(sql, Double.class, year, month);
        return revenue != null ? revenue : 0.0;
    }

    @Override
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM tb_order WHERE status IN ('CONFIRMED', 'SHIPPING', 'DELIVERED')";
        Double revenue = jdbcTemplate.queryForObject(sql, Double.class);
        return revenue != null ? revenue : 0.0;
    }

    @Override
    public List<java.util.Map<String, Object>> getTopSellingProducts(int limit) {
        String sql = "SELECT p.Name, SUM(oi.quantity) as total_sold " +
                "FROM tb_order_item oi " +
                "JOIN tb_product p ON oi.product_id = p.Id " +
                "JOIN tb_order o ON oi.order_id = o.id " +
                "WHERE status IN ( 'CONFIRMED', 'SHIPPING', 'DELIVERED') " +
                "GROUP BY p.Id " +
                "ORDER BY total_sold DESC " +
                "LIMIT ?";
        return jdbcTemplate.queryForList(sql, limit);
    }

    @Override
    public List<java.util.Map<String, Object>> getTopSellingProductsByMonth(int year, int month, int limit) {
        String sql = "SELECT p.Name, SUM(oi.quantity) as total_sold " +
                "FROM tb_order_item oi " +
                "JOIN tb_product p ON oi.product_id = p.Id " +
                "JOIN tb_order o ON oi.order_id = o.id " +
                "WHERE status IN ( 'CONFIRMED', 'SHIPPING', 'DELIVERED') " +
                "AND YEAR(o.created_at) = ? AND MONTH(o.created_at) = ? " +
                "GROUP BY p.Id " +
                "ORDER BY total_sold DESC " +
                "LIMIT ?";
        return jdbcTemplate.queryForList(sql, year, month, limit);
    }

    @Override
    public List<java.util.Map<String, Object>> getDailyRevenue(int days) {
        String sql = "SELECT DATE(created_at) as date, SUM(total_amount) as revenue " +
                "FROM tb_order " +
                "WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) AND status IN ('CONFIRMED', 'SHIPPING', 'DELIVERED') "
                +
                "GROUP BY DATE(created_at) " +
                "ORDER BY DATE(created_at) ASC";
        return jdbcTemplate.queryForList(sql, days);
    }

    @Override
    public List<java.util.Map<String, Object>> getProductsSalesByMonth(int year, int month) {
        String sql = "SELECT p.Id, p.Name, SUM(oi.quantity) as total_sold, SUM(oi.price * oi.quantity) as total_revenue "
                +
                "FROM tb_order_item oi " +
                "JOIN tb_product p ON oi.product_id = p.Id " +
                "JOIN tb_order o ON oi.order_id = o.id " +
                "WHERE status IN ( 'CONFIRMED', 'SHIPPING', 'DELIVERED') "+
                "AND YEAR(o.created_at) = ? AND MONTH(o.created_at) = ? " +
                "GROUP BY p.Id " +
                "ORDER BY total_revenue DESC";
        return jdbcTemplate.queryForList(sql, year, month);
    }

    @Override
    public List<java.util.Map<String, Object>> getDailyRevenueByMonth(int year, int month) {
        String sql = "SELECT DAY(created_at) as day, SUM(total_amount) as revenue " +
                "FROM tb_order " +
                "WHERE YEAR(created_at) = ? AND MONTH(created_at) = ? " +
                "AND status IN ('CONFIRMED', 'SHIPPING', 'DELIVERED') " +
                "GROUP BY DAY(created_at) " +
                "ORDER BY DAY(created_at) ASC";
        return jdbcTemplate.queryForList(sql, year, month);
    }
}
