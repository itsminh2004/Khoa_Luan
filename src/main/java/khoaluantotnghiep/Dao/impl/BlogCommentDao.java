package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IBlogCommentDao;
import khoaluantotnghiep.mapper.BlogCommentMapper;
import khoaluantotnghiep.model.BlogComment;
import org.springframework.beans.factory.annotation.Autowired;
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
public class BlogCommentDao implements IBlogCommentDao {
    private JdbcTemplate jdbcTemplate;
    private static final String BASE_SELECT =
            "SELECT c.*, p.title AS post_title, u.full_name AS commenter_name " +
                    "FROM tb_blog_comments c " +
                    "LEFT JOIN tb_blog_posts p ON c.post_id = p.id " +
                    "LEFT JOIN tb_users u ON c.user_id = u.id ";
    @Autowired
    public BlogCommentDao (JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public BlogComment save(BlogComment c) {
        String sql="INSERT INTO tb_blog_comments(post_id, user_id, comment) VALUES(?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setLong(1, c.getPostId());
                ps.setLong(2, c.getUserId());
                ps.setString(3, c.getComment());
                return ps;
            }
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            c.setId(keyHolder.getKey().intValue());
        }
        return c;
    }

    @Override
    public void delete(int id) {
        String sql="DELETE FROM tb_blog_comments WHERE id=?";
        jdbcTemplate.update(sql,id);
    }

    @Override
    public List<BlogComment> findAllWithDetails() {
        String sql = BASE_SELECT + "ORDER BY c.created_at DESC";
        return jdbcTemplate.query(sql, new BlogCommentMapper());
    }

    @Override
    public List<BlogComment> findByPostId(int postId) {
        String sql= BASE_SELECT + "WHERE c.post_id = ? ORDER BY c.created_at ASC";
        return jdbcTemplate.query(sql, new BlogCommentMapper(), postId);
    }
}
