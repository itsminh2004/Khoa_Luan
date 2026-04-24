package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductComment;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductCommentMapper implements RowMapper<ProductComment> {
    @Override
    public ProductComment mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductComment c = new ProductComment();
        c.setId(rs.getInt("id"));
        c.setProductId(rs.getInt("product_id"));
        c.setUserId(rs.getInt("user_id"));
        c.setParentId(rs.getObject("parent_id") != null ? rs.getInt("parent_id") : null);
        c.setComment(rs.getString("comment"));
        c.setAdminReply(rs.getBoolean("is_admin_reply"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        try { c.setUserName(rs.getString("full_name")); } catch (Exception e) {}
        try { c.setProductName(rs.getString("product_name")); } catch (Exception e) {}

        return c;
    }
}
