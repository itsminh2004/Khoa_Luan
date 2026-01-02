package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductImage;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


public class ProductImageMapper implements RowMapper<ProductImage> {
    @Override
    public ProductImage mapRow(ResultSet rs, int rowNum) throws SQLException{
        ProductImage image=new ProductImage();
        // Thử các tên cột khác nhau để tương thích
        try {
            image.setId(rs.getInt("Id"));
        } catch (SQLException e) {
            try {
                image.setId(rs.getInt("id"));
            } catch (SQLException ignored) { }
        }

        try {
            image.setImageUrl(rs.getString("imageUrl"));
        } catch (SQLException e) {
            try {
                image.setImageUrl(rs.getString("ImageUrl"));
            } catch (SQLException ignored) { }
        }

        try {
            image.setProductId(rs.getInt("productId"));
        } catch (SQLException e) {
            try {
                image.setProductId(rs.getInt("ProductId"));
            } catch (SQLException ignored) { }
        }

        try {
            image.setVariantId((Integer) rs.getObject("variant_id"));
        } catch (SQLException ignored) { }

        try {
            image.setColorId((Integer) rs.getObject("color_id"));
        } catch (SQLException ignored) { }

        return image;
    }
}
