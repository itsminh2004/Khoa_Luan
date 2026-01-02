package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductColorDao;
import khoaluantotnghiep.mapper.ProductColorMapper;
import khoaluantotnghiep.model.ProductColor;
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
public class ProductColorDao implements IProductColorDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductColor save(ProductColor color) {
        String sql = "INSERT INTO tb_product_colors (product_id, color_name, color_code) VALUES (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((PreparedStatementCreator) con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, color.getProductId());
            ps.setString(2, color.getColorName());
            ps.setString(3, color.getColorCode());
            return ps;
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            color.setId(keyHolder.getKey().intValue());
        }
        return color;
    }

    @Override
    public ProductColor update(ProductColor color) {
        String sql = "UPDATE tb_product_colors SET color_name=?, color_code=? WHERE id=?";
        int row = jdbcTemplate.update(sql, color.getColorName(), color.getColorCode(), color.getId());
        if (row == 0) throw new RuntimeException("Color not found");
        return color;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_colors WHERE id=?", id);
    }

    @Override
    public List<ProductColor> findByProductId(int productId) {
        String sql = "SELECT * FROM tb_product_colors WHERE product_id=? ORDER BY id";
        return jdbcTemplate.query(sql, new ProductColorMapper(), productId);
    }

    @Override
    public ProductColor findById(int id) {
        String sql = "SELECT * FROM tb_product_colors WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductColorMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}

