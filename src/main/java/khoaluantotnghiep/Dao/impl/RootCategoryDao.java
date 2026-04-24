package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IRootCategoryDao;
import khoaluantotnghiep.mapper.RootCategoryMapper;
import khoaluantotnghiep.model.RootCategory;
import khoaluantotnghiep.utils.SlugUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.List;

@Repository
public class RootCategoryDao implements IRootCategoryDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public RootCategory insert(RootCategory rootCategory) {
        rootCategory.setAlias(SlugUtils.toSlug(rootCategory.getName()));
        String sql = "INSERT INTO tb_root_category (Name, Description, Image, Alias) VALUES (?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, rootCategory.getName());
                ps.setString(2, rootCategory.getDescription());
                ps.setString(3, rootCategory.getImage());
                ps.setString(4, rootCategory.getAlias());
                return ps;
            }
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            rootCategory.setId(keyHolder.getKey().intValue());
        }
        return rootCategory;
    }

    @Override
    public RootCategory update(RootCategory rootCategory) {
        rootCategory.setAlias(SlugUtils.toSlug(rootCategory.getName()));
        String sql = "UPDATE tb_root_category SET Name=?, Description=?, Image=?, Alias=? WHERE Id=?";
        int row = jdbcTemplate.update(sql, rootCategory.getName(), rootCategory.getDescription(),
                rootCategory.getImage(), rootCategory.getAlias(), rootCategory.getId());
        if (row == 0)
            throw new RuntimeException("Record not found");
        return rootCategory;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_root_category WHERE Id=?", id);
    }

    @Override
    public RootCategory findOne(int id) {
        String sql = "SELECT * FROM tb_root_category WHERE Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new RootCategoryMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<RootCategory> findAll() {
        return jdbcTemplate.query("SELECT * FROM tb_root_category", new RootCategoryMapper());
    }

    @Override
    public List<RootCategory> findAllPaging(int offset, int limit) {
        String sql = "SELECT * FROM tb_root_category ORDER BY Id DESC LIMIT ?, ?";
        return jdbcTemplate.query(sql, new Object[] { offset, limit }, new RootCategoryMapper());
    }

    @Override
    public int countAll() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM tb_root_category", Integer.class);
    }
}
