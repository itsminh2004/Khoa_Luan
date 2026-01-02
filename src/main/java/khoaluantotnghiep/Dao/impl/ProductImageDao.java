package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductImageDao;
import khoaluantotnghiep.mapper.ProductImageMapper;
import khoaluantotnghiep.model.ProductImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

@Repository
public class ProductImageDao implements IProductImageDao {
    @Autowired
    JdbcTemplate jdbcTemplate;


    @Override
    public ProductImage insert(ProductImage productImage) {
        String sql= "INSERT INTO tb_productimage (imageUrl, productId, variant_id, color_id)"+
                "VALUES (?,?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator(){
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1,productImage.getImageUrl());
                ps.setInt(2,productImage.getProductId());
                ps.setObject(3, productImage.getVariantId());
                ps.setObject(4, productImage.getColorId());
                return ps;
            }
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            productImage.setId(keyHolder.getKey().intValue());
        }
        return productImage;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tb_productimage WHERE Id=?";
        jdbcTemplate.update(sql,id);
    }

    @Override
    public List<ProductImage> findByProductId(int productId) {
        String sql = "SELECT * FROM tb_productimage WHERE ProductId = ?";
        return jdbcTemplate.query(sql, new ProductImageMapper(), productId);
    }

    @Override
    public List<ProductImage> findByVariantId(int variantId) {
        String sql = "SELECT * FROM tb_productimage WHERE variant_id = ?";
        return jdbcTemplate.query(sql, new ProductImageMapper(), variantId);
    }

    @Override
    public ProductImage findOne(int id) {
        String sql = "SELECT * FROM tb_productimage WHERE Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductImageMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<ProductImage> findByColorId(int colorId) {
        String sql = "SELECT * FROM tb_productimage WHERE color_id = ?";
        return jdbcTemplate.query(sql, new ProductImageMapper(), colorId);
    }

    @Override
    public void deleteByColorId(int colorId) {
        String sql = "DELETE FROM tb_productimage WHERE color_id = ?";
        jdbcTemplate.update(sql, colorId);
    }
}
