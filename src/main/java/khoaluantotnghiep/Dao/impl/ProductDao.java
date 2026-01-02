package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductDao;
import khoaluantotnghiep.mapper.ProductMapper;
import khoaluantotnghiep.model.Product;
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
import java.sql.Timestamp;
import java.util.List;

@Repository
public class ProductDao implements IProductDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Product insert(Product product) {
        product.setAlias(SlugUtils.toSlug(product.getName()));

        String sql = "INSERT INTO tb_product " +
                "(Name, Description, Price, PriceSale, Stock, CreatedDate, Active, CategoryId, SeriesId, Alias, Image, has_variants, default_ram, default_rom) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setDouble(4, product.getPriceSale());
            ps.setInt(5, product.getStock());
            ps.setTimestamp(6, product.getCreatedDate() != null ?
                    new Timestamp(product.getCreatedDate().getTime()) :
                    new Timestamp(System.currentTimeMillis()));
            ps.setBoolean(7, product.isActive());
            ps.setInt(8, product.getCategoryId());
            ps.setObject(9, product.getSeriesId() == 0 ? null : product.getSeriesId());
            ps.setString(10, product.getAlias());
            ps.setString(11, product.getImage());
            ps.setBoolean(12, product.isHasVariants());
            ps.setString(13, product.getDefaultRam());
            ps.setString(14, product.getDefaultRom());
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            product.setId(keyHolder.getKey().intValue());
        } else {
            // fallback: try LAST_INSERT_ID() in case driver/DB didn't populate GeneratedKeyHolder
            try {
                Integer lastId = jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
                if (lastId != null && lastId > 0) {
                    product.setId(lastId);
                }
            } catch (Exception ignore) {
                // ignore - product.id may remain 0 (but log if you want)
            }
        }
        return product;
    }

    @Override
    public Product update(Product updateProduct) {
        updateProduct.setAlias(SlugUtils.toSlug(updateProduct.getName()));

        String sql = "UPDATE tb_product " +
                "SET Name=?, Description=?, Price=?, PriceSale=?, Stock=?, Active=?, CategoryId=?, SeriesId=?, Alias=?, Image=?, has_variants=?, default_ram=?, default_rom=? WHERE Id=?";

        int row = jdbcTemplate.update(sql,
                updateProduct.getName(),
                updateProduct.getDescription(),
                updateProduct.getPrice(),
                updateProduct.getPriceSale(),
                updateProduct.getStock(),
                updateProduct.isActive(),
                updateProduct.getCategoryId(),
                updateProduct.getSeriesId() == 0 ? null : updateProduct.getSeriesId(),
                updateProduct.getAlias(),
                updateProduct.getImage(),
                updateProduct.isHasVariants(),
                updateProduct.getDefaultRam(),
                updateProduct.getDefaultRom(),
                updateProduct.getId());

        if (row == 0) {
            throw new RuntimeException("Product not found for update");
        }
        return updateProduct;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product WHERE Id=?", id);
    }

    @Override
    public List<Product> findAll() {
        String sql = "SELECT p.*, c.Name AS CategoryName, s.Name AS SeriesName " +
                "FROM tb_product p " +
                "LEFT JOIN tb_productcategory c ON p.CategoryId = c.Id " +
                "LEFT JOIN tb_series s ON p.SeriesId = s.Id";
        return jdbcTemplate.query(sql, new ProductMapper());
    }

    @Override
    public Product findOne(int id) {
        String sql = "SELECT p.*, c.Name AS CategoryName, s.Name AS SeriesName " +
                "FROM tb_product p " +
                "LEFT JOIN tb_productcategory c ON p.CategoryId = c.Id " +
                "LEFT JOIN tb_series s ON p.SeriesId = s.Id " +
                "WHERE p.Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Product findCategoryById(int categoryId) {
        String sql = "SELECT p.*, c.Name AS CategoryName, s.Name AS SeriesName " +
                "FROM tb_product p " +
                "LEFT JOIN tb_productcategory c ON p.CategoryId = c.Id " +
                "LEFT JOIN tb_series s ON p.SeriesId = s.Id " +
                "WHERE c.Id = ? LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, new ProductMapper(), categoryId);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Product> findAllPaging(int offset, int limit) {
        String sql = "SELECT p.*, c.Name AS CategoryName, s.Name AS SeriesName " +
                "FROM tb_product p " +
                "LEFT JOIN tb_productcategory c ON p.CategoryId = c.Id " +
                "LEFT JOIN tb_series s ON p.SeriesId = s.Id " +
                "ORDER BY p.Id DESC " +
                "LIMIT ?, ?";

        return jdbcTemplate.query(sql, new Object[]{offset, limit}, new ProductMapper());
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM tb_product";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
