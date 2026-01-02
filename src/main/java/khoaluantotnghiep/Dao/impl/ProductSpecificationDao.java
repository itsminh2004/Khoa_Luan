package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductSpecificationDao;
import khoaluantotnghiep.mapper.ProductSpecificationMapper;
import khoaluantotnghiep.model.ProductSpecification;
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
public class ProductSpecificationDao implements IProductSpecificationDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductSpecification save(ProductSpecification s) {
        String sql = "INSERT INTO tb_product_attributes (product_id, attr_key, attr_value) VALUES (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((PreparedStatementCreator) con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, s.getProductId());
            ps.setString(2, s.getAttrKey() != null ? s.getAttrKey() : s.getKey());
            ps.setString(3, s.getAttrValue() != null ? s.getAttrValue() : s.getValue());
            return ps;
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            s.setId(keyHolder.getKey().intValue());
        }
        return s;
    }

    @Override
    public ProductSpecification update(ProductSpecification s) {
        String sql = "UPDATE tb_product_attributes SET attr_key=?, attr_value=? WHERE id=?";
        int row = jdbcTemplate.update(sql,
                s.getAttrKey() != null ? s.getAttrKey() : s.getKey(),
                s.getAttrValue() != null ? s.getAttrValue() : s.getValue(),
                s.getId());
        if (row == 0) throw new RuntimeException("Specification not found");
        return s;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_attributes WHERE id=?", id);
    }

    @Override
    public List<ProductSpecification> findByProductId(int productId) {
        String sql = "SELECT * FROM tb_product_attributes WHERE product_id=? ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, new ProductSpecificationMapper(), productId);
    }

    @Override
    public ProductSpecification findById(int id) {
        String sql = "SELECT * FROM tb_product_attributes WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductSpecificationMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}
