package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductVariantDao;
import khoaluantotnghiep.mapper.ProductVariantMapper;
import khoaluantotnghiep.model.ProductVariant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class ProductVariantDao implements IProductVariantDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductVariant save(ProductVariant v) {
        String sql = "INSERT INTO tb_product_variants (product_id, color, configuration, price, price_sale, stock, sku) " +
                "VALUES (?,?,?,?,?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((PreparedStatementCreator) con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, v.getProductId());
            ps.setString(2, v.getColor());
            ps.setString(3, v.getConfiguration());
            ps.setBigDecimal(4, v.getPrice());
            ps.setObject(5, v.getPriceSale());
            ps.setInt(6, v.getStock());
            ps.setString(7, v.getSku());
            return ps;
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            v.setId(keyHolder.getKey().intValue());
        }
        return v;
    }

    @Override
    public ProductVariant update(ProductVariant v) {
        String sql = "UPDATE tb_product_variants SET color=?, configuration=?, price=?, price_sale=?, stock=?, sku=? WHERE id=?";
        int row = jdbcTemplate.update(sql, v.getColor(), v.getConfiguration(), v.getPrice(),
                v.getPriceSale(), v.getStock(), v.getSku(), v.getId());
        if (row == 0) throw new RuntimeException("Variant not found");
        return v;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_variants WHERE id=?", id);
    }

    @Override
    public List<ProductVariant> findByProductId(int productId) {
        String sql = "SELECT * FROM tb_product_variants WHERE product_id=? ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, new ProductVariantMapper(), productId);
    }

    @Override
    public ProductVariant findById(int id) {
        String sql = "SELECT * FROM tb_product_variants WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductVariantMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}
