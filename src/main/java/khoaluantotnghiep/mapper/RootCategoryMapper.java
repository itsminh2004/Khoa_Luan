package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.RootCategory;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RootCategoryMapper implements RowMapper<RootCategory> {
    @Override
    public RootCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        RootCategory category = new RootCategory();
        category.setId(rs.getInt("Id"));
        category.setName(rs.getString("Name"));
        category.setDescription(rs.getString("Description"));
        category.setImage(rs.getString("Image"));
        category.setAlias(rs.getString("Alias"));
        category.setCreatedDate(
                rs.getTimestamp("CreatedDate") != null ? rs.getTimestamp("CreatedDate").toLocalDateTime() : null);
        return category;
    }
}
