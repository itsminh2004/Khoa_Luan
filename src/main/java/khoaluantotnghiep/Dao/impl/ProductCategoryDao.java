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
        String sql = "INSERT INTO tb_productcategory (Name, Description, Image, Alias, ParentId) VALUES (?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, category.getName());
                ps.setString(2, category.getDescription());
                ps.setString(3, category.getImage());
                ps.setString(4, category.getAlias());
                if (category.getParentId() != null) {
                    ps.setInt(5, category.getParentId());
                } else {
                    ps.setNull(5, Types.INTEGER);
                }
                return ps;
            }
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            category.setId(keyHolder.getKey().intValue());
        }
        return category;
    }

    @Override
    public ProductCategory update(ProductCategory updateCategory) {
        updateCategory.setAlias(SlugUtils.toSlug(updateCategory.getName()));
        String sql= "UPDATE tb_productcategory SET Name=?, Description=?, Image=?, Alias=?, ParentId=? WHERE Id=?";
        int row= jdbcTemplate.update(sql,updateCategory.getName(),updateCategory.getDescription(),updateCategory.getImage(),updateCategory.getAlias(),updateCategory.getParentId(),updateCategory.getId());
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
        String sql = "SELECT * FROM tb_productcategory WHERE Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductCategoryMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }


    @Override
    public List<ProductCategory> findAll() {
        String sql = "SELECT c.*, p.Name AS ParentName " +
                "FROM tb_productcategory c " +
                "LEFT JOIN tb_productcategory p ON c.ParentId = p.Id";

       return jdbcTemplate.query(sql, new ProductCategoryMapper());
    }

    @Override
    public List<ProductCategory> findParentCategories() {
        String sql = "SELECT * FROM tb_productcategory WHERE ParentId IS NULL";
        return jdbcTemplate.query(sql, new ProductCategoryMapper());
    }

    @Override
    public List<ProductCategory> findAllPaging(int offset, int limit) {


        String sql = "SELECT c.*, p.Name AS ParentName " +
                "FROM tb_productcategory c " +
                "LEFT JOIN tb_productcategory p ON c.ParentId = p.Id " +
                "ORDER BY c.Id DESC " +
                "LIMIT ?, ?";

        return jdbcTemplate.query(sql, new Object[]{offset, limit}, new ProductCategoryMapper());
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM tb_productcategory";
        Integer total = jdbcTemplate.queryForObject(sql, Integer.class);
        return total == null ? 0 : total;
    }


}
