package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IBrandDao;
import khoaluantotnghiep.mapper.BrandMapper;
import khoaluantotnghiep.model.Brand;
import khoaluantotnghiep.utils.SlugUtils;
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
public class BrandDao implements IBrandDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Brand> findAll() {
        String sql = "SELECT * FROM tb_brand WHERE Active = 1 ORDER BY Name ASC";
        return jdbcTemplate.query(sql, new BrandMapper());
    }

    @Override
    public List<Brand> findAllPaging(int offset, int limit) {
        String sql = "SELECT * FROM tb_brand ORDER BY Id DESC LIMIT ?, ?";
        return jdbcTemplate.query(sql, new BrandMapper(), offset, limit);
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM tb_brand";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return (count != null) ? count : 0;
    }

    @Override
    public Brand findOne(int id) {
        String sql = "SELECT * FROM tb_brand WHERE Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BrandMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Brand findByAlias(String alias) {
        String sql = "SELECT * FROM tb_brand WHERE Alias = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BrandMapper(), alias);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Brand insert(Brand brand) {
        brand.setAlias(SlugUtils.toSlug(brand.getName()));
        String sql = "INSERT INTO tb_brand (Name, Alias, Logo, Active) VALUES (?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, brand.getName());
            ps.setString(2, brand.getAlias());
            ps.setString(3, brand.getLogo());
            ps.setBoolean(4, brand.isActive());
            return ps;
        }, keyHolder);
        Number generatedKey = keyHolder.getKey();
        if (generatedKey != null) {
            brand.setId(generatedKey.intValue());
        }
        return brand;
    }

    @Override
    public Brand update(Brand brand) {
        brand.setAlias(SlugUtils.toSlug(brand.getName()));
        String sql = "UPDATE tb_brand SET Name=?, Alias=?, Logo=?, Active=? WHERE Id=?";
        jdbcTemplate.update(sql,
                brand.getName(),
                brand.getAlias(),
                brand.getLogo(),
                brand.isActive(),
                brand.getId());
        return brand;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_brand WHERE Id=?", id);
    }
}
