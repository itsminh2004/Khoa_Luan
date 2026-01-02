package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.BlogComment;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BlogCommentMapper implements RowMapper<BlogComment> {
    @Override
    public BlogComment mapRow(ResultSet rs, int rowNum) throws SQLException {
        BlogComment c = new BlogComment();
        c.setId(rs.getInt("id"));
        c.setPostId(rs.getInt("post_id"));
        c.setUserId(rs.getInt("user_id"));
        c.setComment(rs.getString("comment"));
        if (hasColumn(rs, "post_title")) {
            c.setPostTitle(rs.getString("post_title"));
        }
        if (hasColumn(rs, "commenter_name")) {
            c.setCommenterName(rs.getString("commenter_name"));
        }
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
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
