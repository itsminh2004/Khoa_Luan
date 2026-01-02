package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductVariantNew;
import org.springframework.jdbc.core.RowMapper;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductVariantNewMapper implements RowMapper<ProductVariantNew> {
    @Override
    public ProductVariantNew mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductVariantNew variant = new ProductVariantNew();
        variant.setId(rs.getInt("id"));
        variant.setProductId(rs.getInt("product_id"));
        variant.setColorId(rs.getInt("color_id"));
        variant.setRamRomId(rs.getInt("ram_rom_id"));
        variant.setPrice(rs.getBigDecimal("price"));
        BigDecimal priceSale = rs.getBigDecimal("price_sale");
        variant.setPriceSale(priceSale);
        variant.setStock(rs.getInt("stock"));
        return variant;
    }
}

