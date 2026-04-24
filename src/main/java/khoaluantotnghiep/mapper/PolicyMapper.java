package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Policy;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PolicyMapper implements RowMapper<Policy> {
    @Override
    public Policy mapRow(ResultSet rs, int rowNum) throws SQLException {
        Policy p = new Policy();
        p.setId(rs.getInt("id"));
        p.setTitle(rs.getString("title"));
        p.setSlug(rs.getString("slug"));
        p.setContent(rs.getString("content"));
        p.setType(rs.getString("type"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    }
}
