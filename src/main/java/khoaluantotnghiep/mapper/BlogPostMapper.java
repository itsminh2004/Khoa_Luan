package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.BlogPost;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BlogPostMapper implements RowMapper<BlogPost> {
    @Override
    public BlogPost mapRow(ResultSet rs, int rowNum) throws SQLException {
        BlogPost p = new BlogPost();
        p.setId(rs.getInt("id"));
        p.setCategoryId((Integer) rs.getObject("category_id"));
        p.setAuthorId(rs.getInt("author_id"));
        if (hasColumn(rs, "category_name")) {
            p.setCategoryName(rs.getString("category_name"));
        }
        if (hasColumn(rs, "author_name")) {
            p.setAuthorName(rs.getString("author_name"));
        }
        p.setTitle(rs.getString("title"));
        p.setSlug(rs.getString("slug"));
        p.setThumbnail(rs.getString("thumbnail"));
        p.setContent(rs.getString("content"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    }

    private boolean hasColumn(ResultSet rs, String columnName) {
        try {
            rs.findColumn(columnName);
            return true;
        } catch (SQLException ignored) {
            return false;
        }
    }
}
