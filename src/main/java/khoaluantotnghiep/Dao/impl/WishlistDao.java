package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IWishlistDao;
import khoaluantotnghiep.mapper.WishlistItemMapper;
import khoaluantotnghiep.model.WishlistItem;
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
public class WishlistDao implements IWishlistDao {

    private static final String BASE_SELECT = "SELECT " +
            "w.id AS wishlist_id, " +
            "w.user_id AS wishlist_user_id, " +
            "w.product_id AS wishlist_product_id, " +
            "w.created_at AS wishlist_created_at, " +
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
            "FROM tb_wishlist w " +
            "JOIN tb_product p ON w.product_id = p.Id " +
            "LEFT JOIN tb_productcategory pc ON p.CategoryId = pc.Id " +
            "LEFT JOIN tb_series s ON p.SeriesId = s.Id ";

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public WishlistItem findById(int id) {
        String sql = BASE_SELECT + "WHERE w.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new WishlistItemMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public WishlistItem findByUserAndProduct(int userId, int productId) {
        String sql = BASE_SELECT + "WHERE w.user_id = ? AND w.product_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new WishlistItemMapper(), userId, productId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<WishlistItem> findByUserId(int userId) {
        String sql = BASE_SELECT + "WHERE w.user_id = ? ORDER BY w.created_at DESC";
        return jdbcTemplate.query(sql, new WishlistItemMapper(), userId);
    }

    @Override
    public WishlistItem insert(WishlistItem item) {
        String sql = "INSERT INTO tb_wishlist (user_id, product_id) VALUES (?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, item.getUserId());
            ps.setInt(2, item.getProductId());
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
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_wishlist WHERE id = ?", id);
    }

    @Override
    public void deleteByUserAndProduct(int userId, int productId) {
        jdbcTemplate.update("DELETE FROM tb_wishlist WHERE user_id = ? AND product_id = ?", userId, productId);
    }
}


