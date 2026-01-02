package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductCategory;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductCategoryMapper implements RowMapper<ProductCategory> {
    @Override
    public ProductCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductCategory category = new ProductCategory();
        category.setId(rs.getInt("Id"));
        category.setName(rs.getString("Name"));
        category.setDescription(rs.getString("Description"));
        category.setImage(rs.getString("Image"));
        category.setAlias(rs.getString("Alias"));
        category.setCreatedDate(rs.getTimestamp("CreatedDate") != null ?
                rs.getTimestamp("CreatedDate").toLocalDateTime() : null);
        category.setParentId(rs.getObject("ParentId") != null ? rs.getInt("ParentId") : null);
//        category.setParentName(rs.getString("ParentName"));

        return category;
    }
}
