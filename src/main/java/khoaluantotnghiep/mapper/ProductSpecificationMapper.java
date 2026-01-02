package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductSpecification;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductSpecificationMapper implements RowMapper<ProductSpecification> {
    @Override
    public ProductSpecification mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductSpecification productSpecification = new ProductSpecification();
        productSpecification.setId(rs.getInt("id"));
        productSpecification.setProductId(rs.getInt("product_id"));
        // Map to new attr_key/attr_value fields
        productSpecification.setAttrKey(rs.getString("attr_key"));
        productSpecification.setAttrValue(rs.getString("attr_value"));
        productSpecification.setCreatedDate(rs.getTimestamp("created_at"));
        return productSpecification;
    }
}
