package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductCategory;
import khoaluantotnghiep.mapper.ProductCategoryMapper;
import khoaluantotnghiep.model.ProductCategory;
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
public class ProductCategoryDao implements IProductCategory {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductCategory insert(ProductCategory category) {
        category.setAlias(SlugUtils.toSlug(category.getName()));
        String sql = "INSERT INTO tb_productcategory (Name, Description, Image, Alias, RootCategoryId) VALUES (?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(con -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImage());
            ps.setString(4, category.getAlias());
            if (category.getRootCategoryId() != null) {
                ps.setInt(5, category.getRootCategoryId());
            } else {
                ps.setNull(5, Types.INTEGER);
            }
            return ps;
        }, keyHolder);

        Number key = keyHolder.getKey();
        if (key != null) {
            category.setId(key.intValue());
        }
        return category;
    }

    @Override
    public ProductCategory update(ProductCategory updateCategory) {
        updateCategory.setAlias(SlugUtils.toSlug(updateCategory.getName()));
        String sql = "UPDATE tb_productcategory SET Name=?, Description=?, Image=?, Alias=?, RootCategoryId=? WHERE Id=?";
        int row = jdbcTemplate.update(sql, updateCategory.getName(), updateCategory.getDescription(),
                updateCategory.getImage(), updateCategory.getAlias(), updateCategory.getRootCategoryId(),
                updateCategory.getId());
        if (row == 0) {
            throw new RuntimeException("Record not found");
        }
        return updateCategory;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tb_productcategory WHERE Id=?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public ProductCategory findOne(int id) {
        String sql = "SELECT c.*, r.Name AS RootCategoryName " +
                "FROM tb_productcategory c " +
                "LEFT JOIN tb_root_category r ON c.RootCategoryId = r.Id " +
                "WHERE c.Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductCategoryMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<ProductCategory> findAll() {
        String sql = "SELECT c.*, r.Name AS RootCategoryName " +
                "FROM tb_productcategory c " +
                "LEFT JOIN tb_root_category r ON c.RootCategoryId = r.Id";

        return jdbcTemplate.query(sql, new ProductCategoryMapper());
    }

    @Override
    public List<ProductCategory> findParentCategories() {
        // This method might need adjustment or removal depending on usage.
        // For now, it returns sub-categories that could be parents (which doesn't make
        // sense in new structure).
        // I will return all sub-categories.
        return findAll();
    }

    @Override
    public List<ProductCategory> findAllPaging(int offset, int limit) {
        String sql = "SELECT c.*, r.Name AS RootCategoryName " +
                "FROM tb_productcategory c " +
                "LEFT JOIN tb_root_category r ON c.RootCategoryId = r.Id " +
                "ORDER BY c.Id DESC " +
                "LIMIT ?, ?";

        return jdbcTemplate.query(sql, new Object[] { offset, limit }, new ProductCategoryMapper());
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM tb_productcategory";
        Integer total = jdbcTemplate.queryForObject(sql, Integer.class);
        return total == null ? 0 : total;
    }

}
