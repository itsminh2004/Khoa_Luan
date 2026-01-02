package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.model.WishlistItem;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class WishlistItemMapper implements RowMapper<WishlistItem> {

    @Override
    public WishlistItem mapRow(ResultSet rs, int rowNum) throws SQLException {
        WishlistItem item = new WishlistItem();
        item.setId(rs.getInt("wishlist_id"));
        item.setUserId(rs.getInt("wishlist_user_id"));
        item.setProductId(rs.getInt("wishlist_product_id"));

        Timestamp created = rs.getTimestamp("wishlist_created_at");
        if (created != null) {
            item.setCreatedAt(new Date(created.getTime()));
        }

        Product product = new Product();
        product.setId(rs.getInt("product_id"));
        product.setName(rs.getString("product_name"));
        product.setDescription(rs.getString("product_description"));
        product.setPrice(rs.getDouble("product_price"));
        product.setPriceSale(rs.getDouble("product_price_sale"));
        product.setStock(rs.getInt("product_stock"));

        Timestamp productCreated = null;
        try {
            productCreated = rs.getTimestamp("product_created_date");
        } catch (SQLException ignored) {
        }
        if (productCreated != null) {
            product.setCreatedDate(new Date(productCreated.getTime()));
        }

        try {
            product.setActive(rs.getBoolean("product_active"));
        } catch (SQLException ignored) {
        }

        product.setCategoryId(rs.getInt("product_category_id"));
        try {
            product.setCategoryName(rs.getString("product_category_name"));
        } catch (SQLException ignored) {
            product.setCategoryName(null);
        }
        product.setSeriesId(rs.getInt("product_series_id"));
        try {
            product.setSeriesName(rs.getString("product_series_name"));
        } catch (SQLException ignored) {
            product.setSeriesName(null);
        }
        product.setAlias(rs.getString("product_alias"));
        product.setImage(rs.getString("product_image"));

        item.setProduct(product);
        return item;
    }
}


