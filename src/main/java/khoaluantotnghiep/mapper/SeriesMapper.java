package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Series;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SeriesMapper implements RowMapper<Series> {
    @Override
    public Series mapRow(ResultSet rs, int rowNum) throws SQLException {
        Series s = new Series();
        s.setId(rs.getInt("Id"));
        s.setName(rs.getString("Name"));
        s.setCategoryId(rs.getInt("CategoryId"));
        return s;
    }
}
