package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.ICartDao;
import khoaluantotnghiep.mapper.CartItemMapper;
import khoaluantotnghiep.model.CartItem;
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
public class CartDao implements ICartDao {

    private static final String BASE_SELECT = "SELECT " +
            "c.id AS cart_id, " +
            "c.user_id AS cart_user_id, " +
            "c.product_id AS cart_product_id, " +
            "c.quantity AS cart_quantity, " +
            "c.created_at AS cart_created_at, " +
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
            "FROM tb_cart c " +
            "JOIN tb_product p ON c.product_id = p.Id " +
            "LEFT JOIN tb_productcategory pc ON p.CategoryId = pc.Id " +
            "LEFT JOIN tb_series s ON p.SeriesId = s.Id ";

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public CartItem findById(int id) {
        String sql = BASE_SELECT + "WHERE c.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new CartItemMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public CartItem findByUserAndProduct(int userId, int productId) {
        String sql = BASE_SELECT + "WHERE c.user_id = ? AND c.product_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new CartItemMapper(), userId, productId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<CartItem> findByUserId(int userId) {
        String sql = BASE_SELECT + "WHERE c.user_id = ? ORDER BY c.created_at DESC";
        return jdbcTemplate.query(sql, new CartItemMapper(), userId);
    }

    @Override
    public CartItem insert(CartItem item) {
        String sql = "INSERT INTO tb_cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, item.getUserId());
            ps.setInt(2, item.getProductId());
            ps.setInt(3, item.getQuantity());
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            item.setId(keyHolder.getKey().intValue());
        }
        if (item.getId() > 0) {
            return findById(item.getId());
        }
        return findByUserAndProduct(item.getUserId(), item.getProductId());
    }

    @Override
    public CartItem updateQuantity(int id, int quantity) {
        String sql = "UPDATE tb_cart SET quantity = ? WHERE id = ?";
        int affected = jdbcTemplate.update(sql, quantity, id);
        if (affected == 0) {
            return null;
        }
        return findById(id);
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_cart WHERE id = ?", id);
    }

    @Override
    public void deleteByUser(int userId) {
        jdbcTemplate.update("DELETE FROM tb_cart WHERE user_id = ?", userId);
    }

    @Override
    public void deleteByUserAndProduct(int userId, int productId) {
        jdbcTemplate.update("DELETE FROM tb_cart WHERE user_id = ? AND product_id = ?", userId, productId);
    }
}


