package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.BlogCategory;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BlogCategoryMapper implements RowMapper<BlogCategory> {
    @Override
    public BlogCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        BlogCategory c = new BlogCategory();
        c.setId(rs.getInt("id"));
        c.setName(rs.getString("name"));
        c.setDescription(rs.getString("description"));
        c.setSlug(rs.getString("slug"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }

}
