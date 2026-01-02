package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IBlogCategoryDao;
import khoaluantotnghiep.mapper.BlogCategoryMapper;
import khoaluantotnghiep.model.BlogCategory;
import khoaluantotnghiep.utils.SlugUtils;
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
public class BlogCategoryDao implements IBlogCategoryDao {
    private JdbcTemplate jdbcTemplate;


    @Autowired
    public BlogCategoryDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public List<BlogCategory> findAll() {
        String sql= "SELECT * FROM tb_blog_category ORDER BY created_at DESC";
        return  jdbcTemplate.query(sql, new BlogCategoryMapper());
    }

    @Override
    public BlogCategory findById(int id) {
        String sql="SELECT * FROM tb_blog_category WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BlogCategoryMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public BlogCategory save(BlogCategory c) {
        c.setSlug(SlugUtils.toSlug(c.getName()));
        String  sql = "INSERT INTO tb_blog_category (name, description, slug) VALUES (?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, c.getName());
                ps.setString(2, c.getDescription());
                ps.setString(3, c.getSlug());

                return ps;
            }
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            c.setId(keyHolder.getKey().intValue());
        }
        return c;
    }

    @Override
    public BlogCategory update(BlogCategory c) {
        c.setSlug(SlugUtils.toSlug(c.getName()));
        String sql = "UPDATE tb_blog_category SET Name = ?, Description = ?, Slug = ? WHERE Id = ?";
        int row= jdbcTemplate.update(sql,c.getName(),c.getDescription(),c.getSlug(),c.getId());
        if (row == 0) {
            throw new RuntimeException("Record not found");
        }
        return c;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tb_blog_category WHERE Id = ?";
        jdbcTemplate.update(sql,id);
    }
}
