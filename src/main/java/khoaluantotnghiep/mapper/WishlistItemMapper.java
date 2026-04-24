package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.*;
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

        int variantId = rs.getInt("wishlist_variant_id");
        if (!rs.wasNull()) {
            item.setVariantId(variantId);

            ProductVariantNew variant = new ProductVariantNew();
            variant.setId(variantId);
            variant.setProductId(rs.getInt("product_id"));
            variant.setPrice(rs.getBigDecimal("variant_price"));
            variant.setPriceSale(rs.getBigDecimal("variant_price_sale"));
            variant.setStock(rs.getInt("variant_stock"));

            // COLOR
            int colorId = rs.getInt("variant_color_id");
            if (!rs.wasNull()) {
                ProductColor color = new ProductColor();
                color.setId(colorId);
                color.setColorName(rs.getString("variant_color_name"));
                color.setColorCode(rs.getString("variant_color_code"));

                variant.setColorId(colorId);
                variant.setColor(color);
            }

            // RAM / ROM
            int ramRomId = rs.getInt("variant_ram_rom_id");
            if (!rs.wasNull()) {
                ProductRamRom ramRom = new ProductRamRom();
                ramRom.setId(ramRomId);
                ramRom.setRam(rs.getString("variant_ram"));
                ramRom.setRom(rs.getString("variant_rom"));

                variant.setRamRomId(ramRomId);
                variant.setRamRom(ramRom);
            }

            item.setVariant(variant);
        }
        return item;
    }
}


