package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductColor;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductColorMapper implements RowMapper<ProductColor> {
    @Override
    public ProductColor mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductColor color = new ProductColor();
        color.setId(rs.getInt("id"));
        color.setProductId(rs.getInt("product_id"));
        color.setColorName(rs.getString("color_name"));
        color.setColorCode(rs.getString("color_code"));
        return color;
    }
}

