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
        variant.setRamRomId(rs.getObject("ram_rom_id", Integer.class));
        variant.setPrice(rs.getBigDecimal("price"));
        BigDecimal priceSale = rs.getBigDecimal("price_sale");
        variant.setPriceSale(priceSale);
        variant.setStock(rs.getInt("stock"));

        // Map joined fields if they exist
        try {
            if (rs.findColumn("color_name") > 0) {
                khoaluantotnghiep.model.ProductColor color = new khoaluantotnghiep.model.ProductColor();
                color.setId(rs.getInt("color_id"));
                color.setColorName(rs.getString("color_name"));
                variant.setColor(color);
            }
        } catch (SQLException ignored) {
        }

        try {
            if (rs.findColumn("ram") > 0) {
                khoaluantotnghiep.model.ProductRamRom ramRom = new khoaluantotnghiep.model.ProductRamRom();
                ramRom.setId(rs.getInt("ram_rom_id"));
                ramRom.setRam(rs.getString("ram"));
                ramRom.setRom(rs.getString("rom"));
                variant.setRamRom(ramRom);
            }
        } catch (SQLException ignored) {
        }

        return variant;
    }
}
