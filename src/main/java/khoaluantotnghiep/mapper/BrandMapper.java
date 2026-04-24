package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Brand;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.NonNull;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BrandMapper implements RowMapper<Brand> {
    @Override
    public Brand mapRow(@NonNull ResultSet rs, int rowNum) throws SQLException {
        Brand brand = new Brand();
        brand.setId(rs.getInt("Id"));
        brand.setName(rs.getString("Name"));
        brand.setAlias(rs.getString("Alias"));
        brand.setLogo(rs.getString("Logo"));
        brand.setActive(rs.getBoolean("Active"));
        return brand;
    }
}
