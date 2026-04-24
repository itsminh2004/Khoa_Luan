package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductReview;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductReviewMapper implements RowMapper<ProductReview> {
    @Override
    public ProductReview mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductReview r = new ProductReview();
        r.setId(rs.getInt("id"));
        r.setProductId(rs.getInt("product_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setRating(rs.getInt("rating"));
        r.setComment(rs.getString("comment"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        try { r.setUserName(rs.getString("full_name")); } catch (Exception e) {}
        try { r.setProductName(rs.getString("Name")); } catch (Exception e) {}
        return r;
    }
}
