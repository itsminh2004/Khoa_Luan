package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductRamRomDao;
import khoaluantotnghiep.mapper.ProductRamRomMapper;
import khoaluantotnghiep.model.ProductRamRom;
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
public class ProductRamRomDao implements IProductRamRomDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductRamRom save(ProductRamRom ramRom) {
        String sql = "INSERT INTO tb_product_ram_roms (product_id, ram, rom) VALUES (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((PreparedStatementCreator) con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, ramRom.getProductId());
            ps.setString(2, ramRom.getRam());
            ps.setString(3, ramRom.getRom());
            return ps;
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            ramRom.setId(keyHolder.getKey().intValue());
        }
        return ramRom;
    }

    @Override
    public ProductRamRom update(ProductRamRom ramRom) {
        String sql = "UPDATE tb_product_ram_roms SET ram=?, rom=? WHERE id=?";
        int row = jdbcTemplate.update(sql, ramRom.getRam(), ramRom.getRom(), ramRom.getId());
        if (row == 0) throw new RuntimeException("RamRom not found");
        return ramRom;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_ram_roms WHERE id=?", id);
    }

    @Override
    public List<ProductRamRom> findByProductId(int productId) {
        String sql = "SELECT * FROM tb_product_ram_roms WHERE product_id=? ORDER BY id";
        return jdbcTemplate.query(sql, new ProductRamRomMapper(), productId);
    }

    @Override
    public ProductRamRom findById(int id) {
        String sql = "SELECT * FROM tb_product_ram_roms WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductRamRomMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }
}

