package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IBlogPostDao;
import khoaluantotnghiep.mapper.BlogPostMapper;
import khoaluantotnghiep.model.BlogPost;
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
public class BlogPostDao implements IBlogPostDao {
    private JdbcTemplate jdbcTemplate;
    private static final String BASE_SELECT =
            "SELECT p.*, c.name AS category_name, u.full_name AS author_name " +
                    "FROM tb_blog_posts p " +
                    "LEFT JOIN tb_blog_category c ON p.category_id = c.id " +
                    "LEFT JOIN tb_users u ON p.author_id = u.id ";

    @Autowired
    public BlogPostDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public BlogPost save(BlogPost p) {
        p.setSlug(buildSlug(p));
        String sql= "INSERT INTO tb_blog_posts(category_id, author_id, title, slug, thumbnail, content, status) VALUES (?,?,?,?,?,?,?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator(){
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, p.getCategoryId());
                ps.setInt(2, p.getAuthorId());
                ps.setString(3, p.getTitle());
                ps.setString(4, p.getSlug());
                ps.setString(5, p.getThumbnail());
                ps.setString(6, p.getContent());
                ps.setString(7, p.getStatus());
                return ps;
            }
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            p.setId(keyHolder.getKey().intValue());
        }
        return p;
    }

    @Override
    public BlogPost update(BlogPost p) {
        p.setSlug(buildSlug(p));
        String sql= "UPDATE tb_blog_posts SET category_id=?, title=?, slug=?, thumbnail=?, content=?, status=? WHERE id=? ";
        int row= jdbcTemplate.update(sql, p.getCategoryId(),p.getTitle(),p.getSlug(),p.getThumbnail(),p.getContent(),p.getStatus(),p.getId());
        if (row == 0) {
            throw new RuntimeException("Record not found");
        }
        return p;
    }

    @Override
    public void delete(int id) {
        String sql= "DELETE FROM tb_blog_posts WHERE id=?";
        jdbcTemplate.update(sql,id);
    }

    @Override
    public List<BlogPost> findAllPublished() {
        String sql= BASE_SELECT + "WHERE p.status='PUBLISHED' ORDER BY p.created_at DESC";
        return jdbcTemplate.query(sql, new BlogPostMapper());
    }

    @Override
    public List<BlogPost> findAll() {
        String sql= BASE_SELECT + "ORDER BY p.created_at DESC";
        return jdbcTemplate.query(sql, new BlogPostMapper());
    }

    @Override
    public BlogPost findById(int id) {
        String sql= BASE_SELECT + "WHERE p.id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BlogPostMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public BlogPost findBySlug(String slug) {
        String sql= BASE_SELECT + "WHERE p.slug = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new BlogPostMapper(), slug);
        }catch (EmptyResultDataAccessException e){
            return null;
        }
    }

    private String buildSlug(BlogPost post) {
        String source = (post.getSlug() != null && !post.getSlug().trim().isEmpty())
                ? post.getSlug()
                : post.getTitle();
        return SlugUtils.toSlug(source);
    }
}