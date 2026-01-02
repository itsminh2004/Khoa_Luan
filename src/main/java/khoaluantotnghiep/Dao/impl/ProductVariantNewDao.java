package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductVariantNewDao;
import khoaluantotnghiep.mapper.ProductVariantNewMapper;
import khoaluantotnghiep.model.ProductVariantNew;
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
public class ProductVariantNewDao implements IProductVariantNewDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductVariantNew save(ProductVariantNew variant) {
        String sql = "INSERT INTO tb_product_variants_new (product_id, color_id, ram_rom_id, price, price_sale, stock) " +
                "VALUES (?,?,?,?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((PreparedStatementCreator) con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, variant.getProductId());
            ps.setInt(2, variant.getColorId());
            ps.setInt(3, variant.getRamRomId());
            ps.setBigDecimal(4, variant.getPrice());
            ps.setObject(5, variant.getPriceSale());
            ps.setInt(6, variant.getStock());
            return ps;
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            variant.setId(keyHolder.getKey().intValue());
        }
        return variant;
    }

    @Override
    public ProductVariantNew update(ProductVariantNew variant) {
        String sql = "UPDATE tb_product_variants_new SET color_id=?, ram_rom_id=?, price=?, price_sale=?, stock=? WHERE id=?";
        int row = jdbcTemplate.update(sql, variant.getColorId(), variant.getRamRomId(), variant.getPrice(),
                variant.getPriceSale(), variant.getStock(), variant.getId());
        if (row == 0) throw new RuntimeException("Variant not found");
        return variant;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_variants_new WHERE id=?", id);
    }

    @Override
    public List<ProductVariantNew> findByProductId(int productId) {
        String sql = "SELECT * FROM tb_product_variants_new WHERE product_id=? ORDER BY id";
        return jdbcTemplate.query(sql, new ProductVariantNewMapper(), productId);
    }

    @Override
    public ProductVariantNew findById(int id) {
        String sql = "SELECT * FROM tb_product_variants_new WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductVariantNewMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public ProductVariantNew findByColorIdAndRamRomId(int colorId, int ramRomId) {
        String sql = "SELECT * FROM tb_product_variants_new WHERE color_id=? AND ram_rom_id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductVariantNewMapper(), colorId, ramRomId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<ProductVariantNew> findByColorId(int colorId) {
        String sql = "SELECT * FROM tb_product_variants_new WHERE color_id=?";
        return jdbcTemplate.query(sql, new ProductVariantNewMapper(), colorId);
    }

    @Override
    public void deleteByColorId(int colorId) {
        jdbcTemplate.update("DELETE FROM tb_product_variants_new WHERE color_id=?", colorId);
    }
}


