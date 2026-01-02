package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductVariant;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductVariantMapper  implements RowMapper <ProductVariant>{
    @Override
    public ProductVariant mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductVariant productVariant = new ProductVariant();
        productVariant.setId(rs.getInt("id"));
        productVariant.setProductId(rs.getInt("product_id"));
        productVariant.setColor(rs.getString("color"));
        productVariant.setConfiguration(rs.getString("configuration"));
        productVariant.setPrice(rs.getBigDecimal("price"));      // ★ CHUẨN
        productVariant.setPriceSale(rs.getBigDecimal("price_sale"));
        productVariant.setStock(rs.getInt("stock"));
        productVariant.setSku(rs.getString("sku"));
        productVariant.setCreatedAt(rs.getTimestamp("created_at"));
        return productVariant;
    }

}
